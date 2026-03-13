package com.code888.edutrack.dao;

import com.code888.edutrack.util.HibernateUtil;
import com.code888.edutrack.model.Student;
import org.hibernate.Transaction;
import org.hibernate.Session;
import org.hibernate.query.Query;

import java.util.List;

/**
 * This is the student Data Access Object 
 */
public class StudentDAO {

    public List<Student> getAllStudents() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Student s JOIN FETCH s.classRoom ORDER BY s.classRoom.name, s.fullName",
                    Student.class).list();
        }
    }

    public List<Student> getStudentsByClass(int classId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Student> query = session.createQuery("FROM Student s WHERE s.classRoom.id = :cid ORDER BY s.fullName",
                    Student.class);
            query.setParameter("cid", classId);
            return query.list();
        }
    }

    public Student findById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Student s = session.get(Student.class, id);
            if (s != null) {
                // Initialize proxy
                s.getClassRoom().getName();
            }
            return s;
        }
    }

    public void save(Student student) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(student);
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            throw e;
        }
    }

    public void update(Student student) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.merge(student);
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            throw e;
        }
    }

    public void delete(int id) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            Student student = session.get(Student.class, id);
            if (student != null) {
                session.remove(student);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            throw e;
        }
    }

    public long count() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("SELECT count(s) FROM Student s", Long.class).uniqueResult();
        }
    }

    public Student findByRegNo(String regNo) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Student> query = session.createQuery(
                    "FROM Student s JOIN FETCH s.classRoom WHERE s.regNo = :regNo", Student.class);
            query.setParameter("regNo", regNo);
            return query.uniqueResult();
        }
    }
}

