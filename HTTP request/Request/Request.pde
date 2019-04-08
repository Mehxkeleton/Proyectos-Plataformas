import http.requests.*;

String entrada [][];

public void setup() 
{
  size(400,400);
  smooth();
  
  
  
    // Display a full circle meter.
  m = new Meter(this, 5, 5, true); // Instantiate a full circle meter class.
  m.setMeterWidth(100);

  // Define where the scale labele will appear
  m.setArcMinDegrees(0.0); // Zero (right side start)
  m.setArcMaxDegrees(360.0); // TWO_PI (right side end)
  m.setDisplayLastScaleLabel(false);
  // Display digital meter value.
  m.setDisplayDigitalMeterValue(true);
  // Set a warning if sensor value is too low.
  m.setLowSensorWarningActive(true);
  m.setLowSensorWarningValue((float)1.0);
  // Set a warning if sensor value is too high.
  m.setHighSensorWarningActive(true);
  m.setHighSensorWarningValue((float)4.0);
}

void draw(){
  GetRequest get = new GetRequest("http://httprocessing.heroku.com"); //esto cambialo por el url que utilizes para el servidor
  get.send();
  entrada = matchAll(get.getContent(),"<Sensor_Id>(.*?)</Sensor_Id>");
  float valores[] = new float [entrada.length];
  
  for (int i =0; i<entrada.length; i++){
    valores [i] = Float.parseFloat(entrada [i][1]);
  }
  
  for (int i=0; i<valores.length; i++){
    m.updateMeter((int)(newSensorReading * 255));
  }
}
