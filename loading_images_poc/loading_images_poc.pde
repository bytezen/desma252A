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

String FACE_MASK = "face_mask.png";
PImage iMask = loadImage(FACE_MASK);

int imgIndex = 0;
int currentRow = 0;
PFont _fMonaco;
int TEXT_WIDTH = 100, TEXT_HEIGHT =100;
XMLElement xmlKoans;

void setup() {
  //load collage images
  for(int i=0; i<images.length; i++) {
    img[i] = loadImage(images[i]);
  }
  
  //load image mask
  
  size(iMask.width, iMask.height);
   _fMonaco = loadFont("Monaco.vlw");
   textFont(_fMonaco, 12); 
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

