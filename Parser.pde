class Parser {
  public HashMap<Integer,Ball> balls = new HashMap<Integer, Ball>();;
  public ArrayList<Spring> springs = new ArrayList();;

  Parser(String filename) {
    String[] lines = loadStrings(filename);
    int n = parseInt(lines[0], 10); // n nodes in graph
    int i = 1;
    String[] spline = split(lines[i],",");
    while (spline.length > 1) {
      int id = parseInt(spline[0], 10);
      int mass = parseInt(spline[1], 10);
      float radius = (float)(mass * MASS_SCALE);
      float x = random(0 + radius, width - radius);
      float y = random(0 + radius, height - radius);
      balls.put(id, new Ball(new PVector(x,y), mass, id));
      spline = split(lines[i++],",");
    } w
    for (int j = i; j < lines.length; j++) {
      spline = split(lines[j],",");
      int id1 = parseInt(spline[0], 10);
      int id2 = parseInt(spline[1], 10);
      float len = parseFloat(spline[2]);
      if (i % 2 == 0) {
        springs.add(new Spring(balls.get(id1),balls.get(id2), len, true));  
      } else {
        springs.add(new Spring(balls.get(id1),balls.get(id2), len, false));
      }
    }
  }
}