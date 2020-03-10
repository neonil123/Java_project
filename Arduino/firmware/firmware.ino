#include <Wire.h>
#include "rgb_lcd.h"

rgb_lcd lcd;
const int colorR = 255;
const int colorG = 255;
const int colorB = 255;

#define speedo 150

#define lenta1 5
#define lenta2 3
#define magnet 11
#define ventilator 12


int spLenta1=0;
int spLenta2=0;
int sMagnet=0;
int sVentilator=0;

char inc;
int value;

int val=0; //sensor value
#define prag 300 

#include <Servo.h>
Servo myservo;
Servo myservo1;

int pos = 130; //de la 95.......130....160
int pos1 =90; //de la  0.........90....150


void setup() 
{
//
    lcd.begin(16, 2);
    lcd.setRGB(colorR, colorG, colorB);
    lcd.print("ASO PROJ'20");
//
  Serial.begin(9600);
  
   myservo.attach(9);  
   myservo1.attach(10); 
   
   pinMode(lenta1, OUTPUT);  
   pinMode(lenta2, OUTPUT); 
   pinMode(magnet, OUTPUT); 
   pinMode(ventilator, OUTPUT); 

}

void loop() 
{

while (Serial.available()) 
  {
    inc = Serial.read();
    if (inc >= '0' && inc <= '9') {
      value = 10*value + (inc-'0');
    } 
    
   else {
      switch (toupper(inc)) {
      case 'A':
       // Serial.print("Case A got ");
       spLenta1=value;
        break;
      case 'B':
        //Serial.print("Case B got ");
        spLenta2=value;
        break;
      case 'C':
        //Serial.print("Case B got ");
        sVentilator=value;
        break;
      case 'D':
        //Serial.print("Case B got ");
        sMagnet=value;
        break;
        
      default :
       ;
      }
      
 
      val = 0;  
    }
  }






  
lcd.setRGB(colorR, colorG, colorB);
lcd.setCursor(0, 0);
lcd.print("Detectare deseu");
  
delay(1000);
myservo.write(95);      
myservo1.write(90); 
analogWrite(lenta1, spLenta1);
analogWrite(lenta2, spLenta2);
val= analogRead(A0);


if(val<prag)
{
    lcd.setCursor(0, 1);
    lcd.print("Metal");
    lcd.setRGB(255, 0, 0);

    
    analogWrite(lenta1, 0);
    analogWrite(lenta2, 0);
    digitalWrite(ventilator, LOW);
    digitalWrite(magnet, HIGH);

    for(int i=0 ;i<130;i++)
    { 
      myservo1.write(i); 
      delay(20);
    }

    digitalWrite(magnet, LOW);
    myservo1.write(90); 
    delay(1000);

    
lcd.clear();
if(val <prag)
{
    lcd.setCursor(0, 1);
    lcd.print("Metal Neferos");
    lcd.setRGB(0,255,0);
    analogWrite(lenta1, 250);
    analogWrite(lenta2,0);
    digitalWrite(ventilator, LOW);
    digitalWrite(magnet, LOW);
    for(int i=95 ;i<140;i++)
    { 
      myservo.write(i); 
      delay(40);
    }
    delay(5000);
    lcd.clear();
}
myservo.write(95); 
delay(1000);
 


}
    digitalWrite(ventilator, sVentilator);
    digitalWrite(magnet, sMagnet);


  
}
