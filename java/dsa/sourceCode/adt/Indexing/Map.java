package dsa_assignment.adt.Indexing;

//author: Tan Xin Li
//reference: https://dzone.com/articles/custom-hashmap-implementation-in-java
//reference: https://docs.oracle.com/javase/8/docs/api/java/util/Map.html 
//reference: https://docs.oracle.com/javase/8/docs/api/java/util/HashMap.html

import dsa_assignment.adt.Filter.List;

public interface Map <K,V>{
    public void put(K key, V value) ;
    /*
        Description : To add the key and value into the map
        Precondition: The size of bucket should not be full
        Postcondition: The key and value is added into the map
        Return: none
      */
    public V get(Object key) ;
     /*
      Description : to return the value of the inputted mapping key or null 
                    if this map contains no mapping for the key
      Precondition: none
      Postcondition: none
      Return: return the value which map with the key, 
              return null if no specified key is mapped
      */
    public boolean containsKey(K key);
    /*
        Description : Check whether there is mapping for the 
                      inputted key in the buckets
        Precondition: none
        Postcondition: none
        Return: return true value which map with the key, 
                return false if no mapping key

      */
    public boolean isEmpty();
    /*
        Description    : Check whether the buckets are empty
        Precondition   : none
        Postcondition  : none
        Return         : return false size is 0 else return true
      */
    public List getHashIndex();
    /*
      Description     : to return a list of hashCode or null
      Precondition    : none
      Postcondition   : none
      Return          : return a list of hashIndex
                        return null if bucket empty
      */
   

}
