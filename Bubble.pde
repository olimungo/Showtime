public class Bubble extends Particle {
  color fillColor;
  
  Bubble(float xStart, float yStart, float xTarget, float yTarget, float radius, color fillColor) {
    super(xStart, yStart, radius, 4, 2, 50);
    super.setTarget(xTarget, yTarget);
    
    this.fillColor = fillColor;
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
}