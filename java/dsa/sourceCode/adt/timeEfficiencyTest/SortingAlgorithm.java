
package dsa_assignment.adt.timeEfficiencyTest;
import dsa_assignment.adt.Sorting.SortedListInterface;
import dsa_assignment.entity.Student;
import dsa_assignment.helper.FileHandling;
import java.util.*;

public class SortingAlgorithm {
    public static void main(String[]  args){
        FileHandling f = new FileHandling();
        Student stud = new Student();
        for(int times =0;times<10;times++){
            long startTime = System.currentTimeMillis();
            long total = 0;
            for (int i = 0; i < 10000000; i++) {
               total += i;
            }
            SortedListInterface s =f .fileToSortedList();
            long stopTime = System.currentTimeMillis();
            long elapsedTime = stopTime - startTime;
            System.out.println("SortedArrayList " +(times+1)+" Elapse Time :" + elapsedTime  +"ms");
        }
        /*
        int size = s.getLength()>10? 10:s.getLength();
        if(size!=0){
            System.out.print(stud.headerText());
            ;
            for(int i=0;i<size;i++)
                System.out.print(String.format("%-5s%s",(i+1),s.get(i)));
        }else{
            System.out.println("No record found!");
        }*/
    }
}
