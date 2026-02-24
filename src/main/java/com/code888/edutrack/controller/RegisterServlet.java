package com.code888.edutrack.controller;

import com.code888.edutrack.dao.ClassRoomDAO;
import com.code888.edutrack.dao.StudentDAO;
import com.code888.edutrack.dao.UserDAO;
import com.code888.edutrack.model.ClassRoom;
import com.code888.edutrack.model.Student;
import com.code888.edutrack.model.User;
import com.code888.edutrack.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final ClassRoomDAO classDAO = new ClassRoomDAO();
    private final StudentDAO studentDAO = new StudentDAO();
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ClassRoom> classes = classDAO.getAllClasses();
        req.setAttribute("classes", classes);
        req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String regNo = req.getParameter("regNo");
        String fullName = req.getParameter("fullName");
        String gender = req.getParameter("gender");
        String dobStr = req.getParameter("dob");
        String classIdStr = req.getParameter("classId");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        if (password == null || !password.equals(confirmPassword)) {
            requestWithError(req, resp, "Passwords do not match.");
            return;
        }

        // Verify email OTP
        jakarta.servlet.http.HttpSession session = req.getSession(false);
        String sessionOtp = (session != null) ? (String) session.getAttribute("reg_otp") : null;
        String sessionEmail = (session != null) ? (String) session.getAttribute("reg_otp_email") : null;
        Long otpTime = (session != null) ? (Long) session.getAttribute("reg_otp_time") : null;

        if (otp == null || !otp.equals(sessionOtp)) {
            requestWithError(req, resp, "Invalid OTP code. Please verify your email first.");
            return;
        }

        if (sessionEmail == null || !sessionEmail.equalsIgnoreCase(email)) {
            requestWithError(req, resp, "Email does not match the one used for OTP.");
            return;
        }

        if (otpTime != null && (System.currentTimeMillis() - otpTime) > 5 * 60 * 1000) {
            requestWithError(req, resp, "OTP has expired. Please request a new one.");
            return;
        }

        try {
            // Check if user already exists
            if (userDAO.findByUsername(regNo) != null) {
                requestWithError(req, resp, "Registration number already registered.");
                return;
            }

            // Create Student
            LocalDate dob = LocalDate.parse(dobStr);
            ClassRoom cls = classDAO.findById(Integer.parseInt(classIdStr));
            Student student = new Student(regNo, fullName, gender, dob);
            student.setClassRoom(cls);
            studentDAO.save(student);

            // Create User
            User user = new User();
            user.setUsername(regNo); // Username is RegNo
            user.setName(fullName);
            user.setPasswordHash(PasswordUtil.hash(password));
            user.setRole("STUDENT");
            user.setStatus("ACTIVE");
            user.setPasswordChangeRequired(false); // They chose their password
            userDAO.createUser(user);

            req.getSession().setAttribute("message", "Registration successful. Please login.");
            resp.sendRedirect(req.getContextPath() + "/login");

        } catch (Exception e) {
            e.printStackTrace();
            requestWithError(req, resp, "Error during registration: " + e.getMessage());
        }
    }

    private void requestWithError(HttpServletRequest req, HttpServletResponse resp, String error)
            throws ServletException, IOException {
        req.setAttribute("error", error);
        req.setAttribute("classes", classDAO.getAllClasses());
        req.setAttribute("regNo", req.getParameter("regNo")); // keep input
        req.setAttribute("fullName", req.getParameter("fullName"));
        req.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(req, resp);
    }
}
