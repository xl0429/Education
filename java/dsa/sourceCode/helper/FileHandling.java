package dsa_assignment.helper;

import dsa_assignment.entity.Course;
import dsa_assignment.entity.Faculty;
import dsa_assignment.entity.Student;
import dsa_assignment.adt.BinarySearch.arrayQueue;
import dsa_assignment.adt.BinarySearch.queueInterface;
import dsa_assignment.adt.DuplicationCheck.ListInterface_duplicateCheck;
import dsa_assignment.adt.DuplicationCheck.ArrayList_duplicateCheck;
import dsa_assignment.adt.Filter.ArrayList;
import dsa_assignment.adt.Filter.List;
import dsa_assignment.adt.Indexing.HashMap;
import dsa_assignment.adt.Indexing.Map;
import dsa_assignment.adt.Sorting.SortedArrayList;

import java.io.*;
import java.util.Scanner;
import dsa_assignment.adt.Sorting.SortedListInterface;

public class FileHandling {
    private int lastStudId;
    public FileHandling(){	
    }

    public int getLastId(String fileName){
    String lastLine =null;
    int lastId =0;
        try{
            FileInputStream in = new FileInputStream(fileName);
            BufferedReader br = new BufferedReader(new InputStreamReader(in)); 
            String strLine = null, tmp;
            while ((tmp = br.readLine()) != null)
               strLine = tmp;	
               lastLine = strLine;
       }catch(Exception e){}	
        String []  arrOfStr =lastLine.split(":");
        lastId = Integer.parseInt(arrOfStr[1].substring(2,7));         
       return lastId;
    }
        
    public static void append(String fName, String toFile) throws IOException {	//append string in to file
        try{
        File dir = new File(".");
        String loc = dir.getCanonicalPath() + File.separator + fName;	 
        FileWriter fstream = new FileWriter(loc, true);
        BufferedWriter out = new BufferedWriter(fstream);	 
        out.write(toFile);
        out.newLine();
        out.close();	//close buffer writer
        }catch(FileNotFoundException e){
            String [] file = fName.split("/"); 
            System.out.print(file[file.length-1] + " is not found");
        }
    }   
     public void readDisplay(String fileName){// display all from file
        try{		
            FileInputStream in = new FileInputStream(fileName);
            BufferedReader br = new BufferedReader(new InputStreamReader(in)); 
            String strLine = null, tmp;
            while ((tmp = br.readLine()) != null)
               System.out.println(tmp);	
        }catch(Exception e){
                System.out.print(fileName + " is not found");
        }
    }
    public List readFaculty(String fileName){//use return all faculty in txt file
         //Faculty [] fac =null;
         List <Faculty> fac = new ArrayList<>();
         try{		
            File f = new File(fileName);
            Scanner sc = new Scanner(f);
            while(sc.hasNextLine()){
               String line = sc.nextLine();
               String[] details = line.split(":");
               fac.add(new Faculty(details[0],details[1]));
            }
                
        }catch(FileNotFoundException e){
                 String [] file = fileName.split("/"); 
                System.out.print(file[file.length-1] + " is not found");
        }
         return fac;
     }
    
  
     
    public List readSelectedCourse(String fileName, String abbr){//use faculty to return its courses
         List course = new ArrayList();
         try{		
            File f = new File("src/data/course.txt");
            Scanner sc = new Scanner(f);
            while(sc.hasNextLine()){
                String line = sc.nextLine();
                String [] arrStr = line.split(":");
                if( arrStr[0].equals(abbr)){
                    for(int i = 0; i< arrStr.length -1; i++){
                        course.add(arrStr[i+1]);
                    }
                    break;
                }

            }
                
        }catch(FileNotFoundException e){
                 String [] file = fileName.split("/"); 
                System.out.print(file[file.length-1] + " is not found");
        }
         return course;
     }
    
