package dsa_assignment.adt.Filter;
//author: amilia lee fang zi
//reference: google classroom
public interface List<T> {
     public void add(T item);
    /*
    description: Add item to the list
    precondition: Item is not null
    postcondition: Item is added to the list
    return: None
    */

    public int remove(T item);
    /*
    description: Remove the item from the list
    precondition: List is not empty
    postcondition: List size is reduced
    return: The index of the data
    */

    public boolean isEmpty();
    /*
    description: Check the item is empty or not 
    precondition: None
    postcondition: None
    return: When true is empty, else return false
    */

    public int size();
    /*
    description: Check the size of List
    precondition: None
    postcondition: None
    return: Return size of list
    */
    
    public T get(int index);
    /*
    description: Get object in index
    precondition: None
    postcondition: None
    return: The index of return object
    */

    public boolean filter(String word);
    /*
    description: Filter item in the list
    precondition: None
    postcondition: None
    return: The index of return object
    */

    public boolean contains(T entry);
    /*
    description: to check whether the object is contain in the list
    precondition: None
    postcondition: None
    return: return true if exist, false if no exist
    */

}
