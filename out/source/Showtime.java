import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Showtime extends PApplet {

ArrayList<String> images = new ArrayList<String>();
ImagesLib imagesLib;
Bubbles bubbles;

float middleWidth = width / 2;
float middleHeight = height / 2;

Boolean starting = true;

public void pre() {
}

public void setup() {
  
  // fullScreen();

  images.add("assets/oli_eye.jpg");
  images.add("assets/pedro.jpg");
  images.add("assets/we-love-art.jpg");
  images.add("assets/maeva_oli.png");
  images.add("assets/heart.png");
  images.add("assets/maeva1.png");
  
  imagesLib = new ImagesLib(images);

  bubbles = new Bubbles(imagesLib.getNextImage());
}

public void draw() {
  background(0);

  // if (starting) {
  //   noLoop();
  // }

  //translateSketch();
  //drawPattern();
  
  bubbles.update();
  bubbles.draw();
  
  if (bubbles.allTargetsReached && !bubbles.effectOutEnded) {
  }
  
  if (bubbles.effectOutEnded) {
    bubbles = new Bubbles(imagesLib.getNextImage());
  }
}

public void translateSketch() {
  scale(0.5f);
  translate(width / 2, height / 2);
}

public void drawPattern() {
  pushMatrix();
    stroke(255);
    noFill();
    rect(0, 0, width, height);
    line(0, middleHeight, width, middleHeight);
    line(middleWidth, 0, middleWidth, height);
  popMatrix();
}

public void mousePressed() {
  println("toto");
  starting = false;
  loop();
}
public class Bubble extends Particle {
  PVector originalLocation;
  int fillColor;
  
  Bubble(float xStart, float yStart, float xTarget, float yTarget, float radius, int fillColor) {
    super(xStart, yStart, radius);
    super.setTarget(xTarget, yTarget);
    
    this.originalLocation = new PVector(xStart, yStart);
    
    this.fillColor = fillColor;
  }
  
  public @Override
  void update() {
    if (!this.targetReached) {
      super.update();
    }
  }
  
  public @Override
  void draw() {
    if (radius > 0) {
      pushMatrix();
        fill(this.fillColor);
        noStroke();
        ellipse(this.location.x, this.location.y, this.radius, this.radius);
      popMatrix();
    }
  }
  
  public void getBack() {
    super.setTarget(this.originalLocation.x, this.originalLocation.y);
  }
}
public class BubbleMatrix {
  float x; // x coordinate
  float y; // y coordinate
  int c; // color
  float r; // radius
  
  BubbleMatrix(float x, float y, int c, float r) {
    this.x =x;
    this.y = y;
    this.c = c;
    this.r = r;
  }
}
public class Bubbles {
  ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
  Boolean allTargetsReached = false;
  Boolean effectOutTriggered = false;
  Boolean effectOutEnded = false;
  
  Bubbles(ArrayList<BubbleMatrix> matrix) {
    float rnd = random(1);
    
    for (BubbleMatrix bubble : matrix) {
      PVector start = new PVector(random(width), random(height));
      
      if (rnd > 0.5f) {
        start = this.effectRadialIn(start);
      } else {
        start = this.effectWaveIn(start);
      }
      
      this.bubbles.add(new Bubble(start.x, start.y, bubble.x, bubble.y, bubble.r, bubble.c));
    }
  }
  
  public void update() {
    Boolean allTargetsReached = true;
    
    if (!this.effectOutEnded) {
      for (Bubble bubble : this.bubbles) {
        bubble.update();
        
        allTargetsReached = allTargetsReached && bubble.targetReached;
      }
      
      if (allTargetsReached) {
        if (effectOutTriggered) {
          this.effectOutEnded = true;
        } else {
          for (Bubble bubble : this.bubbles) {
            this.allTargetsReached = true;
            this.effectOutTriggered = true;

            PVector target = new PVector(random(width), random(height));
            target = this.effectRadialIn(target);
            bubble.setTarget(target.x, target.y);

            // bubble.getBack();
          }
        }
      }
    }
  }

  public void draw() {
    for (Bubble bubble : this.bubbles) {
      bubble.draw();
    }
  }
  
  private PVector effectRadialIn(PVector vector) {
    PVector vectorMiddle = new PVector(width / 2, height / 2);
    
    PVector vectorResult = PVector.sub(vector, vectorMiddle);
    float magnitude = map(random(1), 0, 1, 1000, 1400);

    vectorResult.setMag(magnitude);
    vectorResult.add(vectorMiddle);

    return vectorResult;
  }
  
  private PVector effectWaveIn(PVector vector) {
    PVector vectorMiddle = new PVector(width / 2, height / 2);
    
    int extend = ceil(random(0, 4));
    PVector vectorResult = PVector.sub(vectorMiddle, vector).add(vector);

    switch (extend) {
      case 1:
        vectorResult.x *= -1;
        break;
      case 2:
        vectorResult.y *= -1;
        break;
      case 3:
        vectorResult.x += width;
        break;
      case 4:
        vectorResult.y += height;
        break;
    }

    return vectorResult;
  }

  private PVector randomLocation() {
    PVector vector = PVector.random2D();

    if (vector.x < width / 2 && vector.y < height /2) {

    }

    return vector;
  }
}
public class ImagesLib {
  ArrayList<String> imagesPath;
  ArrayList<PImage> images = new ArrayList<PImage>();
  
  int scaleFactor;
  int dpi = 90;
  int currentImage = -1;
  
  ImagesLib(ArrayList<String> imagesPath) {
    this.imagesPath = imagesPath;
    this.loadImages();
  }
  
  public void loadImages() {
    for (String imagePath : imagesPath) {
      images.add(loadImage(imagePath));
    }
  }
  
  public ArrayList<BubbleMatrix> getNextImage() {
    this.currentImage++;

    if (this.currentImage == this.images.size()) {
        this.currentImage = 0;
    }

    PImage shrinked = this.shrinkImage(this.images.get(this.currentImage));
    
    return this.convertToBubblesMatrix(shrinked);
  };
  
  private PImage shrinkImage(PImage image) {
    this.scaleFactor = floor(image.width / this.dpi);

    int width = image.width / this.scaleFactor;
    int height = image.height / this.scaleFactor;
    PImage shrinked = createImage(width, height, RGB);

    shrinked.copy(image, 0, 0, image.width, image.height, 0, 0, width, height);
    shrinked.loadPixels();
    
    return shrinked;
  }
  
  private ArrayList<BubbleMatrix> convertToBubblesMatrix(PImage image) {
    ArrayList<BubbleMatrix> matrix = new ArrayList<BubbleMatrix>();
    
    this.adjustScaleFactor(image);
    
    float centerX = (width - image.width * this.scaleFactor) / 2;
    float centerY = (height - image.height * this.scaleFactor) / 2;
    
    for (int x = 0; x < image.width; x++) {
      for (int y = 0; y < image.height; y++) {
        int c = image.get(x, y);
        float radius = map(brightness(c), 0, 255, 0, this.scaleFactor * .8f);
        float xCorrected = x * this.scaleFactor + centerX;
        float yCorrected = y * this.scaleFactor + centerY;
        
        matrix.add(new BubbleMatrix(xCorrected, yCorrected, c, radius));
      }
    }
    
    return matrix;
  }
  
  private void adjustScaleFactor(PImage image) {
    int imageWidth = image.width * this.scaleFactor;
    int imageHeight = image.height * this.scaleFactor;
    
    if (imageWidth > width || imageHeight > height) {
      this.scaleFactor = floor(width / image.width);
      int heightScaleFactor = floor(height / image.height);
      
      if (heightScaleFactor < this.scaleFactor) {
        this.scaleFactor = heightScaleFactor;
      }
    }
  }
}
public class Particle extends Sprite {
  PVector target;
  PVector acceleration;
  
  Boolean targetReached;
  
  float SLOW_DOWN_DISTANCE;
  float MAX_SPEED;
  float INERTIA;
  
  Particle(float x, float y, float radius) {
    super(x, y, radius);
    
    this.target = new PVector(x ,y);
    this.acceleration = new PVector();
    
    this.targetReached = false;
    
    this.SLOW_DOWN_DISTANCE = 65;
    this.MAX_SPEED = 10;
    this.INERTIA = 1;
  }
  
  public void setTarget(float x, float y) {
    this.target.x = x;
    this.target.y = y;
    
    this.velocity = this.target.copy();
    this.velocity.normalize();
    
    this.targetReached = false;
  }
  
  public void update() {
    this.behaviors();
    
    this.location.add(this.velocity);
    
    this.velocity.add(this.acceleration);
    this.acceleration.mult(0);
    
    if (abs(this.location.x - this.target.x) < 0.5f && abs(this.location.y - this.target.y) < 0.5f) {
        this.targetReached = true;
    }
  }
  
  public void applyForce(PVector force) {
    this.acceleration.add(force);
  }
  
  private void behaviors() {
    PVector join = this.forceJoinTarget(this.target);
    this.applyForce(join);
  }
  
  private PVector forceJoinTarget(PVector target) {
    PVector desired = PVector.sub(target, this.location);
    float distance = desired.mag();
    float speed = this.MAX_SPEED;
    float inertia = this.INERTIA;

    if (distance < this.SLOW_DOWN_DISTANCE) {
      inertia *= 10;
      speed = map(distance, 0, this.SLOW_DOWN_DISTANCE, 0, speed * 0.3f);
    }

    desired.setMag(speed);
    
    PVector steer = PVector.sub(desired, this.velocity);
    
    steer.limit(inertia);

    return steer;
    }
}
public class Sprite {
  PVector location;
  PVector velocity;

  float radius;
  
  Sprite(float x, float y, float radius) {
    this.location = new PVector(x, y);
    this.velocity = new PVector();
    this.radius = radius;
  }
  
  public void setPosition(float x, float y) {
    this.location.x = x;
    this.location.y = y;
  }
  
 public void setVelocity(float x, float y) {
    this.velocity.x = x;
    this.velocity.y = y;
  }
  
  public void update() {
    this.location.add(this.velocity);
  }
  
  public void draw() {
    pushMatrix();
      fill(255);
      noStroke();
      ellipse(this.location.x, this.location.y, this.radius, this.radius);
    popMatrix();
  }
}
  public void settings() {  size(1000, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Showtime" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
