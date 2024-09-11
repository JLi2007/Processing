void setup() {
  background(255);
  String[] fontList = PFont.list();
    textAlign(LEFT, TOP);
  fill(0);
  printArray(fontList);
  size(700, 800);
  int[] p = {125, 176};
  int y = 30;
  for(int i : p) {
    PFont p1 = createFont(fontList[i], 20);
    textFont(p1);

    text("Thurs Dec 2 @ 7:00 p.m.  " + i, 50, y);
    text("SECTION    ROW    SEAT  " + i, 50, y+30);
    y+= 90;
  }
  
}
