String returnString, textString, thetaSymbol;
boolean rootSymbol, negative;
int y_coord=50; int x_coord=100;

void setup() {
   size(400,400);
   //array for all the cases
   int[] testCases = {-1, -49, 37800, -22, 22};
   //loop to go over all cases: simplifies and then print to graphics screen
   for(int cases=0; cases<testCases.length; cases++){
        simplifyRadical( testCases[cases] );
        // pass array and case number to graphics
        graphics(testCases, cases);
   }
}

// function that simplifies the radical and returns a string
String simplifyRadical(int n){
    // UNICODE for radical symbol
    thetaSymbol = "\u221A";
    // boolean on whether to draw the root symbol or not
    rootSymbol = true;
    negative = false;

   // reset the variable
   int variable=0;

   //if n is negative
   if(n<0){
       n=n*-1;
       negative=true;
   }

   //factor the radical
   for(int i=int(sqrt(n)); i>1; i--){
       if(n%(pow(i,2))==0){
           // set variable to the largest int that n is divisible by
           variable=i;
           break;
       }
   }

   // if the radical is unfactorable:
   if(variable==0){
       if(n!=1){ //returnString is string n
            returnString = n+"";
       }else{ //case for sqrt(-1)
            returnString = "";
            // not required to draw root symbol any more
            rootSymbol=false;
       }
   }

   else{
       // otherwise, return the correct form of string
       int root = n/int(pow(variable,2));
       // if the radical is completely factorable, return only the variable
       if (root==1){
           returnString = variable+"";
           // not required to draw root symbol any more
           rootSymbol=false;
       }else{ //If the radical is not completely factorable
           returnString = variable+"sqrt"+root;
       }
   }
   // returns the string
   return(returnString);
}

// draw with the theta symbol
void graphics(int[] testCases, int cases){
   // size and fill of text
   textSize(40);
   fill(0);
   // if required to draw the root symbol
   if(rootSymbol){
       String[] string = returnString.split("sqrt");
       // since if a "variable" and then a "root" isn't present all cases, we must add a if and else statement to output the correct string
       if(string.length > 1){
           textString = string[0] + thetaSymbol + string[1];
       }else{
           textString = thetaSymbol+ string[0];
       }
   } else{ //if the root symbol is not required, only draw the returnString
       textString=returnString;
   }
   // if negative add i
   if(negative){
    textString = textString+"i";
   }
   // add right hand side to textString
   textString = thetaSymbol + testCases[cases] + "=" + textString + "";
   // create the text
   text(textString,x_coord,y_coord);
   //increase y_coord so the cases don't overlap each other on graphics screen   
   y_coord += 50;
}
