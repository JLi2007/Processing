class Pair implements Comparable<Pair>{
  float first; Node second;
  
  Pair(float first, Node second){
    this.first = first;
    this.second = second;
    
  }
  
  int compareTo(Pair tmp){
    if(first < ((Pair) tmp).first) return -1;
    else if (first > ((Pair) tmp).first) return 1;
    
    return 0;
  }
  
  
}
