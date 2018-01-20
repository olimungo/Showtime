public class Particle extends Sprite {
  PVector target;
  PVector acceleration;
  PVector inertia;
  
  Boolean targetReached;
  
  float SLOW_DOWN_DISTANCE;
  float SPEED;
  float INERTIA;
  
  Particle(float x, float y, float radius) {
    super(x, y, radius);
    
    this.target = new PVector(x ,y);
    this.acceleration = new PVector();
    
    this.targetReached = false;
    
    this.SLOW_DOWN_DISTANCE = 70;
    this.SPEED = 300;
    this.INERTIA = .03;
  }
  
  void setTarget(float x, float y) {
    this.target.x = x;
    this.target.y = y;
    
    this.velocity = this.target.copy();
    this.velocity.normalize();
    
    this.targetReached = false;
  }
  
  @Override
  void update() {
    if (!this.targetReached) {
      this.behaviors();
      
      super.update();
      
      this.velocity.add(this.acceleration);
      this.acceleration.mult(0);
      
      if (abs(this.location.x - this.target.x) < 0.5 && abs(this.location.y - this.target.y) < 0.5) {
          this.targetReached = true;
      }
    }
  }
  
  void applyForce(PVector force) {
    this.acceleration.add(force);
    //println("acc: " + this.acceleration);
  }
  
  private void behaviors() {
    PVector join = this.forceJoinTarget(this.target);
    this.applyForce(join);
  }
  
  private PVector forceJoinTarget(PVector target) {
    PVector desired = PVector.sub(target, this.location);
    float distance = desired.mag();
    float speed = this.SPEED;
    float inertia = this.INERTIA;

    if (distance < this.SLOW_DOWN_DISTANCE) {
      //inertia *= 10;
      speed = map(distance, 0, this.SLOW_DOWN_DISTANCE, 0, speed);
    }

    desired.setMag(speed);
    
    PVector steer = PVector.sub(desired, this.velocity);
    
    desired.limit(inertia);

    return steer;
    }
}