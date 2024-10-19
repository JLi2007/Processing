// initalize arrays and variables
//heavy inspiration from a project I found online but I refactored everything and just took the metheod used (lerp)
float[] tau = new float[6]; 
float[] multiply = new float[3];
float[] angles = new float[3];
float[] x_coords = new float[3];
float[] y_coords = new float[3];
float x_width, y_width;
int color1, color2, color3;

void setup() {
    size(600,600); 
    noFill();
    x_width = width / 2;
    y_width = height / 2;  
    // populate tau array with TAU (circumfrance/radius) of a circle
    for(int i= 0; i<tau.length; i++){
        if(i%2==0){
            tau[i]=TAU/random(1, i*2);
        } else{ //this controls the size of the circle drawn
            tau[i] = tau[i-1]/random(1,4);
        }
    }
    // populate multiply array with random values based on width
    for(int i=0; i<multiply.length; i++){
        multiply[i] = width/random(1,i*2);
    }
    // initialize colors to lerp
    color1=color(200,70,100, 70);
    color2=color(0, 140, 128, 70);
}

void draw() {
    background(0); 
    for (int j = 0; j < 1000; j++) {
        // populate angles array with lerp of tau array (inspiration from project)
        for(int h=0; h<(tau.length/2); h++){
            angles[h]=lerp(tau[h], tau[h+1], h/1000);
        }
        // populate x coords array with the multiply and cosine of angles
        for(int x=0; x<x_coords.length; x++){
            x_coords[x]=x_width+(multiply[x]*cos(angles[x]));
        }
        // populate y coords array with the multiply and sine of angles
        for(int y=0; y<y_coords.length; y++){
            y_coords[y]=y_width+(multiply[y]*sin(angles[y]));
        }
        // take the lerp color of the color variables
        color3 = lerpColor(color1, color2, j/1000);
        // set stroke to color 3
        stroke(color3);
        // triangle with x and y coordinates
        triangle(x_coords[0],y_coords[0],x_coords[1],y_coords[1],x_coords[2],y_coords[2]);

        // change the tau values on each iteration to create the effect
        for(int z=0; z<tau.length; z++){
            // controls the size of the animation
            if(z%2==0){
                tau[z]=tau[z]+TAU+random(100, 1000); 
            }else{
                tau[z]=tau[z]+TAU-random(100, 1000); 
            }
        } 
    }
}