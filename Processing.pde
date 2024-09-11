void setup() {
    roundNumber(37.9883, 3);
}

void roundNumber(float unrounded, int decimals) {    
    float rounded = unrounded * pow(10,decimals);
    print(round(rounded) / pow(10,decimals));
}