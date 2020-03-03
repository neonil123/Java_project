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
#define prag 10160
int stabilizat;

#define capPin A2
#define pulsePin A3
#define millsecs 3   


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
    lcd.print("RUBE GOLDBERG'19");
//
  Serial.begin(9600);
  pinMode(pulsePin, OUTPUT); 
  digitalWrite(pulsePin, LOW);
  pinMode(capPin, INPUT);  
   myservo.attach(9);  
   myservo1.attach(10); 
   
   pinMode(lenta1, OUTPUT);  
   pinMode(lenta2, OUTPUT); 
   pinMode(magnet, OUTPUT); 
   pinMode(ventilator, OUTPUT); 

}

void loop() 
{
lcd.setRGB(colorR, colorG, colorB);
lcd.setCursor(0, 0);
lcd.print("Detectare deseu");
  
int sum1=functie1();
Serial.print("sum1: "); 
Serial.println(sum1); 
delay(100); 
myservo.write(95);      
myservo1.write(90); 
analogWrite(lenta1, speedo);
analogWrite(lenta2, speedo);



if(sum1<prag)
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
    functie1();
    delay(1000);

functie1();
functie1();
Serial.println(sum1); 
int sum1=functie1();
int sum2=functie1();
lcd.clear();
if(sum1<prag)
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
    digitalWrite(ventilator, HIGH);
    digitalWrite(magnet, LOW);


    
}














int functie1()
{



  
  long unsigned int sum=0;
  int minval=1023;
  int maxval=0;
  
  
  for (int i=0; i<256; i++)
  {
    //reset the capacitor
    pinMode(capPin,OUTPUT);
    digitalWrite(capPin,LOW);
    delayMicroseconds(20);
    pinMode(capPin,INPUT);
    applyPulses();
    
    //read the charge of capacitor
    int val = analogRead(capPin); //takes 13x8=104 microseconds
    minval = min(val,minval);
    maxval = max(val,maxval);
    sum+=val;  

  }

  //subtract minimum and maximum value to remove spikes
  
  sum-=minval; 
  sum-=maxval;
  
  return (sum);
  }



void applyPulses()
{
    for (int i=0;i<3;i++) {
      digitalWrite(pulsePin,HIGH); //take 3.5 uS
      delayMicroseconds(millsecs);
      digitalWrite(pulsePin,LOW);  //take 3.5 uS
      delayMicroseconds(millsecs);
    }
}
