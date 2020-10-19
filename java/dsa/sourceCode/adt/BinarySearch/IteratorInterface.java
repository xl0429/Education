package dsa_assignment.adt.BinarySearch;
//author: hong jin xuen
//reference: google classroom
public interface IteratorInterface<T> {
  public boolean hasNext();
    /*
    Description: check whether the array queue has next index
    Precondition: none 
    Postcondition: none
    Return: true if the array queue has next line, false if array queue does not have next line
    */
    public T next();
    /*
    Description: get the element from array queue and return it 
    Precondition: queue is not empty
    Postcondition: get and return the element from array queue
    Return: return the element from array queue
    */
    public void remove();
    /*
    Description: throw the operation to unsupported operation exception 
    Precondition: none
    Postcondition:none
    Return: none
    */
}
