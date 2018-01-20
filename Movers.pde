public class Movers {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int COUNT_PARTICLE = 10;
  
  Movers() {
    for (int i = 0; i < this.COUNT_PARTICLE; i++) {
        Particle particle = new Particle(random(width), random(height), 10);
        particle.setTarget(random(width), random(height));
        particle.SPEED = 500;
        particles.add(particle);
    }
  }
  
  void update() {
    for (Particle particle : particles) {
        particle.update();

        if (particle.targetReached) {
            particle.setTarget(random(width), random(height));
        }
    }
  }
  
  void draw() {
    for (Particle particle : particles) {
        particle.draw();
    }
  }
}