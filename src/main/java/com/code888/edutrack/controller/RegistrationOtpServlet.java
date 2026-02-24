package com.code888.edutrack.controller;

import com.code888.edutrack.util.EmailUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/register-otp")
public class RegistrationOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();

        String email = req.getParameter("email");

        if (email == null || email.trim().isEmpty() || !email.contains("@")) {
            out.print("{\"success\": false, \"message\": \"Please enter a valid email.\"}");
            return;
        }

        String otp = EmailUtil.generateOTP();
        HttpSession session = req.getSession(true);
        session.setAttribute("reg_otp", otp);
        session.setAttribute("reg_otp_email", email.trim());
        session.setAttribute("reg_otp_time", System.currentTimeMillis());

        boolean sent = EmailUtil.sendOTP(email.trim(), otp, "EduTrack Registration Verification");

        if (sent) {
            out.print("{\"success\": true, \"message\": \"OTP sent to " + email.trim() + "\"}");
        } else {
            out.print("{\"success\": false, \"message\": \"Failed to send OTP. Check your email address.\"}");
        }
    }
}
