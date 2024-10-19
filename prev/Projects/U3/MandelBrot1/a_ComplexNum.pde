class ComplexNum{
    // FIELDS
    float realNumber;
    float imaginaryNumber;

    // CONSTRUCTOR
    ComplexNum(float realNum, float imaginaryNum){
        this.realNumber = realNum;
        this.imaginaryNumber = imaginaryNum;
    }

    // PRINTS CONDITIONALLY
    void printMe(){
        if(this.realNumber == 0){
            println(this.imaginaryNumber + "i");
        } 
        else if (this.imaginaryNumber == 0){
            println(this.realNumber);
        }else{
            println(this.realNumber + " + " + this.imaginaryNumber + "i");
        }
    }

    // ADDS THE COMPLEX NUMBERS
    ComplexNum add(ComplexNum complexNum){
        return((new ComplexNum(roundToOneDecimal(this.realNumber + complexNum.realNumber), roundToOneDecimal(this.imaginaryNumber + complexNum.imaginaryNumber))));
    }

    // ABSOLUTE VALUE
    float absoluteValue(){
        return(sqrt((this.realNumber*this.realNumber)+(this.imaginaryNumber*this.imaginaryNumber)));
    }

    // ROUNDS TO ONE DECIMAL PLACE
    float roundToOneDecimal(float value) {
        return round(value * 10) / 10.0;
    }
}