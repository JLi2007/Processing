void setup() {
  String[] myOlympicData = loadStrings("Medal counts.txt");
  
  for(int i = 0; i < myOlympicData.length; i++ ) {
    String[] countryStuff = myOlympicData[i].split(","); 
    
    String country = countryStuff[0];
    int numGold = int(countryStuff[1]);
    int numSilver = int(countryStuff[2]);
    int numAluminum = int(countryStuff[3]);
    
    int totalMedals = numGold + numSilver + numAluminum;
    println(country, "has won", totalMedals, "medals so far");
  }
}
