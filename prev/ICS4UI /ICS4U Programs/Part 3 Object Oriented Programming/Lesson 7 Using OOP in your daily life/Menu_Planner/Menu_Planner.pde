String dateToStart = "May 3";
int dayOfWeekToStart = 3; //Sunday=1, Monday=2, ..., Saturday=7
int numWeeksToPrint = 8;  //NUMBER OF WEEKS TO PLAN AHEAD

int currYear = 2022;
boolean takeOutWeek = true;

Month[] months;
Week[] weeks;
Date menuStartDate;
int totalDays = 0;

String[] dayNames = {"SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"};
String[] monthNames = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
int[] monthLengths = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
int[] monthLengthsLeapYear = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

String[] mealData;

//WILL CONTAIN A LIST OF ALL THE MEALS, WITH EACH MEAL REPEATED AS OFTEN AS DETERMINED BY THEIR FREQUENCY IN THE TEXT FILE
ArrayList<String> mealSetOriginal = new ArrayList<String>(); 
ArrayList<String> mealSetCurrent = new ArrayList<String>(); 

PrintWriter pw;


void setup() {
  //FILLS THE ARRAY NAMED "months[]" USING THE ARRAYS "monthLengths" AND "dayNames"
  buildMonthsArray();
  weeks = new Week[ numWeeksToPrint ];

  //READS DATA FROM THE MEALS TEXT FILE
  String[] fileData = loadStrings("Meal list.txt");
  mealData = new String[ fileData.length ];
  mealData = fileData;
  
  generateMealSet(); 
  
  pw = createWriter("MENU PLAN.txt");
  generateMenuPlan();
  
  pw.close();
  exit();
}


void generateMealSet() {
  int numRows = mealData.length;

  for (int i = 0; i < numRows; i++) {
    String thisRow = mealData[i];
    String[] thisRowPieces = thisRow.split(",");    //SINCE THE .txt FILE IS SPLIT UP BY COMMAS
    String mealName = thisRowPieces[0];            //EXAMPLE: "FRENCH FRIES"
    int frequency = int( thisRowPieces[1] );       //EXAMPLE: 3, IF FRENCH FRIES WILL BE REPEATED 3 TIMES

    //ADDS THAT MEAL TO THE ARRAY LIST AS MANY TIMES AS SPECIFIED BY ITS FREQUENCY
    for (int j = 0; j < frequency; j++) 
      mealSetOriginal.add( mealName );
  }
}


void generateMenuPlan() {
  refillCurrentMealSet();
  
  Date currSunday = new Date( dateToStart );
  
  for( int i = 0; i < numWeeksToPrint; i++ ) {
    weeks[i] = new Week( currSunday, i );
    
    weeks[i].pickMeals();
    weeks[i].printMeals();
      
    currSunday = currSunday.getLaterDate(7);

    takeOutWeek = !takeOutWeek;
  }
}
