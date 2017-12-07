class Edge {
 Ball b1, b2;
 Spring sp;
 float default_length;
 float current_length;
 
 Edge(Ball b1, Ball b2, Spring sp, float len) {
  this.b1 = b1;
  this.b2 = b2;
  this.sp = sp;
  this.default_length = len;
  this.current_length = len;
 }
}
