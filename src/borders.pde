public class borders {

  public int x1, y1, x2, y2;

  public borders(int x1, int y1, int x2, int y2) {
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
  }

  public void show() {
    strokeWeight(2);
    stroke(150);
    line(x1, y1, x2, y2);
  }
}
