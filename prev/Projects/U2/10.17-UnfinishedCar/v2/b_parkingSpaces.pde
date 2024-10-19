class parkingSpaces{
    int lots = 2;
    float lineWidth;
    float lineHeight;
    int numSpots;
    int spaceIndex;
    // MAY REMOVE THIS one
    ArrayList<PVector> numPositions = new ArrayList<PVector>();
    boolean[] isVacant;

    parkingSpaces(int numSpots){
        this.lineWidth = 3.5;
        this.lineHeight = 5;
        this.numSpots = numSpots;
        this.isVacant = new boolean[numSpots*4];

        // initialize all spaces to vacant
        for(int i = 0; i < numSpots*4; i++){
            this.isVacant[i] = true;
        }
    }

    void drawParkingGrid(){
        // black parking lot background
        fill(80,80,80);
        stroke(80,80,80);
        makeRectangle(width/this.lineWidth-150, height/this.lineHeight, (width/this.lineWidth+150)-(width/this.lineWidth-150), heightCalculation(this.lineHeight)-height/this.lineHeight);
        makeRectangle(widthCalculation(this.lineWidth)-150, height/this.lineHeight,  (widthCalculation(this.lineWidth)+150)-(widthCalculation(this.lineWidth)-150), heightCalculation(this.lineHeight)-height/this.lineHeight);

        // grid color (yellow), line width of parking grid
        stroke(252, 232, 3);
        strokeWeight(2);

        // two vertical lines
        line(width/this.lineWidth, height/this.lineHeight, width/this.lineWidth, heightCalculation(this.lineHeight));
        line(widthCalculation(this.lineWidth), height/this.lineHeight, widthCalculation(this.lineWidth), heightCalculation(this.lineHeight));

        // two sets of (a numSpots #) horizontal lines featuring extensive calculations
        // left column
        for(int i = 0; i < this.numSpots+1; i++){
            line(width/this.lineWidth-150, height/this.lineHeight + i*(heightCalculation(this.lineHeight)-(height/this.lineHeight))/this.numSpots, width/this.lineWidth+150, height/this.lineHeight + i*(heightCalculation(this.lineHeight)-(height/this.lineHeight))/this.numSpots);
        }
        // right column
        for(int i = 0; i < this.numSpots+1; i++){
            line(widthCalculation(this.lineWidth)-150, height/this.lineHeight + i*(heightCalculation(this.lineHeight)-(height/this.lineHeight))/this.numSpots, widthCalculation(this.lineWidth)+150, height/this.lineHeight + i*(heightCalculation(this.lineHeight)-(height/this.lineHeight))/this.numSpots);
        }
        drawParkingSpaces();
    }

    // CALCULATIONS THAT ARE USED MULTIPLE TIMES THROUGHOUT THE PROJECT 
    // height [used whenever something is required for the bottom of the vertical lines]
    float heightCalculation(float lineHeight){
        return height*(lineHeight-1)/lineHeight;
    }
    // width [used whenever something is required for the rightmost parking grid]
    float widthCalculation(float lineWidth){
        return width*(lineWidth-1)/lineWidth;
    }

    private void makeRectangle(float x1, float y1, float xs, float ys){
        rect(x1,y1,xs,ys);
        // topleft corner
        lotPositions.add(new PVector(x1,y1));
        // topright corner
        lotPositions.add(new PVector(x1+xs,y1));
        // bottomleft corner
        lotPositions.add(new PVector(x1,y1+ys));
        // bottomright corner
        lotPositions.add(new PVector(x1+xs,y1+ys));
    }

    // to obtain lotPositions from other files
    ArrayList<PVector> getLotPositions() {
        return lotPositions;
    }

    private void drawParkingSpaces(){
        // index for numbering the parking spaces
        spaceIndex = 1;
        // alignment and size
        textAlign(CENTER, CENTER);
        textSize(20);

        // printing text
        // left column
        for(int i = 0; i < this.numSpots; i++){
            printText(this.spaceIndex++, width/this.lineWidth-130, calculateYPos(i));
            printText(this.spaceIndex++, width/this.lineWidth+130, calculateYPos(i));
        }
        // right column
        for(int i = 0; i < this.numSpots; i++){
            printText(this.spaceIndex++, widthCalculation(this.lineWidth)-130, calculateYPos(i));
            printText(this.spaceIndex++, widthCalculation(this.lineWidth)+130, calculateYPos(i));
        }
    }

    // extensive calculation to find the y pos of text (centered in between yellow lines)
    private float calculateYPos(int i){
        return (height/this.lineHeight + i*(heightCalculation(this.lineHeight) - (height/this.lineHeight))/this.numSpots) + 
        ((i+1)*((heightCalculation(this.lineHeight) - (height/this.lineHeight))/this.numSpots) - (i*(heightCalculation(this.lineHeight) -(height/this.lineHeight))/this.numSpots))/2;
    }

    // prints text - color is dependant on if the space is vacant
    private void printText(int index, float x, float y){
        fill(isVacant[index-1] ? color(0, 219, 18) : color(219, 0, 4));
        text(index, x, y);

        // add to pvector
        numPositions.add(new PVector(x,y));
    }
}


