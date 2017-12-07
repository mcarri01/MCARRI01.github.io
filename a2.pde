boolean alreadyDrag = false;
ForceDirectedLayout fdl;
float MASS_SCALE = 5 * width/height;
double kineticEnergy = 1;

void setup() {
  size(1500, 600);
  fdl = new ForceDirectedLayout();
}

void draw() {
  fdl.render();
  for (Ball ball: fdl.balls) {
    ball.checkHover();  
  }
}
void mouseDragged() {
  for (Ball ball: fdl.balls) {
   ball.checkDrag();
 }
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  for (Ball ball: fdl.balls) {
    ball.changeMass(e);  
  }
}