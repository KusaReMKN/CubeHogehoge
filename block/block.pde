//
//ラケットの初期位置設定
int mx = 150;//ラケットのｘ座標をウィンドウの真ん中に設定(あとでmx = mouseXとする)
int my = 360;//ラケットのy座用を設定(ずっと一定のまま)

//ボールの初期位置設定
float bx = 150;//ボールのx座標をウィンドウの真ん中に設定
float by = 120;//ボールのy座標を設定


float lv =3;  //ボールの速さを設定
float bsx = lv;//ボール横向きの速さ
float bsy = lv;//ボール縦向きの速さ

int blockX = 10;//ブロック横方向の数
int blockY = 4;//ブロック縦方向の数
//ブロックそれぞれを配列するよ
int [] blf = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1};

int score = 0;//最初のスコア設定

void setup () {
  size (300, 400);
}




void draw() {
  mx = mouseX;
  
//ラケットにあったったら進行方向逆転
//壁にあったったら進行方向逆転させよう
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


  background (200, 255, 255);//背景設定
  rectMode(CENTER);//四角の中心を真ん中に
  ellipseMode(CENTER);円の中心を真ん中に
  
  //ラケットの設定
  fill (0, 0, 255);
  rect (mx, my, 50, 10);
  ellipse (bx, by, 15, 15);
//ブロックの生成
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
