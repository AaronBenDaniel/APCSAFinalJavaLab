// Both of these are needed for the asset dictionary //<>//
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
boolean showEntityID=false;
boolean showKeys=false;

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
ArrayList<level> levels = new ArrayList<level>();
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
  assets.put("platform", loadImage("Assets/platform.png"));
  assets.put("movementPrompt", loadImage("Assets/movementPrompt.png"));
  assets.put("jumpPrompt", loadImage("Assets/jumpPrompt.png"));
  assets.put("wallclingPrompt", loadImage("Assets/wallclingPrompt.png"));
  assets.put("arrow", loadImage("Assets/arrow.png"));
  assets.put("congratulations", loadImage("Assets/congratulations.png"));

  // Build background image from stoneA sprite
  // Tiles source sprite across entire background image
  // Blends a grey color in to darken the background
  background = createImage(width, height, RGB);
  PImage backgroundSource=assets.get("stoneA");
  for (int i=0; i<background.pixels.length; i++) {
    background.pixels[i]=PImage.blendColor(backgroundSource.pixels[i%backgroundSource.width+backgroundSource.width*((i/background.width)%backgroundSource.height)], color(100, 100, 110), SUBTRACT);
  }

  // Initialize levels
  levels.add(new level(levelStartArray));
  levels.add(new level(level1Array));
  levels.add(new level(level2Array));
  levels.add(new level(level3Array));
  levels.add(new level(level4Array));
  levels.add(new level(level5Array));
  levels.add(new level(level6Array));
  levels.add(new level(levelEndArray));

  // Add OTHER__ objects to levels
  levels.get(0).add(new entity(2*blockSize, 8*blockSize, assets.get("movementPrompt"), OTHER__, true, false, false)); // Movement prompt
  levels.get(0).add(new entity(13*blockSize, 8*blockSize, assets.get("jumpPrompt"), OTHER__, true, false, false)); // Jump prompt
  levels.get(0).add(new entity(3*blockSize, 1*blockSize, assets.get("arrow"), OTHER__, true, false, false)); // Arrow
  levels.get(3).add(new entity(2*blockSize, 8*blockSize, assets.get("wallclingPrompt"), OTHER__, true, false, false)); // Wallcling prompt
  levels.get(7).add(new entity(8*blockSize, 5*blockSize, assets.get("congratulations"), OTHER__, true, false, false)); // Congratuations

  // Load start level and initialize the player
  transition.transition(levels.get(0));
  player=new player(100, 100, assets.get("playerBlue"));
}

void draw() {
  // Update level transition
  transition.transitionUpdate();

  // Update sceneA
  for (entity entity : sceneA) {
    entity.draw();
    entity.physicsUpdate();
  }

  // Update sceneB
  for (entity entity : sceneB) {
    entity.draw();
    entity.physicsUpdate();
  }

  // Update player object
  player.draw();
  player.physicsUpdate();

  // Debug
  if (showKeys) printKeys();
}
