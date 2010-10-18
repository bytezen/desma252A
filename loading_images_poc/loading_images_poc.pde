int IMG_FILES = 15;
PImage[] img = new PImage[IMG_FILES];
String[] images = {"blissyUltrasound.jpg",
                 "chiSillyFace.jpg",
                 "coolAndSmart.jpg",
                 "deeDeeRhazieLove.jpg",
                 "femaleCanon.jpg",
                 "gettyDesertFlower.jpg",
                 "heartTini.jpg",
                 "maleCannon.jpg",
                 "mommyGunnarLove.jpg",
                 "mommyMadeIt.jpg",
                 "mysteriousMuirBeach.jpg",
                 "rhazieMask.jpg",
                 "sexyTowel.png",
                 "sxswLego.jpg",
                 "unicornMan.jpg"};

int imgIndex = 0;
int currentRow = 0;
PFont _fMonaco;
int TEXT_WIDTH = 100, TEXT_HEIGHT =100;

void setup() {
  for(int i=5; i<6; i++) {
    img[i] = loadImage(images[i]);
  }
  
  size(1000, 1000);
   _fMonaco = loadFont("Monaco.vlw");
   textFont(_fMonaco, 16); 
   frameRate(10);
}

void draw() {
    
  int currentRow = 0, widthCursor = 0, heightCursor = 0, ind = 0, maxHeight = 0;
  PImage curr;
  
  while(heightCursor < height ) {
    while(widthCursor < width) {
      if(currentRow % 2 == 0) {
        print("image @ " + widthCursor + ";; " +" height @ " + heightCursor);
        curr = _fetchCurrentImage(); 
       image(curr,widthCursor,heightCursor);
        
        widthCursor += curr.width;
        maxHeight = curr.height > maxHeight ? curr.height : maxHeight;        
      } else {
        //pushMatrix();
        //translate(0,maxHeight);
        println("**"+heightCursor);
        text("hello",widthCursor,heightCursor,TEXT_WIDTH,TEXT_HEIGHT);
        //popMatrix();
        widthCursor += TEXT_WIDTH;
        maxHeight = TEXT_HEIGHT;
      }
    }
    heightCursor += maxHeight;
    widthCursor = 0;
    maxHeight = 0; 
    currentRow++;   
  }
}

PImage _fetchCurrentImage() {
 if(imgIndex < images.length) 
   return loadImage(images[imgIndex++]);
 else 
   imgIndex = 0;
   
 return loadImage(images[imgIndex++]);
}
