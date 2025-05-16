class level {
  public ArrayList<entity> entities;

  public level(int levelTestArray[][]) {
     int sizeX=26;
     int sizeY=16;
    
    entities = new ArrayList<entity>();
    for (int x=0; x<sizeX; x++) {
      for (int y=0; y<sizeY; y++) {
        if (levelTestArray[y][x]==NONE___) continue;
        entity entity;
        if (levelTestArray[y][x]==TRAPDOR)
          entity = new entity(x*blockSize, y*blockSize, assets.get("trapdoor"),TRAPDOR,true,false,false);
        else if(levelTestArray[y][x]==PLATFRM)
        entity = new platform(x*blockSize,y*blockSize,(x+2)*blockSize,y*blockSize,60);
        else
          entity = new entity(x*blockSize, y*blockSize, assets.get("stoneA"),TERRAIN,true,false,false);
        entity.posX=x*blockSize;
        entity.posY=y*blockSize;
        entities.add(entity);
      }
    }
  }
};
