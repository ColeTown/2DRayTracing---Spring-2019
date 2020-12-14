ArrayList<borders> walls = new ArrayList();
ArrayList<ray> lights = new ArrayList();
int FOV = 90;
int currentDirection = 0;
PVector currentDirectionVector = PVector.fromAngle(currentDirection);
float x, y, increment;


void setup() {
  noCursor();
  size(960, 540);
  x = 0;
  y = 0;
    
  octogon();
  //pentagon();
  //randomWalls(5);

    //creation for each "ray" coming from the camera, there is one ray for each x pixel or the size of the width
  increment = (float)FOV / width;
  int count = 0;
  float halfFOV = FOV / 2.0;
  for (float angle = 0; angle < FOV; angle += increment) {
    lights.add(new ray(x, y, angle - halfFOV, count));
    count++;
  }
}

void draw() {
  background(0);
  stroke(255);
  updatePlayer();
  for (ray light : lights) {
    light.show(walls, currentDirection, x, y);
  }
  
}

  //controls
boolean[] keys = new boolean[255];
void keyPressed() {
 keys[keyCode] = true;
}
void keyReleased() {
 keys[keyCode] = false; 
}
void updatePlayer() {
 if(keys[LEFT]) { currentDirection -= 2; currentDirectionVector = PVector.fromAngle(radians(currentDirection)); }
 if(keys[RIGHT]) { currentDirection += 2; currentDirectionVector = PVector.fromAngle(radians(currentDirection)); }
 if(keys[UP]) {x += currentDirectionVector.x * 4; y += currentDirectionVector.y * 4;}
 if(keys[DOWN]) {x -= currentDirectionVector.x * 4; y -= currentDirectionVector.y * 4;}
}


void randomWalls(int x) {
  for (int i = 0; i < x; i++) {
    walls.add(new borders((int)random(width), (int)random(height), (int)random(width), (int)random(height)));
  } 
}

void octogon() {
  walls.add(new borders(696, 169, 504, 169));
  walls.add(new borders(504, 169, 369, 304));
  walls.add(new borders(369, 304, 369, 496));
  walls.add(new borders(369, 496, 504, 631));
  walls.add(new borders(504, 631, 696, 631));
  walls.add(new borders(696, 631, 831, 496));
  walls.add(new borders(831, 496, 831, 304));
  walls.add(new borders(831, 304, 696, 169));
}

void pentagon() {
  walls.add(new borders(600, 300, 505, 369));
  walls.add(new borders(505, 369, 541, 481));
  walls.add(new borders(541, 481, 659, 481));
  walls.add(new borders(659, 481, 695, 369));
  walls.add(new borders(695, 369, 600, 300));
}
