void setup(){
  
  // HidingSpot (name, height, size(how many people can fit), cleverness)
  //can change these values or add new spots
  HidingSpot curtains = new HidingSpot("behind the curtains", 2.0, 3, 1);
  HidingSpot couch = new HidingSpot("under the couch", 1.2, 1, 3);
  HidingSpot closet = new HidingSpot("in the closet", 1.7, 2, 2);
  HidingSpot trapdoor = new HidingSpot("in the trap door under the rug", 1.6, 4,5);
  HidingSpot laundry = new HidingSpot ("in the pile of dirty laundry on the floor", 1.4, 1, 1);
  HidingSpot none = new HidingSpot ("none", 2, 6, 0);
  
  //Hider (name, country, medals won, height, intelligence, hunger level, current hiding spot)
  //can change these values or add new hiders
  Hider bob = new Hider("Bob", "Australia", 0, 1.3, 2, none);
  Hider mary = new Hider("Mary", "Canada", 3, 1.5, 5, none);
  Hider joe = new Hider("Joe", "Italy", 2, 1.7, 4, none);
  Hider amy = new Hider("Amy", "Japan", 2, 1.2, 3, none);
  Hider ella = new Hider("Ella", "England", 1, 1.6, 2, none);
  Hider ryan = new Hider("Ryan", "Madagascar", 0, 1.8, 3, none);
  
  //Seeker (name, country, medals won, height, intelligence)
  //can change values but only one seeker
  Seeker ethan = new Seeker("Ethan", "Brazil", 1, 1.4, 4);
  
 //Host (name, seeker) **needs to know seeker for some functions
  Host mike = new Host("Mike", ethan);
  
  mike.describe();
  mike.introduce(bob);
  mike.introduce(mary);
  mike.introduce(joe);
  mike.introduce(amy);
  mike.introduce(ella);
  mike.introduce(ryan);
  mike.seeker.describe();
  
  mike.startGame();
  ethan.startCounting();
  
  bob.hide(trapdoor);
  bob.hide(laundry);
  mary.hide(trapdoor);
  joe.hide(couch);
  joe.hide(laundry);
  joe.hide(curtains);
  amy.hide(couch);
  ella.hide(curtains);
  ryan.hide(closet);
  ethan.finishCounting();
   
  mike.recap();
  curtains.printHiders() ;
  couch.printHiders() ;
  closet.printHiders() ;
  trapdoor.printHiders() ;
  laundry.printHiders() ;
  none.printHiders();
   
  ethan.search(curtains);
  ethan.search(couch);
  ethan.search(closet);
  ethan.search(trapdoor);
  ethan.search(laundry);
   
  mike.update();   
  mike.findWinner();
  mike.end();
 }
  
