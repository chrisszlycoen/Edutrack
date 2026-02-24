package com.code888.edutrack.model;

import java.time.LocalDate;

public class Person {

    private Integer id;
    private String firstName;
    private String lastName;
    private Gender gender;
    private Integer age;
    LocalDate dob;

    public Person() {}

    public Person(Integer id, String firstName, String lastName, Gender gender, Integer age) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.age = age;
    }
    public Person(Integer id, String firstName, String lastName, Gender gender, LocalDate dob) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.dob = dob;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }
    public LocalDate getDob() {
        return dob;
    }
    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public Integer getAge() {
        return LocalDate.now().getYear() - dob.getYear();
    }


    public boolean isChild() {
        return age != null && age < 18;
    }

    public String getFullName() {
        return firstName + " " + lastName;
    }
}

