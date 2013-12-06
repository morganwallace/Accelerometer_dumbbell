/* Stronghold Game
 * 
 * Defend the castle from the enemies!
 * Use the 'A' button on your keyboard to shoot them.
 * The game is over when the castle is too damaged.
*/

PImage stronghold_bg;
PImage explosion;
String lines[];
//String reps=0;
int previous_reps=0;


Knight knight1;
Skeleton[] skeletons;
ArrayList<Arrow> arrows;
int arrownumber = 1;

float castleborder = 190;  // X coordinate of the wall of the castle
float castlehealth;        // Health of the castle
boolean gameOn;            // If false, game is over
float gamespeed = 1.0;
float walkingspeed = 0.2;
float monster_scale = 2.0; // Scaling factor when drawing the monsters 

void setup() {
  size(640, 480);
  background(0,0,0);
  frameRate(30);
  
  castlehealth = 100;
  gameOn = true;
  
  stronghold_bg = loadImage("../../Assets/stronghold_bg.png");
  explosion = loadImage("../../Assets/explosion.png");
  
  knight1 = new Knight(100, 100);
  
  // Create array of skeletons (with random speed)
  skeletons = new Skeleton[4];
  for (int i = 0; i < skeletons.length; i++) {
    skeletons[i] = new Skeleton(width, (i+1)*100, random(0.5, 1.5), 10, i);
  }
  
  arrows = new ArrayList<Arrow>(); 
}

void draw() {
  if(gameOn) {
    image(stronghold_bg, 0, 0);
    
    drawHealthBar(10, 10, castlehealth);
  
    knight1.display();  
       
    for (int i = 0; i < skeletons.length; i++) {
      skeletons[i].display();
      skeletons[i].move();
    }
    
    for (int i = arrows.size()-1; i >= 0; i--) {
      Arrow arrow = arrows.get(i);
      arrow.display();
      arrow.move();
      if(arrow.finished()) {
        arrows.remove(i);
      }
    }
    
    
    //########## reps shoot skeletons
    
    //Load rep data from file
    lines = loadStrings("player1.txt");
    reps=Integer.parseInt(lines[0]);
    if (reps>previous_reps){
      knight1.shoot();
      previous_reps=reps;
      println(reps);
    }
    
    if(keyPressed) {
      if (key == 'a' || key == 'A') {
        knight1.shoot();
      }
    }
  
  }
  else{
    gameOver();
  }
}

void drawHealthBar (int posx, int posy, float health) { // Draws the health bar
  fill(0,230,0,200);
  noStroke();
  rect(posx, posy, posx+health, posy+10);
}

void gameOver() { // Called when game is over
  // Draw background
  image(stronghold_bg, 0, 0);

  // Draw transparent black box over it
  fill(0, 0, 0, 200);
  noStroke();
  rect(0, 0, width, height);
}
