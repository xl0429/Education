package dsa_assignment.adt.BinarySearch;
//author: hong jin xuen
//reference: google classroom
public class arrayQueue<T> implements queueInterface<T> {

  private T[] queue;
  private final static int frontIndex = 0;
  private int backIndex;
  private static final int DEFAULT_INITIAL_CAPACITY = 50;

  public arrayQueue() {
    this(DEFAULT_INITIAL_CAPACITY);
  } // end default constructor

  public arrayQueue(int initialCapacity) {
    queue = (T[]) new Object[initialCapacity];
    backIndex = -1;
  } // end constructor

  public void enqueue(T newEntry) {
    if (isArrayFull()) // isArrayFull and
    {
      doubleArray();   // doubleArray are private
    }
    backIndex++;
    queue[backIndex] = newEntry;
  } // end enqueue

  public T getFront() {
    T front = null;

    if (!isEmpty()) {
      front = queue[frontIndex];
    }

    return front;
  } // end getFront

  public T dequeue() {
    T front = null;

    if (!isEmpty()) {
      front = queue[frontIndex];

      // shift remaining queue items forward one position
      for (int i = frontIndex; i < backIndex; ++i) {
        queue[i] = queue[i + 1];
      }

      backIndex--;
    } // end if

    return front;
  } // end dequeue

  public boolean isEmpty() {
    return frontIndex > backIndex;
  } // end isEmpty

  public void clear() {
    if (!isEmpty()) { // deallocates only the used portion
      for (int index = frontIndex; index <= backIndex; index++) {
        queue[index] = null;
      } // end for

      backIndex = -1;
    } // end if
  } // end clear

  private boolean isArrayFull() {
    return backIndex == queue.length - 1;
  } // end isArrayFull

  private void doubleArray() {
    T[] oldQueue = queue;
    int oldSize = oldQueue.length;

    queue = (T[]) new Object[2 * oldSize];

    for (int index = 0; index < oldSize; index++) {
      queue[index] = oldQueue[index];
    } // end for
  } // end doubleArray
  
  public int size(){
      return backIndex+1;
  }
}  // end ArrayQueue