void setup() {
   println(convertTemp("59,F"));
}

// function to convert either C to F or F to C
float convertTemp(String temperature) {
    String[] split = split(temperature, ',');
    if(split[1].equals("F")){
        return(((int(split[0])-32))*5/9);
    }
    else{
        return((9/5)*(int(split[0])+32));
    }
}
