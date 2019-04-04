
/* osc send-receive, android sketch */

import oscP5.*;
import netP5.*;
  
OscP5 oscP5_1;
OscP5 oscP5;
NetAddress myRemoteLocation;

//Cambiar altura resolucion telefono
int hsc = 1440;


// Global variables for the ball
float ball_x;
float ball_y;
float ball_dir = 1;
float ball_size = 50;  // Radius
float dy = 0;  // Direction
float paddle_y;
float extMouseY;
float PextMouseY;
float paddle_y_1;
float extMouseY_1;
float PextMouseY_1;

// Global variables for the paddle
int paddle_width = 50;
int paddle_height = 230;

int dist_wall = 15;

void setup() {
  /* start listening on port 12001, incoming messages must be sent to port 12001 */
  oscP5 = new OscP5(this,12001);
  oscP5_1 = new OscP5(this,12000);
  size(1080,720);
  // send to computer address
  //myRemoteLocation = new NetAddress("148.229.21.129",12000);
  
  
  rectMode(RADIUS);
  ellipseMode(RADIUS);
  noStroke();
  smooth();
  ball_y = height/2;
  ball_x = width/2;
}
/**
 * Collision (Pong). 
 * 
 * Move the mouse up and down to move the paddle.  
 */



void draw() 
{
  background(51);
  
  ball_x += ball_dir * 10;
  ball_y += dy;
  if(ball_x > width+ball_size) {
    ball_x = width/2;
    ball_y = random(0, height);
    dy = 0;
  }
  
  // Constrain paddle to screen
  
  
  
  // Test to see if the ball is touching the paddle
  float py = width-dist_wall-paddle_width-ball_size;
  float py_1 = dist_wall+paddle_width+ball_size;
  if((ball_x >= py 
     && ball_y > paddle_y - paddle_height - ball_size 
     && ball_y < paddle_y + paddle_height + ball_size) || (ball_x <= py_1 
     && ball_y > paddle_y - paddle_height - ball_size 
     && ball_y < paddle_y + paddle_height + ball_size)){
    ball_dir *= -1;
    
 
    
    
    if(extMouseY != PextMouseY) {
      dy = (extMouseY-PextMouseY)/2.0;
      //if(dy >  5) { dy =  15; }
      //if(dy < -5) { dy = -15; }
    }
    
  } 
  
  // If ball hits paddle or back wall, reverse direction
  /*if(ball_x < ball_size && ball_dir == -1) {
    ball_dir *= -1;
    
  }*/
  
  // If the ball is touching top or bottom edge, reverse direction
  if(ball_y > height-ball_size) {
    dy = dy * -1;
  }
  if(ball_y < ball_size) {
    dy = dy * -1;
  }

  // Draw ball
  fill(255);
  ellipse(ball_x, ball_y, ball_size, ball_size);
  
  // Draw the paddle
  fill(153);
  rect(width-dist_wall, paddle_y, paddle_width, paddle_height);  
  fill(153);
  rect(0, paddle_y, paddle_width+dist_wall, paddle_height);  
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.port()==12000){
    PextMouseY = extMouseY;
    extMouseY = (theOscMessage.get(0).floatValue());
    paddle_y = constrain(extMouseY, paddle_height, height-paddle_height);
  }else if (theOscMessage.port()==12001){
    PextMouseY_1 = extMouseY_1;
    extMouseY_1 = (theOscMessage.get(0).floatValue()) ;
    paddle_y_1 = constrain(extMouseY_1, paddle_height, height-paddle_height);
  }
  
  //println(paddle_y);
}
