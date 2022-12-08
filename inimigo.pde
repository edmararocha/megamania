class Inimigo {
  float posX; // posição X do inimigo
  float posY; // posição Y do inimigo
  PImage imgInimigo;
 
  int velocidade; // [new] para ser usada para diminuir a velocidade dos inimigos

  Inimigo (float x, float y) {
    posX = x;
    posY = y;
    velocidade = 5;
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
      posX+=velocidade;
    } else {
      posX = 10;
    }
  }
}

// adiciona os inimigos ao array
void criarInimigos () {
  for (int i = 0; i < 5; i++) { // quantidade de inimigos por linha
    for (int j = 0; j < 3; j++ ) { // quantidade de linhas
      if (j%2 == 0) { // gera a alternância na posição dos inimigos de cada linha
        inimigos.add(new Inimigo((150*i)-75, (60*j)+ 50));
      } else {
        inimigos.add(new Inimigo(150*i, (60*j)+ 50));
      }
    }
  }
}

void desenhaInimigos () {
  // percorre o array de inimigos e desenha cada um
  for (int i = 0; i < inimigos.size(); i++) {
    Inimigo inimigo = inimigos.get(i);
    inimigo.desenha();
  }
}
