package com.code888.edutrack.util;

import com.code888.edutrack.model.Attendance;
import com.code888.edutrack.model.ClassRoom;
import com.code888.edutrack.model.DisciplineCase;
import com.code888.edutrack.model.Student;
import com.code888.edutrack.model.User;
import org.hibernate.SessionFactory; 
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;
import org.hibernate.cfg.Environment;
import org.hibernate.service.ServiceRegistry;

import java.util.Properties;

public class HibernateUtil {
    private static SessionFactory sessionFactory;

    public static SessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            try {
                Configuration configuration = new Configuration();
                Properties settings = new Properties();

                settings.put(Environment.JAKARTA_JDBC_DRIVER, "com.mysql.cj.jdbc.Driver");

                settings.put(Environment.JAKARTA_JDBC_URL,
                        "jdbc:mysql://localhost:3306/edutrack_db?useSSL=false&serverTimezone=UTC&characterEncoding=utf8");

                settings.put(Environment.JAKARTA_JDBC_USER, "edutrack_user");
                settings.put(Environment.JAKARTA_JDBC_PASSWORD, "StrongPass@123");

                settings.put(Environment.DIALECT, "org.hibernate.dialect.MySQLDialect");

                settings.put(Environment.SHOW_SQL, "true");
                settings.put(Environment.FORMAT_SQL, "true");

                settings.put(Environment.HBM2DDL_AUTO, "update");

                settings.put(Environment.CURRENT_SESSION_CONTEXT_CLASS, "thread");

                configuration.setProperties(settings);

                configuration.addAnnotatedClass(User.class);
                configuration.addAnnotatedClass(ClassRoom.class);
                configuration.addAnnotatedClass(Student.class);
                configuration.addAnnotatedClass(Attendance.class);
                configuration.addAnnotatedClass(DisciplineCase.class);

                ServiceRegistry serviceRegistry = new StandardServiceRegistryBuilder()
                        .applySettings(configuration.getProperties())
                        .build();

                sessionFactory = configuration.buildSessionFactory(serviceRegistry);

            } catch (Exception e) {
                e.printStackTrace();
                throw new RuntimeException("Failed to create SessionFactory: " + e.getMessage());
            }
        }
        return sessionFactory;
    }

    public static void shutdown() {
        if (sessionFactory != null) {
            sessionFactory.close();
            sessionFactory = null;
        }
    }
}
