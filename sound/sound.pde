import java.lang.*;
import processing.sound.*;
import gifAnimation.*;

GifMaker gifFile;

AudioIn IN;
Amplitude level;

int mode = 0;
int playerWidth = 20;
int playerHeight = 20;
int holeHeight = playerHeight * 8;
int separation = playerWidth * 12;
int colWidth = playerWidth * 2;

int MAX_SCORE = 20;

int playerY = 0;
int lastVol = 0;

int score = 0;

int[] holes;
ArrayList<Rectangle> rectangles;

void setup() {
  size(640, 480);
  
  gifFile = new GifMaker(this, "./assets/gotele-animation.gif");
  gifFile.setRepeat(0);
  
  IN = new AudioIn(this, 0);

  IN.start();
  level = new Amplitude(this);
  level.input(IN);
  
  resetGame();
}

void draw() {
  
  gifFile.addFrame();
  
  background(66,133,244);
  if (mode == 0) {
    textSize(64);
    fill(255);
    textAlign(CENTER, CENTER);
    text("Flappy Gorrión", width/2, height/4);
    
    textSize(24);
    text("The objective is to score 20.\nUse your voice to control the box.\n ", width/2, height/2);
    textSize(32);
    text("Press ENTER to start", width/2, height - 50);
  }
  
  if (mode == 1) {
    textSize(32);
    textAlign(CENTER, CENTER);
    fill(244,160,0);
    text(score + "", width/2, 20, -1);
    fill(255);
    updatePlayer();
    
    
    rect(width/2, playerY, playerWidth, playerHeight);
    fill(15,157,88);
    paintRectangles();
    updateScore();
    if (score == rectangles.size() / 2) {
      mode = 3;
      resetGame();
    }
    
    boolean collision = checkCollision();
    if (collision) {
      mode = 4;
      resetGame();
    }
    updateRectangles();    
  }  
  if (mode == 3) {
    fill(255);
    textSize(64);
    textAlign(CENTER, CENTER);
    text("YOU WIN!", width/2, height/3);
    
    textSize(32);
    text("Press ENTER to go back to menu", width/2, height/2);
  }
  
  if (mode == 4) {
    textSize(64);
    fill(255);
    textAlign(CENTER, CENTER);
    text("YOU LOSE!", width/2, height/3);
    
    textSize(32);
    text("Press ENTER to go back to menu", width/2, height/2);
  }
}

void updatePlayer() {
  float volume = level.analyze() * 3;
  volume  = (volume > 1) ? 1 : volume; 
  
  if (volume >= 0.90 ) { playerY -= 20; }
  else if (volume >= 0.75 ) { playerY -= 10; }
  else if (volume >= 0.5) { playerY -= 5; }
  else if (volume >= 0.25) { playerY -= 0; }
  else if (volume >= 0.10) { playerY += 5; }
  else if (volume >= 0) { playerY += 10; }

  // playerY = (int)(height - (volume * height));
  playerY = ((playerY + playerHeight) >= height) ? height - playerHeight : playerY;
  playerY = ((playerY) <= 0) ? 0 : playerY;
  
  
  
}

void resetGame() {
  rectangles = new ArrayList<Rectangle>();
  
  holes = new int[height/holeHeight + 1];
  for(int i = 0; i < height/holeHeight; i++) {
    holes[i] = i * holeHeight;
  } 
  
  score = 0;
  playerY = height/2;
  
  generateRectangles();
}

boolean checkCollision() {
  if (score == rectangles.size() / 2) { return false; }
  
  Rectangle topBar = rectangles.get(score * 2);
  Rectangle botBar = rectangles.get(score * 2 + 1);
  
  if (topBar.x < width/2 + playerWidth && topBar.x + topBar.w > width/2) {
    if ((topBar.y + topBar.h ) > playerY) {
      return true;
    }
    
    if ((botBar.y) < playerY + playerHeight) {
      return true;
    }
  }
  
  return false;
}

void updateScore() {
  for(int i = 0; i < rectangles.size(); i++) {
    Rectangle currentRect = rectangles.get(i);
    if (currentRect.x + currentRect.w > width/2) {
      score = i / 2;
      return;
    }
  }
  score = rectangles.size() / 2;
}

void updateRectangles() {
  for(int i = 0; i < rectangles.size(); i++) {
    Rectangle currentRect = rectangles.get(i);
    currentRect.x -= 2;
  }
}

void paintRectangles() {
  pushMatrix();
  for(int i = 0; i < rectangles.size(); i++) {
    Rectangle currentRect = rectangles.get(i);
    rect(currentRect.x, currentRect.y, currentRect.w, currentRect.h); 
  }
  popMatrix();
}

void generateRectangles() {
  for(int i = 0; i < MAX_SCORE; i++) {
    int hole = holes[(int)random(0, holes.length - 1)];
    int posX = i * (colWidth + separation) + width;
    rectangles.add(new Rectangle(posX, 0, colWidth, hole));
    rectangles.add(new Rectangle(posX, hole + holeHeight, colWidth, height - hole - holeHeight));
  }
}

void keyReleased() {
  if ((keyCode == ENTER)) {
    mode = (mode == 0) ? 1 : (mode == 3 || mode == 4) ? 0 : mode;
  }  
  if ((keyCode == UP)) {
    playerY -= (playerY <= 0) ? 0 : 20;
  }
  
  if ((keyCode == DOWN)) {
    playerY += ((playerY + playerHeight) >= height) ? 0 : 20;
  }

}
