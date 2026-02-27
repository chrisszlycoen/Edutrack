package com.code888.edutrack.controller;

import com.code888.edutrack.dao.UserDAO;
import com.code888.edutrack.model.User;
import com.code888.edutrack.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    public void init() throws ServletException {
        // Create default admin if not exists
        log("Initializing LoginServlet - Checking for default admin user");
        try {
            User admin = userDAO.findByUsername("admin");
            if (admin == null) {
                log("Admin user not found, creating default admin...");
                User newAdmin = new User();
                newAdmin.setUsername("admin");
                newAdmin.setName("System Administrator");
                newAdmin.setPasswordHash(PasswordUtil.hash("admin123"));
                newAdmin.setRole("ADMIN");
                newAdmin.setStatus("ACTIVE");
                newAdmin.setPasswordChangeRequired(true);
                userDAO.createUser(newAdmin);
                log("Default admin user created successfully.");
            } else {
                log("Admin user already exists.");
            }
        } catch (Exception e) {
            log("CRITICAL: Failed to initialize admin user or connect to database", e);
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String captcha = req.getParameter("captcha");

        HttpSession session = req.getSession(false);
        String sessionCaptcha = (session != null) ? (String) session.getAttribute(CaptchaServlet.SESSION_KEY) : null;

        if (captcha == null || !captcha.equals(sessionCaptcha)) {
            req.setAttribute("error", "Invalid captcha.");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
            return;
        }

        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {

            req.setAttribute("error", "Username and password are required.");
            req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
            return;
        }

        try {
            User user = userDAO.findByUsername(username.trim());

            if (user == null) {
                req.setAttribute("error", "Invalid credentials.");
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
                return;
            }

            if (!"ACTIVE".equalsIgnoreCase(user.getStatus())) {
                req.setAttribute("error", "Account is inactive. Contact admin.");
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
                return;
            }

            boolean ok = PasswordUtil.verify(password, user.getPasswordHash());
            if (!ok) {
                req.setAttribute("error", "Invalid credentials.");
                req.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(req, resp);
                return;
            }

            if (user.isPasswordChangeRequired()) { 
                req.getSession().setAttribute("user", user);
                req.getRequestDispatcher("/WEB-INF/views/auth/change-password.jsp").forward(req, resp);
                return;
            }

            if (user.isTwoFactorEnabled()) {
                session = req.getSession(true);
                session.setAttribute("temp_user", user);

                // Generate and send email OTP
                String otp = com.code888.edutrack.util.EmailUtil.generateOTP();
                session.setAttribute("email_otp", otp);
                session.setAttribute("otp_time", System.currentTimeMillis());

                String email = user.getEmail();
                if (email != null && !email.isEmpty()) {
                    com.code888.edutrack.util.EmailUtil.sendOTP(email, otp, "EduTrack Login OTP");
                }

                resp.sendRedirect(req.getContextPath() + "/2fa");
                return;
            }

            session = req.getSession(true);
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/dashboard");
            } else if ("TEACHER".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/teacher-dashboard");
            } else if ("STUDENT".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/student-dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/dashboard");
            }

        } catch (Exception e) {
            throw new ServletException("Login failed: " + e.getMessage(), e);
        }
    }
}
