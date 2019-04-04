import ketai.sensors.*;
import oscP5.*;
import netP5.*;
 
KetaiSensor sensor; 
float aX, aY, aZ;
float pax,pay,paz;
float dThresh=0.05;
boolean accChange=false;
 
float val;
float dc;
float paddle_y;
int paddle_width = 200;
int paddle_height = 50;
int dist_wall = 15;

OscP5 oscP5;
NetAddress myRemoteLocation;
 
void settings() { 
  fullScreen();
}
 
void setup() { 
  sensor = new KetaiSensor(this); 
  sensor.start(); 
  // orientation(LANDSCAPE); 
  textAlign(CENTER, CENTER); 
  textSize(32); 
  
   /* start listening on port 12001, incoming messages must be sent to port 12001 */
  oscP5 = new OscP5(this,12001);

  // send to computer address
  myRemoteLocation = new NetAddress("192.168.137.1",12001);
}
 
void draw() { 
  background(0); 
  text("Accelerometer: \nx: " + nfp(aX, 1, 3) + "\ny: " + nfp(aY, 1, 3) + "\nz: " + nfp(aZ, 1, 3) + "\nCHANGE=" + nfc(dc,2), 0, 0, width, height);
 
  if(accChange==true){
    val = map (aX,-6,+6,0,width);
    paddle_y = constrain(val, 0, width-paddle_width); //(aX,-6,+6,0,width);   
    OscMessage myMessage = new OscMessage("/test");
    myMessage.add(val);
    oscP5.send(myMessage, myRemoteLocation); 
    //println("standard sketch, sending to "+myRemoteLocation);
    accChange=false;
  }
 
 fill(153);
 rect(paddle_y, height-50, paddle_width, paddle_height);  
}
 
void onAccelerometerEvent(float x, float y, float z) {
  pax=aX;
  pay=aY;
  paz=aZ;
 
  aX = x;
  aY = y; 
  aZ = z; 
 
  //...................................................................
  //dc: "detected change", use in case only one axis to be a reference
  dc=abs(aX-pax);
  //...................................................................
  //dc: "detected change", use in case you want to detect change in all three axis
  //dc=sqrt(pow(aX-pax,2)+pow(aY-pay,2)+pow(aZ-paz,2));
 
  if(dc>dThresh){
    accChange=true;
  }
}
