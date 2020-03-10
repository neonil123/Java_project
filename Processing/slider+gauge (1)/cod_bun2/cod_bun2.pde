PImage mostrador, ponteiro; //both images on DATA subfolder
PFont fontA;
int Tx, Ty, P0, P180;       // Tx/Ty position text indicator  P0/P180 start & End point of Arrow

//////////////////////////////////

 
import controlP5.*;
ControlP5 cp5;

int sliderValue =0;




void setup() {  
  size(1800,900);
  
   
   /////////////////////////////
  
   
  cp5 = new ControlP5(this);
  cp5.addSlider("sliderValue").setPosition(50,300).setRange(0,180).setSize(200, 20) ;
  cp5.addSlider("sliderValue1").setPosition(300,300).setRange(0,180).setSize(200, 20) ;
  //////////////////////////

 mostrador = loadImage("Gauge B&P Marshall 180.png");
 ponteiro = loadImage("marshall B&P ponteiro.png"); //loadImage("Ponteiro_Vermelho.png");
 Tx=-20 ;  Ty=58; P0=0  ;  P180=272 ;
   
 
 imageMode(CENTER);
 fontA = createFont("dutcheb.ttf", 20);; //numeric indication of the Angle
 textFont(fontA);


}


void draw() {


  gaude();
}



void gaude(){
 
  pushMatrix();
  stroke(153);
  translate(150, 150); // posiciona o mostrador no centro da tela
  image(mostrador, 0 , 50 , 300*0.9 , 300*0.9); // imagem, coluna, linha, Widt, Height
  fill(255,255,255);                       // Text Color = Blank
  text(int(sliderValue), Tx,Ty);              // Position of Text with Numeric Angle
  rotate(radians(int(sliderValue)));            // Rotate the Arrow as "rodar" value
  image(ponteiro, -20.5 , 75.5 , 300*0.33 , 300*0.33); // imagem, coluna, linha, Widt, Height
    popMatrix();
}
