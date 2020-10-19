package dsa_assignment.adt.Sorting;

public class SortedArrayList<T extends Comparable<? super T>> implements SortedListInterface<T> {

  private T[] list;
  private int length;
  private static final int DEFAULT_INITIAL_CAPACITY = 1;

  public SortedArrayList() {
    this(DEFAULT_INITIAL_CAPACITY);
  }

  public SortedArrayList(int initialCapacity) {
    length = 0;
    list = (T[]) new Comparable[initialCapacity];
  }

  public boolean add(T newEntry) {
    int i = 0;
    if(isFull()){
        doubleArray();
     }  
    while (i < length && newEntry.compareTo(list[i]) > 0) {
      i++;
    }
    makeRoom(i + 1);
    list[i] = newEntry;
    length++;
    return true;
  }
  

  public boolean remove(T anEntry) {
    throw new UnsupportedOperationException();
  }

  public int getPosition(T anEntry) {
    throw new UnsupportedOperationException();
  }

  public T remove(int givenPosition) {
    T result = null;

    if ((givenPosition >= 1) && (givenPosition <= length)) {
      result = list[givenPosition - 1];
      if (givenPosition < length) {
        removeGap(givenPosition);
      }
      length--;
    }

    return result;
  }

  public void clear() {
    length = 0;
  }

  public T getEntry(int givenPosition) {
    T result = null;

    if ((givenPosition >= 1) && (givenPosition <= length)) {
      result = list[givenPosition - 1];
    }

    return result;
  }

  public boolean contains(T anEntry) {
    boolean found = false;
    for (int index = 0; !found && (index < length); index++) {
      if (anEntry.equals(list[index])) {
        found = true;
      }
    }

    return found;
  }

  public int getLength() {
    return length;
  }

  public boolean isEmpty() {
    return length == 0;
  }

  public boolean isFull() {
        if(length == list.length){
            return true;
        }
        else{
            return false;
        }
  }

  public String toString() {
    String outputStr = "";
    for (int index = 0; index < length; ++index) {
      outputStr += list[index] + "\n";
    }

    return outputStr;
  }

  private boolean isArrayFull() {
    return length == list.length;
  }


  
  private void doubleArray(){
    
        //assign array address to oldArray
        T[] oldArray = list;
        int oldSize = oldArray.length;
        int newSize =2 * oldSize;
        //create "new" array with double the size
         list = (T[] ) new  Comparable[newSize];
        //copy value one by one from oldArray to array
        for(int i=0; i<oldArray.length; i++){
            list[i] = oldArray[i];
        }
        oldArray = null;
    }

  private void makeRoom(int newPosition) {
    int newIndex = newPosition - 1;
    int lastIndex = length - 1;

    for (int index = lastIndex; index >= newIndex; index--) {
      list[index + 1] = list[index];
    }
  }

  private void removeGap(int givenPosition) {
    int removedIndex = givenPosition - 1;
    int lastIndex = length - 1;

    for (int index = removedIndex; index < lastIndex; index++) {
      list[index] = list[index + 1];
    }
  }
  
  public T get(int i){
      return list[i];
  }
  
}