import android.os.Bundle; 
import android.content.Intent;  

import ketai.net.bluetooth.*;
import netP5.*;
import ketai.ui.*;
import ketai.net.*;
import oscP5.*;

OscP5 oscP5;
NetAddress remoteLocation;

int num = 0;

KetaiBluetooth bt;  
KetaiList connectionList;  


String myIPAddress;

boolean acel, prox, touch, gps, luz;

void setup()
{
   initNetworkConnection();
   bt.start(); 
   bt.makeDiscoverable();  
   orientation(LANDSCAPE);
}

void draw()
{ 
  background(150);
  
  textSize(45);
  // Diferentes tipos de Alarmas
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
  


// Presiona la pantalla para conectar el otro telefono
void mousePressed()
{
  if (bt.getDiscoveredDeviceNames().size() > 0)
      connectionList = new KetaiList(this, bt.getDiscoveredDeviceNames());  
  else if (bt.getPairedDeviceNames().size() > 0)
      connectionList = new KetaiList(this, bt.getPairedDeviceNames());  
}


// Metodo que recibe el mensaje por Bluetooth
void onBluetoothDataEvent(String who, byte[] data) 
{
  print("Recibo");
   KetaiOSCMessage m = new KetaiOSCMessage(data); 
   if (m.isValid())
  {
    if (m.checkAddrPattern("/test"))
    {  
        num= m.get(0).intValue();
        switch(num){
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
        
        // Mandamos el mensaje de alerta a la computadora
        OscMessage myMessage = new OscMessage("Alarmas");
        myMessage.add(num);
        oscP5.send(myMessage, remoteLocation);
    }
  }
}  

void onKetaiListSelection(KetaiList connectionList)  
{
  String selection = connectionList.getSelection();  
  bt.connectToDeviceByName(selection);  
  connectionList = null;  
}

void initNetworkConnection()
{
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress("192.168.1.1", 12001); 
  myIPAddress = KetaiNet.getIP(); // Verifica la dirección Ip del dispositivo Android
}
