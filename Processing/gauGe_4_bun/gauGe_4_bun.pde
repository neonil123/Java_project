
import controlP5.*;
import java.awt.Frame;
import java.awt.BorderLayout;
import processing.serial.*;

/* SETTINGS BEGIN */
byte[] inBuffer = new byte[100]; // holds serial message
int i = 0; // loop variable
// Serial port to connect to
String serialPortName = "COM5";

// If you want to debug the plotter without using a real serial port set this to true
boolean mockupSerial = false;

/* SETTINGS END */
Serial serialPort; // Serial port object
ControlP5 cp5;

// plots

Graph LineGraph = new Graph(1125, 300, 600, 300, color (20, 20, 200));

float[][] lineGraphValues = new float[6][100];
float[] lineGraphSampleNumbers = new float[100];
color[] graphColors = new color[1];

// helper for saving the executing path
String topSketchPath = "";

int col = color(255);
int myColor = color(0,0,0);

boolean toggleValue = false;

int BANDA1 =0;
int BANDA2 =0;

import meter.*;

Meter m;
Meter n; 
 ////////////////////

void setup() {
 cp5 = new ControlP5(this);
  size(1800, 900);
  noStroke();
   ///////////////////////////// 
   graphColors[0] = color(131, 255, 20);
  

  // settings save file
  topSketchPath = sketchPath();
  // init charts
  setChartSettings();
  // build x axis values for the line graph
  for (int i=0; i<lineGraphValues.length; i++) {
    for (int k=0; k<lineGraphValues[0].length; k++) {
      lineGraphValues[i][k] = 0;
      if (i==0)
        lineGraphSampleNumbers[k] = k;
    }
  }
  
  // start serial communication
  if (!mockupSerial) {
    //String serialPortName = Serial.list()[3];
    serialPort = new Serial(this, serialPortName, 115200);
  }
  else
    serialPort = null;
  /////////////////////////////
  
  cp5.addSlider("BANDA1").setPosition(180,360).setRange(0,255).setSize(250, 30) ;
  cp5.addSlider("BANDA2").setPosition(180,760).setRange(0,255).setSize(250, 30) ;
  //////////////////////////

  m = new Meter(this, 70, 55, false); // full circle - true, 1/2 circle - false  
  m.setMinScaleValue(0);
  m.setMaxScaleValue(100);
    
  // Display digital meter value.
  m.setDisplayDigitalMeterValue(true);
  m.setTitle("Speed 1");
  
  String[] scaleLabels = {"0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"};
  m.setScaleLabels(scaleLabels);
  m.setShortTicsBetweenLongTics(4);

////////////////////////////////////////////////////////////////////////
  n = new Meter(this, 70, 455, false); // full circle - true, 1/2 circle - false  
  n.setMinScaleValue(0);
  n.setMaxScaleValue(100);
    
  // Display digital meter value.
  n.setDisplayDigitalMeterValue(true);
  n.setTitle("Speed 2");
  
  String[] scaleLabels2 = {"0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"};
  n.setScaleLabels(scaleLabels);
  n.setShortTicsBetweenLongTics(4);
 
 ///////////////////////////////
 cp5.addToggle("toggle")
     .setPosition(700,90)
     .setSize(100,40)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setColorActive(color(0,255,0));
     ;
 ////////////////////////////////
cp5.addToggle("toggle1")
     .setPosition(700,230)
     .setSize(100,40)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setColorActive(color(0,255,0));
     
     ;

 /////////////////////////////////////////////////
  cp5.addSlider("slider1")
     .setPosition(650,500)
     .setSize(40,200)
     .setRange(0,180)
     .setNumberOfTickMarks(4)
     ;
     ///////////////////////////////
      cp5.addSlider("slider2")
     .setPosition(850,500)
     .setSize(40,200)
     .setRange(0,180)
     .setNumberOfTickMarks(4)
     ;
     //////////////////////
}

void draw() {
  
  /////VOID DRAW PLOTTER////
  if (mockupSerial || serialPort.available() > 0) {
    String myString = "";
    if (!mockupSerial) {
      try {
        serialPort.readBytesUntil('\r', inBuffer);
      }
      catch (Exception e) {
      }
      myString = new String(inBuffer);
    }
    else {
      myString = mockupSerialFunction();
    }

    //println(myString);

    // split the string at delimiter (space)
    String[] nums = split(myString, ' ');
   
   
    

      

      // update line graph
      
        if (i<lineGraphValues.length) {
          for (int k=0; k<lineGraphValues[i].length-1; k++) {
            lineGraphValues[i][k] = lineGraphValues[i][k+1];
          }

          lineGraphValues[i][lineGraphValues[i].length-1] = float(nums[i]);
        }
      
      
     
    
  }

  

  // draw the line graphs
  LineGraph.DrawAxis();
  
    LineGraph.GraphColor = graphColors[0];
    
      LineGraph.LineGraph(lineGraphSampleNumbers, lineGraphValues[0]);
 /////////////////////////VOID DRAW PLOTTER FINISH/////////
m.updateMeter(BANDA1);
  n.updateMeter(BANDA2);
  pushMatrix();
  textOFF(680,121);  
  textON(870,120);
  //////////////////////
  textOFF(680,262); 
  textON(870,262);
  ventilatorul(860,75);
  electromagnet(880,220);
  brat1(700,460);
  brat2(900,460);
    popMatrix();
  

  
  
  
}

void textOFF(int a, int b){
  textSize(32);                  //OFF
  text("OFF", a, b); 
  fill(0, 102, 153);
}
    
void textON(int a, int b){
  textSize(32);                  //ON
  text("ON", a, b); 
  fill(0, 102, 153);
}

void ventilatorul(int a, int b){
  textSize(35);
  text("Ventilatorul", a, b); 
  fill(0, 102, 153);
}
void electromagnet(int a, int b){
  textSize(35);
  text("Electromagnet", a, b); 
  fill(0, 102, 153);
}

void brat1(int a, int b){
  textSize(35);
  text("Brat1", a, b); 
  fill(0, 102, 153);
}
void brat2(int a, int b){
  textSize(35);
  text("Brat2", a, b); 
  fill(0, 102, 153);
}
void toggle(boolean theFlag) {
  if(theFlag==true) {
    println("Ventilator off");
  } else {
    println("Ventilator on");
  }
}
void toggle1(boolean theFlag) {
  if(theFlag==true) {
    println("Electromagnet off");
  } else {
    println("Electromagnet on");
  }
  
}

void slider1(int slider1) {
    println("Slider1: "+slider1);
  }

void slider2(int slider2) {
    println("Slider2: "+slider2);
  }  
void setChartSettings() {
  LineGraph.xLabel=" Samples ";
  LineGraph.yLabel="Value";
  LineGraph.Title="";  
  LineGraph.xDiv=20;  
  LineGraph.xMax=100; 
  LineGraph.xMin=0;  
  LineGraph.yMax=1024; 
  LineGraph.yMin=0;
}
