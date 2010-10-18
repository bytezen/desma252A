class AgeCircle {
  int radius, maskRadius;
  int segments;
  float radiansPerSegment;  //this is equivalent to radians per year
  float radiansPerMonth;
  
  public AgeCircle(int _radius, int _segments) {
    radius = _radius;
    maskRadius = radius - 10;
    segments = _segments;
    radiansPerSegment = TWO_PI / _segments;
    radiansPerMonth = radiansPerSegment/BASE_MONTHS;
  }
  
  //this is a wedge
  public void drawYear(int aYear) {
    pushMatrix();
    _transformCoordsForYear(aYear);
     stroke(#00FF00);
     noFill();
     arc(0,0,radius * 2, radius * 2, 0, radiansPerSegment);  
   
     _drawMask(maskRadius,radiansPerSegment);
     
     fill(255,0,0);
     popMatrix();           
  }
  
  public void drawMonth(int aYear, int aMonth) {
    pushMatrix();
    _transformCoordsForYear(aYear);
    //noFill();
    
    rotate(aMonth*radiansPerMonth);
    fill(0);
    arc(0,0, radius*2,radius*2,0,radiansPerMonth);
    _drawMask(maskRadius,radiansPerMonth);
    popMatrix();
  }
  
  public void drawMonths(int aYear, int startMonth, int endMonth) {
   int months = endMonth - startMonth + 1;
   pushMatrix();
   _transformCoordsForYear(aYear);
   rotate(startMonth*radiansPerMonth);
   fill(0);
   arc(0,0,radius*2,radius*2,0,months*radiansPerMonth); 
   _drawMask(maskRadius,months*radiansPerMonth);  
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
     rotate(aYear*radiansPerSegment);    
  }
  
}
