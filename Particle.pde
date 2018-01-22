public class Particle extends Sprite {
    PVector acceleration;
    PVector accelerationCopy;
    float slowDownDistance;
    float maxSpeed;
    float maxSteer;
    float targetDistanceThreshold = .05;

    private PVector target;
    private Boolean targetReached;

    Particle(float x, float y, float radius, float maxSpeed, float maxSteer, float slowDownDistance) {
        super(x, y, radius);

        this.target = new PVector(x ,y);
        this.acceleration = new PVector();

        this.targetReached = false;

        this.slowDownDistance = slowDownDistance;
        this.maxSpeed = maxSpeed;
        this.maxSteer = maxSteer;
    }
  
    PVector getTarget() {
        return this.target;
    }
  
    void setTarget(float x, float y) {
        this.target = new PVector(x, y);

        this.velocity = new PVector();
        this.acceleration = new PVector();
        this.accelerationCopy = new PVector();

        this.targetReached = false;
    }

    Boolean getTargetReached() {
        return this.targetReached;
    }
  
    @Override
    void update() {
        if (!this.targetReached) {
            this.behaviors();

            super.update();

            this.velocity.add(this.acceleration);

            this.accelerationCopy.set(this.acceleration.x, this.acceleration.y);

            this.acceleration.mult(0);

            if (abs(this.location.x - this.target.x) < this.targetDistanceThreshold
                && abs(this.location.y - this.target.y) < this.targetDistanceThreshold) {
                this.targetReached = true;
                this.velocity.mult(0.000000001); // Don't set it to 0, so we keep the heading
                this.accelerationCopy.mult(0);
            }
        }
    }

    @Override
    void draw() {
        super.draw();

        // Target
        stroke(255, 0, 0);
        line(this.target.x - 5, this.target.y, this.target.x + 5, this.target.y);
        line(this.target.x, this.target.y - 5, this.target.x, this.target.y + 5);
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
        float maxSpeed = this.maxSpeed;
        float maxSteer = this.maxSteer;

        if (distance < this.slowDownDistance) {
            maxSteer *= 10;
            maxSpeed = map(distance, 0, this.slowDownDistance, 0, maxSpeed);
        }

        desired.setMag(maxSpeed);

        PVector steer = PVector.sub(desired, this.velocity);

        steer.limit(maxSteer);

        return steer;
    }
}