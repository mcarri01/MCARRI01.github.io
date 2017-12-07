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
   oldDisp = b1.p.get().sub(b2.p.get());
 }
 
 void render() {
   PVector p1, p2;
   p1 = b1.p.get();
   p2 = b2.p.get(); 
   
   dist = p1.get().sub(p2).normalize();
   
   //dist.set(cos(degrees(35)) * len, sin(degrees(35)) * len);
   PVector distPoints = p1.get().sub(p2);
   if (Math.abs(distPoints.mag()) > dist.mag() ) {
     force1 = distPoints.get().sub(dist).mult(k);
     force2 = dist.get().sub(distPoints).mult(k);
     //force2 = distPoints.get().sub(dist).mult(-k);
   }
    line(b1.p.x, b1.p.y, b2.p.x, b2.p.y);
    oldTime = millis();
 }
 PVector getForce(Ball b) {
   if (b == b1) {
    return force1.get(); 
   } else {
    return force2.get(); 
   }
 }
}