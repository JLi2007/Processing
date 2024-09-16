void setup() {
    println("SumToProduct");
    SumToProduct();
    println("Double Angle");
    DoubleAngle();
    exit();
}

// sinα + sinβ = 2sin([α+β]/2)*cos([α-β]/2)
void SumToProduct() {
    for (float angle = 0; angle <= 30; angle += 1) {
        float alpha = angle;
        float beta = angle;
        float floatLHS = sin(radians(alpha)) + sin(radians(beta));
        float floatRHS = 2 * sin((radians(alpha) + radians(beta)) / 2) * cos((radians(alpha) - radians(beta)) / 2);
        println(angle,":", floatLHS, "=", floatRHS);
    }
}

// sin(2θ) = 2sin(θ)cos(θ) = 2tan(θ) / 1+tan^2(θ)
void DoubleAngle() {
    for (float theta = 0; theta <= 30; theta += 1) {
        float floatLHS = sin(2*radians(theta));
        float floatRHS = (2 * tan(radians(theta))) / (1 + pow(tan(radians(theta)), 2));
        println(theta,":", floatLHS, "=", floatRHS);
    }
}



