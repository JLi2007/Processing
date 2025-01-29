class Edge{
    Node n1, n2;    //the two nodes that make up this edge
    int dist;       //distance between the nodes
    color defaultStroke;
    color selectedStroke;
    color currentStroke;
    color inverseCurrentStroke;
    int weight;

    Edge(Node n1, Node n2, int dist, boolean selected){
        this.n1 = n1;
        this.n2 = n2;
        this.dist = dist; 
        this.defaultStroke = color(2, 30, 107);  
        this.selectedStroke = color(191, 8, 75);
        this.weight = 3;
        // different colours when selected/unselected
        if(selected){
            this.currentStroke = this.selectedStroke;
            this.inverseCurrentStroke = this.defaultStroke;
            this.weight = 4;
        }else{
            this.currentStroke = this.defaultStroke;
            this.inverseCurrentStroke = this.selectedStroke;
        }
    }

    // show edge (drawing it to the screen) using the correct colours
    void showEdge(){
        strokeWeight(this.weight);
        stroke(this.currentStroke);
        line(n1.x, n1.y, n2.x, n2.y);
    }

    // show edge weights it the checkbox is toggled 
    void showEdgeDist(){
        if(showEdgeDist){
            // draw the weight on the midpoint of the edge
            float x = (this.n1.x + this.n2.x ) / 2;
            float y = (this.n1.y + this.n2.y ) / 2;

            // if the edge isn't with itself
            if(this.dist != 0){
                fill(this.inverseCurrentStroke);
                stroke(this.currentStroke);
                strokeWeight(1);

                // if statements to handle the size of the Edge Weight on the ui. Larger distances get larger weights
                if(this.dist>150){
                    textSize(15);
                    rect(x-15,y-9,30,20);
                }
                else if(this.dist<100){
                    textSize(10);
                    rect(x-10,y-6,20,13);
                }
                else{
                    textSize(12);
                    rect(x-12,y-7,24,16);
                }

                // draw the distance on the weight
                fill(this.currentStroke);
                text(this.dist, x, y);
            }
        }
        // reset the text size
        textSize(15);
    }
}