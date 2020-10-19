package dsa_assignment.adt.Indexing;

import dsa_assignment.adt.Filter.ArrayList;
import dsa_assignment.adt.Filter.List;

public class HashMap <K,V> implements Map<K,V>{
    private Entry<K, V>[] buckets;
    private int capacity; // 16
    private int size = 0;
    private double lf = 0.75;

    public HashMap() {
        this(16);
    }

    public HashMap(int capacity) {
        this.capacity = capacity;
        this.buckets = new Entry[this.capacity];
    }

    @Override
    public void put(K key, V value) {
        if (size == lf * capacity) { 
        //if the buckets if 75% full expand the bucket
            expandBuckets();
        }
        Entry<K, V> entry = new Entry<>(key, value, null);

        int bucket = getHash(key) % getBucketSize();

        Entry<K, V> existing = buckets[bucket];
        if (existing == null) { //for the first entry
            buckets[bucket] = entry;
            size++;
        } else {
            //compare whether the key exist
            while (existing.next != null) {
                if (existing.key.equals(key)) {
                    existing.value = value;
                    return;
                }
                existing = existing.next;
            }

            if (existing.key.equals(key)) {
                existing.value = value;
            } else {
                existing.next = entry;
                size++;
            }
        }
    }
    
    public V get(Object key) {
        Entry<K, V> bucket = buckets[getHash((K) key) % getBucketSize()];

        while (bucket != null) {
            if (key.equals(bucket.key) ) {
                return bucket.value;
            }
            bucket = bucket.next;
        }
        return null;
       
        
    }
    @Override
    public boolean containsKey(K key){
        boolean contain = false;
        Entry<K, V> bucket = buckets[getHash(key) % getBucketSize()];
            while (bucket != null) {
                if (bucket.key.equals(key)) {
                    return true;
                }
                bucket = bucket.next;
            }
            return contain;
    }
   
    @Override
    public boolean isEmpty() {
         return size ==0;
    }
    public void clear() {
        if (!isEmpty()) { // deallocates only the used portion
            for (int index = 0; index < getBucketSize(); index++) {
              buckets[index] = null;
            }
        }
    }
    private int getBucketSize() {
        return buckets.length;
    }
    private int getHash(K key) {
        return key == null ? 0 : Math.abs(key.hashCode());
    }
    public void expandBuckets(){
        Entry<K, V>[] old = buckets; //expand the bucket
        capacity *= 2;
        size = 0;
        buckets = new Entry[capacity];

        for (Entry<K,V> e: old) { // rehash

            while (e != null) {
                put(e.key, e.value);
                e = e.next;
            }
        }
    }

    @Override
    public  List getHashIndex() {
        List<Integer> index = new ArrayList<>();
        if(!isEmpty()){
            for (Entry entry : buckets) {
                while (entry != null) {
                    index.add(Math.abs(entry.getHashCode()));
                    entry = entry.next;
                }
            }
            return  index;
        }else
            return null;
    }
    
   
}
