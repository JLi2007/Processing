void setup() {
    for (int i = 1000; i <= 1100; i++) 
      println(i + " divisible by 9?  " + isDivisibleBy9(i));  
}


int sumDigits(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n = n / 10;
    }
    return sum;
}


int getLastDigit(int n) {
    return n % 10;
}


int getAllButLastDigit(int n) {
    return (n - n%10)/10;
}


boolean isDivisibleBy7(int n) {
    if (n < 10) {
        if (n == 7 || n == -7 || n == 0) 
            return true;
         
        else 
            return false;
    } 

    else {
        int lastDigit = getLastDigit(n);
        int otherDigits = getAllButLastDigit(n);
        int nReduced = otherDigits - 2 * lastDigit;

        return isDivisibleBy7(nReduced);
    }
}


boolean isDivisibleBy3(int n) {
    if (n < 10) {
        if (n == 3 || n == 6 || n == 9) 
            return true;
         
        else 
            return false;
        
    } 
    else {
        int nReduced = sumDigits(n);
        return isDivisibleBy3(nReduced);
    }
}


boolean isDivisibleBy9(int n) {
    if (n < 10) {
        if (n == 9) 
            return true;
         
        else 
            return false;
    } 
    
    else {
        int nReduced = sumDigits(n);
        return isDivisibleBy9(nReduced);
    }
}
