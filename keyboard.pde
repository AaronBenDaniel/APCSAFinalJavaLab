// Processing does keypresses weird

boolean wPressed = false;
boolean aPressed = false;
boolean dPressed = false;
boolean qPressed = false;
boolean ePressed = false;

void keyPressed() {
  if (key=='w') wPressed=true;
  else if (key=='a') aPressed=true;
  else if (key=='d') dPressed=true;
  else if (key=='q') {
    qPressed=true;
    player.addPosX(-1);
  } else if (key=='e') {
    ePressed=true;
    player.addPosX(1);
  }
  else if(key=='t') transition.nextLevel();
}

void keyReleased() {
  if (key=='w') wPressed=false;
  else if (key=='a') aPressed=false;
  else if (key=='d') dPressed=false;
  else if (key=='q') qPressed=false;
  else if (key=='e') ePressed=false;
}

void printKeys() {
  fill(255, 0, 0);
  textAlign(LEFT);
  text("W: "+wPressed+"\nA: "+aPressed+"\nD: "+dPressed+"\nQ: "+qPressed+"\nE: "+ePressed+"\nSceneA: "+sceneA.size()+"\nSceneB: "+sceneB.size(), 0, 10); // There's also some other debug stuff
}
