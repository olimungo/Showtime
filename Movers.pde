public class Movers {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int COUNT_PARTICLE = 40000;
  
  Movers() {
    for (int i = 0; i < this.COUNT_PARTICLE; i++) {
        Particle particle = new Particle(random(width), random(height), 30, 10, 2, 70);
        particle.setTarget(random(width), random(height));
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