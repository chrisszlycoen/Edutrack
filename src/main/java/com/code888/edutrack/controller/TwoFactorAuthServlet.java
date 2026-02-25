package com.code888.edutrack.controller;

import com.code888.edutrack.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/2fa")
public class TwoFactorAuthServlet extends HttpServlet {

    private static final long OTP_EXPIRY_MS = 5 * 60 * 1000; // 5 minutes

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("temp_user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.getRequestDispatcher("/WEB-INF/views/auth/2fa.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("temp_user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("temp_user");
        String code = req.getParameter("code");
        String sessionOtp = (String) session.getAttribute("email_otp");
        Long otpTime = (Long) session.getAttribute("otp_time");

        // Check OTP expiry (5 minutes)
        if (otpTime != null && (System.currentTimeMillis() - otpTime) > OTP_EXPIRY_MS) {
            session.removeAttribute("email_otp");
            session.removeAttribute("otp_time");
            session.removeAttribute("temp_user");
            req.setAttribute("error", "OTP has expired. Please login again.");
            req.getRequestDispatcher("/WEB-INF/views/auth/2fa.jsp").forward(req, resp);
            return;
        }

        // Verify OTP
        if (code != null && code.equals(sessionOtp)) {
            session.removeAttribute("temp_user");
            session.removeAttribute("email_otp");
            session.removeAttribute("otp_time");
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60);

            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/dashboard");
            } else if ("TEACHER".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/teacher-dashboard");
            } else if ("STUDENT".equalsIgnoreCase(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/student-dashboard");
            } else {
                resp.sendRedirect(req.getContextPath() + "/dashboard");
            }
        } else {
            req.setAttribute("error", "Invalid OTP code. Please try again.");
            req.getRequestDispatcher("/WEB-INF/views/auth/2fa.jsp").forward(req, resp);
        }
    }
}

