public class Vehicle extends Particle {
    Vehicle(float x, float y) {
        super(x, y, 1, 2, 5, 50);
        super.setTarget(random(width), random(height));
    }

    @Override
    void update() {
        super.setTarget(mouseX, mouseY); 
        super.update();
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
  
    // @Override
    // void behaviors() {
    //     PVector join = this.seek(this.target);
    //     super.applyForce(join);
    // }
  
    private PVector seek(PVector target) {
        PVector desired = PVector.sub(target, this.location);
        float distance = desired.mag();
        float speed = this.maxSpeed;
        float inertia = this.maxForce;

        if (distance < this.slowDownDistance) {
            speed = map(distance, 0, this.slowDownDistance, 0, speed);
        }

        desired.setMag(speed);

        PVector steer = PVector.sub(desired, this.velocity);

        steer.limit(inertia);

        return steer;
    }
}