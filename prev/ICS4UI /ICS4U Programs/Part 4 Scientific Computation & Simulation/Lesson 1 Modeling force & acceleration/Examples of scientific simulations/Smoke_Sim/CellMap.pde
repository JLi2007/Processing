/*
  Collection of cells that make-up the environment, and contains the functions for simulating generations
 */
class CellMap {
  CellMapSettings cms;
  ArrayList<EmissionEpicenter> emissionEpicenters;

  Cell[][] cells;
  Cell[][] nextCells;

  CellMap(CellMapSettings cms) {
    this.cms = cms;

    cells = new Cell[cms.gridSizes[0]][cms.gridSizes[1]];
    nextCells = new Cell[cms.gridSizes[0]][cms.gridSizes[1]];

    emissionEpicenters = new ArrayList<EmissionEpicenter>();

    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        cells[i][j] = new Cell(i, j, cms.ambientTemperature, 0);
        nextCells[i][j] = cells[i][j];
      }
    }
  }


  void getNextCellGeneration() {
    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        averageSpread(cells[i][j]);
      }
    }

    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        simulateWind(cells[i][j]);
      }
    }

    for (int i = 0; i < cells.length; i++) {
      for (int j = 0; j < cells[i].length; j++) {
        cells[i][j] = nextCells[i][j];
      }
    }

    emit();
  }

  // update individual cell  -------------------------------------------------------------------------------------------

  void averageSpread(Cell cell) {
    //println("\t"+cell.x+"|"+cell.y);
    ArrayList<Cell> neighbours = getNeighbouringCells(cell.x, cell.y);
    float newTemp = cell.temp + cms.tempSpreadMod*(averageTemp(neighbours) - cell.temp);
    float newSmokeCon = cell.smokeCon + cms.smokeSpreadMod*(averageSmokeCon(neighbours)-cell.smokeCon);

    PVector curWind = new PVector(cell.windVec.x, cell.windVec.y);
    PVector newWindVec = curWind.add((averageWindVec(neighbours).sub(curWind)).mult(cms.windSpreadMod));

    nextCells[cell.x][cell.y].temp = newTemp;
    nextCells[cell.x][cell.y].smokeCon = newSmokeCon;
    nextCells[cell.x][cell.y].windVec = newWindVec;
  }

  void simulateWind(Cell cell) {
    ArrayList<Cell> cellsBlownTo = getCellsPassedThrough(cell.getMidpoint(), cell.windVec, 1);
    /*println(cell.x+"|"+cell.y, "blew to:", cellsBlownTo.size());
     for (int i=0; i<cellsBlownTo.size(); i++) {
     println("  "+cellsBlownTo.get(i).x+"|"+cellsBlownTo.get(i).y);
     }*/

    float windSpeed = cell.windVec.mag();

    float curSmoke = nextCells[cell.x][cell.y].smokeCon;
    float curTemp = nextCells[cell.x][cell.y].temp;
    float smokeToDisperse = cell.smokeCon*windSpeed*cms.windSmokeSpreadFactor;
    float tempToDisperse = cell.temp*windSpeed*cms.windTempSpreadFactor;

    smokeToDisperse = min(curSmoke, smokeToDisperse);
    tempToDisperse = min(curTemp, tempToDisperse);
    nextCells[cell.x][cell.y].smokeCon -= smokeToDisperse;
    nextCells[cell.x][cell.y].temp -=tempToDisperse;

    for (int n = 0; n < cellsBlownTo.size(); n++) {
      cellsBlownTo.get(n).smokeCon += smokeToDisperse/cellsBlownTo.size();
      cellsBlownTo.get(n).temp += tempToDisperse/cellsBlownTo.size();
    }

    //println(cell.x+"|"+cell.y + " O:", curSmoke, "N:", nextCells[cell.x][cell.y].smokeCon);

    float newWindSpeed = clamp(cms.minWindSpeed, cms.maxWindSpeed, windSpeed);
    PVector newWindVec = new PVector(cell.windVec.x, cell.windVec.y);
    newWindVec.mult(newWindSpeed/windSpeed);
    newWindVec.add(new PVector(-1, 0).mult((cell.temp-cms.ambientTempToVelocity*cms.ambientTemperature)*cms.risingHeatStrength));

    nextCells[cell.x][cell.y].windVec = newWindVec;
  }

  float averageTemp(ArrayList<Cell> cells) {
    float avgTemp = cms.ambientTemperature;
    for (int n = 0; n < cells.size(); n++) {
      avgTemp += cells.get(n).temp;
    }

    return avgTemp / (cells.size() + 1);
  }

  float averageSmokeCon(ArrayList<Cell> cells) {
    float avgSmokeCon = 0;
    for (int n = 0; n < cells.size(); n++) {
      avgSmokeCon += cells.get(n).smokeCon;
    }

    return avgSmokeCon / cells.size();
  }

  PVector averageWindVec(ArrayList<Cell> cells) {
    PVector avgWindVec = new PVector(0, 0);
    for (int n = 0; n < cells.size(); n++) {
      avgWindVec.add(cells.get(n).windVec);
    }

    return avgWindVec.div(cells.size());
  }

  // Epicenter handlers -------------------------------------------------------------------------------------------

  void addNewEpicenter(Cell newEpicenter) {
    EmissionEpicenter epicenter = new EmissionEpicenter(newEpicenter, cms.emissionSmoke, cms.emissionTemp, cms.emissionDirection, cms.emissionLength);
    emissionEpicenters.add(epicenter);
  }

  void emit() {
    for (int i = 0; i < emissionEpicenters.size(); i++) {
      EmissionEpicenter emEp = emissionEpicenters.get(i);
      emEp.emit();
    }

    for (int i = 0; i < emissionEpicenters.size(); i++) {
      if (emissionEpicenters.get(i).dead) {
        emissionEpicenters.remove(emissionEpicenters.get(i));
        break;
      }
    }
  }

  // Get Cell Lists -------------------------------------------------------------------------------------------

  ArrayList<Cell> getNeighbouringCells(int x, int y) {
    ArrayList<Cell> neighbours = new ArrayList<Cell>();
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        if (i != 0 || j != 0) {
          try {
            neighbours.add(cells[x+i][y+j]);
          } 
          catch(Exception e) {
            //println("  cell", (x+i) + "|" + (y+j), "doesn't exist");
          }
        }
      }
    }

    return neighbours;
  }

  ArrayList<Cell> getCellsPassedThrough(PVector point, PVector velocity, int layer) {
    //println("P:", point, "V:", velocity);
    PVector endPoint = new PVector(point.x, point.y);
    endPoint.add(velocity);
    //println("E:", endPoint);
    int endX = floor(endPoint.x);

    int endY = floor(endPoint.y);

    //println(layer +" try, E: ["+ endX + "," + endY + "]");
    try {
      Cell endCell = cells[endX][endY];
      ArrayList<Cell> cellsPassedThrough = getEdgePassedThrough(endCell, point, velocity, -1, 0);

      return cellsPassedThrough;
    } 
    catch(Exception e) { // endPoint out of bounds, reducing velocity mag
      if (layer < 3) {
        float newMag = velocity.mag()*(layer/(layer+1));
        if (newMag <= 0) {
          newMag = .25;
        }
        if (newMag == velocity.mag()) { 
          return new ArrayList<Cell>();
        }
        PVector newVelocity = new PVector(velocity.x, velocity.y);
        newVelocity.setMag(newMag);
        //println("endpoint out of bounds, reducing,", velocity.mag(), "to", newMag);
        return getCellsPassedThrough(point, newVelocity, ++layer);
      } else {
        println("couldn't reduce", point, "+", velocity, "to usuable length");
        return new ArrayList<Cell>();
      }
    }
  }

  ArrayList<Cell> getEdgePassedThrough(Cell curCell, PVector point, PVector velocity, int edge, int layer) {
    boolean edgeFound = false;
    int e1 = edge % 4;
    ArrayList<Cell> cellsPassedThrough;
    Cell nextCell = curCell;

    //println("["+curCell.x + "," + curCell.y+"] e1:", e1);

    while (!edgeFound) {
      edge = (++edge) % 4;
      //println(" ", "edge:", edge);
      float t;

      switch(edge) {
      case 0:  //RIGHT
        t = ((curCell.x+1) - point.x)/velocity.x;
        float r = point.y + t*velocity.y;
        if (curCell.y <= r && r <= (curCell.y+1)) {
          edgeFound = true;

          try { // wind velocity continues out of the grid
            nextCell = nextCells[curCell.x+1][curCell.y];
          }
          catch(Exception e) {
            //println("next cell out of bounds");
            cellsPassedThrough = new ArrayList<Cell>();
            cellsPassedThrough.add(curCell);
            return cellsPassedThrough;
          }
        }

      case 1:  //UP
        t = ((curCell.y+1) - point.y)/velocity.y;
        float u = point.x + t*velocity.x;
        if (curCell.x <= u && u <= (curCell.x+1)) {
          edgeFound = true;

          try {
            nextCell = nextCells[curCell.x][curCell.y-1];
          }
          catch(Exception e) {
            //println("next cell out of bounds");
            cellsPassedThrough = new ArrayList<Cell>();
            cellsPassedThrough.add(curCell);
            return cellsPassedThrough;
          }
        }

      case 2:  //LEFT
        t = (curCell.x - point.x)/velocity.x;
        float l = point.y + t*velocity.y;
        if (curCell.y <= l && l <= (curCell.y+1)) {
          edgeFound = true;

          try {
            nextCell = nextCells[curCell.x-1][curCell.y];
          }
          catch(Exception e) {
            //println("next cell out of bounds");
            cellsPassedThrough = new ArrayList<Cell>();
            cellsPassedThrough.add(curCell);
            return cellsPassedThrough;
          }
        }

      case 3:  //DOWN
        t = (curCell.y - point.y)/velocity.y;
        float d = point.x + t*velocity.x;
        if (curCell.x <= d && d <= (curCell.x+1)) {
          edgeFound = true;

          try {
            nextCell = nextCells[curCell.x][curCell.y+1];
          }
          catch(Exception e) {
            //println("next cell out of bounds");
            cellsPassedThrough = new ArrayList<Cell>();
            cellsPassedThrough.add(curCell);
            return cellsPassedThrough;
          }
        }
      }

      if (e1 == edge) { // went through every edge w/o finding an edge it passed through, origin must be in this area
        return new ArrayList<Cell>();
      }

      if (e1 == -1 && edge == 3 && !edgeFound) { // air velocity never leaves the first square
        //print("velocity never leaves", curCell.x + "|" + curCell.y);
        return new ArrayList<Cell>();
      }

      if (layer > 6) {
        return new ArrayList<Cell>();
      }
    }
    cellsPassedThrough = getEdgePassedThrough(nextCell, point, velocity, edge+2, ++layer);
    cellsPassedThrough.add(curCell);

    return cellsPassedThrough;
  }

  // Math funcs  -------------------------------------------------------------------------------------------

  float clamp(float a, float b, float v) {
    if (v < a) {
      v = a;
    }

    if (v > b) {
      v = b;
    }

    return v;
  }
}
