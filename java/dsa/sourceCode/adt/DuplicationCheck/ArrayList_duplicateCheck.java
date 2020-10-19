package dsa_assignment.adt.DuplicationCheck;
import dsa_assignment.entity.Student;
import dsa_assignment.helper.FileHandling;
import java.util.Scanner;
import javax.swing.JButton;


public class ArrayList_duplicateCheck<T> implements ListInterface_duplicateCheck <T> {
  private T[] list; // array of list entries
  private int numberOfEntries;
  private static final int DEFAULT_INITIAL_CAPACITY = 25;

  // default constructor
  public ArrayList_duplicateCheck() {
    this(DEFAULT_INITIAL_CAPACITY);
  } 

  // constructor
  public ArrayList_duplicateCheck(int initialCapacity) {
    numberOfEntries = 0; 
   // @SuppressWarnings("unchecked")
    T[] tempList = (T[]) new Object[initialCapacity];
    list = tempList;
  } 

  public boolean add(T newEntry) {
    if (isArrayFull()) {
      expandArray();
    }

    list[numberOfEntries] = newEntry;
    numberOfEntries++;
    return true;
  }


  public T remove(int givenPosition) {
    T result = null;

    if ((givenPosition >= 1) && (givenPosition <= numberOfEntries)) {
      result = list[givenPosition - 1];

      if (givenPosition < numberOfEntries) {
        removeGap(givenPosition);
      }

      numberOfEntries--;
    }

    return result;
  }
  
   private void removeGap(int givenPosition) {
    // move each entry to next lower position starting at entry after tp
    // one removed and continuing until end of list
    int removedIndex = givenPosition - 1;
    int lastIndex = numberOfEntries - 1;

    for (int index = removedIndex; index < lastIndex; index++) {
      list[index] = list[index + 1];
    }
  }


  public void clear() {
    numberOfEntries = 0;
  }
 
  //duplicate part extra add
  public int Check() {
    FileHandling f = new FileHandling();
    ListInterface_duplicateCheck <Student> li = f.fileToListInterface_duplicateCheck();
    int index = -1;
    for (int i = 0; i < numberOfEntries; i++) {
      for (int j = i+1; j < numberOfEntries; j++) {
          if(list[i].equals(list[j])){
            System.out.println("\nDuplicate Indexes: " + i +"_and_"+ j);
            System.out.println("Dupliate Object:\n"+ list[i] + list[j]);
            index = j;
            RemoveDuplicate(index);
            //remove(index);
        }
      }
    }
    return index;
  }   //reference: 1.https://coderanch.com/t/667505/java/Ways-Remove-Duplicates-ArrayList
       //          2.https://stackoverflow.com/questions/15181395/removing-duplicates-from-a-list-in-java-using-iterators

  private void RemoveDuplicate(int index) {
    Scanner sc = new Scanner(System.in);
    System.out.print("\nDo you want to remove the duplicate object at: " + index + "\n(Yes/Y or No/N)?=");
    
    //    if(ans.equals("Yes") || ans.equals("Y")){
    //      remove(index);
    //    }
    String answer = sc.nextLine();
    answer = answer.toUpperCase();
    switch(answer){
       case "YES":
       case "Y":
            remove(index);
             System.out.println("\nThe duplicate objects has been deleted!! ");
        break;
      case "NO":
       case "N":
            System.out.println("\nThe duplicate objects has been remained!! ");
            break;
   }

  }

  public boolean contains(T anEntry) {
    boolean found = false;
    for (int index = 0; !found && (index < numberOfEntries); index++) {
      if (anEntry.equals(list[index])) {
        found = true;
      }
    }

    return found;
  }

  public int getNumberOfEntries() {
    return numberOfEntries;
  }

  public boolean isEmpty() {
    return numberOfEntries == 0;
  }
  public int size(){
      return numberOfEntries;
  }
  public T get(int index){
      return list[index];
  }

  public boolean isFull() {
    return false;
  }

  public String toString() {
    String outputStr = "";
    for (int index = 0; index < numberOfEntries; ++index) {
      outputStr += list[index] + "\n";
    }

    return outputStr;
  }

  private boolean isArrayFull() {
    return numberOfEntries == list.length;
  }

 
  private void  expandArray() {
    T[] oldList = list; // save reference to array of list entries
    int oldSize = oldList.length;     // save old max size of array

    list = (T[]) new Object[2 * oldSize];    // double size of array

  
    for (int index = 0; index < oldSize; index++) {
      list[index] = oldList[index];
    }
  } 

 
  
} 


