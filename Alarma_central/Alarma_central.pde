import netP5.*;
import oscP5.*;

OscP5 oscP5; // carro

boolean acel, prox, touch, gps, luz;

void setup(){
  oscP5 = new OscP5(this, 12001);  
  
  size(400,600);
  
  ellipseMode(RADIUS);
}

void draw(){
  background(240);
  
  text("Movimiento en auto estacionado", 50, 100);
  text("Robo de Auto", 50, 200);
  text("Proximidad al Auto", 50, 300);
  text("Peligro de forzado de vidrios", 50, 400);
  text("Peligro de entrada no autorizada", 50, 500);
  
  stroke(0);
  fill(0);
  
  //alarma 1
  if (acel && !gps){
    fill(0,255,0);
    acel = false;
  }
  rect(350,100,10,10);
  
  
  //alarma 2
  if (acel && gps){
    fill(0,255,0);
    acel = false;
    gps = false;
  }
  rect(350,200,10,10);
  fill(0);
  
  //alarma 3
  if (prox){
    fill(0,255,0);
    prox = false;
  }
  rect(350,300,10,10);
  fill(0);
  
  //alarma4
  if (touch && !luz){
    fill(0,255,0);
    touch = false;
  }
  rect(350,400,10,10);
  fill(0);
  
  //alarma 5
  if (touch && luz){
    fill(0,255,0);
    touch = false;
    luz = false;
  }
  rect(350,500,10,10);
  fill(0);
}

void oscEvent(OscMessage theOscMessage) {
  int valor=theOscMessage.get(0).intValue()
  println(valor);
  switch(valor){
    case 1:
      acel = true;
      break;
    case 2:
      gps = true;
      break;
    case 3:
      prox = true;
    break;
    case 4:
      touch = true;
      break;
    case 5:
      luz = true;
    break;
  }
   
}

void mousePressed(){
  acel = true;
  prox = true;
  gps = true;
  touch = true;
  luz = true;
}
/*
void mouseReleased(){
  acel = false;
  prox = false;
  gps = false;
  touch = false;
  luz = false;
}*/
