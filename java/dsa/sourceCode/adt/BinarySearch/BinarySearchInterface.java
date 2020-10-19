package dsa_assignment.adt.BinarySearch;
//author: hong jin xuen
//reference: google classroom
public interface BinarySearchInterface<T extends Comparable<? super T>> extends BinaryTreeIteratorInterface<T> {
      public boolean contains(T entry);
      /*
      Description : check whether the entry is contain in the binary tree
      Precondition: make sure it is not null
      Postcondition: return true or false
      Return: true if data is contain in binary tree, false if data is not contain in binary tree
      */
      public T getEntry(T entry);
      /*
      Description : check whether the entry is contain in the binary tree and get the entry
      Precondition: make sure the root node is not null
      Postcondition: the data is get and return
      Return: return the data
      */
      public T add(T newEntry);
      /*
      Description : add data into binary tree
      Precondition: make sure it is not empty
      Postcondition: data is added into binary tree
      Return: return data 
      */
      public boolean isEmpty();
      /*
      Description : check whether the root is null 
      Precondition: none
      Postcondition: none
      Return: true if root is null, false if root is not null
      */
      public void clear();
      /*
      Description : clear the root
      Precondition: none
      Postcondition: the root is null or cleared
      Return: none
      */
}
