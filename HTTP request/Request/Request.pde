import meter.*;

import http.requests.*;


String entrada [][] = new String [3][10];
Meter m[] = new Meter[3];
float valores[] = new float [3];

public void setup() 
{
  size(1500,600);
  //smooth();
    // Display a full circle meter.
  for (int i=0; i<3; i++){
    m[i] = new Meter(this, 5+(410*i), 25, true); // Instantiate a full circle meter class.
    //m[i].setMeterWidth(120);

  // Define where the scale labele will appear
    m[i].setArcMinDegrees(0.0); // Zero (right side start)
    m[i].setArcMaxDegrees(360.0); // TWO_PI (right side end)
    m[i].setDisplayLastScaleLabel(false);
    // Display digital meter value.
    m[i].setDisplayDigitalMeterValue(true);
    // Set a warning if sensor value is too low.
    m[i].setLowSensorWarningActive(true);
    m[i].setLowSensorWarningValue((float)1.0);
    // Set a warning if sensor value is too high.
    m[i].setHighSensorWarningActive(true);
    m[i].setHighSensorWarningValue((float)4.0);
  }
}

void draw(){
  GetRequest get = new GetRequest("http://httprocessing.heroku.com"); //esto cambialo por el url que utilizes para el servidor
  get.send();
  entrada = matchAll(get.getContent(),"<Sensor_Id>(.*?)</Sensor_Id>");
  
  
  /*for (int i =0; i<3; i++){
    valores [i] = Float.parseFloat(entrada [i][1]);
  }*/
  
  for (int i=0; i<3; i++){
    //m[i].updateMeter((int)(valores[i] * 255));
    m[i].updateMeter(200);
  }
}
