package com.code888.edutrack.controller;

import com.code888.edutrack.dao.ClassRoomDAO;
import com.code888.edutrack.dao.StudentDAO;
import com.code888.edutrack.model.ClassRoom;
import com.code888.edutrack.model.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {

    private final StudentDAO studentDAO = new StudentDAO();
    private final ClassRoomDAO classDAO = new ClassRoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            handleDelete(req, resp);
            return;
        }

        List<Student> students = studentDAO.getAllStudents();
        List<ClassRoom> classes = classDAO.getAllClasses();

        req.setAttribute("students", students);
        req.setAttribute("classes", classes);
        req.setAttribute("contentPage", "/WEB-INF/views/modules/students.jsp");
        req.setAttribute("pageTitle", "Manage Students");
        req.setAttribute("currentPage", "students");
        req.getRequestDispatcher("/WEB-INF/views/layout/main.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("create".equals(action)) {
            createStudent(req, resp);
        } else if ("update".equals(action)) {
            updateStudent(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void createStudent(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            String regNo = req.getParameter("regNo");
            String fullName = req.getParameter("fullName");
            String gender = req.getParameter("gender");
            LocalDate dob = LocalDate.parse(req.getParameter("dob"));
            int classId = Integer.parseInt(req.getParameter("classId"));

            ClassRoom cls = classDAO.findById(classId);
            Student student = new Student(regNo, fullName, gender, dob);
            student.setClassRoom(cls);

            studentDAO.save(student);
            req.getSession().setAttribute("message", "Student added successfully.");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error adding student: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/students");
    }

    private void updateStudent(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String regNo = req.getParameter("regNo");
            String fullName = req.getParameter("fullName");
            String gender = req.getParameter("gender");
            LocalDate dob = LocalDate.parse(req.getParameter("dob"));
            int classId = Integer.parseInt(req.getParameter("classId"));

            Student student = studentDAO.findById(id);
            if (student != null) {
                student.setRegNo(regNo);
                student.setFullName(fullName);
                student.setGender(gender);
                student.setDob(dob);
                student.setClassRoom(classDAO.findById(classId));
                studentDAO.update(student);
                req.getSession().setAttribute("message", "Student updated successfully.");
            }
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error updating student: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/students");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            studentDAO.delete(id);
            req.getSession().setAttribute("message", "Student deleted successfully.");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error deleting student: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/students");
    }
}
