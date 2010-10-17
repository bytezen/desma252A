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
   
     _drawMask(maskRadius,yRads);
     popMatrix();           
  }
  
  public void drawMonth(int aYear, int aMonth) {
    pushMatrix();
    _transformCoordsForYear(aYear);
    //noFill();
    
    rotate(aMonth*mRads);
    fill(0);
    arc(0,0, radius*2,radius*2,0,mRads);
    _drawMask(maskRadius,mRads);
    popMatrix();
  }
  
  public void drawMonths(int aYear, int startMonth, int endMonth) {
   int months = endMonth - startMonth + 1;
   pushMatrix();
   _transformCoordsForYear(aYear);
   rotate(startMonth*mRads);
   fill(0);
   arc(0,0,radius*2,radius*2,0,months*mRads); 
   _drawMask(maskRadius,months*mRads);  
   popMatrix();
  }
  
  private void _initialize() {
    
  }
  
  private void _drawMask(int _radius, float rads) {
     //draw the inner ring to mask the wedge
     fill(BACKGROUND);
     //stroke(BACKGROUND);
     arc(0,0, _radius * 2, _radius * 2, 0, rads);   
  }
  
  private void _transformCoordsForYear(int aYear) {
     rotate(aYear*yRads);    
  }
  
}
