import java.lang.*;

int mode = 0;
int playerWidth = 20;
int playerHeight = 20;
int holeHeight = playerHeight * 8;
int separation = playerWidth * 10;
int colWidth = playerWidth * 2;

int playerY = 0;

int score = 0;

int[] holes;
ArrayList<Rectangle> rectangles;

void setup() {
  size(640, 480);
  rectangles = new ArrayList<Rectangle>();
  
  
  holes = new int[height/holeHeight + 1];
  for(int i = 0; i < height/holeHeight; i++) {
    holes[i] = i * holeHeight;
  } 
  
  playerY = height/2;
  
  generateRectangles();
}

void draw() {
  background(0);
  if (mode == 0) {
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Flappy Gorrión", width/2, height/2);
  }
  if (mode == 1) {
    textSize(32);
    textAlign(CENTER, CENTER);
    text(score + "", width/2, 10);
    
    rect(width/2, playerY, playerWidth, playerHeight);
    
    paintRectangles();
    updateScore();
    if (score == rectangles.size() / 2) {
      mode = 3;
    }
    
    boolean collision = checkCollision();
    if (collision) {
      mode = 4;
    }
    updateRectangles();
    
    
  }
  if (mode == 2) {
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Pause", width/2, height/2);
  }
  if (mode == 3) {
    textSize(32);
    textAlign(CENTER, CENTER);
    text("WIN!", width/2, height/2);
  }
  if (mode == 4) {
    textSize(32);
    textAlign(CENTER, CENTER);
    text("LOSE!", width/2, height/2);
  }
}

void updatePlayer() {
  
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
  for(int i = 0; i < 5; i++) {
    int hole = holes[(int)random(0, holes.length - 1)];
    print(hole);
    int posX = i * (colWidth + separation) + width;
    rectangles.add(new Rectangle(posX, 0, colWidth, hole));
    rectangles.add(new Rectangle(posX, hole + holeHeight, colWidth, height - hole - holeHeight));
  }
}

void keyReleased() {
  if ((keyCode == ENTER)) {
    mode = (mode == 0) ? 1 : mode;
  }
  if ((key == ' ') && mode != 0) {
     mode = (mode == 1) ? 2 : 1;
  }
  
  if ((keyCode == UP)) {
    playerY -= (playerY <= 0) ? 0 : 20;
  }
  
  if ((keyCode == DOWN)) {
    playerY += ((playerY + playerHeight) >= height) ? 0 : 20;
  }

}
