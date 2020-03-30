class Rectangle {
  int x;
  int y;
  int h;
  int w;
  
  public Rectangle(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
  }
  
  void paint() {
    rect(x, y, w, h);
  }
}
