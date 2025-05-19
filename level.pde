class level {
  public ArrayList<entity> entities;

  public level(int levelArray[][]) {
    int sizeX=26;
    int sizeY=16;

    entities = new ArrayList<entity>();
    for (int y=sizeY-1; y>=0; y--) {
      for (int x=0; x<sizeX; x++) {
        if (levelArray[y][x]==NONE___) continue;
        entity entity;
        if (levelArray[y][x]==TRAPDOR)
          entity = new entity(x*blockSize, y*blockSize, assets.get("trapdoor"), TRAPDOR, true, false, false);
        // Detect platforms and consoliate into one object
        else if (levelArray[y][x]==PLATFRM) {
          int UX=x;
          int UY=y;
          while (true) {
            if (UY>0 && levelArray[UY-1][x]==PLATFRM) {
              levelArray[UY-1][x]=NONE___;
              UY--;
              continue;
            }
            if (UX<levelArray[y].length-1 && levelArray[y][UX+1]==PLATFRM) {
              levelArray[y][UX+1]=NONE___;
              UX++;
              continue;
            }
            break;
          }
          entity = new platform(x*blockSize, UY*blockSize, UX*blockSize, y*blockSize, 120);
        } else
          entity = new entity(x*blockSize, y*blockSize, assets.get("stoneA"), TERRAIN, true, false, false);
        entity.posX=x*blockSize;
        entity.posY=y*blockSize;
        entities.add(entity);
      }
    }
  }
  
  public void add(entity entity){
    entities.add(entity);
  }
}
