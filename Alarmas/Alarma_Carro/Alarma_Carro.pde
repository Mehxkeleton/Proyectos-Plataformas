import android.os.Bundle; 
import android.content.Intent; 

import ketai.sensors.*;
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
import oscP5.*;

KetaiSensor sensor;
KetaiBluetooth bt;  
KetaiList connectionList; 

double longitude, latitude, altitude;

float accelerometerX, accelerometerY, accelerometerZ;

boolean acel, prox, touch, gps, luz;


void settings() { 
  fullScreen();
}


void setup(){
  sensor = new KetaiSensor(this); 
  sensor.start(); 
  bt.start(); 
  bt.makeDiscoverable();
  if (bt.getDiscoveredDeviceNames().size() > 0)
      connectionList = new KetaiList(this, bt.getDiscoveredDeviceNames());  
  else if (bt.getPairedDeviceNames().size() > 0)
      connectionList = new KetaiList(this, bt.getPairedDeviceNames()); 

  textAlign(CENTER, CENTER); 
  textSize(32);
  
}

void draw(){
  background(240);
  text(bt.getConnectedDeviceNames().toString(), 100,550);
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
  }
  rect(350,100,10,10);
  fill(0);
  
  //alarma 2
  if (acel && gps){
    fill(0,255,0);
  }
  rect(350,200,10,10);
  fill(0);
  
  //alarma 3
  if (prox){
    fill(0,255,0);
  }
  rect(350,300,10,10);
  fill(0);
  
  //alarma4
  if (touch && !luz){
    fill(0,255,0);
  }
  rect(350,400,10,10);
  fill(0);
  
  //alarma 5
  if (touch && luz){
    fill(0,255,0);
  }
  rect(350,500,10,10);
  fill(0);
}

void onAccelerometerEvent(float x, float y, float z){
  if (x - accelerometerX > 1 || y - accelerometerY > 1 || z - accelerometerZ > 1){
    acel=true;
    OscMessage myMessage = new OscMessage("/test");
    myMessage.add(1);
    bt.broadcast(myMessage.getBytes());
  } else {
    acel=false;
  }
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}

void onLocationEvent(double _latitude, double _longitude,
  double _altitude, float _accuracy) { // 5
  if(longitude != _longitude || latitude != _latitude || altitude != _altitude){
    gps=true;
    OscMessage myMessage = new OscMessage("/test");
    myMessage.add(2);
    bt.broadcast(myMessage.getBytes());
  }
  else{ 
    gps = false;
  }
  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
}

void onProximityEvent(float v) // 4
{
  if (v==1){
    prox= true;
    OscMessage myMessage = new OscMessage("/test");
    myMessage.add(3);
    bt.broadcast(myMessage.getBytes());
  } else{
    prox=false;
  }
}

void mousePressed(){
  touch=true;
  OscMessage myMessage = new OscMessage("/test");
  myMessage.add(4);
  bt.broadcast(myMessage.getBytes());

}

void mouseReleased(){
  touch=false;
}

void onLightEvent(float v){
  if (v>40){
    luz=true;
    OscMessage myMessage = new OscMessage("/test");
    myMessage.add(5);
    bt.broadcast(myMessage.getBytes()); 
  } else{
    luz= false;
  }
  
}

void onKetaiListSelection(KetaiList connectionList)  
{
  String selection = connectionList.getSelection();  
  bt.connectToDeviceByName(selection);  
  connectionList = null;  
}
