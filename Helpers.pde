public class Helpers {
    float middleWidth = width / 2;
    float middleHeight = height / 2;

    void translateSketch(float ratio) {
        scale(1/ratio);
        translate((width * ratio - width) / 2, (height * ratio - height) / 2);
    }

    void drawPattern() {
        pushMatrix();
            stroke(255);
            noFill();
            rect(0, 0, width, height);
            line(0, middleHeight, width, middleHeight);
            line(middleWidth, 0, middleWidth, height);
            ellipse(middleWidth, middleHeight, 400, 400);
        popMatrix();
    }

    void showFrameRate() {
        if (frameCount % 5 == 0 || frameCount < 5) {
        msg = String.format("%2.0f / %d / %d", frameRate, frameCount, millis());
        }

        pushMatrix();
            fill(255, 255, 255, 100);
            text(msg, 30, height - 40);
        popMatrix();
    }
}