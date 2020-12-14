public class ray {

  float lastDirection = 0;
  float x1, y1;
  float x2, y2;
  float angle;
  PVector angleVector;
  int count;

  public ray(float x, float y, float angle, int count) {
    this.x1 = x;
    this.y1 = y;
    this.angle = angle - FOV / 2.0;
    this.angleVector = PVector.fromAngle(radians(angle));
    this.count = count;
  }

  public void show(ArrayList<borders> walls, float currentDirection, float x, float y) {
    
    if(currentDirection != lastDirection) {
      this.angleVector.rotate(radians(currentDirection - lastDirection));
    }
    lastDirection = currentDirection;
    
    this.x1 = x;
    this.y1 = y;
    this.x2 = this.x1 + angleVector.x * width;
    this.y2 = this.y1 + angleVector.y * width;
    float uA = 2;
    for (borders wall : walls) {
      float temp = intersects(wall, x2, y2);
      if (uA > temp) {
        uA = temp;
      }
    }
    this.x2 = this.x1 + (uA * (this.x2 - this.x1));
    this.y2 = this.y1 + (uA * (this.y2 - this.y1));
    
    
    //TODO: make wall height calculate logarithmically to distance
    float lineLength = dist(this.x1, this.y1, this.x2, this.y2);
    strokeWeight(1);
    stroke(255 - uA * 255);
    line(count, lineLength * .25, count, height - lineLength * .25);
  }

  public float intersects(borders wall, float x, float y) {
    float x1 = this.x1;
    float y1 = this.y1;
    float x2 = x;
    float y2 = y;

    float x3 = wall.x1;
    float y3 = wall.y1;
    float x4 = wall.x2;
    float y4 = wall.y2;

    float den = ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));


    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / den;

    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / den;

    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
      return uA;
    }
    return 1;
  }
}
