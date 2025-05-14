class entity{
 private int ID;
 private int posX;
 private int posY;
 private int velX;
 private int velY;
 private PImage sprite;
 private int type;
 private boolean ignoreGravity;
 private boolean screenCollision;
 private boolean entityCollision;
 private boolean onGround;
 private boolean test=false;
 
 private int direction=RIGHT;
 
 public int entityCount(){
  return(IDCounter); 
 }
 
 public entity(int posX,int posY,PImage sprite,int type){
   ID=IDCounter+1;
   this.posX=posX;
   this.posY=posY;
   this.sprite=sprite;
   this.type=type;
   this.ignoreGravity=false;
   this.screenCollision=true;
   this.entityCollision=true;
 }
 
 public entity(int posX,int posY,PImage sprite,int type,boolean ignoreGravity,boolean screenCollision,boolean entityCollision){
   ID=IDCounter+1;
   this.posX=posX;
   this.posY=posY;
   this.sprite=sprite;
   this.type=type;
   this.ignoreGravity=ignoreGravity;
   this.screenCollision=screenCollision;
   this.entityCollision=entityCollision;
 }
 
 public void draw(){
   if(test){
     fill(0,255,0);
     rect(posX,posY,posX+blockSize,posY+blockSize);
     return;
   }
   
   if (sprite==null) {
      sprite=assets.get("noSprite");
      System.out.print("Warning! Entity ID: ");
      System.out.print(ID);
      System.out.println(" has a NULL sprite!");
    }
    
    if (velX<0) direction=LEFT;
    else if (velX>0) direction=RIGHT;

    // If direction is right, mirror sprite horizontally
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
      text(ID, posX+blockSize/2, posY+blockSize/2+5);
    }
 }
 
 public void physicsUpdate(){
   onGround=true;
   
    // X calcs
    posX+=velX;
    
    if (velX>0) velX-=1;
    else if (velX<0) velX+=1;
    
    // COLLISION
    
    // Y calcs
    if(!ignoreGravity) velY+=gravity;
    posY+=velY;
        
    // COLLISION
    
    // Screen collision
    if(screenCollision){
      if(posX<0){
        velX=0;
        posX=0;
      }
      else if(posX+blockSize>width){
        velX=0;
        posX=width-blockSize;
      }
      
      if(posY<0){
        velY=0;
        posY=0;
      }
      else if(posY+blockSize>height){
        velY=0;
        posY=height-blockSize;
      }
    }
    
    // Entity collision
    if(entityCollision){
     for(entity entity : sceneA){
      if(entity.type==PLAYER_) continue; // Don't collide with players
      if(entity.ID==ID) continue; // Don't collide with self
      
      test=false;
      
      // Not Working yet
      if(entity.posX+blockSize<posX && entity.posX>posX+blockSize){ // X overlap
        //if(entity.posY+blockSize<posY && entity.posY>posY+blockSize){ // Y overlap
        test=true;
        System.out.println(ID+" collide!");
        //}
      }
     }
    }
 }
 
 public void addVelX(int val){
   velX+=val;
 }
 
 public void addVelY(int val){
   velY+=val;
 }
 
 public int getVelX(){
   return(velX);
 }
 
 public boolean onGround(){
   return(onGround);
 }
}
