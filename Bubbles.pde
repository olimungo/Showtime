public class Bubbles {
  ArrayList<Bubble> bubbles = new ArrayList<Bubble>();
  Boolean allTargetsReached = false;
  Boolean effectOutTriggered = false;
  Boolean effectOutEnded = false;
  
  Bubbles(ArrayList<BubbleMatrix> matrix) {
    float rnd = random(1);
    
    for (BubbleMatrix bubble : matrix) {
      PVector start = new PVector(random(width), random(height));
      
      if (rnd > 0.5) {
        start = this.effectRadialIn(start);
      } else {
        start = this.effectWaveIn(start);
      }
      
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

            PVector target = new PVector(random(width), random(height));
            target = this.effectRadialIn(target);
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
  
  private PVector effectRadialIn(PVector vector) {
    PVector vectorMiddle = new PVector(width / 2, height / 2);
    
    PVector vectorResult = PVector.sub(vector, vectorMiddle);
    float magnitude = map(random(1), 0, 1, 1000, 1400);

    vectorResult.setMag(magnitude);
    vectorResult.add(vectorMiddle);

    return vectorResult;
  }
  
  private PVector effectWaveIn(PVector vector) {
    PVector vectorMiddle = new PVector(width / 2, height / 2);
    
    int extend = ceil(random(0, 4));
    PVector vectorResult = PVector.sub(vectorMiddle, vector).add(vector);

    switch (extend) {
      case 1:
        vectorResult.x *= -1;
        break;
      case 2:
        vectorResult.y *= -1;
        break;
      case 3:
        vectorResult.x += width;
        break;
      case 4:
        vectorResult.y += height;
        break;
    }

    return vectorResult;
  }

  private PVector randomLocation() {
    PVector vector = PVector.random2D();

    if (vector.x < width / 2 && vector.y < height /2) {

    }

    return vector;
  }
}