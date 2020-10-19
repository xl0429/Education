package dsa_assignment.adt.Sorting;
//author: Lee Shue Man
//reference: google classroom
//reference: https://drive.google.com/drive/u/1/folders/1Jb8guBemP6ghLOoVTj1YgxWO2M8K34xK 
public interface SortedListInterface<T> {

  /*
   description: add a new entry to the sorted list in its proper order
   precondition: null
   postcondition: the object to be added as a new entry
    return: true if the addition is successful
   */
  public boolean add(T newEntry);

  /*
  description: add data into the list in ascending order
  precondition: none / the iteem is not null
  postcondition: data is added to the list, the list size increased
  return: none / void
   */
  public boolean remove(T anEntry);

  /*
  description: to remove item from the list
  precondition: the list is not empty, data is not null, data is in the list
  postcondition: data is removed from the list, the list size reduced
  return: the index of the data
   */
  public int getPosition(T anEntry);

  /*
Description: get the position of object
Precondition: None
Postcondition: None
Return: The index of return object.
  */
  public T getEntry(int givenPosition);
  /*
Description: get the entry of object
Precondition: None
Postcondition: None
Return: The index of return object.

  */

  public boolean contains(T anEntry);
  /*
Description: Get object in boolean
Precondition: Check the object whether is smaller than length or equal to 0
Postcondition: return true when the result equal to the list
Return: the result of the data will return
  */

  public T remove(int givenPosition);
  /*
  description: to remove item from the list
  precondition: the list is not empty, data is not null, data is in the list
  postcondition: data is removed from the list, the list size reduced
  return: the index of the data
  */

  public void clear();
  /*
Description: Get object poition of the list
Precondition: None
Postcondition: None
Return: return if result equal to 0
  */

  public int getLength();
  /*
Description: Get the length of list
Precondition: None
Postcondition: None
Return: The index of return object.
  */

  public boolean isEmpty();
  /*
Description: check whether the list is empty or not
Precondition: None
Postcondition: None
Return: The index of return object if equal to 0.
  */

  public boolean isFull();
  /*
Description: check whether the list is full or not
Precondition: none
Postcondition: check the length whether equal to the list length
Return: return true is equal 0
  */
  
  public T get(int i);
  /*
Description: Get the object int
Precondition: None
Postcondition: None
Return: The index of data
  */
} // end SortedListInterface