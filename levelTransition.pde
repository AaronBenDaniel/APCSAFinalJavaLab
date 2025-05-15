public class levelTransition {
  private int amount=0;
  private level level;

  // Request transition to new level
  public void transition(level iLevel) {
    // If a transition is in progess, discard request
    if (amount!=0) return;
    level=iLevel;
    // Load new level into sceneB
    for (entity entity : level.entities) {
      entity newEntity = new entity(entity);
      newEntity.addPosY(-1*height);
      sceneB.add(newEntity);
    }
    amount=height;
  }

  public void transitionUpdate() {
    // If there is no more distance to move the levels, complete the transition
    if (amount<=0) {
      amount=0;
      if (sceneB.size()>0) {
        sceneA.clear();
        sceneB.clear();
        for (entity entity : level.entities) {
          sceneA.add(new entity(entity));
        }
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
    transition((transition.getLevel()==levelB)?levelA:levelB);
  }


  public level getLevel() {
    return(level);
  }
}
