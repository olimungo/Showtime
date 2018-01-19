public class Particle extends Sprite {
  PVector target;
  PVector acceleration;
  
  Boolean targetReached;
  
  float SLOW_DOWN_DISTANCE;
  float MAX_SPEED;
  float INERTIA;
  
  Particle(float x, float y, float radius) {
    super(x, y, radius);
    
    this.target = new PVector(x ,y);
    this.acceleration = new PVector();
    
    this.targetReached = false;
    
    this.SLOW_DOWN_DISTANCE = 65;
    this.MAX_SPEED = 10;
    this.INERTIA = 1;
  }
  
  void setTarget(float x, float y) {
    this.target.x = x;
    this.target.y = y;
    
    this.velocity = this.target.copy();
    this.velocity.normalize();
    
    this.targetReached = false;
  }
  
  void update() {
    if (!this.targetReached) {
      this.behaviors();
      
      this.location.add(this.velocity);
      
      this.velocity.add(this.acceleration);
      this.acceleration.mult(0);
      
      if (abs(this.location.x - this.target.x) < 0.5 && abs(this.location.y - this.target.y) < 0.5) {
          this.targetReached = true;
      }
    }
  }
  
  void applyForce(PVector force) {
    this.acceleration.add(force);
  }
  
  private void behaviors() {
    PVector join = this.forceJoinTarget(this.target);
    this.applyForce(join);
  }
  
  private PVector forceJoinTarget(PVector target) {
    PVector desired = PVector.sub(target, this.location);
    float distance = desired.mag();
    float speed = this.MAX_SPEED;
    float inertia = this.INERTIA;

    if (distance < this.SLOW_DOWN_DISTANCE) {
      inertia *= 10;
      speed = map(distance, 0, this.SLOW_DOWN_DISTANCE, 0, speed * 0.3);
    }

    desired.setMag(speed);
    
    PVector steer = PVector.sub(desired, this.velocity);
    
    steer.limit(inertia);

    return steer;
    }
}