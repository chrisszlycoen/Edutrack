package com.code888.edutrack.controller;

import com.code888.edutrack.dao.UserDAO;
import com.code888.edutrack.model.User;
import com.code888.edutrack.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/staff")
public class StaffServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        List<User> staff = userDAO.findByRole("TEACHER");
        req.setAttribute("staffList", staff);

        req.setAttribute("contentPage", "/WEB-INF/views/modules/staff.jsp");
        req.setAttribute("pageTitle", "Manage Staff");
        req.setAttribute("currentPage", "staff");
        req.getRequestDispatcher("/WEB-INF/views/layout/main.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name"); // Using name as username
        String password = req.getParameter("password");

        try {
            if (userDAO.findByUsername(name) != null) {
                req.getSession().setAttribute("error", "Username already exists.");
            } else {
                User staff = new User();
                staff.setUsername(name);
                staff.setName(name);
                staff.setPasswordHash(PasswordUtil.hash(password));
                staff.setRole("TEACHER");
                staff.setStatus("ACTIVE");
                staff.setPasswordChangeRequired(true);
                userDAO.createUser(staff);
                req.getSession().setAttribute("message", "Staff added successfully.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error adding staff: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/staff");
    }
}

