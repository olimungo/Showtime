public class Sprite {
  PVector location;
  PVector velocity;

  int ellapsedTime;
  float radius;
  
  Sprite(float x, float y, float radius) {
    this.location = new PVector(x, y);
    this.velocity = new PVector();
    this.radius = radius;

    this.ellapsedTime = millis();
  }
  
  void setPosition(float x, float y) {
    this.location.x = x;
    this.location.y = y;
  }
  
 void setVelocity(float x, float y) {
    this.velocity.x = x;
    this.velocity.y = y;
  }
  
  void update() {
    float timeCorrection = 1;
    int currentTime = millis();

    if (currentTime - this.ellapsedTime < 500) {
      timeCorrection = map(currentTime - this.ellapsedTime, 1,  500, 1/500, 1);
    }

    this.ellapsedTime = currentTime;

    this.velocity.mult(timeCorrection);
    this.location.add(this.velocity);
  }
  
  void draw() {
    pushMatrix();
      fill(255);
      noStroke();
      ellipse(this.location.x, this.location.y, this.radius, this.radius);
    popMatrix();
  }
}