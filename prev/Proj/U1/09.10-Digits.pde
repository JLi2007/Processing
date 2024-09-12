// program that rounds a floating point number to a certain amount of digits
// September 11, 2024
// Discovered "Float" with a capital F. Is a wrapper for "float" and allows null values.
int count = 0;
boolean isInt = false;
// set numbers and digits
float number = 69.75;
int digits = 3;


void setup() {
    // call function with a float and int
    Float result = roundAny(number, digits);
    if (result == null) {
        println("Cannot round to specified digits");
} else if (isInt) {
        println(int(result));
} else {
        println(result);
}
}


// function to round the float to the number of digits
Float roundAny(float unrounded, int digits) {
    // divide by 10 until number is under and keep track of the count
    while(unrounded >= 10) {
        count += 1;
        unrounded = unrounded / 10;
}
    
    
    // if digits is equal or less to count, that means the amount of digits to the left of the decimal is more than the digits specified to round to (not possible to round)
    if (digits <= count) {
        return null;
}
    
    // multiply by [10^digits-1] to obtain the correct amount of digits before the decimal place
    float rounded = round(unrounded * pow(10,digits - 1));
    // initialize the float required to divide by to obtain the correct result
    float divide = pow(10,digits - (count + 1));
    
    // if divide is NOT 1, round rounded (which is everything to the left of decimal place) then divide it by divide
    if (divide!= 1.0) {
        return(rounded / divide);
}
    // otherwise, indicate that the number is in integer and return rounded
    isInt = true;
    return(rounded);
}
