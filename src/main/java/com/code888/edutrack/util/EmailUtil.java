package com.code888.edutrack.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.security.SecureRandom;
import java.util.Properties;

public class EmailUtil {

    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final int SMTP_PORT = 587;
    private static final String FROM_EMAIL = "uhiriwechrisostom0@gmail.com";
    private static final String APP_PASSWORD = "rqpu bkae rtru ycqc";
    private static final String FROM_NAME = "EduTrack";
    private static final SecureRandom RNG = new SecureRandom();

    /**
     * Generate a random 6-digit OTP code.
     */
    public static String generateOTP() {
        int otp = 100000 + RNG.nextInt(900000);
        return String.valueOf(otp);
    }

    /**
     * Send an OTP email.
     */
    public static boolean sendOTP(String toEmail, String otpCode, String subject) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", String.valueOf(SMTP_PORT));

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            message.setContent(
                    "<div style='font-family:Arial,sans-serif;max-width:500px;margin:0 auto;'>" +
                            "<h2 style='color:#0d6efd;'>" + FROM_NAME + "</h2>" +
                            "<p>Your verification code is:</p>" +
                            "<div style='background:#f0f0f0;padding:15px;text-align:center;border-radius:8px;'>" +
                            "<h1 style='letter-spacing:8px;margin:0;color:#333;'>" + otpCode + "</h1>" +
                            "</div>" +
                            "<p style='color:#666;margin-top:15px;'>This code expires in <strong>5 minutes</strong>.</p>"
                            +
                            "<hr style='border:none;border-top:1px solid #eee;'>" +
                            "<p style='color:#999;font-size:12px;'>If you did not request this code, please ignore this email.</p>"
                            +
                            "</div>",
                    "text/html; charset=utf-8");
            Transport.send(message);
            System.out.println("OTP email sent to " + toEmail);
            return true;
        } catch (Exception e) {
            System.err.println("Failed to send OTP email to " + toEmail + ": " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
