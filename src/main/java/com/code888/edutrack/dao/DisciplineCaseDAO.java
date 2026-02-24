package com.code888.edutrack.dao;

import com.code888.edutrack.model.DisciplineCase;
import com.code888.edutrack.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class DisciplineCaseDAO {

    public List<DisciplineCase> getAllCases() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "FROM DisciplineCase dc JOIN FETCH dc.student s JOIN FETCH s.classRoom JOIN FETCH dc.teacher ORDER BY dc.caseDate DESC",
                    DisciplineCase.class).list();
        }
    }

    public void save(DisciplineCase disciplineCase) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(disciplineCase);
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            throw e;
        }
    }

    public long countPending() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("SELECT count(dc) FROM DisciplineCase dc", Long.class).uniqueResult();
        }
    }

    public List<DisciplineCase> getCasesByStudentRegNo(String regNo) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "FROM DisciplineCase dc JOIN FETCH dc.student s JOIN FETCH dc.teacher WHERE s.regNo = :regNo ORDER BY dc.caseDate DESC",
                    DisciplineCase.class).setParameter("regNo", regNo).list();
        }
    }
}

