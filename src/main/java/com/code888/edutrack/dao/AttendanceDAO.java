package com.code888.edutrack.dao;

import com.code888.edutrack.model.Attendance;
import com.code888.edutrack.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.time.LocalDate;
import java.util.List;

public class AttendanceDAO {

    public List<Attendance> getAttendanceByClassAndDate(int classId, LocalDate date) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Attendance> query = session.createQuery(
                    "FROM Attendance a WHERE a.classRoom.id = :cid AND a.attDate = :date", Attendance.class);
            query.setParameter("cid", classId);
            query.setParameter("date", date);
            return query.list();
        }
    }

    public void saveOrUpdate(Attendance attendance) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            // Check if exists
            Query<Attendance> q = session.createQuery(
                    "FROM Attendance a WHERE a.student.id = :sid AND a.attDate = :date", Attendance.class);
            q.setParameter("sid", attendance.getStudent().getId());
            q.setParameter("date", attendance.getAttDate());
            Attendance existing = q.uniqueResult();

            if (existing != null) {
                existing.setStatus(attendance.getStatus());
                existing.setTeacher(attendance.getTeacher()); // Update teacher if changed?
                session.merge(existing);
            } else {
                session.persist(attendance);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            throw e;
        }
    }

    public List<Attendance> getAttendanceByStudentRegNo(String regNo) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Attendance> query = session.createQuery(
                    "FROM Attendance a JOIN FETCH a.classRoom WHERE a.student.regNo = :regNo ORDER BY a.attDate DESC",
                    Attendance.class);
            query.setParameter("regNo", regNo);
            return query.list();
        }
    }

    public long countPresentByStudentRegNo(String regNo) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Long count = session.createQuery(
                    "SELECT count(a) FROM Attendance a WHERE a.student.regNo = :regNo AND a.status = 'PRESENT'",
                    Long.class).setParameter("regNo", regNo).uniqueResult();
            return count != null ? count : 0;
        }
    }

    public long countTotalByStudentRegNo(String regNo) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Long count = session.createQuery(
                    "SELECT count(a) FROM Attendance a WHERE a.student.regNo = :regNo",
                    Long.class).setParameter("regNo", regNo).uniqueResult();
            return count != null ? count : 0;
        }
    }
}
