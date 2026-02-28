package com.code888.edutrack.model;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(
        name = "attendance",
        uniqueConstraints = {
                // prevents marking the same student twice on the same day 
                @UniqueConstraint(columnNames = {"student_id", "att_date"})
        }
)
public class Attendance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "class_id", nullable = false)
    private ClassRoom classRoom;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "teacher_id", nullable = false)
    private User teacher;

    @Column(name = "att_date", nullable = false)
    private LocalDate attDate;

    @Column(nullable = false, length = 10)
    private String status;

    public Attendance() {}

    public Attendance(Student student, ClassRoom classRoom, User teacher, LocalDate attDate, String status) {
        this.student = student;
        this.classRoom = classRoom;
        this.teacher = teacher;
        this.attDate = attDate;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public ClassRoom getClassRoom() {
        return classRoom;
    }

    public void setClassRoom(ClassRoom classRoom) {
        this.classRoom = classRoom;
    }

    public User getTeacher() {
        return teacher;
    }

    public void setTeacher(User teacher) {
        this.teacher = teacher;
    }

    public LocalDate getAttDate() {
        return attDate;
    }

    public void setAttDate(LocalDate attDate) {
        this.attDate = attDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
