package dsa_assignment.adt.timeEfficiencyTest;

import dsa_assignment.adt.Filter.ArrayList;
import dsa_assignment.adt.Filter.List;
import dsa_assignment.adt.Indexing.Map;
import dsa_assignment.entity.Student;
import dsa_assignment.helper.FileHandling;
import java.util.Scanner;

public class IndexingAlgorithm {
     public static void main(String[] args) 
    { 
        
        FileHandling f= new FileHandling();
        Scanner sc = new Scanner(System.in);

        Map<Integer, Student> map= f.fileToHashMap();
        List <Student> studList =  f.fileToList(); // get all students from file
        List <Integer> hashIndexList = new ArrayList<>();
        
        //System.out.println("Please enter id /first name /last name to search: ");
        //String searchStr = sc.next();
        String searchStr = "Rosamund";
        searchStr = searchStr.toUpperCase();
        
        //get hashIndex of student which contains the search string and add to hashIndexList
        for(int i=0; i< studList.size();i++){ 
            String id = studList.get(i).getId();
            String fName = studList.get(i).getfName().toUpperCase();
            String lName = studList.get(i).getlName().toUpperCase();

            if(id.contains(searchStr) ||fName.contains(searchStr)
                    ||lName.contains(searchStr) )
                 hashIndexList.add(studList.get(i).getHashIndex());
        }
        
        for(int times = 0;times < 10;times++){    
            long startTime = System.currentTimeMillis();
            long total = 0;
            for (int i = 0; i < 10000000; i++) {
               total += i;
            }
            /*
                to get the value(Students) mapping with the key(hashIndex) 
                in the hashIndexList
            */ 
            if(hashIndexList.size()> 0){
            for(int i=0;i<hashIndexList.size();i++) 
                if(map.containsKey(hashIndexList.get(i))){
                    //System.out.println(String.format("%-5s%s",(i+1),
                    //        map.get(hashIndexList.get(i))));
                    map.get(hashIndexList.get(i));
                }
            }else{
                System.out.println("No record found");
            }                   
            long stopTime = System.currentTimeMillis();
            long elapsedTime = stopTime - startTime;
            System.out.println("Indexing " +(times+1)+" Elapse Time :" + elapsedTime  +"ms");
        }
    } 
     
  
}
