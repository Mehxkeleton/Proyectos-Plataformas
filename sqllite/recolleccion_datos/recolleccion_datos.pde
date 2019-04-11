import ketai.camera.*;
import ketai.cv.facedetector.*;
import ketai.data.*;
import ketai.net.*;
import ketai.net.bluetooth.*;
import ketai.net.nfc.*;
import ketai.net.nfc.record.*;
import ketai.net.wifidirect.*;
import ketai.sensors.*;
import ketai.ui.*;


KetaiSensor sensor;
KetaiSQLite db;
String CREATE_DB_SQL = "CREATE TABLE data ( _id INTEGER PRIMARY KEY AUTOINCREMENT, accelerometerX NUMBER NOT NULL,  accelerometerZ NUMBER NOT NULL, rotationX NUMBER NOT NULL, rotationY NUMBER NOT NULL, rotationZ NUMBER NOT NULL, magx NUMBER NOT NULL, magy NUMBER NOT NULL, magz NUMBER NOT NULL);";

float accelerometerX, accelerometerY, accelerometerZ;
float rotationX, rotationY, rotationZ;
float magx,magy,magz;


void setup()
{
  fullScreen();
  db = new KetaiSQLite( this);  // open database file
  sensor = new KetaiSensor(this);
  sensor.start();
  
  if ( db.connect() )
  {
    // for initial app launch there are no tables so we make one
    if (!db.tableExists("data"))
      db.execute(CREATE_DB_SQL);

    println("data count for data table: "+db.getRecordCount("data"));

    //lets insert a random number or records
    

    for (int i=0; i < 10; i++)
      if (!db.execute("INSERT into data ('accelerometerX', 'accelerometerY', 'accelerometerZ', 'rotationX', 'rotationY', 'rotationZ', 'magx','magy','magz') VALUES ("+accelerometerX +","+ accelerometerY+","+ accelerometerZ+","+ rotationX+","+ rotationY+","+ rotationZ+","+ magx+","+ magy+","+ magz+" )"))
        println("error w/sql insert");

    println("data count for data table after insert: "+db.getRecordCount("data"));

    // read all in table "table_one"
    db.query( "SELECT * FROM data" );

    while (db.next ())
    {
      println("----------------");
      print( db.getString("name") );
      print( "\t"+db.getInt("age") );
      println("\t"+db.getInt("foobar"));   //doesn't exist we get '0' returned
      println("----------------");
    }
  }
}

void onAccelerometerEvent(float x, float y, float z)
{
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}
void onGyroscopeEvent(float x, float y, float z)
{
  rotationX = x;
  rotationY = y;
  rotationZ = z;
}

void onMagneticFieldEvent(float x, float y, float z){
  magx=x;
  magy=y;
  magz=z;
}
