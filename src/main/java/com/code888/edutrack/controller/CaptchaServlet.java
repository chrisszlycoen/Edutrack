package com.code888.edutrack.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.security.SecureRandom;

@WebServlet(name = "CaptchaServlet", value = "/captcha")
public class CaptchaServlet extends HttpServlet {
    public static final String SESSION_KEY = "CAPTCHA_CODE";
    private static final SecureRandom RNG = new SecureRandom();
                                                                                                              // 
    private static final String ALPHABET = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";

    @Override
            
    public void init() throws ServletException {
        // Force headless mode for environments without a display
        System.setProperty("java.awt.headless", "true");
        log("CaptchaServlet initialized. java.awt.headless=" + java.awt.GraphicsEnvironment.isHeadless());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        String code = generateCode(6);
        session.setAttribute(SESSION_KEY, code);
        log("Generated captcha code: " + code);

        int width = 160;
        int height = 55;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = image.createGraphics();

        try {
            g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

            // White background
            g.setColor(new Color(245, 245, 245));
            g.fillRect(0, 0, width, height);

            // Noise lines
            for (int i = 0; i < 8; i++) {
                g.setColor(new Color(150 + RNG.nextInt(80), 150 + RNG.nextInt(80), 150 + RNG.nextInt(80)));
                g.drawLine(RNG.nextInt(width), RNG.nextInt(height), RNG.nextInt(width), RNG.nextInt(height));
            }

            // Use a Java logical font name — guaranteed to exist on all systems
            g.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 28));
            FontMetrics fm = g.getFontMetrics();
            int charWidth = width / (code.length() + 1);
            int baseY = (height + fm.getAscent()) / 2 - 4;

            for (int i = 0; i < code.length(); i++) {
                g.setColor(new Color(30 + RNG.nextInt(80), 30 + RNG.nextInt(80), 30 + RNG.nextInt(80)));
                double angle = (RNG.nextDouble() - 0.5) * 0.5;
                AffineTransform old = g.getTransform();
                int x = (i + 1) * charWidth - 10;
                g.rotate(angle, x, baseY);
                g.drawString(String.valueOf(code.charAt(i)), x, baseY);
                g.setTransform(old);
            }
        } finally {
            g.dispose();
        }

        // Set response headers BEFORE writing bytes
        response.setContentType("image/png");
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        try (OutputStream out = response.getOutputStream()) {
            boolean ok = ImageIO.write(image, "png", out);
            if (!ok) {
                log("ERROR: ImageIO.write returned false — no PNG writer found");
            }
            out.flush();
        } catch (Exception e) {
            log("ERROR writing captcha image", e);
        }
    }

    private static String generateCode(int length) {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            sb.append(ALPHABET.charAt(RNG.nextInt(ALPHABET.length())));
        }
        return sb.toString();
    }
}

