// import libraries
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*; // http://www.sojamo.de/libraries/controlP5/
import processing.serial.*;

/* SETTINGS BEGIN */

// Serial port to connect to
String serialPortName = "COM5";

// If you want to debug the plotter without using a real serial port set this to true
boolean mockupSerial = false;

/* SETTINGS END */

Serial serialPort; // Serial port object

// interface stuff
ControlP5 cp5;



// plots

Graph LineGraph = new Graph(225, 350, 600, 200, color (20, 20, 200));

float[][] lineGraphValues = new float[6][100];
float[] lineGraphSampleNumbers = new float[100];
color[] graphColors = new color[1];

// helper for saving the executing path
String topSketchPath = "";

void setup() {
  frame.setTitle("Realtime plotter");
  size(890, 620);

  // set line graph colors
  graphColors[0] = color(131, 255, 20);
  

  // settings save file
  topSketchPath = sketchPath();
  

  // gui
  cp5 = new ControlP5(this);
  
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

  // build the gui
  int x = 170;
  int y = 60;

 

  
  

}

byte[] inBuffer = new byte[100]; // holds serial message
int i = 0; // loop variable
void draw() {
  /* Read serial and update values */
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
    

    
    
    
    
   

    // build the arrays for bar charts and line graphs
    int barchartIndex = 0;
    for (i=0; i<nums.length; i++) {

      

      // update line graph
      try {
        if (i<lineGraphValues.length) {
          for (int k=0; k<lineGraphValues[i].length-1; k++) {
            lineGraphValues[i][k] = lineGraphValues[i][k+1];
          }

          lineGraphValues[i][lineGraphValues[i].length-1] = float(nums[i]);
        }
      }
      catch (Exception e) {
      }
    }
  }

  

  // draw the line graphs
  LineGraph.DrawAxis();
  
    LineGraph.GraphColor = graphColors[0];
    
      LineGraph.LineGraph(lineGraphSampleNumbers, lineGraphValues[0]);
  
}

// called each time the chart settings are changed by the user 
void setChartSettings() {
  LineGraph.xLabel=" Samples ";
  LineGraph.yLabel="Value";
  LineGraph.Title="";  
  LineGraph.xDiv=20;  
  LineGraph.xMax=1000; 
  LineGraph.xMin=0;  
  LineGraph.yMax=1; 
  LineGraph.yMin=-1;
}
