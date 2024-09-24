void setup(){
    String[] PremData = loadStrings("prem.txt");
    // initialize PrintWriter and specify where to write the output file
    PrintWriter pw = createWriter(("data/Prem_Output.txt"));

    for(int i=0; i<PremData.length; i++){
        // logic to calculate the amount of points.
        int points = 0;
        String[] MatchWeek = PremData[i].split(",");
        
        String club = MatchWeek[0];
        for(int week = 1; week<MatchWeek.length; week++){
            if(MatchWeek[week].equals("W")){
                points+=3;
            }else if(MatchWeek[week].equals("D")) {
                points+=1;
            }else{
                points+=0;
            }
        }
        // print to printwriter
        pw.println(club + " has " + points + " points so far! ");
    }
    // close program and pw
    pw.close();
    exit();
}