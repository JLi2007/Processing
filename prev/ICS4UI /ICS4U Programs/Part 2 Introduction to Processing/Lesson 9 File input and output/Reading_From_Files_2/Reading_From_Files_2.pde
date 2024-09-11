void setup() {
  
  String[] lines = loadStrings("Medal counts.txt");
  PrintWriter pw = createWriter("data/Medal totals.txt");
  
  for(int i=0; i< lines.length; i++) {
    String currLine = lines[i];
    String[] parts = currLine.split(",");
    
    String country = parts[0];
    int gold = int(parts[1]);
    int silver = int(parts[2]);
    int bronze = int(parts[3]);
    
    int total = gold+silver+bronze;
    
    pw.print(country.substring(0,3) + "\t" + total);
    pw.println("");
  }
  
  pw.close();
  
  exit();
}
