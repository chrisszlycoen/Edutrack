package com.code888.edutrack.dao;

import com.code888.edutrack.model.ClassRoom;
import com.code888.edutrack.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class ClassRoomDAO {

    public List<ClassRoom> getAllClasses() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM ClassRoom ORDER BY name", ClassRoom.class).list();
        }
    }

    public ClassRoom findById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(ClassRoom.class, id);
        }
    }

    public void save(ClassRoom classRoom) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(classRoom);
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            throw e;
        }
    }

    public void update(ClassRoom classRoom) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.merge(classRoom);
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
            ClassRoom classRoom = session.get(ClassRoom.class, id);
            if (classRoom != null) {
                session.remove(classRoom);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx != null)
                tx.rollback();
            throw e;
        }
    }
}
