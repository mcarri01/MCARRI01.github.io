class ForceDirectedLayout {
  public ArrayList<Ball> balls = new ArrayList<Ball>();
  public ArrayList<Spring> springs = new ArrayList<Spring>();
  public PVector p1;
  public PVector p2;
  public Parser p;
  private float c = (float)(10 * Math.pow(10, 1));

  ForceDirectedLayout() {
    p = new Parser("100.csv");
    for (Ball ball : p.balls.values()) {
      balls.add(ball);
    }
    springs = p.springs;
    for (Spring spring : springs) {
      spring.b1.springs.add(spring);
      spring.b2.springs.add(spring);
    }
  }

  public PVector applyHookes(Ball b) {
    PVector force = new PVector(0, 0);
    for (Spring spring : b.springs) {
          PVector f = spring.getForce(b);
          force.add(f);
        }
    return force;
  }

  public double applyForces() {
    double energy = 0;
    for (Ball b : balls) {
      PVector totalForce = new PVector(0, 0);
      totalForce.add(applyHookes(b));
      totalForce.add(applyCoulombs(b));
      b.force = totalForce;
      energy += 0.5*b.mass*totalForce.copy().dot(totalForce);
    }
    return energy;
  }
  public PVector applyCoulombs(Ball b1) {
    PVector force = new PVector(0, 0);
    for (Ball b2: balls) {
      if (b1.id != b2.id) {
          PVector u;
          float q1 = b1.mass * 1;
          float q2 = b2.mass * 1;
          float dist = (float)Math.pow(b1.p.dist(b2.p), 2);
          u = b1.p.copy().sub(b2.p);
          u.normalize();
          u.mult((Math.abs(q1 * q2)) / dist);
          force.add(u);
      }
    }    
    return force.mult(c);
  }

  public void render() {
    background(#9ff2e8);
    for (Spring spring: springs) {
     spring.render(); 
    }
    for (Ball ball: balls) {
     ball.render(); 
    }
    if (kineticEnergy < 0) {
      for (Ball ball: balls) {
       ball.velocity.set(0,0,0);
       ball.acceleration.set(0,0,0);
      }
    } else {
      kineticEnergy = applyForces();
    }
    //string, x y, wid, height
    fill(#000000);
    text("Kinetic Energy of System (in Joules): "+Double.toString(kineticEnergy), 10, 20);
  }
}