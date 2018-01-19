ArrayList<String> images = new ArrayList<String>();
ImagesLib imagesLib;
Bubbles bubbles;

float middleWidth = width / 2;
float middleHeight = height / 2;

Boolean starting = true;

void pre() {
}

void setup() {
  size(1000, 800);
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

void draw() {
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

void translateSketch() {
  scale(0.5);
  translate(width / 2, height / 2);
}

void drawPattern() {
  pushMatrix();
    stroke(255);
    noFill();
    rect(0, 0, width, height);
    line(0, middleHeight, width, middleHeight);
    line(middleWidth, 0, middleWidth, height);
  popMatrix();
}

void mousePressed() {
  frameRate(1);
}

void mouseReleased() {
  frameRate(60);
}