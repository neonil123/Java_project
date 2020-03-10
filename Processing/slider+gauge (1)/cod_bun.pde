PImage mostrador, ponteiro; //both images on DATA subfolder
PFont fontA;
int Tx, Ty, P0, P180;       // Tx/Ty position text indicator  P0/P180 start & End point of Arrow
int Wsize1 = 300;   //Wsize1  &  Wsize2 = tamanho janela 
int Wsize2 = 300;
//////////////////////////////////

 
import controlP5.*;
ControlP5 cp5;

int sliderValue =0;




void setup() {  
  size(700,400,OPENGL);
  
   
   /////////////////////////////
  
   
  cp5 = new ControlP5(this);
  cp5.addSlider("sliderValue").setPosition(50,300).setRange(0,180).setSize(200, 20) ;
  
  //////////////////////////

 mostrador = loadImage("Gauge B&P Marshall 180.png");
 ponteiro = loadImage("marshall B&P ponteiro.png"); //loadImage("Ponteiro_Vermelho.png");
 Tx=-20 ;  Ty=58; P0=0  ;  P180=272 ;
   
 
 imageMode(CENTER);
 fontA = createFont("dutcheb.ttf", 20);; //numeric indication of the Angle
 textFont(fontA);


}


void draw() {

  gaude(sliderValue);
  
}



void gaude(int a){
 
   pushMatrix();
    float angulo=a; 
    stroke(153);
  translate(Wsize1/2, Wsize2/2); // posiciona o mostrador no centro da tela
  image(mostrador, 0 , 0 , Wsize1*0.9 , Wsize2*0.9); // imagem, coluna, linha, Widt, Height
  fill(255,255,255);                       // Text Color = Blank
  text(int(angulo), Tx,Ty);              // Position of Text with Numeric Angle
  rotate(radians(int(angulo)));            // Rotate the Arrow as "rodar" value
  image(ponteiro, -22.9 , 23.1 , Wsize1*0.33 , Wsize2*0.33); // imagem, coluna, linha, Widt, Height
    popMatrix();
}
