
import controlP5.*;
ControlP5 cp5;

int BANDA1 =0;
int BANDA2 =0;

import meter.*;

Meter m;
Meter n; 



void setup() {
 
  size(1800, 900);
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
  m.setShortTicsBetweenLongTics(5);

////////////////////////////////////////////////////////////////////////
  n = new Meter(this, 70, 455, false); // full circle - true, 1/2 circle - false  
  n.setMinScaleValue(0);
  n.setMaxScaleValue(100);
    
  // Display digital meter value.
  n.setDisplayDigitalMeterValue(true);
  n.setTitle("Speed 2");
  
  String[] scaleLabels2 = {"0", "10", "20", "30", "40", "50", "60", "70", "80", "90", "100"};
  n.setScaleLabels(scaleLabels);
  n.setShortTicsBetweenLongTics(5);



}

void draw() {
  m.updateMeter(BANDA1);
  n.updateMeter(BANDA2);
}
