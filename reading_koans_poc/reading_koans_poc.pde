PFont _fMonaco;
PFont _fMuseo;
PFont _fGotham;

XMLElement xml;

void setup() {
 size(300,300);
 background(255);
 _fMonaco = loadFont("Monaco.vlw");
 _fMuseo = loadFont("Museo-300-18.vlw");
 _fGotham = loadFont("Gotham-Light-24.vlw");
 textFont(_fGotham, 18); 
 smooth();
 
  xml = new XMLElement(this, "koans.xml");
 int koans = xml.getChildCount();
 println(_getKoanChildContent(xml.getChild(0), "title"));
 print(_getKoanChildContent(xml.getChild(0), "content"));
}

void draw() {
 fill(0);
 stroke(1);

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


