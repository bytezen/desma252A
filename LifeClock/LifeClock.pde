void setup() {
 size(500,500);
 //noFill(); 
  
}

int AGE = 42;        //should be multiple of 3
int LIFE_STAGES = 3;
color BACKGROUND = color(255);
int yWedges = AGE / LIFE_STAGES;

//number of radians per year
float yRads = TWO_PI / yWedges;

//number of radians per month
float mRads = yRads/12;

color[] c = {150,255};
int radii = 75;

//
AgeCircle[] ac = {new AgeCircle(75,yWedges)};

void draw() {
  background(BACKGROUND);
  fill(0);
  
  /* UNCOMMENT TO DRAW CLOCK
  
  for(int j=LIFE_STAGES; j >= 1; j--) {
    for(int i =0 ; i < yWedges; i++) {
     pushMatrix();
     translate(width/2,height/2);
     rotate(i*yRads);
     stroke(#00FF00);
     fill(c[i % c.length]);
     arc(0,0,j*radii * 2, j*radii * 2, 0, yRads);
     
     point(0,j* radii); 
     popMatrix(); 
    }
  }

*/  
  
  /* UNCOMMENT TO test ONE MONTH
  translate(width/2, height/2);
  ac[0].drawYear(3);
  int _month = int(frameCount/10) % 12;
  //ac[0].drawMonth(3,_month);
  ac[0].drawMonths(3,0,_month);
  */
  
  //Test for drawing an age
  // hypothetical age; 3 years old
  int testAgeYear = 3;
  int testAgeMonth = 0;
  int testAgeDay = 0;
  
  

}
