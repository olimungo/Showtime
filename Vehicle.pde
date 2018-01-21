public class Vehicle extends Particle {
    Vehicle(float x, float y) {
        super(x, y, 0, 5, .05, 100);
        super.setTarget(random(width), random(height));
    }
  
    @Override
    void draw() {
        pushMatrix();
            fill(255);
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
        float speed = this.maxSpeed;
        float force = this.maxForce;

        if (distance < this.slowDownDistance) {
            force *= 10;
            speed = map(distance, 0, this.slowDownDistance, 0, speed);
        }

        desired.setMag(speed);

        PVector steer = PVector.sub(desired, this.velocity);

        steer.limit(force);

        return steer;
    }
}