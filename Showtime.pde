ArrayList<String> images = new ArrayList<String>();
ImagesLib imagesLib;
Bubbles bubbles;
MoversShow moversShow;
VehicleShow vehicleShow;
RandomShow randomShow;
FlowFieldShow flowFieldShow;
Starfield starfield;
PFont font;
String msg = "";
Helpers helpers;
Boolean slowFrameRate = false;

float middleWidth = 1500 / 2;
float middleHeight = 1000 / 2;

void pre() {
}

void setup() {
    size(1500, 1000, P2D);
    //fullScreen();
    //frameRate(5);

    helpers = new Helpers();

    font = loadFont("HelveticaNeue-48.vlw");
    textFont(font, 48);

    images.add("assets/oli_eye.jpg");
    images.add("assets/pedro.jpg");
    images.add("assets/we-love-art.jpg");
    images.add("assets/maeva1.png");
    images.add("assets/maeva_oli.png");
    images.add("assets/heart.png");

    imagesLib = new ImagesLib(images);
    bubbles = new Bubbles(imagesLib.getNextImage());
    moversShow = new MoversShow();
    vehicleShow = new VehicleShow();
    randomShow = new RandomShow();
    flowFieldShow = new FlowFieldShow(20);
    starfield = new Starfield();
}

void draw() {
    background(0);

    // helpers.translateSketch(1.5);
    //helpers.drawPattern();

    // bubbles.update();
    // bubbles.draw();

    // moversShow.update();
    // moversShow.draw();

    // starfield.draw();

    // vehicleShow.update();
    // vehicleShow.draw();

    // randomShow.update();
    // randomShow.draw();

    flowFieldShow.update();
    flowFieldShow.draw();

    //helpers.showFrameRate();
}

void mousePressed() {
    if (slowFrameRate) {
        frameRate(60);
    } else {
        frameRate(10);
    }

    slowFrameRate = !slowFrameRate;
    noLoop();
}

void mouseReleased() {
    // frameRate(60);
    loop();
}