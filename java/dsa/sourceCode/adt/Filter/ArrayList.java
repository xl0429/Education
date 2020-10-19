package dsa_assignment.adt.Filter;


public class ArrayList<T> implements List<T> {
    private T[] array;
    private int size;
    
    public ArrayList(){
        array = (T[])new Object[5];
        size = 0;
    }
    
    public void add(T item){
        if(item!=null){
            if(isFull()){
                expandArray();
            }  
            array[size] = item;
            size++;
        }
    }
    
    private boolean isFull(){
        if(size == array.length){
            return true;
        }
        else{
            return false;
        }
    }
    
    private void expandArray(){
        //assign array address to oldArray
        T[] oldArray = array;
        //create "new" array with double the size
        array = (T[])new Object[oldArray.length * 2];
        //copy value one by one from oldArray to array
        for(int i=0; i<oldArray.length; i++){
            array[i] = oldArray[i];
        }
        oldArray = null;
    }
    
    public int remove(T item)
    {
        int index = -1;
        if(item!=null && !isEmpty()){
            for(int i=0; i<size; i++){
                if(array[i].equals(item)){
                    shiftItemtoLeft(i);
                    size--;
                    index = i;
                }
            }
        }
        return index;
    }
     
    private void shiftItemtoLeft(int currentIndex){
        for(int i=currentIndex; i<size-1; i++){
            array[i] = array[i+1];
        }
        array[size-1]=null;
    }
     
    public boolean isEmpty(){
        if(size == 0){
            return true;
        }
        else{
            return false;
        }
    }
     
    public int size()
    {
        return size;
    }
     
    public String toString(){
        String str = "";
        for(int i=0; i<size; i++){
            str += array[i].toString() + "\n";
        }
        return str;
    }
     
    public T get(int index){
       return array[index];
    }
     
    public boolean filter(String word){
        boolean match = false;
        if(word.equals("amy")){
            System.out.println("Result found");
            match =true;
        }
        else
            System.out.println("Result is not found");
    return match;
    }
     public boolean contains(T entry){
         boolean found = false;
         for(int i=0;i<array.length;i++){
             if(entry.equals(array[i])){
                 found = true;
                 break;
             }
         }
         return found;
     }
}