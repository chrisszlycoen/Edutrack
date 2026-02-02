package com.code888.edutrack.filter;

import com.code888.edutrack.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebFilter("/*")
public class AuthFilter implements Filter {

    // Public paths that do not require login
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
            "/login", 
            "/register",
            "/register-otp",
            "/captcha",
            "/2fa",
            "/change-password",
            "/assets",
            "/static",
            "/css",
            "/js");

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String path = req.getServletPath();

        // 1. Allow public paths
        for (String p : PUBLIC_PATHS) {
            if (path.startsWith(p)) {
                chain.doFilter(request, response);
                return;
            }
        }

        // 2. Check if user is logged in
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        String role = user.getRole();

        // 3. Role-based access control

        // Students can ONLY access student-dashboard and logout
        if ("STUDENT".equalsIgnoreCase(role)) {
            if (!path.equals("/student-dashboard") && !path.equals("/logout")) {
                resp.sendRedirect(req.getContextPath() + "/student-dashboard");
                return;
            }
        }

        // Admin-only pages
        if (path.equals("/dashboard") || path.equals("/staff") || path.equals("/classes")) {
            if (!"ADMIN".equalsIgnoreCase(role)) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied. Admin only.");
                return;
            }
        }

        // CRUD restrictions: only admin can create/update/delete students and classes
        if ((path.equals("/students") || path.equals("/classes")) && action != null) {
            if ("delete".equals(action) || "create".equals(action) || "update".equals(action) || "new".equals(action)) {
                if (!"ADMIN".equalsIgnoreCase(role)) {
                    resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied. Admin only.");
                    return;
                }
            }
        }

        chain.doFilter(request, response);
    }
}
