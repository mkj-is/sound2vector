
import ddf.minim.*;
import processing.pdf.*;

Minim minim;
AudioPlayer in;
float offset;
float size = 1;
int soundlen;

static int jump = 100;

void setup()
{
  size(5000, 100, PDF, "sound.pdf");
  background(255);
  frameRate(10);
  offset = 0.0;
  minim = new Minim(this);
  in = minim.loadFile("sound.mp3");
  soundlen = in.getMetaData().length();
  size = width / (soundlen / 100.0);
  in.play();
  stroke(0);
}

void draw()
{
  int buffer = in.bufferSize();
  for(int i = 0; i < buffer - jump; i += jump)
  {
    float firstValue = (in.left.get(i) + in.right.get(i))/2;
    float secondValue = (in.left.get(i + jump) + in.right.get(i + jump))/2;
    line(offset + (size / buffer) * i, 50 + firstValue * 50, offset + (size / buffer) * (i + jump), 50 + secondValue * 50);
  }
  offset += size;
  
  if(millis() >= soundlen)
  {
    exit();
  }
}


