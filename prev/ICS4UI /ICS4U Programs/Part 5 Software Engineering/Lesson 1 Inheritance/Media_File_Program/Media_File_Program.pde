void setup() {
  MediaFile[] myFavoriteEntertainment = new MediaFile[5];

  myFavoriteEntertainment[0] = new Movie("Grinding Nemo", "Horror", "2:05:30", 5, "Wes Craven", "Naomi Campbell");
  myFavoriteEntertainment[1] = new Song("Quadratic Formula Rap", "Hip Hop", "3:14", 4, "Math Attack Schatt", "Math Rap Top 40");
  myFavoriteEntertainment[2] = new Song("I'd Die For You...Except I'm Already Dead", "R&B", "4:40", 3, "The Zombies", "40 Classic Elevator Hits");
  myFavoriteEntertainment[3] = new Movie("Ironing Man 4", "Sci Fi", "1:56:21", 2, "Joel Coen", "Morton Uppy Jr.");
  myFavoriteEntertainment[4] = new MediaFile("Some Generic Entertainment", "Nothing Really", "0:30:30", 3);

  for (int i = 0; i < myFavoriteEntertainment.length; i++) {
    myFavoriteEntertainment[i].describe();  // Processing automatically detects which "describe" is needed for each item in the array
    println();
  }
  
  exit();
}
