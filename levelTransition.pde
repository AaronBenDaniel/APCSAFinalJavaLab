public class levelTransition {
  private int cooldown=30;
  private int levelID=0;
  private int amount=0;
  private level level;

  // Request transition to new level
  public void transition(level iLevel) {
    // If a transition is in progess, discard request
    if (amount!=0) return;
    level=iLevel;
    // Load new level into sceneB
    for (entity entity : level.entities) {
      entity newEntity = entity.duplicate();
      newEntity.addPosY(-1*height);
      sceneB.add(newEntity);
    }
    amount=height;
  }

  public void transitionUpdate() {
    if(cooldown>0) cooldown--;
    // If there is no more distance to move the levels, complete the transition
    if (amount<=0) {
      amount=0;
      if (sceneB.size()>0) {
        sceneA.clear();
        for (entity entity : sceneB) {
          entity.addPosY(-1*(entity.getPosY()%blockSize));
          sceneA.add(entity);
        }
        sceneB.clear();
      }
      image(background, 0, 0);
      return;
    }

    // I wanted the transition to lead in and out, so I used a quadratic equation to determine the velocity

    double a = -0.0190476;
    double b = 1.90476;
    double c = 6.66667;

    int distance=(height-amount)*100/height;

    int transition=(int)(a*Math.pow(distance, 2)+b*distance+c)+1;

    amount-=transition;

    // Move background image
    image(background, 0, height-amount);
    image(background, 0, -amount);

    // Move all the entities in sceneA down by amount
    for (entity entity : sceneA) {
      entity.addPosY(transition);
    }

    // Move all the entities in sceneB down by amount
    for (entity entity : sceneB) {
      entity.addPosY(transition);
    }

    // Move the player with the terrain
    if (player.getPosY()<height-amount-2*blockSize) {
      player.setPosY(height-amount-2*blockSize);
      player.setVelY(0);
      player.setVelX(0);
    }
  }

  public void nextLevel() {
    if(cooldown>0) return;
    cooldown=60;
    levelID++;
    if(levelID==levels.size()) levelID=0;
    transition(levels.get(levelID));
  }


  public level getLevel() {
    return(level);
  }
}
