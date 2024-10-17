class parkingLot{
    float lineWidth;
    float lineHeight;
    parkingSpaces parkingSpaces;
    // arrayList PVectors for roadlines
    ArrayList<PVector[]> horizontalLines = new ArrayList<PVector[]>();
    ArrayList<PVector[]> verticalLines = new ArrayList<PVector[]>();

    parkingLot(){
        this.lineWidth = 3.5;
        this.lineHeight = 5;
        this.parkingSpaces = new parkingSpaces(6);
    }
    
    void drawParkingLot(){
        background(11, 173, 9);
        stroke(100,100,100);
        fill(100,100,100);
        rect(0, 0, width, height,150,150,100,100);
        parkingSpaces.drawParkingGrid();
        drawRoadLines();
    }

    void drawRoadLines(){
        // fill, color (yellow), weight
        fill(252, 232, 3);
        stroke(252, 232, 3);
        strokeWeight(3);
        
        // calculate important points on the lines
        float leftX = (width/this.lineWidth-150)/2;
        float rightX = width-(width/this.lineWidth-150)/2;
        float centerX = (width/this.lineWidth +150)+((parkingSpaces.widthCalculation(this.lineWidth)-150) - (width/this.lineWidth+150))/2;
        float topY = (height/this.lineHeight)/2;
        float bottomY = (parkingSpaces.heightCalculation(this.lineHeight) + (height/this.lineHeight)/2);

        // add new PVectors to arrayList 
        // top horizontal line
        horizontalLines.add(new PVector[]{new PVector(leftX, topY), new PVector(rightX, topY)});
        // bottom horitonzal line
        horizontalLines.add(new PVector[]{new PVector(leftX, bottomY), new PVector(rightX, bottomY)});
        // left vertical line
        verticalLines.add(new PVector[]{new PVector(leftX, topY), new PVector(leftX,bottomY)});
        // center vertical line
        verticalLines.add(new PVector[]{new PVector(centerX, 0), new PVector(centerX,height)});
        // right vertical line
        verticalLines.add(new PVector[]{new PVector(rightX, topY), new PVector(rightX,bottomY)});

        // draw the lines
        for (PVector[] line : horizontalLines){
            line(line[0].x, line[0].y, line[1].x, line[1].y);
        }
        for (PVector[] line : verticalLines){
            line(line[0].x, line[0].y, line[1].x, line[1].y);
        }
    }

    ArrayList<PVector[]> getHLinePositions(){
        return horizontalLines;
    }

    ArrayList<PVector[]> getVLinePositions(){
        return verticalLines;
    }
}



