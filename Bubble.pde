public class Bubble extends Particle {
  color fillColor;
  
  Bubble(float xStart, float yStart, float xTarget, float yTarget, float radius, color fillColor) {
    super(xStart, yStart, radius, 5, 0.05, 100);
    super.setTarget(xTarget, yTarget);
    
    this.fillColor = fillColor;
  }
  
  @Override
  void draw() {
    if (this.radius > 0) {
      fill(this.fillColor);
      noStroke();
      ellipse(this.location.x, this.location.y, this.radius, this.radius);
    }
  }
}