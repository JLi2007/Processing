void setup(){
  solveTower(4, "A", "C");
}


void solveTower(int n, String s, String t) {
  if( n==1 ) 
    println("Move disk 1 from", s, "to", t);
    
  else {
    String f = getFreePegName(s, t);
    
    solveTower(n-1, s, f);
    println("Move disk", n, "from", s, "to", t);
    solveTower(n-1, f, t);
  }
}

String getFreePegName(String s, String t) {
  if( !s.equals("A") && !t.equals("A"))
    return "A";
    
  else if( !s.equals("B") && !t.equals("B"))
    return "B";
    
  else
    return "C";
}
