public class VectorMeter {
    PVector position;
    int lengthFactor = 10;
    String label = "";

    private int radius = 60;

    VectorMeter(float x, float y) {
        this.position = new PVector(x ,y);
    }

    void update() {

    }

    void draw(PVector vector) {
        pushMatrix();
            translate(this.position.x, this.position.y);

            fill(255);
            textAlign(CENTER);
            textSize(11);
            text(this.label, 0, -15);

            stroke(255);
            noFill();
            ellipse(0, 0, radius, radius);

            // println(this.vector.mag());

            float angle = vector.heading();
            float length = vector.mag() * lengthFactor;

            if (length > radius / 2) {
                length = radius / 2;
            }

            rotate(angle);
            stroke(0, 255, 0);

            line(0, 0, length, 0);
        popMatrix();
    }
}