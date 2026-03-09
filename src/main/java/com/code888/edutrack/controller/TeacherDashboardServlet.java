package com.code888.edutrack.controller;

import com.code888.edutrack.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/teacher-dashboard")
public class TeacherDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"TEACHER".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("contentPage", "/WEB-INF/views/dashboard/teacher_dashboard.jsp");
        req.setAttribute("pageTitle", "Teacher Dashboard");
        req.setAttribute("currentPage", "teacher-dashboard");
        req.getRequestDispatcher("/WEB-INF/views/layout/main.jsp").forward(req, resp);

    }
}
