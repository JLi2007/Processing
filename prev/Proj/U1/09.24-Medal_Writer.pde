void setup(){
    String[] MedalData = loadStrings("medals.txt");
    PrintWriter pw = createWriter(("data/Output.txt"));

    for(int i=0; i<MedalData.length; i++){
        String Row = MedalData[i];
        String[] RowChunks = Row.split(",");
        
        String Country = RowChunks[0];
        int GoldMedals = int(RowChunks[1]);
        int SilverMedals = int(RowChunks[2]);
        int BronzeMedals = int(RowChunks[3]);

        int Total = GoldMedals + SilverMedals + BronzeMedals;

        pw.println(Country + " has won " + Total + " total medals so far!");
    }
    pw.close();
    exit();
}