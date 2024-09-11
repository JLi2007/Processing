
package kochsnowflake;

import java.awt.*;
import javax.swing.*;
import java.lang.Thread;

public class KochSnowflake extends JFrame {
    
    static double PiBy3 = Math.PI/3;
    static int width=700, height=700;
    static int maxlevel = 7;
    static int currLevel = 1;
    static double degToRad = Math.PI / 180;
    

    
    public void drawSnowflake(Graphics g, double x1, double y1, double x5, double y5, int level) {
        
        //BASE CASE
        if (level==1) {
            g.drawLine((int) x1, (int) y1, (int) x5, (int) y5);
        }
        
        //RECURSIVE CASE
        else {
            double dx = x5 - x1;  //THE DIFFERENCE BETWEEN THE X-VALUES
            double dy = y1 - y5;    
            double w = Math.hypot( dx, dy ) / 3;    //ONE THIRD THE LENGTH OF THE ORIGINAL LINE
            
            double theta = Math.atan2(dy, dx);      //THE ANGLE THAT THE BASE LINE MAKES WITH THE HORIZONTAL
            double bigAngle = theta + PiBy3;        //ADD 60 DEGREES (PI/3) TO GET THE ANGLE THAT THE LEFT SIDE OF THE WEDGE MAKES WITH THE HORIZONTAL 
            
            double x2 = x1 + dx/3;   //THE FIRST BENDING POINT
            double y2 = y1 - dy/3;   //SUBTRACT BECAUSE Y POINTS DOWN IN SCREEN GRAPHICS
            
            double x3 = x2 + w * Math.cos( bigAngle );    //THE WEDGE POINT
            double y3 = y2 - w * Math.sin( bigAngle );    //SUBSTRACT BECAUSE Y POINTS DOWN IN SCREEN GRAPHICS
            
            double x4 = x5 - dx/3;   //THE SECOND BENDING POINT
            double y4 = y5 + dy/3;
            
            drawSnowflake( g, x1,y1, x2,y2, level-1);
            drawSnowflake( g, x2,y2, x3,y3, level-1);
            drawSnowflake( g, x3,y3, x4,y4, level-1);
            drawSnowflake( g, x4,y4, x5,y5, level-1);
       }
    }
    
    public void paint(Graphics g) {
        g.clearRect(0, 0, width, height);
        g.setColor(Color.yellow);
        
        double Ax = width/5;
        double Bx = width - Ax;
        double Cx = (Ax+Bx)/2;
        
        double Ay = 4*height/5;
        double By = Ay;
        double Cy = Ay - (Bx-Ax)*Math.sqrt(3)/2;
       
        
        drawSnowflake(g, Bx, By, Ax, Ay, currLevel);
        drawSnowflake(g, Cx, Cy, Bx, By, currLevel);
        drawSnowflake(g, Ax, Ay, Cx, Cy, currLevel);
        //drawBinaryTree (g, 300, 500, 50, 90, 80, 7);
            
    }
    
 
    public static void sleep( int duration ) {
        try {
              Thread.sleep( duration );
            }
        catch (Exception e) {
            }
    }
    
    
    public static void main(String[] args) {
        KochSnowflake k = new KochSnowflake();
        
        k.setBackground(Color.black);
        k.setSize(width, height);
        k.setDefaultCloseOperation(EXIT_ON_CLOSE);
        k.setVisible(true);
        
        for (int i = 1; i < 8; i++) {
            k.repaint();
            sleep(2000);
            currLevel = i;
            
            
        }
        
    }
}
