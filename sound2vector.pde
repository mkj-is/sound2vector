/**
 *
 * @file sound2vector.pde
 *
 * @author Matěj Kašpar Jirásek <matej.jirasek@gmail.com>
 * @date 2013-12-22
 *
 * @link http://mkj.is
 *
 * Processing project which converts music/sound to vector PDF. 
 */
import ddf.minim.*;
import processing.pdf.*;

/**
 * Minim library
 */
Minim minim;
/**
 * Player object representing sound/music
 */
AudioPlayer in;
/**
 * Offset of the drawing function
 */
float offset;
/**
 * Size of one drawn sample
 */
float size;
/**
 * Length of the sound in miliseconds
 */
int soundlen;

/**
 * How many values shall be jumped over when drawing
 */
static int jump = 50;

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


