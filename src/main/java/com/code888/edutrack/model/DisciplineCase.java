package com.code888.edutrack.model;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "discipline_cases")
public class DisciplineCase {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "student_id", nullable = false)
    private Student student;

    // Teacher who reported the case
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "teacher_id", nullable = false)
    private User teacher;


    @Column(name = "case_type", nullable = false, length = 60)
    private String caseType;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "action_taken", length = 200)
    private String actionTaken;

    @Column(name = "case_date", nullable = false)
    private LocalDate caseDate;

    public DisciplineCase() {}

    public DisciplineCase(Student student, User teacher, String caseType,
                          String description, String actionTaken, LocalDate caseDate) {
        this.student = student;
        this.teacher = teacher;
        this.caseType = caseType;
        this.actionTaken = actionTaken;
        this.description = description; 
        this.caseDate = caseDate;
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

    public User getTeacher() {
        return teacher;
    }

    public void setTeacher(User teacher) {
        this.teacher = teacher;
    }

    public String getCaseType() {
        return caseType;
    }

    public void setCaseType(String caseType) {
        this.caseType = caseType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getActionTaken() {
        return actionTaken;
    }

    public void setActionTaken(String actionTaken) {
        this.actionTaken = actionTaken;
    }

    public LocalDate getCaseDate() {
        return caseDate;
    }

    public void setCaseDate(LocalDate caseDate) {
        this.caseDate = caseDate;
    }
}
