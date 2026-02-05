package com.code888.edutrack.controller;

import com.code888.edutrack.dao.ClassRoomDAO;
import com.code888.edutrack.model.ClassRoom;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/classes")
public class ClassRoomServlet extends HttpServlet {

    private final ClassRoomDAO classDAO = new ClassRoomDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("delete".equals(action)) {
            handleDelete(req, resp);
            return;
        }

        List<ClassRoom> classes = classDAO.getAllClasses();
        req.setAttribute("classes", classes);
        req.setAttribute("contentPage", "/WEB-INF/views/modules/classes.jsp");
        req.setAttribute("pageTitle", "Manage Classes");
        req.setAttribute("currentPage", "classes");
        req.getRequestDispatcher("/WEB-INF/views/layout/main.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("create".equals(action)) {
            createClass(req, resp);
        } else if ("update".equals(action)) {
            updateClass(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void createClass(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        String level = req.getParameter("level");

        ClassRoom cls = new ClassRoom(name, level);
        try {
            classDAO.save(cls);
            req.getSession().setAttribute("message", "Class created successfully.");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error creating class: " + e.getMessage());
        }
        resp.sendRedirect(req.getContextPath() + "/classes");
    }

    private void updateClass(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String level = req.getParameter("level");

        ClassRoom cls = classDAO.findById(id);
        if (cls != null) {
            cls.setName(name);
            cls.setLevel(level);
            try {
                classDAO.update(cls);
                req.getSession().setAttribute("message", "Class updated successfully.");
            } catch (Exception e) {
                req.getSession().setAttribute("error", "Error updating class: " + e.getMessage());
            }
        }
        resp.sendRedirect(req.getContextPath() + "/classes");
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            classDAO.delete(id);
            req.getSession().setAttribute("message", "Class deleted successfully.");
        } catch (Exception e) {
            req.getSession().setAttribute("error", "Error deleting class. Ensure no students depend on it.");
        }
        resp.sendRedirect(req.getContextPath() + "/classes");
    }
}

