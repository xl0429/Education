
package dsa_assignment.entity;

public class Faculty {
    private String abbreviation;
    private String FacultyName;
    private Course [] courseName;

    public Faculty() {
    }

    public Faculty(String abbreviate) {
        this.abbreviation = abbreviate;
    }

    public Faculty(String abbreviation, String FacultyName) {
        this.abbreviation = abbreviation;
        this.FacultyName = FacultyName;
    }
    
    
    
    public String getAbbreviation() {
        return abbreviation;
    }

    public String getFacultyName() {
        return FacultyName;
    }

    public Course[] getCourseName() {
        return courseName;
    }



    public void setAbbreviation(String abbreviate) {
        this.abbreviation = abbreviate;
    }

    public void setFacultyName(String FacultyName) {
        this.FacultyName = FacultyName;
    }

    public void setCourseName(Course[] courseName) {
        this.courseName = courseName;
    }
    
   
    
}
