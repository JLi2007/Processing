void setup() {
  size(800,600);
  String request = "Draw a red circle at center (10, 105) with radius 135";
  
  parseString(request);
}

int fillColor;
void parseString(String request){
  background(0,0,0);
  String[] list = split(request, " ");

  int commaIndex = request.indexOf(",");
  int leftBracket = request.indexOf("(");
  int rightBracket = request.indexOf(")");

  String colors = list[2];
  String rad = list[list.length-1];
  String yRad = request.substring( commaIndex+1, rightBracket);
  String xRad = request.substring( leftBracket+1, commaIndex);

  // how to not hard code color?
  if(colors.equals("red")){
    fillColor = 255;
  }
  // etc

  fill(fillColor,0,0);
  circle(float(xRad), float(yRad), float(rad));
}