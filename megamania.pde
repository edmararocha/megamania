Nave nave;
ArrayList<Inimigo> inimigos;
ArrayList<PowerUp> powerUps;
float bala;
int pointer;
PFont fontAtari;

void setup () {
  size(800, 600);
  noStroke();
  nave = new Nave(); // cria o objeto [nave]
  inimigos = new ArrayList<Inimigo>(); // cria a lista de objetos [inimigos]
  powerUps = new ArrayList<PowerUp>();
  bala = nave.posY;
  pointer = 0; // pontuação inicial
  criarInimigos();
  fontAtari = createFont("AtariSmall.otf", 50);
  textFont(fontAtari, 50);
}

void draw () {
  if (pointer < 750) {
    background(0);
    desenhaPowerUps();
    desenhaInimigos();
    nave.desenha(bala);
    colisaoBalaInimigo();
    colisaoPowerUpNave();

    if (nave.atirando) {
      // Não deixa a bola sair da tela [em Y] | até a altura onde existem inimigos
      if (bala > height*0.05) {
        bala-=10;
      } else {
        // "zera" a posição da Bala
        bala = nave.posY;
        nave.atirando = false;
      }
    } else {
      // Para que a bala volte a posição X onde a nave está.
      nave.balaX = nave.posX;
    }

    if (powerUps.size() > 0) {
      for (int i = 0; i < powerUps.size(); i++) {
        PowerUp powerUp = powerUps.get(i);
        if (powerUp.active == true) powerUp.activePU();
        if (powerUp.finish == true) powerUps.remove(powerUp);
      }
    }
    mostrarBarraDeEnergia();
  } else {
    background(0, 0, 255);
    textSize(100);
    fill(255);
    text("YOU WIN!", width/4, height/1.8);
  }
}
void keyPressed () {
  if (key == ' ') {
    // Se a bala estiver na nave [atire]
    // pois a bala enquanto atirava seguia o eixo X da nave.
    if (bala == nave.posY)
      nave.atirar();
  }
}

void colisaoBalaInimigo () {
  // faz a verificação de todos os inimigos em relação a bala
  for (int i = 0; i < inimigos.size(); i++) {
    Inimigo inimigo = inimigos.get(i);
    // se a bala colidir, remove o inimigo e "zera" a pposição da mesma
    if (bala < inimigo.posY+30 && nave.balaX > inimigo.posX && nave.balaX < inimigo.posX+40) { // posX + (largInimigo - largBala)
      criarPowerUp(inimigo.posX, inimigo.posY);
      inimigos.remove(i); // remove o inimigo da lista de inimigos
      bala = nave.posY;
      nave.atirando = false;
      pointer+=50; // aumenta a pontuação do jogador
    }
  }
}

void colisaoPowerUpNave () {
  for (int i = 0; i < powerUps.size(); i++) {
    PowerUp powerUp = powerUps.get(i);
    if (powerUp.posX > nave.posX && powerUp.posX < nave.posX+60 && powerUp.posY > nave.posY+30 && powerUp.posY < nave.posY+100) {
      powerUp.active = true;
      powerUp.posY = height*0.9;
    }
  }
}

void mostrarBarraDeEnergia() {
  fill(200);
  rect(0, height*0.8, width, height*0.2);
  fill(50);
  textSize(16);
  text("ENERGY:", 0.32*width, height*0.95);
  fill(180);
  rect(0.82*width/2, height*0.925, 200, 20);
  fill(0, 255, 0);
  rect(0.82*width/2, height*0.925, nave.balas*2, 20);
  fill(0, 0, 255);
  textSize(30);
  fill(0, 0, 100);
  text("SCORE: " + pointer, 0.4*width, height*0.87);
}
