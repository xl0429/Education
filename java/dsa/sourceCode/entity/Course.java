package dsa_assignment.entity;

public class Course {
    private String courseName;


    public Course() {
    }

    public Course(String courseName) {
        this.courseName = courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCourseName() {
        return courseName;
    }
}
