package com.code888.edutrack.controller;

import com.code888.edutrack.dao.AttendanceDAO;

import com.code888.edutrack.dao.DisciplineCaseDAO;
import com.code888.edutrack.dao.StudentDAO;
import com.code888.edutrack.model.Attendance;
import com.code888.edutrack.model.DisciplineCase;
import com.code888.edutrack.model.Student;
import com.code888.edutrack.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/student-dashboard")
public class StudentDashboardServlet extends HttpServlet {

    private final AttendanceDAO attendanceDAO = new AttendanceDAO();
    private final DisciplineCaseDAO disciplineCaseDAO = new DisciplineCaseDAO();
    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null || !"STUDENT".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String regNo = user.getUsername(); // Student username = registration number

        // Get student info
        Student student = studentDAO.findByRegNo(regNo);

        // Attendance stats
        long totalAttendance = attendanceDAO.countTotalByStudentRegNo(regNo);
        long presentCount = attendanceDAO.countPresentByStudentRegNo(regNo);
        int attendancePercent = (totalAttendance > 0) ? (int) ((presentCount * 100) / totalAttendance) : 0;

        // Recent attendance records (last 10)
        List<Attendance> recentAttendance = attendanceDAO.getAttendanceByStudentRegNo(regNo);
        if (recentAttendance.size() > 10) {
            recentAttendance = recentAttendance.subList(0, 10);
        }

        // Discipline cases
        List<DisciplineCase> disciplineCases = disciplineCaseDAO.getCasesByStudentRegNo(regNo);

        req.setAttribute("student", student);
        req.setAttribute("totalAttendance", totalAttendance);
        req.setAttribute("presentCount", presentCount);
        req.setAttribute("absentCount", totalAttendance - presentCount);
        req.setAttribute("attendancePercent", attendancePercent);
        req.setAttribute("recentAttendance", recentAttendance);
        req.setAttribute("disciplineCases", disciplineCases);
        req.setAttribute("disciplineCount", disciplineCases.size());

        req.setAttribute("pageTitle", "My Dashboard");
        req.setAttribute("contentPage", "/WEB-INF/views/dashboard/student_dashboard.jsp");
        req.setAttribute("currentPage", "student-dashboard");
        req.getRequestDispatcher("/WEB-INF/views/layout/main.jsp").forward(req, resp);
    }
}
