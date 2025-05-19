class player extends entity{
  private int jumpCounter;
  
  public player(int posX,int posY,PImage sprite){
    super(posX,posY,sprite,PLAYER_);
    jumpCounter=0;
    // Make sure the player starts facing right
    this.setVelX(1);
    this.draw();
    this.setVelX(0);
  }
  
  public void physicsUpdate(){
    if(jumpCounter>0) jumpCounter--;
    super.physicsUpdate();
    if(aPressed && getVelX()>-7) addVelX(-2);
    if(dPressed && getVelX()<7) addVelX(2);
    if(wPressed && onGround() && jumpCounter==0){
      addVelY(-15);
      jumpCounter=15;
    }
    if (this.getPosY()<10) {
      transition.nextLevel();
    }
  }
}
