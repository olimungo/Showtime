import java.util.Random;

public class RandomShow {
    static final int RANDOM_RANDMOMNESS = 1;
    static final int NORMAL_DISTRIBUTION = 2;
    static final int PERLIN_NOISE = 3;

    final int GRAPH_COUNT = 30;
    final float GRAPH_WIDTH = width / this.GRAPH_COUNT;
    final float GRAPH_MAX = 500;

    String title = "";
    Random random;

    int currentMode = this.NORMAL_DISTRIBUTION;
    float[] graphs;
    float seed = 0;

    RandomShow() {
        this.random = new Random();

        this.graphs = new float[this.GRAPH_COUNT];
        this.resetGraphs();

        this.switchMode();
    }

    void update() {
        int index = -1;

        switch(this.currentMode) {
            case 1:
                index = floor(random(this.GRAPH_COUNT));
                break;
            case 2:
                float gaussian = (float)this.random.nextGaussian();
                index = floor((gaussian * 5) + this.GRAPH_COUNT / 2);
                break;
            case 3:
                this.seed += 0.1;
                index = floor(map(noise(seed), 0, 1, 0, this.GRAPH_COUNT - 1));
                break;
        }

        if (index >= 0 && index < this.GRAPH_COUNT) {
            this.graphs[index] = this.graphs[index] + 10;
        }
    }

    void draw() {
        pushMatrix();
            translate(width / 2, 200);

            fill(80);
            textAlign(CENTER);
            textSize(30);
            text(this.title, 0, 0);
        popMatrix();

        pushMatrix();
            translate(0, height);

            stroke(255);
            fill(150);

            for(float graph : this.graphs) {
                if (graph > this.GRAPH_MAX) {
                    this.switchMode();
                }

                rect(0, 0, this.GRAPH_WIDTH, -graph);
                translate(this.GRAPH_WIDTH, 0);
            }
        popMatrix();
    }

    private void switchMode() {
        this.resetGraphs();

        switch(this.currentMode) {
            case 1:
                this.currentMode = this.NORMAL_DISTRIBUTION;
                this.title = "[normal distribution]";
                break;
            case 2:
                this.currentMode = this.PERLIN_NOISE;
                this.title = "[Perlin noise]";
                break;
            default:
                this.currentMode = this.RANDOM_RANDMOMNESS;
                this.title = "[random randomness]";
                break;
        }
    } 

    private void resetGraphs() {
        for(int i = 0; i < this.GRAPH_COUNT; i++) {
            this.graphs[i] = 0;
        }
    }
}