
package dsa_assignment.UI;

import dsa_assignment.adt.DuplicationCheck.ListInterface_duplicateCheck;
import dsa_assignment.entity.Student;
import dsa_assignment.helper.FileHandling;



public class DuplicationCheck_NoUI {
     public static void main(String[] args) {
        FileHandling f = new FileHandling();
        ListInterface_duplicateCheck <Student> li = f.fileToListInterface_duplicateCheck();
        li.Check();  
        System.out.print(li);
    }
}
