/* autogenerated by Processing revision 1293 on 2024-09-11 */
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

public class Processing extends PApplet {

public void setup() {
   println(convertTemp("59,F"));
}


// function to convert either C to F or F to C
public float convertTemp(String temperature) {
    String[] split = split(temperature, ',');
    println(split[1]);
    if(split[1].equals("F")){
        return(((PApplet.parseInt(split[0])-32))*5/9);
    }
    else{
        return((9/5)*(PApplet.parseInt(split[0])+32));
    }
}


  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
