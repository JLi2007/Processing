package performancetasksolution;

import java.util.*;
import java.io.*;

public class PerformanceTaskSOLUTION {

    public static String[] bubbleSort(String[] a) {
        
        int n = a.length;

        for (int pass = 1; pass <= n-1; pass++) {
            for (int i = 0; i < n - pass; i++) {
                if ( a[i].compareTo(a[i + 1]) > 0 ) {
                    swap(i, i+1, a);
                }
            }
        }
        return a;
    }

    public static void swap(int i, int j, String[] a) {
        String temp = a[i];
        a[i] = a[j];
        a[j] = temp;
    }
    
    public static void printArray(String[] array) {
        for (int i = 0; i < array.length; i++) {
            System.out.println(array[i] + " ");
        }

        System.out.println("");
    }
    
    public static void binarySearch( String[] a, String w, int l, int h ) {
        
        if (l==h) {
            if ( a[h].equals( w ) ) {
                System.out.println( "Found " + w + " at index "  + h );
            }
            else{
                System.out.println( w + " is not in my list." );
            }
        }
        
        else{
            int mid = (l+h)/2;
            
            if( a[mid].equals( w ) ) {
                System.out.println( "Found " + w + " at index " + mid );
            }
            
            else if( a[mid].compareTo( w ) < 0) {
                binarySearch( a, w, mid+1, h );
            }
            
            else{
                binarySearch( a, w, l, mid );
            }
        }
    }
    
    public static void main(String[] args) throws IOException {
        FileReader f = new FileReader( "random words.txt" );
        Scanner s = new Scanner(f);

        String[] unsortedWords = new String[100];

        for (int i = 0; i < unsortedWords.length; i++) {
            unsortedWords[i] = s.next();
        }
        
        String[] sortedWords = bubbleSort( unsortedWords );
        printArray( sortedWords );
        
        Scanner s2 = new Scanner(System.in);
        
        System.out.println( "Enter a search word (or Q to quit): " );
        String w = s2.next();
        
        while( ! w.equals( "Q" ) ) {
            binarySearch( sortedWords, w, 0, sortedWords.length-1);
            
            System.out.println( "\nEnter a search word (or Q to quit): " );
            w = s2.next(); 
        }
        
        System.out.println("Thanks for using my dictionary! I hope you learned some new words.");
    }
}
