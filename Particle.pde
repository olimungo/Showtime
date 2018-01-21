public class Particle extends Sprite {
    PVector target;
    PVector acceleration;

    Boolean targetReached;

    float slowDownDistance;
    float maxSpeed;
    float maxForce;

    Particle(float x, float y, float radius, float maxSpeed, float maxForce, float slowDownDistance) {
        super(x, y, radius);

        this.target = new PVector(x ,y);
        this.acceleration = new PVector();

        this.targetReached = false;

        this.slowDownDistance = slowDownDistance;
        this.maxSpeed = maxSpeed;
        this.maxForce = maxForce;
    }
  
    void setTarget(float x, float y) {
        this.target.x = x;
        this.target.y = y;

        this.velocity = this.target.copy().normalize();
        this.acceleration = this.velocity.copy().setMag(0);

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
  
    void behaviors() {
        PVector join = this.arrive(this.target);
        this.applyForce(join);
    }

    private void applyForce(PVector force) {
        this.acceleration.add(force);
    }
  
    private PVector arrive(PVector target) {
        PVector desired = PVector.sub(target, this.location);
        float distance = desired.mag();
        float speed = this.maxSpeed;
        float force = this.maxForce;

        if (distance < this.slowDownDistance) {
            speed = map(distance, 0, this.slowDownDistance, 0, speed);
        }

        desired.setMag(speed);

        PVector steer = PVector.sub(desired, this.velocity);

        steer.limit(force);

        return steer;
    }
}