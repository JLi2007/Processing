void setup() {
  
  //MAKE SEVERAL SONG OBJECTS. THEY'RE NOT ON ANY PLAYLISTS YET
  Song s1 = new Song( "Stanley", "Calvin Salsali", 2, "3:41" );
  Song s2 = new Song( "Don't Mess with Vectors", "Kevin Gao", 3, "2:59" );
  Song s3 = new Song( "Pythakorean Theorem", "Math Attack Schatt", 0, "3:15" );
  Song s4 = new Song( "Luv You with All My Seoul", "BTS", 3, "4:05" );
  Song s5 = new Song( "Yo! Factor This!", "Math Attack Schatt", 1, "2:02" );

  //CREATE SOME EMPTY PLAYLISTS. THEY DON'T HAVE ANY SONGS ON THEM YET
  Playlist cw = new Playlist( "Country Western Favourites" );
  Playlist math = new Playlist( "Math Hits 2024" );
  Playlist kPop = new Playlist( "KPop Dance Hits" );

  //ADD SONG OBJECTS TO PLAYLISTS.
  //THE SAME SONG OBJECT CAN BE ON MULTIPLE PLAYLISTS
  cw.addSong( s1 );
  cw.addSong( s2 );
  
  math.addSong( s2 );
  math.addSong( s3 );
  math.addSong( s5 );
  
  kPop.addSong( s3 );
  kPop.addSong( s4 );

  //PRINT THE PLAYLISTS BEFORE PLAYING ANY SONGS
  cw.printPlaylist();
  math.printPlaylist();
  kPop.printPlaylist();

 //PLAY SEVERAL SONGS, SOME OF THEM MULTIPLE TIMES (BECAUSE THEY'RE SO CATCHY!)
  s2.play();
  s1.play();
  s1.play();
  s1.play();
  s1.play();
  s2.play();
  s2.play();
  s5.play();
  s3.play();
  s3.play();
  
  println("*************************************************************************");
  println("*************************************************************************");
  println("*************************************************************************");
  println();

  //PRINT THE PLAYLISTS AGAIN.  WHAT'S DIFFERENT THIS TIME?       
  cw.printPlaylist();
  math.printPlaylist();
  kPop.printPlaylist(); 
  
  exit();
}
