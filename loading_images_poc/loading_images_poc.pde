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
XMLElement xmlKoans;

void setup() {
  for(int i=5; i<6; i++) {
    img[i] = loadImage(images[i]);
  }
  
  size(1000, 1000);
   _fMonaco = loadFont("Monaco.vlw");
   textFont(_fMonaco, 16); 
  xmlKoans = new XMLElement(this, "koans.xml");   
   frameRate(10);
}

void draw() {
  if(frameCount % 50 != 0 && frameCount > 10 )
    return;
  background(0);  
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
        pushMatrix();
        translate(widthCursor,heightCursor);
        println("**"+heightCursor);
        text(_getRandomKoan(),0,0,TEXT_WIDTH,TEXT_HEIGHT);

        widthCursor += TEXT_WIDTH;
        maxHeight = TEXT_HEIGHT;
        popMatrix();
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

String _getRandomKoan() {
 int ind = (int)random(0,xmlKoans.getChildCount()-1); 
 XMLElement koan = xmlKoans.getChild(ind);
 String ret = _getKoanChildContent(koan, "title");
 ret = ret == null ? "" : ret;
 ret = ret + "\n" + _getKoanChildContent(koan,"content");
 
 return ret;
}

/**
  parameter koan: Expected formate <koan><childName></childName></koan>
*/
String _getKoanChildContent(XMLElement koan, String childName) {
 int children = koan.getChildCount();
 for(int i=0; i < children; i++) {
   if(koan.getChild(i).getName().equals(childName)) 
    return koan.getChild(i).getContent(); 
 } 
 return null;
}

