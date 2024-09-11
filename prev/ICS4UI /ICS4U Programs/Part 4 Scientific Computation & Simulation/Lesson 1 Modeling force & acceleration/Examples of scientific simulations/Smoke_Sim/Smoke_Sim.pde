/*
  Handles the drawing the simulation, and getting a new generation at fixed time steps
 */
// edits visuals
int blinksPerSecond = 30;
boolean drawWindVecs = true;
float padding = 50;

// dont touch
boolean running = true;
int frames = 0;
float cellSize;

CellMap cellMap;


void setup() {
  size(1000, 1000);
  frameRate( blinksPerSecond );
  
  // replace .standard*( w/ .custom() for changes to CellMapSettings to have an effect
  cellMap = new CellMap(CellMapSettings.standard());
  
  float[] cellSizes = { (width-3*padding)/cellMap.cms.gridSizes[0], (height-3*padding)/cellMap.cms.gridSizes[1] };
  cellSize = min(cellSizes);
}


void draw() {
  background(40, 0, 60);
  colorMode(HSB, 100);

  stroke(0, 0, 0);
  fill(100);
  textSize(32);
  text(frames, width-1.5*padding, height-padding);

  drawCells();

  if (frames > 9999) {
    setup();
  }
}

void drawCells() {
  strokeWeight(0);
  for (int i=0; i < cellMap.cms.gridSizes[0]; i++) {
    float y = padding + i*cellSize;
    for (int j=0; j < cellMap.cms.gridSizes[1]; j++) {
      float x = padding + j*cellSize;

      fill(getCellColor(cellMap.cells[i][j]));
      rect(x, y, cellSize, cellSize);
    }
  }

  for (int i = 0; i < cellMap.emissionEpicenters.size(); i++) {
    EmissionEpicenter emEp = cellMap.emissionEpicenters.get(i);
    fill(80, 30+75*(1-(float(emEp.timeAlive)/emEp.lifeTime)), 100);
    rect(padding + emEp.cell.y*cellSize, padding + emEp.cell.x*cellSize, cellSize, cellSize);
  }

  if (drawWindVecs) {
    for (int i=0; i < cellMap.cms.gridSizes[0]; i++) {
      float ly = padding + i*cellSize + cellSize/2;
      for (int j=0; j < cellMap.cms.gridSizes[1]; j++) {
        float lx = padding + j*cellSize + cellSize/2;
        strokeWeight(.05*cellSize);
        line(lx, ly, lx+(cellSize*cellMap.cells[i][j].windVec.y), ly+(cellSize*cellMap.cells[i][j].windVec.x));
      }
    }
  }

  if (running) {
    cellMap.getNextCellGeneration();
    ++frames;
  }
}

void mousePressed() {
  int cellX = floor((mouseY - padding)/cellSize);
  int cellY = floor((mouseX - padding)/cellSize);

  println("new emission:", cellX + "|" + cellY);

  try {
    Cell cell = cellMap.cells[cellX][cellY];
    cellMap.addNewEpicenter(cell);
  }
  catch(Exception e) {
    running = !running;
  }
}

color getCellColor(Cell cell) {
  float h = 70-(.75*cell.temp); //0-70
  float s = 5+cell.smokeCon;
  float b = 100-cell.smokeCon;

  return color(h, s, b);
}
