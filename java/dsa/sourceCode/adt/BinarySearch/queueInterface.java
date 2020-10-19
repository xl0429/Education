package dsa_assignment.adt.BinarySearch;
//author: hong jin xuen
//reference: google classroom
public interface queueInterface<T> {
    public void enqueue(T newEntry);
    /*
    Description: add the data into array queue 
    Precondition: check whether the array is full or not
    Postcondition: data is added into array queue
    Return: none
   */
    public T dequeue();
    /*
    Description: retrieve the data from array queue 
    Precondition: make sure it is not empty
    Postcondition: data is retrieved and return to user
    Return: data is return
    */
    public T getFront();
    /*
    Description: get the front data in array queue 
    Precondition: make sure it is not empty
    Postcondition: data from front index of array queue is retrieved and returned
    Return: data of front index is return 
    */
    public boolean isEmpty();
    /*
    Description: check whether front index is bigger than or smaller than back index, check whether the array queue is empty or not
    Precondition: none
    Postcondition: none 
    Return: true if is empty or front index is bigger than back index, false if it is not empty or front index is smaller than back index
    */
    public void clear();
    /*
    Description: clear the array queue
    Precondition:make sure the array queue is not empty
    Postcondition: array queue is cleared 
    Return:none
    */
    public int size();
    /*
    Description: check the size of the array queue
    Precondition:none
    Postcondition:none
    Return: return the size of array queue
    */
}
