// Both of these are needed for the asset dictionary
import java.util.Dictionary;
import java.util.Hashtable;

// Processing won't let me do this with a static attribute
int IDCounter=0;

// Aliases
int NONE___ = 0;
int OTHER__ = 1;
int PLAYER_ = 2;
int TERRAIN = 3;
int TRAPDOR = 4;
int PLATFRM = 5;
int RIGHT = 0;
int LEFT = 1;

// Global debug bools
boolean showEntityID=true;
boolean showKeys=true;

// Global consts
int blockSize = 48;
int gravity = 1;

// Asset dictionary
Dictionary<String, PImage> assets = new Hashtable<>();

// Background image
PImage background;

// Game objects
player player;
levelTransition transition = new levelTransition();
ArrayList<entity> sceneA = new ArrayList<entity>();
ArrayList<entity> sceneB = new ArrayList<entity>();

void setup() {
  size(1248, 768); // Assigns values to `width` and `height` vars

  // Load assets
  assets.put("playerBlue", loadImage("Assets/playerBlue.png"));
  assets.put("stoneA", loadImage("Assets/stoneA.png"));
  assets.put("stoneB", loadImage("Assets/stoneB.png"));
  assets.put("noSprite", loadImage("Assets/noSprite.png"));
  assets.put("trapdoor", loadImage("Assets/trapdoor.png"));

  // Build background image from stoneA sprite
  // Tiles source sprite across entire background image
  // Blends a grey color in to darken the background
  background = createImage(width, height, RGB);
  PImage backgroundSource=assets.get("stoneA");
  for (int i=0; i<background.pixels.length; i++) {
    background.pixels[i]=PImage.blendColor(backgroundSource.pixels[i%backgroundSource.width+backgroundSource.width*((i/background.width)%backgroundSource.height)], color(100, 100, 110), SUBTRACT);
  }

  // Initialize game objects
  levelA=new level(levelAArray);
  levelB=new level(levelBArray);
  transition.transition(levelB);
  player=new player(100, 100, assets.get("playerBlue"));
}

void draw() {
  // Update level transition
  transition.transitionUpdate();

  // Update player object
  player.draw();
  player.physicsUpdate();

  // Update sceneA
  for(entity entity:sceneA) {
    entity.draw();
    entity.physicsUpdate();
    //if(entity.getType()==PLATFRM) System.out.println("platform udpate");
    if(entity instanceof platform) System.out.println("works");
  }

  // Update sceneB
  for(entity entity:sceneB) {
    entity.draw();
    entity.physicsUpdate();
  }
  
  // Debug
  if (showKeys) printKeys();
}
