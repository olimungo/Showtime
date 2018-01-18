public class Sprite {
  PVector location;
  PVector velocity;

  float radius;
  
  Sprite(float x, float y, float radius) {
    this.location = new PVector(x, y);
    this.velocity = new PVector();
    this.radius = radius;
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