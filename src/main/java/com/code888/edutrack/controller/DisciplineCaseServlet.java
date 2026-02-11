package com.code888.edutrack.controller;

import com.code888.edutrack.dao.DisciplineCaseDAO;
import com.code888.edutrack.dao.StudentDAO;
import com.code888.edutrack.model.DisciplineCase;
import com.code888.edutrack.model.Student;
import com.code888.edutrack.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException; 
import java.time.LocalDate;
import java.util.List;

@WebServlet("/discipline")
public class DisciplineCaseServlet extends HttpServlet {

    private final DisciplineCaseDAO caseDAO = new DisciplineCaseDAO();
    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<DisciplineCase> cases = caseDAO.getAllCases();
        List<Student> allStudents = studentDAO.getAllStudents(); // For the modal dropdown

        req.setAttribute("disciplineCases", cases);
        req.setAttribute("allStudents", allStudents);
        req.setAttribute("contentPage", "/WEB-INF/views/modules/discipline.jsp");
        req.setAttribute("pageTitle", "Discipline Management");
        req.setAttribute("currentPage", "discipline");
        req.getRequestDispatcher("/WEB-INF/views/layout/main.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("create".equals(action)) {
            createCase(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void createCase(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int studentId = Integer.parseInt(req.getParameter("studentId"));
            String caseType = req.getParameter("caseType");
            LocalDate caseDate = LocalDate.parse(req.getParameter("caseDate"));
            String description = req.getParameter("description");
            String actionTaken = req.getParameter("actionTaken");
            User teacher = (User) req.getSession().getAttribute("user");

            Student student = studentDAO.findById(studentId);

            DisciplineCase dc = new DisciplineCase(student, teacher, caseType, description, actionTaken, caseDate);
            caseDAO.save(dc);

            req.getSession().setAttribute("message", "Discipline case reported.");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error creating case: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/discipline");
    }
}
