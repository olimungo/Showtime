public class Vehicle extends Particle {
    color normalColor = color(255);
    color targetReachedColor = color(0, 255, 0);
    color currentColor = normalColor;

    Vehicle(float x, float y) {
        super(x, y, 0, 5, .05, 100);
        super.setTarget(random(width), random(height));
        super.setTargetDistanceThreshold(5);
    }

    @Override
    void setTarget(float x, float y) {
        super.setTarget(x, y);
        this.currentColor = normalColor;
    }

    @Override
    void update() {
        super.update();

        if (this.getTargetReached()) {
            this.currentColor = this.targetReachedColor;
        }
    }
  
    @Override
    void draw() {
        super.draw();

        pushMatrix();
            fill(this.currentColor);
            noStroke();
            translate(this.location.x, this.location.y);
            float angle = this.velocity.heading();
            rotate(angle);
            triangle(-15, -10, 15, 0, -15, 10);
        popMatrix();
    }
  
    @Override
    void behaviors() {
        PVector seek = this.seek(this.target);
        super.applyForce(seek);
    }
  
    private PVector seek(PVector target) {
        PVector mouse = new PVector(mouseX, mouseY);
        PVector desired = PVector.sub(mouse, this.location);
        float distance = desired.mag();
        float speed = this.getMaxSpeed();
        float force = this.getMaxSteer();

        if (distance < this.getSlowDownDistance()) {
            force *= 10;
            speed = map(distance, 0, this.getSlowDownDistance(), 0, speed);
        }

        desired.setMag(speed);

        PVector steer = PVector.sub(desired, this.velocity);

        steer.limit(force);

        return steer;
    }
}