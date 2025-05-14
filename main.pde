import java.util.Dictionary;
import java.util.Hashtable;

Dictionary<String, PImage> assets = new Hashtable<>();

int IDCounter=0; // Processing won't lget me do this with a static attribute

PImage background; // Background image

// Aliases
static int NONE___ = 0;
static int OTHER__ = 1;
static int PLAYER_ = 2;
static int TERRAIN = 3;
static int TRAPDOR = 4;
static int RIGHT = 0;
static int LEFT = 1;


// Global debug bools
boolean showEntityID=true;
boolean showKeys=true;

// Global consts
static int blockSize = 48;
static int gravity = 1;

player player;
ArrayList<entity> sceneA = new ArrayList<entity>();
ArrayList<entity> sceneB = new ArrayList<entity>();

void setup(){
  size(1248, 768); // Assigns values to `width` and `height` vars
  
  // Load assets
  assets.put("playerBlue",loadImage("Assets/playerBlue.png"));
  assets.put("stoneA",loadImage("Assets/stoneA.png"));
  assets.put("stoneB",loadImage("Assets/stoneB.png"));
  assets.put("noSprite",loadImage("Assets/noSprite.png"));
  assets.put("trapdoor",loadImage("Assets/trapdoor.png"));
  
  // Build background image from stoneA sprite
  // Tiles source sprite across entire background image
  // Blends a grey color in to darken the background
  background = createImage(width, height, RGB);
  PImage backgroundSource=assets.get("stoneA");
  for (int i=0; i<background.pixels.length; i++) {
    background.pixels[i]=PImage.blendColor(backgroundSource.pixels[i%backgroundSource.width+backgroundSource.width*((i/background.width)%backgroundSource.height)], color(100, 100, 110), SUBTRACT);
  }
  
  player=new player(100,100,assets.get("playerBlue"));
  sceneA.add(new entity(400,0,assets.get("stoneB"),TERRAIN));
}

void draw(){
  image(background, 0, 0);
  
  player.draw();
  player.physicsUpdate();
  
  for (int i=0; i<sceneA.size(); i++) {
    entity entity = sceneA.get(i);
    entity.draw();
    entity.physicsUpdate();
    sceneA.set(i, entity);
  }

  for (int i=0; i<sceneB.size(); i++) {
    entity entity = sceneB.get(i);
    entity.draw();
    entity.physicsUpdate();
    sceneB.set(i, entity);
  }
  
  if(showKeys) printKeys();
}
