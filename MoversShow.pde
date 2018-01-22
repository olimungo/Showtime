public class MoversShow {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  int COUNT_PARTICLES = 10;
  
  MoversShow() {
    for (int i = 0; i < this.COUNT_PARTICLES; i++) {
        Particle particle = new Particle(random(width), random(height), 30, 20, .5, 70);
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