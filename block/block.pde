int mx = 150;
int my = 360;

float bx = 150;
float by = 120;

float lv = 3;
float bsx = lv;
float bsy = lv;

int blockX = 10;
int blockY = 4;
int [] blf = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};

int score = 0;

void setup () {
  size (300, 400);
}




void draw() {
  mx = mouseX;
  
  lv = 3 + score /500;
  bx = bx + bsx;
  by = by + bsy;

  if (bx < 0) {
    bsx = lv;
  }
  if (bx > width) {
    bsx = -lv;
  }

  if (by < 0) {
    bsy = lv;
  }
  
  if (by > height) {
    mx = 150;
    my = 360;

    by = 120;

    lv = 3 + score /500;
    bsx = lv;
    bsy = lv;

    blockX = 10;
    blockY = 4;

    score -= 500;
    
  }
  
  if (score < 0) score = 0;
  


  if (bx > mx-25 && bx < mx+25 && by > my-15 && by < my+15) {
    bsy = -lv;
  }

  for (int j = 0; j < blockY; j++) {

    for (int i = 0; i < blockX; i++) {
      if (blf[j* blockX + i] == 1 && bx > (((width/blockX) * i) - (width/blockX/2)) && bx < (((width/blockX) * i) + (width/blockX/2)) && by < 20 + (j * 20)) {
        blf[j* blockX + i] = 0;
        bsy = lv;
        score += 100;
      }
    }
  }


  background (200, 255, 255);
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  
  fill (0, 0, 255);
  rect (mx, my, 50, 10);
  ellipse (bx, by, 15, 15);

  for (int j = 0; j < blockY; j++) {

    for (int i = 0; i < blockX; i++) {
      rectMode(CORNER);
      
      fill (0, 125 + i*10 + j*20, 255 - i*10 - j*20);
      if (blf[j* blockX + i] == 1) rect ((width/blockX) * i, j * 20, width/blockX, 20);
    }
  }
  fill (0);
  textSize(22);
  text("Score : "+score, 10, 390);
}
