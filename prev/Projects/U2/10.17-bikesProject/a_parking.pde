class ParkingLot {
    // FIELDS
    float lineWidth;
    float lineHeight;
    
    // CONSTRUCTOR
    ParkingLot() {
        this.lineWidth = 3.5;
        this.lineHeight = 5;
    }

    // Draw parking lot with road lines
    void drawParkingLot() {
        background(11, 173, 9);
        stroke(100,100,100);
        fill(100,100,100);
        // gray concrete
        rect(0, 0, width, height,150,150,100,100);
        drawRoadLines();
    }
    
    void drawRoadLines() {
        // fill, color (yellow), weight
        fill(252, 232, 3);
        stroke(252, 232, 3);
        strokeWeight(3);
        
        // calculate important points on the lines
        float leftX = (width / this.lineWidth - 150) / 2;
        float rightX = width - (width / this.lineWidth - 150) / 2;
        float centerX = (width / this.lineWidth + 150) + ((ParkingSpace.widthCalculation(this.lineWidth) - 150) - (width / this.lineWidth + 150)) / 2;
        float topY = (height / this.lineHeight) / 2;
        float bottomY = (ParkingSpace.heightCalculation(this.lineHeight) + (height / this.lineHeight) / 2);
        
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
        for (PVector[] line : horizontalLines) {
            line(line[0].x, line[0].y, line[1].x, line[1].y);
        }
        for (PVector[] line : verticalLines) {
            line(line[0].x, line[0].y, line[1].x, line[1].y);
        }
    }
}



