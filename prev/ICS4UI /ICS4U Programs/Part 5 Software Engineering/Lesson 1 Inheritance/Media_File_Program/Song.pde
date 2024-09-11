class Song extends MediaFile {  //Song is a subclass of MediaFile

  //These are the only 2 fields of the Song class that are not 
  //already contained in MediaFile, its superclass.
  String artist;
  String album;

  Song (String t, String g, String d, int r, String a, String al) {
    super(t, g, d, r);  //super() causes the superclass's constructor to be called on these 4 arguments

    this.artist = a;  //Sets the field values that are particular to Song objects
    this.album = al;
  }


  void describe() {
    super.describe(); //Calls MediaFile's describe() method

    println( "Artist: " + artist);  //Summarizes the field values that 
    println( "Album: " + album);    //are particular to Songs
  }
}
