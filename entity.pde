public class entity{
 private int ID;
 private int posX;
 private int posY;
 private int velX;
 private int velY;
 private PImage sprite;
 private int type;
 private boolean ignoreGravity;
 
 private int direction=RIGHT;
 
 public int entityCount(){
  return(IDCounter); 
 }
 
 public entity(int posX,int posY,PImage sprite,int type,boolean ignoreGravity){
   ID=IDCounter+1;
   this.posX=posX;
   this.posY=posY;
   this.velX=velX;
   this.velY=velY;
   this.sprite=sprite;
   this.type=type;
   this.ignoreGravity=ignoreGravity;
 }
 
 public void draw(){
   if (sprite==null) {
      sprite=assets.get("noSprite");
      System.out.print("Warning! Entity ID: ");
      System.out.print(ID);
      System.out.println(" has a NULL sprite object!");
    }
    
    if (direction==RIGHT) {
      pushMatrix();
      translate(posX + sprite.width, posY);
      scale( -1, 1 );
      image(sprite, 0, 0 );
      popMatrix();
    } else {
      image(sprite, posX, posY);
    }

    if (showEntityID) {
      fill(255, 0, 0);
      textAlign(CENTER);
      text(ID, posX+sizeX/2, posY+sizeY/2+5);
    }
 }
}
