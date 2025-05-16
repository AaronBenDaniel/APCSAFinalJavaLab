class platform extends entity{
 private int limRX;
 private int limLX;
 private int limUY;
 private int limLY;
 private int duration;
 private boolean dir;
  
  // Main constructor
  public platform(int limRX,int limUY,int limLX,int limLY,int duration){
   super(limRX,limLX,assets.get("platform"),PLATFRM,true,false,false);
   this.limRX=limRX;
   this.limLX=limLX;
   this.limUY=limUY;
   this.limLY=limLY;
   this.duration=duration;
   dir=false;
  }
  
  // Duplicate constructor
  // NOT FINISHED: FINISH THIS FIRST!
  public entity(entity entity) {
    ID=++IDCounter;
    this.posX=entity.posX;
    this.posY=entity.posY;
    this.sprite=entity.sprite;
    this.type=entity.type;
    this.ignoreGravity=entity.ignoreGravity;
    this.screenCollision=entity.screenCollision;
    this.entityCollision=entity.entityCollision;
  }
  
  public void physicsUpdate(){    
   int xInc=(limLX-limRX)/duration;
   int yInc=(limLY-limUY)/duration;
   
   System.out.println(xInc);

   if(dir){
     xInc*=-1;
     yInc*=-1;
   }
   
   this.addPosX(xInc);
   this.addPosY(yInc);
   
   if(this.getPosX()>=limLX) dir=true;
   else if(this.getPosX()<=limRX) dir=false;
   
   super.physicsUpdate(); 
  }
}
