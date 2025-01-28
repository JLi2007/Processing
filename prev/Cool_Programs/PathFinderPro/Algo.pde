ArrayList<Node> path; //stores the path

Node startNode = null, endNode = null;

HashMap<Node, ArrayList<Pair>> adj; //adjacency list where each node stores an arraylist of pairs (and each pair stores a connected node and the weight)

void setValues(){ //create adjacency list
  adj =  new HashMap<Node, ArrayList<Pair>>();
  for(Edge e: edges){
    if(e.exists){ //sometimes the edge will be "blocked", prevents creating unwanted paths
      adj.put(e.n1, new ArrayList<Pair>());
      adj.put(e.n2, new ArrayList<Pair>());
    }
    
  }
  for(Edge e: edges){
    if(e.exists){
      adj.get(e.n1).add(new Pair (e.dist, e.n2)); 
      adj.get(e.n2).add(new Pair (e.dist, e.n1));
    }
  }
  for(Node n: nodes){
    n.SD = 100000.0;
    n.vis = false;
    n.prev = null;
  }
  
}

void findPath(){
  //priority queue automatically sorts the queue and picks the smallest value (since we put distance as the first value in the pair, it will sort by shortest distance)
  PriorityQueue<Pair> queue = new PriorityQueue<Pair>(); 
  path = new ArrayList<Node>();
  queue.add(new Pair(0, startNode)); // distance, node (so the priority queue can sort based on distance)
  startNode.SD = 0;
  startNode.prev = null;
  
  while(queue.isEmpty()==false && startNode!=null){
    Pair curPair = queue.poll(); //gets the min.value and removes it from queue
    Node curNode = curPair.second;
    
    if(curNode.vis) continue;
    curNode.vis=true;
    
    if(adj.containsKey(curNode)){ // if the current node has connected nodes
      for(Pair nxt : adj.get(curNode)){ //loop through each connected node
        Node nxtNode = nxt.second;
        float weight = nxt.first;

        if(nxtNode.SD > curNode.SD+weight){ 
          nxtNode.SD = curNode.SD+weight;
          nxtNode.prev = curNode;
          queue.add(new Pair(nxtNode.SD, nxtNode));
        }
        
      }
    }
    
  }
  showPath();
}

void showPath(){
  for(Edge e: edges){
    e.inPath = false;
  }
  
  if(endNode.vis){
    for(Node n = endNode; n != null; n = n.prev){
      path.add(n);
    }
  }
   
  Collections.reverse(path);
  
  for(Node n: nodes){
    if(!path.contains(n)) {
      if(n.col!=clicked) n.col = og;
    }
  }
  
  for(Node n: path){
    n.col = chosenPath;
    if(n.prev!=null){
      for(Edge e: edges){
        if((e.n1 == n.prev && e.n2 == n) || (e.n2 == n.prev && e.n1 == n)){
          e.col = chosenPath;
          e.inPath = true;
        }
      }
    }
  }
  
  
  for(Edge e: edges){
    if(!e.inPath && e.col!=blocked) e.col = og;
  }
  
}
