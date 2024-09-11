class Maze {
    boolean [][] cells;
    int cellSize, pad;
    int mazeWidth, mazeHeight;
    int exitJ, exitI;
    
    color tunnelColour = color(255);
    color wallColour = color(120,120,120);
    color exitColour = color(255, 100, 255);
    
    Maze(int numRows, int numColumns) {
        this.cells = new boolean[numRows][numColumns];
        this.pad = 30;
        this.cellSize = min((width-2*pad)/numColumns, (height-2*pad)/numRows); 
        this.mazeWidth = numColumns;
        this.mazeHeight = numRows;
    } 
    
    
    void setExit(int exitI, int exitJ) {
        this.exitJ = exitJ;
        this.exitI = exitI;
        this.cells[exitI][exitJ] = true;
    }
    
    
    void digRow(int rowNum, int start, int end) {
        for (int j = start; j <= end; j++) 
            cells[rowNum][j] = true;                  
    }
    
    
    void digRow(int rowNum) {
        for (int j = 0; j < cells[0].length; j++) 
            cells[rowNum][j] = true;                  
    }
    
    
    void digColumn(int colNum, int start, int end) {
        for (int i = start; i <= end; i++) 
            cells[i][colNum] = true;                  
    }
    
    
    void digColumn(int colNum) {
        for (int i = 0; i < cells.length; i++) 
            cells[i][colNum] = true;                  
    }
    
     
    void drawMe() {
        stroke(0);
        fill(0, 0, 255); 
        rect(0, 0, 800, 800); 
        
        int xPos = pad;
        int yPos = pad;
        
        for (int i = 0; i < cells.length; i++) {
            for (int j = 0; j < cells[0].length; j++) {
                
                if( i == exitI && j == exitJ )
                    fill( exitColour );
                
                else if (cells[i][j] == true) 
                    fill( tunnelColour );
                 
                else 
                    fill( wallColour  );
                
                rect(xPos, yPos, cellSize, cellSize);

                xPos += cellSize;           
            }
            
            xPos = pad;
            yPos += cellSize;
        }
    }
}
