class Clock {
 public int AGE = 20;              //total time represented in clock must be divisible by number of rungs
                                   //    also equal to the # of wedges in the clock
 private int BASE_MONTHS = 12; 
 private AgeCircle[] rungs;    

 private int rungCount;       //corresponds to the number of rings in clock
 private int yearWedges;       //years per wedge
 private float yearRadians;    //radians per year
 private float monthRadians;   //radians per month
 private int rungRadius;
 
 private ClockCoordinate[] timePath;   //Path of wedges coordinates to current yearWedge
 private int _tpIndex = 0;             //pointer to current coordinate in timePath
 
 private ArrayList[] yearsPast; //indexed by rungs to keep track of the years (wedges) that
                                       //have been rendered for that rung; primarily used in
                                       //rendering to get the right z-layering
 private int[] _ypIndex;               //List of indices to track the current Index of yearsPast
                                       // for a rung. 
                                       
 private ClockCoordinate ccCurrent;    //keep track of the Coordinate that we are drawing in now.                                       
 public Date birthDate, currentAge;
 
 
 //public Clock(int rungRadius, int rungs, Date birthDate) {
 public Clock(int rungRadius, int rungs, Date age) {   
  rungCount = rungs;
  this.rungRadius = rungRadius;
  this.rungs = new AgeCircle[rungs];
  this.currentAge = age;  
  
  timePath = new ClockCoordinate[AGE];
  initialize();
 } 
 
 public void display() {
  //for each rung in the clock update the state
  ClockCoordinate _c;
  for(int i = rungCount-1; i >= 0; i--) {
    println("{display} rung: " + i);
   for(int j=0; j < yearsPast[i].size(); j++) {
     if(yearsPast[i].get(j) == null)
       break;
     _c = (ClockCoordinate) yearsPast[i].get(j);  
     println("\tcoord: "+ _c);
     drawYear(_c);
   }  
  }
  
  /*
  for(int i=0; i < _tpIndex; i++) {
   ClockCoordinate c = timePath[i];
   drawYear(c);
  } 
  */
 }
 
 /**
  INITIALIZE
  **/
 private void initialize() {
  yearWedges = AGE / rungCount;
  yearRadians = TWO_PI / yearWedges;
  monthRadians = yearRadians/BASE_MONTHS;
  yearsPast = new ArrayList[rungCount];
  
  // initialize years past to track the yearWedges to draw
  _ypIndex = new int[rungCount];  
  for(int i=0; i< rungCount; i++) {
    _ypIndex[i] = 0;
    yearsPast[i] = new ArrayList();
  }
  
  //initialize each rung in the clock
  for(int i=0; i< rungCount; i++) {
      rungs[i] = new AgeCircle((i+1)*rungRadius, yearWedges); 
  }
  
  //choose a base wedge to start
  ccCurrent = getRandomValidCoordinate(); 
  cacheCoordinate(ccCurrent);
  
  //build path for the initial age
  for(int i=1; i< currentAge.y; i++) {
   ClockCoordinate c = getNextCoordinate();
   cacheCoordinate(c); 
  }
  
 }
 
  /**
  DRAW YEAR
  **/
 private void drawYear(ClockCoordinate c) {
  //get the appropriate rung

  AgeCircle ac = rungs[c.rung];
  ac.drawYear(c.wedge); 
 } 
 
 
 /**
   CACHECOORDINATE
   store a clockCoordinate that has been displayed onto:
   the timePath,
   and the yearsPast cache
 **/
 private void cacheCoordinate(ClockCoordinate c) {
  println("caching coord: " + c); 
  timePath[_tpIndex++] = c;
  int ind = _ypIndex[c.rung];
  yearsPast[c.rung].add( c );
  _ypIndex[c.rung] = ind +1;  
 }
 
 
 
 /**
   return a ClockCoordinate that is adjacent to the current ClockCoordinate
 **/
 private ClockCoordinate getNextCoordinate() {
   println("{getNextCoordinate} ");
   ArrayList validCoords = new ArrayList();
   ArrayList validRungs = new ArrayList();
   ArrayList validWedges = new ArrayList();
   Boolean valid = false;

   int currentRung = ccCurrent.rung;
   int currentWedge = ccCurrent.wedge;
   
   //get valid rungs first
   validRungs.add( currentRung );           // the current rung has to be valid
   if(currentRung == 0) {                   //only check the rung above
     validRungs.add(currentRung+1);
   } else if(currentRung == rungCount-1) {  //only check the rung below
     validRungs.add(currentRung-1);
   } else {
     validRungs.add(currentRung-1);
     validRungs.add(currentRung+1);
   }
   
   //get valid Wedges
   validWedges.add( currentWedge );
   if(currentWedge == 0) {    // get last hour
     validWedges.add(yearWedges-1);
   } else if(currentWedge == yearWedges-1) {  // get first hour
     validWedges.add(0);
   } else {
     validWedges.add( currentWedge - 1);
     validWedges.add( currentWedge + 1);
   }
   
   //println("\t validRungs = " + validRungs);
   //println("\t validWedges = " + validWedges);
   
   //build a list of coordinates that are valid next coords
   for(int i=0; i < validRungs.size(); i++) {
     for(int j=0; j < validWedges.size(); j++) {
       int _rung = (Integer)validRungs.get(i);
       int _wedge = (Integer) validWedges.get(j);
       if(currentRung == _rung && currentWedge == _wedge)
         continue;
        
       //make sure this year has not already been seen
       valid = isValid(_rung,_wedge);
       if(valid)
         validCoords.add(new ClockCoordinate( _rung , _wedge)); 
     }
   }
      
   //println("\tvalidCoord "+ validCoords);
   if(validCoords.size() > 0) {
     int ind = min( (int)random(0,validCoords.size()),
                    validCoords.size()-1 );
                    
     return (ClockCoordinate)validCoords.get(ind);
   } else {
     return getRandomValidCoordinate();
   }
 }
 
 private ClockCoordinate getRandomValidCoordinate() {
   ClockCoordinate c = null;
   Boolean valid = false;
   int counter = 0;
   
   while(!valid && counter < AGE) {
     c = new ClockCoordinate(int(random(0,rungCount)), 
                                int(random(0,yearWedges)) );
     valid = isValid(c);
     counter++;
   } 
     
   if(!valid) {
    println("\n\n***");
    for(int i=0; i< yearsPast.length; i++) {
      println("rung"+i+"  " +yearsPast[i]);
    }
        println("\n\n***");
    throw new Error("could not find a valid coordinate?!?!");   
    
   }
    
   return c;                            
 }
 
 /**
   returns true if the ClockCoordinate has not been seen i.e. is not in the years past
 **/  
 private Boolean isValid(ClockCoordinate c) {
    return isValid(c.rung, c.wedge);
 }
 
 private Boolean isValid(int rung, int wedge) {
   //println("{isValid} " + "(" + rung + "," + wedge +")");
   for(int i=0; i < yearsPast[rung].size(); i++) {
          ClockCoordinate cc = (ClockCoordinate) yearsPast[rung].get(i);
          //println("\t yearPast coord = " + cc);
          if( cc != null && cc.wedge == wedge) {
             //println("\t\t return false");
             return false;
          }
    }
    //println("\t\t return true");
    return true;   
 }
 
} //--END Clock Class

class ClockCoordinate {
 int rung, wedge;
 
 ClockCoordinate() {}
 ClockCoordinate(int rung, int wedge) {
   this.rung = rung;
   this.wedge = wedge;
 }

 String toString() {
  return "("+rung+","+wedge+")"; 
 }
}


