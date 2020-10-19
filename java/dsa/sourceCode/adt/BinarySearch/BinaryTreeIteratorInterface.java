package dsa_assignment.adt.BinarySearch;
//author: hong jin xuen
//reference: google classroom

public interface BinaryTreeIteratorInterface<T>{
  public IteratorInterface<T> getPreorderIterator();
     /*
      Description : arrange the binary tree data in preorder sequence
      Precondition: make sure the tree node is not null
      Postcondition: the data is arranged in preorder sequence
      Return: return the ouput in root left right sequence
      */
  public IteratorInterface<T> getPostorderIterator();
   /*
      Description : arrange the binary tree data in postorder sequence
      Precondition: make sure the tree node is not null
      Postcondition: the data is arranged in postorder sequence
      Return: return the data in left right root sequence
      */
  public IteratorInterface<T> getInorderIterator();
   /*
      Description : arrange the binary tree data in inorder sequence
      Precondition: make sure the tree node is not null
      Postcondition: the data is arranged in in order sequence
      Return: return the data in left root right sequence
      */
}
