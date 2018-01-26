public class FlowFieldShow {
    private int resolution;
    private int cols, rows;
    PVector[][] field;
    float[][][] noise;

    FlowFieldShow(int resolution) {
        this.resolution = resolution;
        this.cols = width / this.resolution;
        this.rows = height / this.resolution;

        this.field = new PVector[cols][rows];
        this.noise = new float[cols][rows][2];

        this.init();
    }

    void update() {
        //this.animate();
    }

    void draw() {
        for (int i = 0; i < cols; i++) {
            for (int j = 0; j < rows; j++) {
                drawVector(this.field[i][j], i * this.resolution, j * this.resolution, this.resolution - 5);
            }
        }
    }

    private void init() {
        noiseSeed((int)random(10000));

        float xoff = 0;
        for (int i = 0; i < this.cols; i++) {
            float yoff = 0;
            for (int j = 0; j < this.rows; j++) {
                float theta = map(noise(xoff, yoff), 0, 1, 0, TWO_PI);
                this.field[i][j] = new PVector(cos(theta), sin(theta));
                this.noise[i][j][0] = xoff;
                this.noise[i][j][1] = yoff;

                yoff += 0.1;
            }

            xoff += 0.1;
        }
    }

    private void animate() {
        for (int i = 0; i < this.cols; i++) {
            for (int j = 0; j < this.rows; j++) {
                float xoff = this.noise[i][j][0] + 0.001;
                float yoff = this.noise[i][j][1] + 0.001;
                float theta = map(noise(xoff, yoff), 0, 1, 0, TWO_PI);

                this.field[i][j] = new PVector(cos(theta), sin(theta));
                this.noise[i][j][0] = xoff;
                this.noise[i][j][1] = yoff;
            }
        }
    }

  private void drawVector(PVector vector, float x, float y, float scayl) {
    pushMatrix();
        float arrowsize = 5;

        translate(x, y);

        stroke(255);
        strokeWeight(2);

        // Call vector heading function to get direction (note that pointing to the right is a heading of 0) and rotate
        rotate(vector.heading2D());

        // Calculate length of vector & scale it to be bigger or smaller if necessary
        float length = vector.mag() * scayl;

        // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
        line(0, 0, length, 0);
        line(length, 0, length - arrowsize, arrowsize / 2);
        line(length, 0 , length - arrowsize, -arrowsize / 2);
    popMatrix();
  }
}