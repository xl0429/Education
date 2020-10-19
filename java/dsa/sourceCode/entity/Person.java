
package dsa_assignment.entity;

public class Person {
    private String fName;
    private String lName;
    private char gender;
    private String email;
    private String phoneNo;
    private String address;

    public Person() {
    }

    public Person(String fName,String lName, char gender, String email, String phoneNo, String address) {
        this.fName = fName;
        this.lName = lName;
        this.gender = gender;
        this.email = email;
        this.phoneNo = phoneNo;
        this.address = address;
    }

    public String getfName() {
        return fName;
    }

    public String getlName() {
        return lName;
    }

    public char getGender() {
        return gender;
    }

    public String getEmail() {
        return email;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public String getAddress() {
        return address;
    }

    public void setfName(String fName) {
        this.fName = fName;
    }

    public void setlName(String lName) {
        this.lName = lName;
    }

    public void setGender(char gender) {
        this.gender = gender;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public void setAddress(String address) {
        this.address = address;
    }
    public String toFile(){
    	return fName +':' + lName + ':' + gender +  ':' +email+  ':' + phoneNo+  ':' + address; 
    }
    public String toString(){
    	return String.format("%-15s%-15s%-15s%-15s%-15s%-15s",fName, lName, gender, email, phoneNo, address);
    }
    
    
    
}
