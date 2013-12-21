
import ddf.minim.*;
import processing.pdf.*;

Minim       minim;
//AudioInput  in;
AudioPlayer in;
float      offset;
float      size = 1;
boolean    record = true;
int        jump = 100;

void setup()
{
  size(1000, 100, PDF, "sound.pdf");
  
  offset = 0.0;
  minim = new Minim(this);
  in = minim.loadFile("music.mp3"); //minim.getLineIn();
  in.play();
  stroke(0);
  beginRecord(PDF, "frame-####.pdf"); 
}

void draw()
{
  if (record) {
     beginRecord(PDF, "frame-####.pdf");
     record = false;
  }

  int buffer = in.bufferSize();
  for(int i = 0; i < buffer - jump; i += jump)
  {
    float firstValue = (in.left.get(i) + in.right.get(i))/2;
    float secondValue = (in.left.get(i + jump) + in.right.get(i + jump))/2;
    line(offset + (size / buffer) * i, 50 + firstValue * 50, offset + (size / buffer) * (i + jump), 50 + secondValue * 50);
  }
  offset += size;
  
  /*if (record) {
    endRecord();
    record = false;
  }*/
  
  if(frameCount == 1000)
  {
    exit();
  }
}

void keyPressed() {
  endRecord();
}


