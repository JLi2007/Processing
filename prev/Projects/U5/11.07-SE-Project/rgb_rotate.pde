class RGBRotate{
    // Matrix 2d array field
    float[][] valueMatrix;

    // Constructor to initialize the matrix
    RGBRotate() {
        valueMatrix = new float[3][3];
        valueMatrix[0][0] = 1; valueMatrix[0][1] = 0; valueMatrix[0][2] = 0;
        valueMatrix[1][0] = 0; valueMatrix[1][1] = 1; valueMatrix[1][2] = 0;
        valueMatrix[2][0] = 0; valueMatrix[2][1] = 0; valueMatrix[2][2] = 1;
    }

    // This function sets up a 3x3 matrix to perform a hue rotation on a color
    void setHueRotation(float degrees) {
        // - A hue rotation redistributes red, green, and blue contributions to each channel in a way 
        //   that rotates their position around the "hue wheel." The effect preserves brightness and
        //   maintains a balance between the colors.
        // - One can search up the hue wheel for better understanding

        // convert the angle from degrees to radians for trigonometric calculations
        float cosA = cos(radians(degrees));  // cosine of rotation angle
        float sinA = sin(radians(degrees));  // sine of rotation angle
        float sqrt = sqrt(1.0 / 3.0);        // scaling factor: sqrt(1/3) is used to normalize the rotation effect, used to uniformly distribute colors


        // Altering the matrix:
        // - The "diagonal terms" (e.g., valueMatrix[0][0]) are largely controlled by cosA,
        //   representing how much of each channel "stays" in itself after rotation.
        // - The "off-diagonal terms" includes sine (sinA) and normalization sqrt(1/3),
        //   which distribute the rotated hue across the other channels.

        // first row of the hue rotation matrix
        valueMatrix[0][0] = cosA + (1.0 - cosA) / 3.0;
        valueMatrix[0][1] = 1.0 / 3.0 * (1.0 - cosA) - sqrt * sinA;
        valueMatrix[0][2] = 1.0 / 3.0 * (1.0 - cosA) + sqrt * sinA;

        // second row of the hue rotation matrix
        valueMatrix[1][0] = 1.0 / 3.0 * (1.0 - cosA) + sqrt * sinA;
        valueMatrix[1][1] = cosA + 1.0 / 3.0 * (1.0 - cosA);
        valueMatrix[1][2] = 1.0 / 3.0 * (1.0 - cosA) - sqrt * sinA;

        // third row of the hue rotation matrix
        valueMatrix[2][0] = 1.0 / 3.0 * (1.0 - cosA) - sqrt * sinA;
        valueMatrix[2][1] = 1.0 / 3.0 * (1.0 - cosA) + sqrt * sinA;
        valueMatrix[2][2] = cosA + 1.0 / 3.0 * (1.0 - cosA);
    }
    
    // Applies the filter by using the value matrix along with the r,g,b values specified
    int[] applyFilter(float r, float g, float b){

        // creates the new values by multiplying by the matrix, which specifies how much of the original red, green, and blue
        // contribute to the new red/green/blue value. 
        float r_value = r*valueMatrix[0][0] + g*valueMatrix[0][1] + b*valueMatrix[0][2];
        float g_value = r*valueMatrix[1][0] + g*valueMatrix[1][1] + b*valueMatrix[1][2];
        float b_value = r*valueMatrix[2][0] + g*valueMatrix[2][1] + b*valueMatrix[2][2];

        // return the values in a integer array after constraining them to avoid going out of color bounds
        return new int [] {bounds(r_value), bounds(g_value), bounds(b_value)};
    }

    // Ensure that values are constrained to an integer from 0-255
    int bounds(float value){
        if (value < 0){
            return 0;
        }
        if (value > 255){
            return 255;
        }

        // return value rounded to the nearest integer
        return int(value + 0.5);
    }

    // BROKEN FEATURE (SATURATION)
    // void setSaturationRotation(float scale){
    //     float luminanceR = 0.2126f; 
    //     float luminanceG = 0.7152f; 
    //     float luminanceB = 0.0722f;
        
    //     valueMatrix[0][0] = luminanceR + (1.0 - luminanceR) * scale;
    //     valueMatrix[0][1] = luminanceG * (1.0 - scale);
    //     valueMatrix[0][2] = luminanceB * (1.0 - scale);

    //     valueMatrix[1][0] = luminanceR * (1.0 - scale);
    //     valueMatrix[1][1] = luminanceG + (1.0 - luminanceG) * scale;
    //     valueMatrix[1][2] = luminanceB * (1.0 - scale);

    //     valueMatrix[2][0] = luminanceR * (1.0 - scale);
    //     valueMatrix[2][1] = luminanceG * (1.0 - scale);
    //     valueMatrix[2][2] = luminanceB + (1.0 - luminanceB) * scale;
    // }
}

    
