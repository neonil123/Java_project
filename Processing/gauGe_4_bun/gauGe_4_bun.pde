
import controlP5.*;
ControlP5 cp5;

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
 
  size(1800, 900);
  noStroke();
   ///////////////////////////// 
  cp5 = new ControlP5(this);
  cp5.addSlider("BANDA1").setPosition(180,350).setRange(0,255).setSize(250, 30) ;
  cp5.addSlider("BANDA2").setPosition(180,750).setRange(0,255).setSize(250, 30) ;
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
  m.updateMeter(BANDA1);
  n.updateMeter(BANDA2);
  pushMatrix();
  textOFF(620,121);  
  textON(820,120);
  //////////////////////
  textOFF(620,262); 
  textON(820,262);
  ventilatorul(640,75);
  electromagnet(620,220);
  brat1(620,460);
  brat2(820,460);
  
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
  textSize(40);
  text("Ventilatorul", a, b); 
  fill(0, 102, 153);
}
void electromagnet(int a, int b){
  textSize(40);
  text("Electromagnet", a, b); 
  fill(0, 102, 153);
}

void brat1(int a, int b){
  textSize(40);
  text("Brat1", a, b); 
  fill(0, 102, 153);
}
void brat2(int a, int b){
  textSize(40);
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