    public String printAllStudent(){ //return count of students
        String  s ="";
        int count =0;
        try {
         
            File f = new File("src/data/student.txt");
            Scanner sc = new Scanner(f);//read file	
            //separate each element in a line with a variable
                s +=String.format("%-5s%-10s%-12s%-15s%-7s%-40s%-13s%-50s%-9s%-45s%-5s%-8s\n",
                        "No.","Stud ID", "First Name", "Last Name","Gender", "Email", 
                        "Phone No.","Address", "Faculty","Course", "Grp","Session");
                  s +=String.format("%-5s%-10s%-12s%-15s%-7s%-40s%-13s%-50s%-9s%-45s%-5s%-8s\n",
                        "---","-------", "----------", "---------","------", "-----", 
                        "---------","-------", "-------","------","---", "-------");
            while(sc.hasNextLine()){
                String line = sc.nextLine();
                String[] details = line.split(":");
                String studId = details[1];
                String fName = details[2];
                String lName = details[3];
                char gender =details[4].charAt(0);
                String email = details[5]; 
                String phoneNumber = details[6];
                String address =details[7];
                String faculty =details[8];
                String course =details[9];
                String tutorialGroup = details[10];
                String session =details[11];
                s +=String.format("%-5s%-10s%-12s%-15s%-7s%-40s%-13s%-50s%-9s%-45s%-5s%-8s\n",
                        count+1,studId, fName, lName,gender, email, 
                        phoneNumber,address, faculty,course,tutorialGroup, session);
                count++;
            }       
        }catch (FileNotFoundException e){         
            e.printStackTrace();
            System.out.printf("File is not found");          
        }
        
        return s +"\nCount of Student: "+ count;
    }
    
    public Map<Integer,Student> fileToHashMap(){ 
        Map<Integer,Student>  hmap =new HashMap<>();
        
        List<Student> s= splitDelimeter();
        for(int i=0;i<s.size();i++)
             hmap.put(s.get(i).getHashIndex(),s.get(i));
        return hmap;
    }
      
    public List <Student> fileToList(){
        List<Student> l= splitDelimeter();
        return l;
    }
    
    public ListInterface_duplicateCheck <Student> fileToListInterface_duplicateCheck(){
        ListInterface_duplicateCheck li = new ArrayList_duplicateCheck<>();
        List<Student> s= splitDelimeter();
        for(int i=0;i<s.size();i++)
            li.add(s.get(i));
        return li;
    }  
          
    public SortedListInterface fileToSortedList(){
        SortedListInterface <Student> q = new SortedArrayList<>();
        List<Student> s= splitDelimeter();
        for(int i=0;i<s.size();i++)
            q.add(s.get(i));
        return q;
    }
    
    public queueInterface fileToQueue(){
        queueInterface <Student> q = new arrayQueue<>();
        List<Student> s= splitDelimeter();
        for(int i=0;i<s.size();i++)
            q.enqueue(s.get(i));
        return q;
    }

    public List<Student> splitDelimeter(){
         List <Student> s = new ArrayList<>() ;
         int i =0;
         try {
            File f = new File("src/data/student.txt");
            Scanner sc = new Scanner(f);//read file	

            while(sc.hasNextLine()){
                String line = sc.nextLine();
                String[] details = line.split(":");
                int hashIndex = Integer.parseInt(details[0]);
                String studId = details[1];
                String fName = details[2];
                String lName = details[3];
                char gender =details[4].charAt(0);
                String email = details[5]; 
                String phoneNumber = details[6];
                String address =details[7];
                String faculty =details[8];
                String course =details[9];
                int tutorialGroup = Integer.parseInt(details[10]);
                String session =details[11];

                s.add(new Student(hashIndex,studId,fName,lName,gender,email, 
                        phoneNumber,address,new Faculty(faculty),
                        new Course(course),tutorialGroup,session));
                i++;
            }       
        }catch (FileNotFoundException e){         
            e.printStackTrace();
            System.out.printf("File is not found");          
        }
        return s;
    }
    
   /*  public static void a() throws IOException{
          String fileName = "src/data/student.txt";
          Map<Integer,Student>  hmap =new HashMap<>();
          List <Integer>hashMap = new ArrayList<>();
          int i = 0;
           try {
            File f = new File("src/data/Student_new.txt");
            Scanner sc = new Scanner(f);//read file	
            while(sc.hasNextLine()){
                String line = sc.nextLine();
                String[] details = line.split(":");
                String studId = details[0];
                String fName = details[1];
                String lName = details[2];
                char gender =details[3].charAt(0);
                String email = details[4]; 
                String phoneNumber = details[5];
                String address =details[6];
                String faculty =details[7];
                String course =details[8];
                int tutorialGroup = Integer.parseInt(details[9]);
                String session =details[10];
                       
                hmap.put(i ,new Student(i,
                    studId,fName,lName,gender,email,phoneNumber,address,
                    new Faculty(faculty),new Course(course),
                    tutorialGroup
                        ,session
                 ));
               hashMap =  hmap.getHashIndex();
               if(gender == 'G'){
                   gender = 'M';
               }
               
               Student s = new Student(hashMap.get(i),
                    studId,fName,lName,gender,email,phoneNumber,address,
                    new Faculty(faculty),new Course(course),
                   tutorialGroup,session);
               
               append(fileName, s.toFile());
               i++;
            }       
        }catch (FileNotFoundException e){         
            e.printStackTrace();
            System.out.printf("File is not found");          
        }
      }*/
}
