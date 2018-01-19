ArrayList<String> images = new ArrayList<String>();
ImagesLib imagesLib;
Bubbles bubbles;

float middleWidth = 1500 / 2;
float middleHeight = 1000 / 2;

Boolean starting = true;

void pre() {
}

void setup() {
  size(1500, 1000);
  //fullScreen();
  //frameRate(1);

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

  // translateSketch(4);
  drawPattern();

  
  
  bubbles.update();
  bubbles.draw();
  
  if (bubbles.allTargetsReached && !bubbles.effectOutEnded) {
  }
  
  if (bubbles.effectOutEnded) {
    bubbles = new Bubbles(imagesLib.getNextImage());
  }
}

void translateSketch(float ratio) {
  scale(1/ratio);
  translate((width * ratio - width) / 2, (height * ratio - height) / 2);
}

void drawPattern() {
  pushMatrix();
    stroke(255);
    noFill();
    rect(0, 0, width, height);
    line(0, middleHeight, width, middleHeight);
    line(middleWidth, 0, middleWidth, height);
    ellipse(middleWidth, middleHeight, 400, 400);
  popMatrix();
}

void mousePressed() {
  frameRate(1);
}

void mouseReleased() {
  frameRate(60);
}