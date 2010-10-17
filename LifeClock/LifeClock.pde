void setup() {
 size(500,500);
 //noFill(); 
  
}

int AGE = 21;
int LIFE_STAGES = 3;
color BACKGROUND = color(255);
int yWedges = AGE / LIFE_STAGES;

float yRads = TWO_PI / yWedges;

color[] c = {150,255};
int radii = 75;

//
AgeCircle[] ac = {new AgeCircle(75,yWedges)};

void draw() {
  background(BACKGROUND);
  fill(0);
  translate(width/2, height/2);
  ac[0].drawYear(3);
  /*for(int j=LIFE_STAGES; j >= 1; j--) {
    
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
  }*/
}
