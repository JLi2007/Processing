String returnString;
void setup() {
    String a = "3.15x10^4";       //That’s 31,500
    String b = "4.0x10^3";      //That’s 4,000
    String aTimesb = multiplyInSciNotation(a, b);       //Should return "1.26x10^8"
    println(aTimesb);
        
    String c= "1.3x10^-9";      //That’s 0.0000000013
    String aTimesC = multiplyInSciNotation(a, c);       //Should return "4.695x10^-5"
    println(aTimesC);
        
    String d= "1.0x10^-4";  //That’s .0001
    String aTimesD = multiplyInSciNotation(a, d);       //Should return just "3.15" with no exponent
    println(aTimesD);

    exit();
}

String multiplyInSciNotation(String a, String b){
    // array of strings a and b split by x10^
    String[] a_list = split(a, "x10^");
    String[] b_list = split(b, "x10^");

    // calculating the power and multiply variables using the array and index:
    // add the powers
    int power = int(a_list[1])+int(b_list[1]);
    // multiply the numbers before "x"
    float multiply = float(a_list[0])*float(b_list[0]);

    // ensure the multiply is less than 10
    while (multiply > 10){
        multiply = multiply/10;
        power+=1;
    }

    // handle case if power = 0
    if(power == 0){
        // if power is 0, return only multiply
        returnString = multiply + "";
    }else{
        // combine the strings
        returnString = multiply + "x10^" + power;
    }

    // return the final string
    return(returnString);
}

        