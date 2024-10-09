void setup() {
  
  //MAKE SEVERAL SONG OBJECTS. THEY'RE NOT ON ANY PLAYLISTS YET
  Song s1 = new Song( "Vidul", "Charlie Gazzola", 5, "10:00" );
  Song s2 = new Song( "My Love for Vectors", "James Li", 0, "00:01" );
  Song s3 = new Song( "Running Around Aimlessly", "??", 4, "50:51" );

  //CREATE SOME EMPTY PLAYLISTS. THEY DON'T HAVE ANY SONGS ON THEM YET
  Playlist charlie = new Playlist( "Charlie Gazzola's Favorites" );

  //ADD SONG OBJECTS TO PLAYLISTS.
  //THE SAME SONG OBJECT CAN BE ON MULTIPLE PLAYLISTS
  charlie.addSong( s1 );
  charlie.addSong( s2 );
  charlie.addSong( s3 );

  //PRINT THE PLAYLISTS BEFORE PLAYING ANY SONGS
  charlie.printPlaylist();

 //PLAY SEVERAL SONGS, SOME OF THEM MULTIPLE TIMES (BECAUSE THEY'RE SO CATCHY!)
  s2.play();
  s1.play();
  s1.play();
  s1.play();
  s1.play();
  s2.play();
  s2.play();
  s3.play();
  s3.play();
  
  println("*************************************************************************");
  println("*************************************************************************");
  println("*************************************************************************");
  println();

  //PRINT THE PLAYLISTS AGAIN.  WHAT'S DIFFERENT THIS TIME?       
  charlie.printPlaylist();
  
  exit();
}
