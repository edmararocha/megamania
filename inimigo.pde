class Inimigo {
  float posX; // posição X do inimigo
  float posY; // posição Y do inimigo
  PImage imgInimigo;

  Inimigo (float x, float y) {
    posX = x;
    posY = y;
    imgInimigo = loadImage("inimigo.png");
  }

  void desenha () {
    move();
    fill(0, 0, 255);
    image(imgInimigo, posX, posY, 50, 30);
    //circle(posX, posY, 30);
  }

  void move () {
    // colisão com a lateral 
    if (posX < width-10) {
      // movimentação
      posX+=5;
    } else {
      posX = 10;
    }
  }
}
