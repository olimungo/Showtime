public class Bubbles {
  ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
  Boolean allTargetsReached = false;
  Boolean effectOutTriggered = false;
  Boolean effectOutEnded = false;
  
  Bubbles(ArrayList<BubbleMatrix> matrix) {
    float rnd = random(1);
    
    for (BubbleMatrix bubble : matrix) {
      PVector start = new PVector(bubble.x, bubble.y);
      
      if (rnd > 1) {
        start = this.effectRadial(start);
      } else {
        start = this.effectWave(start);
      }
      
      // this.bubbles.add(new Bubble(bubble.x, bubble.y, start.x, start.y, bubble.r, bubble.c));
      this.bubbles.add(new Bubble(start.x, start.y, bubble.x, bubble.y, bubble.r, bubble.c));
    }
  }
  
  void update() {
    Boolean allTargetsReached = true;
    
    if (!this.effectOutEnded) {
      for (Bubble bubble : this.bubbles) {
        bubble.update();
        
        allTargetsReached = allTargetsReached && bubble.targetReached;
      }
      
      if (allTargetsReached) {
        if (effectOutTriggered) {
          this.effectOutEnded = true;
        } else {
          for (Bubble bubble : this.bubbles) {
            this.allTargetsReached = true;
            this.effectOutTriggered = true;

            PVector target = new PVector(bubble.location.x, bubble.location.y);
            target = this.effectRadial(target);
            bubble.setTarget(target.x, target.y);
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
    float magnitude = map(random(1), 0, 1, screenMagnitude * 1.05, screenMagnitude * 1.05);

    vectorResult.setMag(magnitude);
    vectorResult.add(vectorMiddle);

    return vectorResult;
  }
  
  private PVector effectWave(PVector vector) {
    PVector vectorMiddle = new PVector(width / 2, height / 2);
    
    int extend = ceil(random(0, 4));

    switch (extend) {
      case 1:
        vectorMiddle.x -= width / 2 * 1.2;
        break;
      case 2:
        vectorMiddle.y -= height / 2 * 1.2;
        break;
      case 3:
        vectorMiddle.x += width / 2 * 1.2;
        break;
      case 4:
        vectorMiddle.y += height / 2 * 1.2;
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