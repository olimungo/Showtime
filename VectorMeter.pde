public class VectorMeter {
    PVector position;
    int lengthFactor = 10;
    String label = "";

    private int radius = 100;

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
            textSize(15);
            text(this.label, 0, -25);

            stroke(255);
            noFill();
            ellipse(0, 0, 100, 100);

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