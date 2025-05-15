class player extends entity{
  public player(int posX,int posY,PImage sprite){
    super(posX,posY,sprite,PLAYER_);
  }
  
  public void physicsUpdate(){
    super.physicsUpdate();
    if(aPressed && getVelX()>-7) addVelX(-2);
    if(dPressed && getVelX()<7) addVelX(2);
    if(wPressed && onGround()) addVelY(-15);
    if (this.getPosY()<10) {
      transition.nextLevel();
    }
  }
}
