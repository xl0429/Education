
package dsa_assignment.adt.timeEfficiencyTest;


import dsa_assignment.adt.DuplicationCheck.ListInterface_duplicateCheck;
import dsa_assignment.entity.Student;
import dsa_assignment.helper.FileHandling;

 public class DuplicationCheckAlgorithm {
     public static void main(String[] args) {

    
        FileHandling f = new FileHandling();
        ListInterface_duplicateCheck <Student> li = f.fileToListInterface_duplicateCheck();
         for(int times =0;times<10;times++){
            long startTime = System.currentTimeMillis();
            long total = 0;
            for (int i = 0; i < 10000000; i++) {
               total += i;
            }
            li.Check();
            long stopTime = System.currentTimeMillis();
            long elapsedTime = stopTime - startTime;
            System.out.println("DuplicationCheck " +(times+1)+" Elapse Time :" + elapsedTime  +"ms");
         }
            
       
        //System.out.print(li);
            
       
    }
}
