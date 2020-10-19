
package dsa_assignment.adt.timeEfficiencyTest;
import dsa_assignment.adt.BinarySearch.BinarySearch;
import dsa_assignment.adt.BinarySearch.BinarySearchInterface;
import dsa_assignment.adt.BinarySearch.queueInterface;
import dsa_assignment.entity.Student;
import dsa_assignment.helper.FileHandling;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;


public class BinarySearchAlgorithm {
        
     public static void main(String[] args) {
        FileHandling f =new FileHandling();
        //System.out.println("Binary Search");
        BinarySearchInterface<String> bTree = new BinarySearch<>();
        Scanner input = new Scanner(System.in);
        //System.out.println("search for :");
        //String tree = input.nextLine();
        String tree="Rosamund";
        tree = tree.toUpperCase();
        
        Student stud = new Student();

       queueInterface <Student> q = f.fileToQueue();
       queueInterface <Student> tmp = f.fileToQueue();

       int size = q.size();
       String [] a =new String[size];
       String [] b =new String[size];
       String [] c =new String[size];
       
        for(int i=0; i< size;i++){
            stud = q.dequeue();
            a[i] = stud.getfName().toUpperCase();
            b[i] = stud.getlName().toUpperCase();
            c[i] = stud.getId().toUpperCase();
        }
        for(int i = 0;i< size;i++){
            bTree.add(a[i]);
            bTree.add(b[i]);
            bTree.add(c[i]);
        }
       
        Student s2 = new Student();
         
        
        long startTime = System.currentTimeMillis();
        long total = 0;
        for (int i = 0; i < 10000000; i++) {
           total += i;
        }
        
        if(bTree.contains(tree)){
            System.out.println("Record is Existed");
            for(int i=0;i<size;i++){
            stud =tmp.dequeue();
            if(bTree.getEntry(tree).equals(stud.getfName().toUpperCase())||
                    bTree.getEntry(tree).equals(stud.getlName().toUpperCase())||
                    bTree.getEntry(tree).equals(stud.getId().toUpperCase())){
                s2 = stud;
                 break;
            }
            }
            
            System.out.print("Result :\n");
            System.out.print(s2.toString());

        }
        else{
            System.out.println("Record is NOT Existed");
        }

       System.out.print("\n");
       long stopTime = System.currentTimeMillis();
       long elapsedTime = stopTime - startTime;
       System.out.println("Binary Tree Elapse Time :" + elapsedTime  +"ms");
        }
     
}
