/* autogenerated by Processing revision 1293 on 2024-10-18 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class processing extends PApplet {

public void setup() {
  ComplexNum z = new ComplexNum(6, 8);
  ComplexNum w = new ComplexNum(-2.5f, -7.9f);
  ComplexNum i = new ComplexNum(0, 1);
  
  z.printMe();  //would print 6 + 8i  
  w.printMe();   
  i.printMe();     
  
  float absZ = z.absoluteValue();
  float absI = i.absoluteValue();

  println( absZ );    //Should print 10.0
  println( absI );    //Should print 1.0
  
  ComplexNum zPlusW = z.add( w );
  zPlusW.printMe();    //Should print "3.5+0.1i"
  
  ComplexNum wPlusI = w.add( i );
  wPlusI.printMe();    //Does it print the right thing?

  exit();
}
class ComplexNum{
    float realNumber;
    float imaginaryNumber;

    ComplexNum(float realNum, float imaginaryNum){
        this.realNumber = realNum;
        this.imaginaryNumber = imaginaryNum;
    }

    public void printMe(){
        if(this.realNumber == 0){
            println(this.imaginaryNumber + "i");
        } 
        else if (this.imaginaryNumber == 0){
            println(this.realNumber);
        }else{
            println(this.realNumber + " + " + this.imaginaryNumber + "i");
        }
    }

    public ComplexNum add(ComplexNum complexNum){
        return((new ComplexNum(roundToOneDecimal(this.realNumber + complexNum.realNumber), roundToOneDecimal(this.imaginaryNumber + complexNum.imaginaryNumber))));
    }

    public float absoluteValue(){
        return(sqrt((this.realNumber*this.realNumber)+(this.imaginaryNumber*this.imaginaryNumber)));
    }

    public float roundToOneDecimal(float value) {
        return round(value * 10) / 10.0f;
    }
}


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
