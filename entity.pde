class entity {
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

  private int direction=LEFT;

  public int entityCount() {
    return(IDCounter);
  }

  // Basic constructor
  public entity(int posX, int posY, PImage sprite, int type) {
    ID=++IDCounter;
    this.posX=posX;
    this.posY=posY;
    this.sprite=sprite;
    this.type=type;
    this.ignoreGravity=false;
    this.screenCollision=true;
    this.entityCollision=true;
  }


  // Advanced constructor
  public entity(int posX, int posY, PImage sprite, int type, boolean ignoreGravity, boolean screenCollision, boolean entityCollision) {
    ID=++IDCounter;
    this.posX=posX;
    this.posY=posY;
    this.sprite=sprite;
    this.type=type;
    this.ignoreGravity=ignoreGravity;
    this.screenCollision=screenCollision;
    this.entityCollision=entityCollision;
  }
  
  // Duplicate constructor
  public entity(entity entity) {
    ID=entity.ID;
    this.posX=entity.posX;
    this.posY=entity.posY;
    this.sprite=entity.sprite;
    this.type=entity.type;
    this.ignoreGravity=entity.ignoreGravity;
    this.screenCollision=entity.screenCollision;
    this.entityCollision=entity.entityCollision;
  }

  public entity duplicate(){
    return(new entity(this));
  }

  public void draw() {
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

  public void physicsUpdate() {    
    onGround=false;

    posX+=velX;
    if (velX>0) velX-=1;
    else if (velX<0) velX+=1;

    if (!ignoreGravity) velY+=gravity;
    posY+=velY;

    // Screen collision
    if (screenCollision) {
      if (posX<0) {
        velX=0;
        posX=0;
      } else if (posX+blockSize>width) {
        velX=0;
        posX=width-blockSize;
      }

      if (posY<0) {
        velY=0;
        posY=0;
      } else if (posY+blockSize>height) {
        velY=0;
        posY=height-blockSize;
        onGround=true;
      }
    }

    // Entity collision
    if (entityCollision) {
      for (entity entity : sceneA) {
        if (entity.type==PLAYER_) continue; // Don't collide with players
        if (entity.type==OTHER__) continue; // Don't collide with other objects
        if (entity.ID==ID) continue; // Don't collide with self

        // Detect collision with object
        if (posX+blockSize>entity.posX && posX<entity.posX+blockSize) {
          if (posY+blockSize>entity.posY && posY<entity.posY+blockSize) {

            int xClip;
            int yClip;

            // Determine by how much the objects are colliding on each axis
            xClip = (posX+blockSize/2)-(entity.posX+blockSize/2);
            yClip = (posY+blockSize/2)-(entity.posY+blockSize/2)-velY; // Taking velY into account makes jumping more realistic

            // Push the object out on the side with the least intersection
            if (Math.abs(xClip)>Math.abs(yClip)) {
              if (xClip>0) {
                posX=entity.posX+blockSize;
                velX=0;
              } else {
                posX=entity.posX-blockSize;
                velX=0;
              }
            } else {
              if (yClip>0) {
                posY=entity.posY+blockSize;
                velY=0;
              } else {
                posY=entity.posY-blockSize;
                velY=0;
                onGround=true;
              }
            }
          }
        }
      }
    }
  }

  public int getType(){
    return(type);
  }

  public void addVelX(int val) {
    velX+=val;
  }

  public void addVelY(int val) {
    velY+=val;
  }

  public int getVelX() {
    return(velX);
  }

  public boolean onGround() {
    return(onGround);
  }

  public void addPosX(int val) {
    posX+=val;
  }

  public void addPosY(int val) {
    posY+=val;
  }

  public int getPosX(){
    return(posX);
  }
  
  public int getPosY() {
    return(posY);
  }

  public void setVelX(int val) {
    velX=val;
  }
  
  public void setVelY(int val){
    velY=val;
  }

  public void setPosY(int val) {
    posY=val;
  }
}
