// Processing does keypresses weird

boolean wPressed = false;
boolean aPressed = false;
boolean dPressed = false;

void keyPressed() {
  if (key=='w') wPressed=true;
  else if (key=='a') aPressed=true;
  else if (key=='d') dPressed=true;
  //else if (key=='q') player.entity.posX-=1;
  //else if (key=='e') player.entity.posX+=1;
  //else if(key=='t') player.nextLevel();
}

void keyReleased() {
  if (key=='w') wPressed=false;
  else if (key=='a') aPressed=false;
  else if (key=='d') dPressed=false;
}

void printKeys(){
  fill(255, 0, 0);
  textAlign(LEFT);
  text("W: "+wPressed+"\nA: "+aPressed+"\nD: "+dPressed, 0, 10);
}
