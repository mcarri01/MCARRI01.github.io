class Spring {
 public Ball b1, b2;
 private PVector oldDisp, dispacement;
 private PVector oldb1, oldb2;
 public PVector force1 = new PVector(0, 0);
 public PVector force2 = new PVector(0, 0);
 public float k = -0.0005;
 public float len = 0;
 public PVector dist = new PVector(0, 0);

 private int oldTime = 0;

 Spring(Ball b1, Ball b2, float l, boolean test) {
   this.b1 = b1;
   this.b2 = b2;
   this.len = l;
   // gets approx the distance as a vector
   oldDisp = b1.p.copy().sub(b2.p.copy());
 }
 
 void render() {
   PVector p1, p2;
   p1 = b1.p.copy();
   p2 = b2.p.copy(); 
   
   dist = p1.copy().sub(p2).normalize();
   
   //dist.set(cos(degrees(35)) * len, sin(degrees(35)) * len);
   PVector distPoints = p1.copy().sub(p2);
   if (Math.abs(distPoints.mag()) > dist.mag() ) {
     force1 = distPoints.copy().sub(dist).mult(k);
     force2 = dist.copy().sub(distPoints).mult(k);
     //force2 = distPoints.copy().sub(dist).mult(-k);
   }
    line(b1.p.x, b1.p.y, b2.p.x, b2.p.y);
    oldTime = millis();
 }
 PVector getForce(Ball b) {
   if (b == b1) {
    return force1.copy(); 
   } else {
    return force2.copy(); 
   }
 }
}