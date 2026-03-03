package com.code888.edutrack.controller;

import com.code888.edutrack.dao.UserDAO;
import com.code888.edutrack.model.User;
import com.code888.edutrack.util.TwoFactorAuthUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/2fa-setup")
public class TwoFactorSetupServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Generate a new secret if user doesn't have one yet
        String secret = user.getTwoFactorSecret();
        if (secret == null || secret.isEmpty()) {
            secret = TwoFactorAuthUtil.generateSecret();
            req.setAttribute("newSecret", secret);
        }

        req.setAttribute("secret", secret);
        req.setAttribute("twoFactorEnabled", user.isTwoFactorEnabled());
        req.setAttribute("username", user.getUsername());

        req.getRequestDispatcher("/WEB-INF/views/auth/2fa-setup.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false); 
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");

        try {
            if ("enable".equals(action)) {
                String secret = req.getParameter("secret");
                String code = req.getParameter("code");

                if (TwoFactorAuthUtil.verifyCode(secret, code)) {
                    user.setTwoFactorSecret(secret);
                    user.setTwoFactorEnabled(true);
                    userDAO.update(user);
                    session.setAttribute("user", user);
                    req.getSession().setAttribute("message", "2FA has been enabled successfully!");
                } else {
                    req.getSession().setAttribute("error", "Invalid verification code. Please try again.");
                }
            } else if ("disable".equals(action)) {
                user.setTwoFactorSecret(null);
                user.setTwoFactorEnabled(false);
                userDAO.update(user);
                session.setAttribute("user", user);
                req.getSession().setAttribute("message", "2FA has been disabled.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error updating 2FA: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/2fa-setup");
    }
}
