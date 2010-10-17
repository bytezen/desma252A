class AgeCircle {
  int radius, maskRadius;
  int segments;
  
  public AgeCircle(int _radius, int _segments) {
    radius = _radius;
    maskRadius = radius - 10;
    segments = _segments;
  }
  
  //this is a wedge
  public void drawYear(int aYear) {
    pushMatrix();
     rotate(aYear*yRads);
     stroke(#00FF00);
     arc(0,0,radius * 2, radius * 2, 0, yRads);  
   
     //draw the inner ring to mask the wedge
     fill(BACKGROUND);
     arc(0,0, maskRadius * 2, maskRadius * 2, 0, yRads);  
     popMatrix();
  }
  
  //this is a month
  public void drawMonth() {
    
  }
  
  private void initialize() {
    
  }
  
}
