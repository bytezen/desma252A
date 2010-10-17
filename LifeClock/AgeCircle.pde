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
    _transformCoordsForYear(aYear);
     stroke(#00FF00);
     noFill();
     arc(0,0,radius * 2, radius * 2, 0, yRads);  
   
     drawMask(maskRadius,yRads);
     popMatrix();           
  }
  
  //this is a month
  public void drawMonth(int aYear, int aMonth) {
    pushMatrix();
    _transformCoordsForYear(aYear);
    //noFill();
    
    rotate(aMonth*mRads);
    fill(0);
    arc(0,0, radius*2,radius*2,0,mRads);
    drawMask(maskRadius,mRads);
    popMatrix();
  }
  
  private void _initialize() {
    
  }
  
  private void drawMask(int _radius, float rads) {
     //draw the inner ring to mask the wedge
     fill(BACKGROUND);
     //stroke(BACKGROUND);
     arc(0,0, _radius * 2, _radius * 2, 0, rads);   
  }
  
  private void _transformCoordsForYear(int aYear) {
     rotate(aYear*yRads);    
  }
  
}
