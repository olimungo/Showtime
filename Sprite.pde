public class Sprite {
    PVector location;
    PVector velocity;
    float radius;

    Sprite(float x, float y, float radius) {
        this.location = new PVector(x, y);
        this.velocity = new PVector();
        this.radius = radius;
    }

    void update() {
        this.location.add(this.velocity);
    }

    void draw() {
        fill(255);
        noStroke();
        ellipse(this.location.x, this.location.y, this.radius, this.radius);
    }
}