package dsa_assignment.adt.DuplicationCheck;
//Yong Xue Er --- Duplicate part
//reference: classroom sample code

public interface ListInterface_duplicateCheck<T> {

  public boolean add(T newEntry);
  
//Description: add the new entry in the end of the list
//Precondition: make sure the not null or no empty
//Post condition: new entry is added in the end of the list
//Return: none

 public T remove(int givenPosition);
//Description: remove the object at the position within the list
//Precondition: given Position need to between 1 to total entries
//Post condition: the entry at position will be deleted from the list
//Return: will show the entry that removed from the list

  public void clear();

//Description: delete all the entries from the list
//Precondition: none
//Post condition: the list is empty now
//Return: none


  public boolean contains(T anEntry);
//Description: check whether the list contain entry
//Precondition: none
//Post condition: the list keep unchanged
//Return: none


  public int getNumberOfEntries();
//Description: get the number of entries
//Precondition: none
//Post condition: the list keep unchanged
//Return: return number of entries of the list


  public boolean isEmpty();
//Description: check whether the list is empty
//Precondition: none
//Post condition: the list keep unchanged
//Return: true if the list is empty, or false if not

  public boolean isFull();
//Description: check whether the list is full
//Precondition: none
//Post condition: the list keep unchanged
//Return: true if the list is empty, or false if not

  
   public int size();
//Description: check the size of the list
//Precondition: none
//Post condition: none
//Return: return size of the list

   
   public T get(int i);
   
//Description: get the data from the list
//Precondition: none
//Post condition: none
//Return: return data from the list

   
  public int Check();
//Description: check whether the list is duplicate object
//Precondition: list is not empty
//Post condition: duplicate object will be show out 
//Return: none
  

}



