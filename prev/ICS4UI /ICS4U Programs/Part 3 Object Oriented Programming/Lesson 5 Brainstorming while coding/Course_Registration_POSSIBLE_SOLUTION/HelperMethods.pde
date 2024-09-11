static class HelperMethods {
  
    static void printSmartHeader( String title ) { 
      String starRow = "";
      
      for(int i=0; i< title.length(); i++) 
        starRow = starRow + "*";
      
       println(title);
       println(starRow);
    }
}
