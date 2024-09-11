println( 3*4 );
println( 12/5 );   //Processing and Java do "integer division", meaning they always chop off the decimal.
println( 12.0/5 ); //To force Processing to give you the decimal result, you can do this...
println( (float) 12/5);     //...or cast the result to a float data type
println( (int) 34.345342);  //you can also cast decimals as integers

//Typical mistake
float celsius = 20.0;
float fahrenheit = 9/5*celsius + 32;
println( fahrenheit ); //What will go wrong here?

println( pow(100, 3));    //exponentiation
println( sqrt(456));      //no math package importing required
println( pow(100, 1/2));  //why does this give 1 and not 10? Because 1/2 evaluates to 0!
println( pow(100, 0.5));  //this works

println( sin(30) );          //why does this not give 0.5? Because Processing does trig calculations in radians
println( sin(radians(30)) ); //this gives 0.5
println( sin(PI/6));         //and so does this
println( pow(sin(PI/17.1), 2) + pow(cos(PI/17.1), 2)); //should give 1 because sin^2(x) + cos^2(x) = 1 for all x

exit();
