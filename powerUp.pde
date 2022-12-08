class PowerUp {
  int powerUps[] = {0, 1, 2};
  int pU;
  float posX;
  float posY;
  boolean active;
  boolean finish;
  int temp;

  PowerUp (float x, float y) {
    this.posX = x;
    this.posY = y;
    pU = int(random(powerUps.length));
    temp = 0;
  }

  void checkPU () {
    switch (pU) {
    case 1:
      fill(0, 255, 0);
      break;
    case 2:
      fill(255, 0, 0);
      break;
    default:
      fill(0);
      active = false;
    }
  }

  void desenha () {
    checkPU();
    if (posY < (height*0.8)+20) {
      rect(posX, posY, 20, 20);
      posY+=3;
    }
  }

  void activePU () {
    switch (pU) {
    case 1:
      powerUpNave(nave);
      break;
    case 2:
      powerUpInimigo(inimigos);
      break;
    }
  }

  void powerUpNave (Nave nave) {
    if (temp < 300) {
      nave.velocidade = 10;
      temp++;
    } else {
      nave.velocidade = 5;
      this.finish = true;
      temp = 0;
    }
    fill(200);
    rect(width*0.78, height*0.55, 150, 80);
    fill(0, 255, 0);
    rect(width*0.855, height*0.57, 20, 20);
    fill(0);
    if (temp > 0)rect(width*0.8, height*0.65, (300-temp)/2.5, 10);
  }

  void powerUpInimigo (ArrayList<Inimigo> inimigos) {
    if (temp < 300) {
      for (int i = 0; i < inimigos.size(); i++) {
        Inimigo inimigo = inimigos.get(i);
        inimigo.velocidade = 2;
      }
      temp++;
    } else {
      for (int i = 0; i < inimigos.size(); i++) {
        Inimigo inimigo = inimigos.get(i);
        inimigo.velocidade = 5;
      }
      this.finish = true;
      temp = 0;
    }
    fill(200);
    rect(width*0.02, height*0.55, 150, 80);
    fill(255, 0, 0);
    rect(width*0.103, height*0.57, 20, 20);
    fill(0);
    if (temp > 0)rect(width*0.04, height*0.65, (300-temp)/2.5, 10);
  }
}

// Desenhar PowerUps
void desenhaPowerUps () {
  for (int i = 0; i < powerUps.size(); i++) {
    PowerUp powerUp = powerUps.get(i);
    powerUp.desenha();
  }
}

// Criar um PowerUp
void criarPowerUp (float x, float y) {
  PowerUp powerUp = new PowerUp(x+15, y);
  if (powerUp.pU != 0) powerUps.add(powerUp);
  powerUp.desenha();
}
