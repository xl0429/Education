
package dsa_assignment.adt.timeEfficiencyTest;

import dsa_assignment.adt.Filter.List;
import dsa_assignment.entity.Student;
import dsa_assignment.helper.FileHandling;
import java.util.Scanner;

/**
 *
 * @author user
 */
public class FilterAlgorithm {
   public static void main (String[] args){

       Scanner sc =new Scanner(System.in);
       
       //System.out.println("Please enter id /first name /last name to search: ");

       //String searchStr = sc.next(); 

       FileHandling f = new FileHandling();
       List <Student> stud =  f.fileToList();
       Student s =new Student();
       boolean found = false;
        int count =0 ;
        String searchStr = "Rosamund";
        searchStr = searchStr.toUpperCase();
      // System.out.print(s.headerText());
       for(int times = 0;times < 10;times++){
            long startTime = System.currentTimeMillis();
            long total = 0;
            for (int i = 0; i < 10000000; i++) {
               total += i;
            }
           for(int i =0;i < stud.size();i++){
               boolean idCondition= stud.get(i).getId().toUpperCase().contains(searchStr);
               boolean fNameCondition= stud.get(i).getfName().toUpperCase().contains(searchStr);
               boolean lNameCondition=stud.get(i).getlName().toUpperCase().contains(searchStr);
             //  String aa= Character.toUpperCase(searchStr.charAt(0)) + "";
             //  String bb = Character.toUpperCase(stud.get(i).getGender()) + "";
             //  boolean genderCondition =  aa.equals(bb);
             //  boolean phoneNoCondition=stud.get(i).getPhoneNo().toUpperCase().contains(searchStr); 
             //  boolean addressCondition=stud.get(i).getAddress().toUpperCase().contains(searchStr);
             //  boolean facultyAbbrCondition=stud.get(i).getFacultyAbbr().getAbbreviation().toUpperCase().contains(searchStr);
              // boolean courseNameCondition=stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr);


                //filter id first name and last name
            if(idCondition||fNameCondition||lNameCondition){

                //Gender == firstname(Search)
            //if((stud.get(i).getGender()+"").equals("F") && stud.get(i).getfName().toUpperCase().contains(searchStr)){
            //if((stud.get(i).getGender()+"").equals("G") && stud.get(i).getfName().toUpperCase().contains(searchStr)){

                //Gender == lastname(Search)
            //if((stud.get(i).getGender()+"").equals("F") && stud.get(i).getlName().toUpperCase().contains(searchStr)){
            //if((stud.get(i).getGender()+"").equals("G") && stud.get(i).getlName().toUpperCase().contains(searchStr)){    

                //Gender == address(Search)
            //if((stud.get(i).getGender()+"").equals("F") && stud.get(i).getAddress().toUpperCase().contains(searchStr)){    
            //if((stud.get(i).getGender()+"").equals("G") && stud.get(i).getAddress().toUpperCase().contains(searchStr)){ 

                //Gender == faculty(Search)
            //if((stud.get(i).getGender()+"").equals("F") && stud.get(i).getFacultyAbbr().getAbbreviation().toUpperCase().contains(searchStr)){     
            //if((stud.get(i).getGender()+"").equals("G") && stud.get(i).getFacultyAbbr().getAbbreviation().toUpperCase().contains(searchStr)){ 

                //Facuty == course(Search)
            //if(stud.get(i).getFacultyAbbr().getAbbreviation().equals("FOCS") && stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr)){   
            //if(stud.get(i).getFacultyAbbr().getAbbreviation().equals("FAFB") && stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr)){  
            //if(stud.get(i).getFacultyAbbr().getAbbreviation().equals("FOET") && stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr)){  
            //if(stud.get(i).getFacultyAbbr().getAbbreviation().equals("FOAS") && stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr)){  

                //Gender (F) == faculty == course(Search)
            //if((stud.get(i).getGender()+"").equals("F") && stud.get(i).getFacultyAbbr().getAbbreviation().equals("FOCS") && stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr)){    
            //if((stud.get(i).getGender()+"").equals("F") && stud.get(i).getFacultyAbbr().getAbbreviation().equals("FAFB") && stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr)){    
            //if((stud.get(i).getGender()+"").equals("F") && stud.get(i).getFacultyAbbr().getAbbreviation().equals("FOET") && stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr)){    
            //if((stud.get(i).getGender()+"").equals("F") && stud.get(i).getFacultyAbbr().getAbbreviation().equals("FOAS") && stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr)){    

                //Gender (M) == faculty == course(Search)
            //if((stud.get(i).getGender()+"").equals("M") && stud.get(i).getFacultyAbbr().getAbbreviation().equals("FOCS") && stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr)){    
            //if((stud.get(i).getGender()+"").equals("M") && stud.get(i).getFacultyAbbr().getAbbreviation().equals("FAFB") && stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr)){    
            //if((stud.get(i).getGender()+"").equals("M") && stud.get(i).getFacultyAbbr().getAbbreviation().equals("FOET") && stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr)){    
            //if((stud.get(i).getGender()+"").equals("M") && stud.get(i).getFacultyAbbr().getAbbreviation().equals("FOAS") && stud.get(i).getCourseName().getCourseName().toUpperCase().contains(searchStr)){        
                stud.get(i);
                   //System.out.print(stud.get(i));
                    found =true;

                    count++;
                }
           }
            long stopTime = System.currentTimeMillis();
            long elapsedTime = stopTime - startTime;
            System.out.println("Filter " +(times+1)+" Elapse Time :" + elapsedTime  +"ms");
       }
       System.out.println("Total Record = " + count);
       
       if(!found)
            System.out.println("No record found");
    } 
}
