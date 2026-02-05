package com.code888.edutrack.controller;

import com.code888.edutrack.dao.UserDAO;
import com.code888.edutrack.model.User;
import com.code888.edutrack.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.getRequestDispatcher("/WEB-INF/views/auth/change-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (newPassword == null || newPassword.trim().isEmpty() || !newPassword.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match or are empty.");
            req.getRequestDispatcher("/WEB-INF/views/auth/change-password.jsp").forward(req, resp);
            return;
        }

        try {
            // Update password
            user.setPasswordChangeRequired(false);
            user.setPasswordHash(PasswordUtil.hash(newPassword));
            userDAO.update(user);

            // Update session user
            session.setAttribute("user", user);

            req.getSession().setAttribute("message", "Password changed successfully.");

            // Redirect to role-appropriate dashboard
            String role = user.getRole();
            if ("TEACHER".equalsIgnoreCase(role)) {
                resp.sendRedirect(req.getContextPath() + "/teacher-dashboard");
            } else if ("STUDENT".equalsIgnoreCase(role)) {
                resp.sendRedirect(req.getContextPath() + "/student-dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/dashboard");
            }
        } catch (Exception e) {
            req.setAttribute("error", "Error changing password: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/auth/change-password.jsp").forward(req, resp);
        }
    }
}
