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
                 "sexyTowel.jpg",
                 "sxswLego.jpg",
                 "unicornMan.jpg"};


void setup() {
  for(int i=5; i<6; i++) {
    img[i] = loadImage(images[i]);
  }
  
  size(1000, 1000);
}

void draw() {
  int widthCursor = 0, heightCursor = 0, ind = 0, maxHeight = 0;
  PImage curr;
  
  while(heightCursor < height ) {
    while(widthCursor < width) {
      curr = loadImage(images[ind]);
      image(curr,widthCursor,heightCursor);
      widthCursor += curr.width;
      maxHeight = curr.height > maxHeight ? curr.height : maxHeight;
    }
    heightCursor += maxHeight;
    widthCursor = 0;
    maxHeight = 0;    
  }

    
}

