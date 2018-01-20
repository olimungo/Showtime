ArrayList<String> images = new ArrayList<String>();
ImagesLib imagesLib;
Bubbles bubbles;
Movers movers;
PFont font;
String msg = "";

float middleWidth = 1000 / 2;
float middleHeight = 800 / 2;

Boolean starting = true;

void pre() {
}

void setup() {
  size(1000, 800);
  // fullScreen();
  // frameRate(1);

  font = loadFont("HelveticaNeue-48.vlw");
  textFont(font, 48);
  textSize(30);

  images.add("assets/oli_eye.jpg");
  images.add("assets/we-love-art.jpg");
  images.add("assets/pedro.jpg");
  images.add("assets/maeva_oli.png");
  images.add("assets/heart.png");
  images.add("assets/maeva1.png");
  
  imagesLib = new ImagesLib(images);

  bubbles = new Bubbles(imagesLib.getNextImage());

  movers = new Movers();
}

void draw() {
  background(0);

  // if (starting) {
  //   noLoop();
  // }

  // translateSketch(1.5);
  // drawPattern();
  showFrameRate();

  movers.update();
  movers.draw();
  
  
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

void showFrameRate() {
  if (frameCount % 5 == 0) {
    msg = String.format("%2.0f / %d / %d", frameRate, frameCount, millis());
  }

  pushMatrix();
    fill(255);
    text(msg, 30, height - 40);
  popMatrix();
}

void mousePressed() {
  // frameRate(5);
  noLoop();
}

void mouseReleased() {
  // frameRate(60);
  loop();
}