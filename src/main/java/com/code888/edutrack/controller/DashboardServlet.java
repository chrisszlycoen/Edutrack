package com.code888.edutrack.controller;

import com.code888.edutrack.dao.ClassRoomDAO;
import com.code888.edutrack.dao.DisciplineCaseDAO;
import com.code888.edutrack.dao.StudentDAO;
import com.code888.edutrack.dao.UserDAO;
import com.code888.edutrack.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();
    private final ClassRoomDAO classDAO = new ClassRoomDAO();
    private final DisciplineCaseDAO disciplineCaseDAO = new DisciplineCaseDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        long totalStudents = studentDAO.count();
        int totalClasses = classDAO.getAllClasses().size();
        long totalDiscipline = disciplineCaseDAO.countPending();
        int attendancePercentage = 85;

        req.setAttribute("totalStudents", totalStudents);
        req.setAttribute("totalClasses", totalClasses);
        req.setAttribute("pendingDiscipline", totalDiscipline);
        req.setAttribute("attendancePercentage", attendancePercentage);

        req.setAttribute("contentPage", "/WEB-INF/views/dashboard/home.jsp");
        req.setAttribute("pageTitle", "Dashboard");
        req.setAttribute("currentPage", "dashboard");
        req.getRequestDispatcher("/WEB-INF/views/layout/main.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        try {
            if ("enable2fa".equals(action)) {
                String email = req.getParameter("email");
                if (email == null || email.trim().isEmpty() || !email.contains("@")) {
                    req.getSession().setAttribute("error", "Please enter a valid email address.");
                } else {
                    user.setEmail(email.trim());
                    user.setTwoFactorEnabled(true);
                    userDAO.update(user);
                    session.setAttribute("user", user);
                    req.getSession().setAttribute("message",
                            "2FA enabled! An OTP will be sent to " + email + " on every login.");
                }
            } else if ("disable2fa".equals(action)) {
                user.setTwoFactorEnabled(false);
                userDAO.update(user);
                session.setAttribute("user", user);
                req.getSession().setAttribute("message", "2FA has been disabled.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error updating 2FA: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/dashboard");
    }
}

