package dsa_assignment.entity;

import dsa_assignment.helper.FileHandling;
import java.io.*;
import java.util.Calendar;
import java.util.Objects;
import java.util.Scanner;



public class Student extends Person implements Comparable<Person>{
    String fileName = "src/data/student.txt";
    FileHandling f = new FileHandling();
    private int hashIndex;
    private String id;
    private Faculty facultyAbbr;
    private Course courseName;
    private int tutorialGroup;
    private String session;

    public Student() {
    }

    public Student(String id,  String fName, String lName, char gender, 
            String email, String phoneNo, String address,Faculty facultyAbbr, 
            Course courseName, int tutorialGroup, String session) {
        super(fName, lName, gender, email, phoneNo, address);
        this.id = id;
        this.facultyAbbr = facultyAbbr;
        this.courseName = courseName;
        this.tutorialGroup = tutorialGroup;
        this.session = session;
    }

 
    
    public Student(int hashIndex,String id,  String fName, String lName, char gender, 
            String email, String phoneNo, String address,Faculty facultyAbbr, 
            Course courseName, int tutorialGroup, String session) {
        super(fName, lName, gender, email, phoneNo, address);
        this.hashIndex = hashIndex;
        this.id = id;
        this.facultyAbbr = facultyAbbr;
        this.courseName = courseName;
        this.tutorialGroup = tutorialGroup;
        this.session = session;
    }

    
    public String toFile(){//return String save to file
        return String.format("%s:%s:%s:%s:%s:%s:%s",hashIndex,id,super.toFile(), 
                facultyAbbr.getAbbreviation(), courseName.getCourseName(),tutorialGroup,session);
    }
   
    public static void main(String args[]){
        
       
    }
    public int getHashIndex() {
        return hashIndex;
    }
    
    public String generateNewId(){
        String year = (Calendar.getInstance().get(Calendar.YEAR)+"").substring(2); // last 2 value of year
        return  year+ (f.getLastId(fileName)+1);
    }
    
    public void savetoFile(){
        try{
             f.append(fileName, toFile());
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    public String getId() {
        return id;
    }

    public Faculty getFacultyAbbr() {
        return facultyAbbr;
    }

    public Course getCourseName() {
        return courseName;
    }

    public int getTutorialGroup() {
        return tutorialGroup;
    }

    public String getSession() {
        return session;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setFacultyAbbr(Faculty facultyAbbr) {
        this.facultyAbbr = facultyAbbr;
    }

    public void setCourseName(Course courseName) {
        this.courseName = courseName;
    }

    public void setTutorialGroup(int tutorialGroup) {
        this.tutorialGroup = tutorialGroup;
    }

    public void setSession(String session) {
        this.session = session;
    }
    
    public String headerText(){
        String s = "";
        s +=String.format("%-5s%-10s%-12s%-15s%-7s%-40s%-13s%-50s%-9s%-45s%-5s%-8s\n",
                        "No.","Stud ID", "First Name", "Last Name","Gender", "Email", 
                        "Phone No.","Address", "Faculty","Course", "Grp","Session");
        s +=String.format("%-5s%-10s%-12s%-15s%-7s%-40s%-13s%-50s%-9s%-45s%-5s%-8s\n",
              "---","-------", "----------", "---------","------", "-----", 
              "---------","-------", "-------","------","---", "-------");
        return s;
    }
   @Override
    public String toString() {
        return String.format("%-10s%-12s%-15s%-7s%-40s%-13s%-50s%-9s%-45s%-5s%-8s\n",
                        id, super.getfName(), super.getlName(),super.getGender(), super.getEmail(), 
                        super.getPhoneNo(),super.getAddress(), facultyAbbr.getAbbreviation(), courseName.getCourseName(),tutorialGroup, session);
    }
    
    @Override
    public int compareTo(Person s) {
    if(this.getfName() .compareTo(s.getfName()) > 0) return 1; 
    if(this.getfName().compareTo(s.getfName()) < 0 )
        return -1;
    else
        return 0;    
    }

    //duplication Check
    public int hashCode(){
        return Objects.hash(super.getEmail());
    }

    public boolean equals(Object obj){
        if (obj instanceof Person) {
            Person ppl = (Person) obj;
            return (ppl.getEmail().equals(super.getEmail()));
        } else {
            return false;
        }
    }

    
    
}
