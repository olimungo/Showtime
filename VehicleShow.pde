public class VehicleShow {
    Vehicle vehicle;

    private VectorMeter vectorMeterVelocity;
    private VectorMeter vectorMeterAcceleration;
    private VectorMeter vectorMeterMode;

    private int timer = 0;

    VehicleShow() {
        int randomMode = ceil(random(2));
        vehicle = new Vehicle(random(width), random(height), randomMode);
        vehicle.setTarget(random(width), random(height));

        vectorMeterVelocity = new VectorMeter(50, 50);
        vectorMeterVelocity.lengthFactor = 15;
        vectorMeterVelocity.label = "VEL";
        vectorMeterAcceleration = new VectorMeter(130, 50);
        vectorMeterAcceleration.lengthFactor = 100;
        vectorMeterAcceleration.label = "ACC";
        vectorMeterMode = new VectorMeter(210, 50);
        vectorMeterMode.lengthFactor = 100;

        this.setVectorMeterModeLabel(randomMode);
    }

    void update() {
        vehicle.update();

        if (vehicle.getTargetReached() && this.timer == 0) {
            this.timer = millis() + 1000;
        }
    }

    void draw() {
        this.vectorMeterVelocity.draw(vehicle.velocity);
        this.vectorMeterAcceleration.draw(vehicle.accelerationCopy);
        this.vectorMeterMode.draw(vehicle.fleeOrSeekCopy);

        vehicle.draw();

        if (this.timer != 0) {
            this.checkTimer();
        }
    }

    private void setVectorMeterModeLabel(int randomMode) {
        if (randomMode == Vehicle.SEEK) {
            vectorMeterMode.label = "SEEK";
        } else {
            vectorMeterMode.label = "FLEE";
        }
    }

    private void setNewTarget() {
        int randomMode = ceil(random(2));
        vehicle.mode = randomMode;
        this.setVectorMeterModeLabel(randomMode);
        vehicle.setTarget(random(width), random(height));
    }

    private void checkTimer() {
        if (millis() > this.timer) {
            this.timer = 0;
            this.setNewTarget();
        }
    }
}