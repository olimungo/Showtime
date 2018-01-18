public class Bubble extends Particle {
  PVector originalLocation;
  color fillColor;
  
  Bubble(float xStart, float yStart, float xTarget, float yTarget, float radius, color fillColor) {
    super(xStart, yStart, radius);
    super.setTarget(xTarget, yTarget);
    
    this.originalLocation = new PVector(xStart, yStart);
    
    this.fillColor = fillColor;
  }
  
  @Override
  void update() {
    if (!this.targetReached) {
      super.update();
    }
  }
  
  @Override
  void draw() {
    if (radius > 0) {
      pushMatrix();
        fill(this.fillColor);
        noStroke();
        ellipse(this.location.x, this.location.y, this.radius, this.radius);
      popMatrix();
    }
  }
  
  void getBack() {
    super.setTarget(this.originalLocation.x, this.originalLocation.y);
  }
}