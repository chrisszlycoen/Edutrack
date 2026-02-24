package com.code888.edutrack.controller;

import com.code888.edutrack.dao.AttendanceDAO;
import com.code888.edutrack.dao.ClassRoomDAO;
import com.code888.edutrack.dao.StudentDAO;
import com.code888.edutrack.model.Attendance;
import com.code888.edutrack.model.ClassRoom;
import com.code888.edutrack.model.Student;
import com.code888.edutrack.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/attendance")
public class AttendanceServlet extends HttpServlet {

    private final ClassRoomDAO classDAO = new ClassRoomDAO();
    private final StudentDAO studentDAO = new StudentDAO();
    private final AttendanceDAO attendanceDAO = new AttendanceDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ClassRoom> classes = classDAO.getAllClasses();
        req.setAttribute("classes", classes);

        String classIdParam = req.getParameter("classId");
        String dateParam = req.getParameter("date");

        if (classIdParam != null && !classIdParam.isEmpty() && dateParam != null && !dateParam.isEmpty()) {
            int classId = Integer.parseInt(classIdParam);
            LocalDate date = LocalDate.parse(dateParam);

            List<Student> students = studentDAO.getStudentsByClass(classId);
            List<Attendance> existing = attendanceDAO.getAttendanceByClassAndDate(classId, date);

            Map<Integer, String> attendanceMap = new HashMap<>();
            for (Attendance a : existing) {
                attendanceMap.put(a.getStudent().getId(), a.getStatus());
            }

            req.setAttribute("students", students);
            req.setAttribute("selectedClassId", classId);
            req.setAttribute("selectedDate", date);
            req.setAttribute("existingAttendance", attendanceMap);
        } else {
            req.setAttribute("selectedDate", LocalDate.now());
        }

        req.setAttribute("contentPage", "/WEB-INF/views/modules/attendance.jsp");
        req.setAttribute("pageTitle", "Attendance");
        req.setAttribute("currentPage", "attendance");
        req.getRequestDispatcher("/WEB-INF/views/layout/main.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("save".equals(action)) {
            saveAttendance(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void saveAttendance(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int classId = Integer.parseInt(req.getParameter("classId"));
            LocalDate date = LocalDate.parse(req.getParameter("date"));
            User teacher = (User) req.getSession().getAttribute("user");

            ClassRoom cls = classDAO.findById(classId);
            List<Student> students = studentDAO.getStudentsByClass(classId);

            for (Student s : students) {
                String status = req.getParameter("status_" + s.getId());
                if (status != null) {
                    Attendance att = new Attendance(s, cls, teacher, date, status);
                    attendanceDAO.saveOrUpdate(att);
                }
            }

            req.getSession().setAttribute("message", "Attendance saved successfully.");
            resp.sendRedirect(req.getContextPath() + "/attendance?classId=" + classId + "&date=" + date);

        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error saving attendance: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/attendance");
        }
    }
}
