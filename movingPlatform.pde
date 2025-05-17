class platform extends entity {
  private int limLX;
  private int limRX;
  private int limUY;
  private int limLY;
  private int duration;
  private boolean dir;

  // Main constructor
  public platform(int limLX, int limUY, int limRX, int limLY, int duration) {
    super(limRX, limLX, assets.get("platform"), PLATFRM, true, false, false);
    this.limLX=limLX;
    this.limRX=limRX;
    this.limUY=limUY;
    this.limLY=limLY;
    this.duration=duration;
    dir=false;
  }

  // Duplicate constructor
  public platform(platform platform) {
    super(platform);
    this.limLX=platform.limLX;
    this.limRX=platform.limRX;
    this.limUY=platform.limUY;
    this.limLY=platform.limLY;
    this.duration=platform.duration;
    this.dir=platform.dir;
  }

  public entity duplicate() {
    return(new platform(this));
  }

  public void physicsUpdate() {
    int xInc=(limRX-limLX);
    int yInc=(limLY-limUY);
    
    if(xInc!=0) xInc=2;
    if(yInc!=0) yInc=2;
  
    if (dir) {
      xInc*=-1;
      yInc*=-1;
    }

    this.addPosX(xInc);
    this.addPosY(yInc);

    if (this.getPosX()>=limRX && this.getPosY()>=limLY && !dir)
      dir=true;
    else if (this.getPosX()<=limLX && this.getPosY()<=limUY && dir)
      dir=false;

    super.physicsUpdate();

    if (player.getPosX()<this.getPosX()+blockSize && player.getPosX()+blockSize>this.getPosX())
      if (this.getPosY()-player.getPosY()-blockSize<=5) {
        player.addPosX(xInc);
        player.addPosY(yInc);
      }
  }
}
