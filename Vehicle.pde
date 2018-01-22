public class Vehicle extends Particle {
    public static final int SEEK = 1;
    public static final int FLEE = 2;

    PVector fleeOrSeekCopy = new PVector();

    private color normalColor = color(255);
    private color targetReachedColor = color(0, 255, 0);
    private color currentColor = normalColor;
    private int mode;

    Vehicle(float x, float y, int mode) {
        super(x, y, 0, 3, .01, 70);
        super.setTarget(random(width), random(height));
        super.targetDistanceThreshold = 5;
        this.mode = mode;
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
            this.fleeOrSeekCopy.mult(0);
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
            stroke(this.currentColor);
            noFill();
            triangle(-15, -10, 15, 0, -15, 10);
        popMatrix();
    }
  
    @Override
    void behaviors() {
        PVector mouse = new PVector(mouseX, mouseY);
        PVector force;

        super.behaviors();

        if (mode == Vehicle.SEEK) {
            force = this.seek(mouse);

        } else {
            force = this.flee(mouse);
        }

        super.applyForce(force);
    }
  
    private PVector seek(PVector target) {
        PVector desired = PVector.sub(target, this.location);
        float distance = desired.mag();
        float maxSpeed = this.maxSpeed;

        if (distance < this.slowDownDistance) {
            maxSpeed = map(distance, 0, this.slowDownDistance, 0, maxSpeed);
        }

        desired.setMag(maxSpeed);

        PVector steer = PVector.sub(desired, this.velocity);

        steer.limit(this.velocity.mag() / 2);

        this.fleeOrSeekCopy.set(steer.x, steer.y);

        return steer;
    }
  
    private PVector flee(PVector target) {
        PVector desired = PVector.sub(target, this.location);
        float distance = desired.mag();

        if (distance < 100) {
            desired.setMag(this.maxSpeed);
            desired.mult(-1);

            PVector steer = PVector.sub(desired, this.velocity);

            steer.limit(this.velocity.mag());

            this.fleeOrSeekCopy.set(steer.x, steer.y);

            return steer;
        } else {
            this.fleeOrSeekCopy.set(0, 0);

            return new PVector();
        }
    }
}