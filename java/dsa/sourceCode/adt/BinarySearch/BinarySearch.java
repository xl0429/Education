package dsa_assignment.adt.BinarySearch;
import java.util.NoSuchElementException;

public class BinarySearch<T extends Comparable<? super T>> implements BinarySearchInterface<T>{
    
      private BinaryNode root;

  public BinarySearch() {
    root = null;
  }

  public BinarySearch(T rootData) {
    root = new BinaryNode(rootData);
  }

  public boolean contains(T entry) {
    return getEntry(entry) != null;
  }

  public T getEntry(T entry) {
    return findEntry(root, entry);
  }

  private T findEntry(BinaryNode rootNode, T entry) {
    T result = null;

    if (rootNode != null) {
      T rootEntry = rootNode.data;

      if (entry.equals(rootEntry)) {
        result = rootEntry;
      } else if (entry.compareTo(rootEntry) < 0) {
        result = findEntry(rootNode.left, entry);
      } else {
        result = findEntry(rootNode.right, entry);
      }
    }
    return result;
  }

  public T add(T newEntry) {
    T result = null;

    if (isEmpty()) {
      root = new BinaryNode(newEntry);
    } else {
      result = addEntry(root, newEntry);
    }

    return result;
  }

  
   // Task: Adds newEntry to the nonempty subtree rooted at rootNode.
   
  private T addEntry(BinaryNode rootNode, T newEntry) {
    T result = null;
    int comparison = newEntry.compareTo(rootNode.data);

    if (comparison == 0) {						
      result = rootNode.data;
      rootNode.data = newEntry;
    } else if (comparison < 0) {				
      if (rootNode.left != null) {
        result = addEntry(rootNode.left, newEntry);
      } else {
        rootNode.left = new BinaryNode(newEntry);
      }
    } else {														// newEntry > entry in root
      if (rootNode.right != null) {
        result = addEntry(rootNode.right, newEntry);
      } else {
        rootNode.right = new BinaryNode(newEntry);
      }
    }
    return result;
  }

  public boolean isEmpty() {
    return root == null;
  }

  public void clear() {
    root = null;
  }

  public IteratorInterface<T> getInorderIterator() {
    return new InorderIterator();
    //throw new UnsupportedOperationException();
  }

  public IteratorInterface<T> getPreorderIterator() {
    //throw new UnsupportedOperationException();
    return new PreorderIterator();
  }

  public IteratorInterface<T> getPostorderIterator() {
    throw new UnsupportedOperationException();
  }

  private class BinaryNode {

    private T data;
    private BinaryNode left;
    private BinaryNode right;

    private BinaryNode() {
      this(null);
    }

    private BinaryNode(T dataPortion) {
      this(dataPortion, null, null);
    }

    private BinaryNode(T data, BinaryNode left, BinaryNode right) {
      this.data = data;
      this.left = left;
      this.right = right;
    }

    private boolean isLeaf() {
      return (left == null) && (right == null);
    }
  }
    
  //arrange in inorder search
    private class InorderIterator implements IteratorInterface<T> {

    private queueInterface<T> queue = new arrayQueue<T>();

    public InorderIterator() {
      inorder(root);
    }

    private void inorder(BinaryNode treeNode) {
      if (treeNode != null) {
        inorder(treeNode.left);
        queue.enqueue(treeNode.data);
        inorder(treeNode.right);
      }
    }

    public boolean hasNext() {
      return !queue.isEmpty();
    }

    public T next() {
      if (!queue.isEmpty()) {
        return queue.dequeue();
      } else {
        throw new NoSuchElementException("Illegal call to next(); iterator is after end of list.");
      }
    }

    public void remove() {
      throw new UnsupportedOperationException();
    }
  }
   
  //arrange in preorder search      
private class PreorderIterator implements IteratorInterface<T> {

    private queueInterface<T> queue = new arrayQueue<T>();

    public PreorderIterator() {
      preorder(root);
    }

    private void preorder(BinaryNode treeNode) {
      if (treeNode != null) {
       queue.enqueue(treeNode.data);
       preorder(treeNode.left); 
       preorder(treeNode.right);
      }
    }

    public boolean hasNext() {
      return !queue.isEmpty();
    }

    public T next() {
      if (!queue.isEmpty()) {
        return queue.dequeue();
      } else {
        throw new NoSuchElementException("Illegal call to next(); iterator is after end of list.");
      }
    }

    public void remove() {
      throw new UnsupportedOperationException();
    }
  }

//arrange in postorder search
//private class PostorderIterator implements IteratorInterface<T> {
//
//    private queueInterface<T> queue = new arrayQueue<T>();
//
//    public PostorderIterator() {
//      postorder(root);
//    }

//    private void postorder(BinaryNode treeNode) {
//      if (treeNode != null) {
//        postorder(treeNode.left);
//        postorder(treeNode.right);
//        queue.enqueue(treeNode.data);
//      }
//    }
//
//    public boolean hasNext() {
//      return !queue.isEmpty();
//    }
//
//    public T next() {
//      if (!queue.isEmpty()) {
//        return queue.dequeue();
//      } else {
//        throw new NoSuchElementException("Illegal call to next(); iterator is after end of list.");
//      }
//    }
//
//    public void remove() {
//      throw new UnsupportedOperationException();
//    }
//  }
}
    