public class Bubbles {
    ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
    Boolean allTargetsReached = false;
    Boolean effectOutTriggered = false;
    Boolean effectOutEnded = false;

    Bubbles(ArrayList<BubbleMatrix> matrix) {
        for (BubbleMatrix bubble : matrix) {
            PVector start = new PVector(bubble.x, bubble.y);
            start = this.effectWave(start);

            this.bubbles.add(new Bubble(start.x, start.y, bubble.x, bubble.y, bubble.r, bubble.c));
        }
    }

    void update() {
        Boolean allTargetsReached = true;

        if (!this.effectOutEnded) {
            for (Bubble bubble : this.bubbles) {
                bubble.update();

                allTargetsReached = allTargetsReached && bubble.getTargetReached();
            }

            if (allTargetsReached) {
                if (effectOutTriggered) {
                    this.effectOutEnded = true;
                } else {
                    this.allTargetsReached = true;
                    this.effectOutTriggered = true;

                    for (Bubble bubble : this.bubbles) {
                        PVector target = new PVector(bubble.location.x, bubble.location.y);
                        target = this.effectRadial(target);
                        bubble.setTarget(target.x, target.y);
                        bubble.maxSpeed = 10;
                        bubble.maxSteer = 3;
                    }
                }
            }
        }
    }

    void draw() {
        for (Bubble bubble : this.bubbles) {
            bubble.draw();
        }
    }

    private PVector effectRadial(PVector vector) {
        PVector vectorMiddle = new PVector(width / 2, height / 2);
        float screenMagnitude = this.getScreenMagnitude();

        PVector vectorResult = PVector.sub(vector, vectorMiddle);

        vectorResult.setMag(screenMagnitude * 1.03);
        vectorResult.add(vectorMiddle);

        return vectorResult;
    }

    private PVector effectWave(PVector vector) {
        PVector vectorMiddle = new PVector(width / 2, height / 2);

        int extend = ceil(random(0, 4));

        switch (extend) {
            case 1:
            vectorMiddle.x -= width / 2 * 1.1;
            break;
        case 2:
            vectorMiddle.y -= height / 2 * 1.1;
            break;
        case 3:
            vectorMiddle.x += width / 2 * 1.1;
            break;
        case 4:
            vectorMiddle.y += height / 2 * 1.1;
            break;
        }

        return vectorMiddle;
    }

    private float getScreenMagnitude() {
        PVector origin = new PVector(0, height);
        PVector center = new PVector(middleWidth, middleHeight);
        PVector result = PVector.sub(center, origin);

        return result.mag();
    }
}