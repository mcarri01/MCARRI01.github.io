class Ball {
  public float radius = 0;
  public int last_update = 0;
  public int id;
  public float mass = 1;
  public int deltaTime;
  //public PVector velocity = new PVector(-1, 1);
  public ArrayList<Spring> springs = new ArrayList<Spring>();
  public PVector velocity = new PVector(0, 0);
  public PVector acceleration = new PVector(0, 0);
  public PVector force = new PVector(0, 0);
  //public float kineticEnergy = 0;
  private PVector old_mouse = null;

  PVector p = new PVector();
  color c = #ac5bcc;

  Ball(PVector p, int mass, int id) {
    this.p = p;
    this.mass = mass;
    this.id = id;
    this.radius = mass * MASS_SCALE;
  }

  void render() {
    if (last_update == 0) {
      last_update = millis();
    }
    deltaTime = millis() - last_update;
    fill(c);
    ellipseMode(RADIUS);
    radius = mass * MASS_SCALE;
    ellipse(p.x,p.y,radius,radius);
    if (p.x + radius > width) {
      acceleration.x = 0;
      velocity.x = 0;
      p.x = width - radius;
    }
    if (p.x - radius <= 0) {
      acceleration.x = 0;
      velocity.x = 0;
      p.x = 0 + radius;
    }
    if (p.y + radius > height) {
      velocity.y = 0;
      acceleration.y = 0;
      p.y = height - radius;
    }
    if (p.y - radius <= 0) {
     acceleration.y = 0;
     velocity.y = 0;
     p.y = 0 + radius;
    }
    acceleration = force.div(mass);
    this.velocity.add(acceleration);
    this.p.add(this.velocity.mult(0.93));
    //kineticEnergy = 0.5 * mass * (float)Math.pow(velocity.mag(), 2);
    last_update = millis();
  }
  
  void checkDrag() {
    // Checks if within area of circle
    boolean withinCircle = sqrt(sq(mouseX - p.x) + sq(mouseY - p.y)) <= radius;
    if (withinCircle & !alreadyDrag) { 
      // If you're about to start dragging or are dragging
      alreadyDrag = true;
      if (mouseX + radius > width) {
        p.x = width - radius;
      } else if (mouseX - radius < 0) {
        p.x = radius;
      } else {
        p.x = mouseX; 
      }
      // Do the same for y
      if (mouseY + radius > height) {
        p.y = height - radius;  
      } else if (mouseY - radius < 0) {
        p.y = radius;
      } else {
        p.y = mouseY; 
      }
    } else { // If you're done dragging
      alreadyDrag = false;
      kineticEnergy = 1;
    }
  }
  void checkHover() {
    boolean withinCircle = sqrt(sq(mouseX - p.x) + sq(mouseY - p.y)) <= radius;
    if (withinCircle) {
      c = #e9bed7;
      String tooltip = String.format("Id: %d\nMass: %f", id, mass);
      fill(250);
      stroke(204, 102, 0);
      rect(mouseX + textWidth(tooltip) / 2, mouseY - 10, textWidth(tooltip) + 10, height * 0.05);
      fill(0);
      text(tooltip, (mouseX + textWidth(tooltip) / 2) + 5, mouseY - 10, textWidth(tooltip) * 2, height * 0.05);
    } else {
      c = #ac5bcc;
    }
  }
  void changeMass(float direction) {
    boolean withinCircle = sqrt(sq(mouseX - p.x) + sq(mouseY - p.y)) <= radius;
    if (withinCircle) {
        mass = (mass < 1? 1: mass + direction);
    }
  }
}
