ArrayList<String> images = new ArrayList<String>();
ImagesLib imagesLib;
Bubbles bubbles;
Movers movers;
Vehicle vehicle;
PFont font;
String msg = "";
Helpers helpers;

float middleWidth = 1000 / 2;
float middleHeight = 800 / 2;

void pre() {
}

void setup() {
    size(1000, 800, P2D);
    //fullScreen();
    //frameRate(1);

    helpers = new Helpers();

    font = loadFont("HelveticaNeue-48.vlw");
    textFont(font, 48);
    textSize(30);

    images.add("assets/maeva1.png");
    images.add("assets/oli_eye.jpg");
    images.add("assets/pedro.jpg");
    images.add("assets/maeva_oli.png");
    images.add("assets/we-love-art.jpg");
    images.add("assets/heart.png");

    imagesLib = new ImagesLib(images);
    bubbles = new Bubbles(imagesLib.getNextImage());
    movers = new Movers();
    vehicle = new Vehicle(random(width), random(height));
}

void draw() {
    background(0);

    //helpers.translateSketch(1.5);
    helpers.drawPattern();

    bubbles.update();
    bubbles.draw();

    // movers.update();
    // movers.draw();

    // vehicle.update();
    // vehicle.draw();

    if (bubbles.allTargetsReached && !bubbles.effectOutEnded) {
    }

    if (bubbles.effectOutEnded) {
        bubbles = new Bubbles(imagesLib.getNextImage());
    }

    helpers.showFrameRate();
}

void mousePressed() {
    // frameRate(5);
    noLoop();
}

void mouseReleased() {
    // frameRate(60);
    loop();
}