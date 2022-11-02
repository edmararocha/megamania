Nave nave;
float bala;
ArrayList<Inimigo> inimigos;
int pointer;

void setup () {
  size(800, 600);
  noStroke();
  nave = new Nave(); // cria o objeto [nave]
  inimigos = new ArrayList<Inimigo>(); // cria a lista de objetos [inimigos]
  bala = nave.posY;
  pointer = 0; // pontuação inicial
  criarInimigos();
}

void draw () {
  background(0);
  nave.desenha(bala);
  desenhaInimigos();
  colisaoBalaInimigo();

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
  mostrarBarraDeEnergia();
}
void keyPressed () {
  if (key == ' ') {
    // Se a bala estiver na nave [atire]
    // pois a bala enquanto atirava seguia o eixo X da nave.
    if (bala == nave.posY)
      nave.atirar();
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

void colisaoBalaInimigo () {
  // faz a verificação de todos os inimigos em relação a bala
  for (int i = 0; i < inimigos.size(); i++) {
    Inimigo inimigo = inimigos.get(i);
    // se a bala colidir, remove o inimigo e "zera" a pposição da mesma
    if (bala < inimigo.posY+30 && nave.balaX > inimigo.posX && nave.balaX < inimigo.posX+40) { // posX + (largInimigo - largBala)
      println("inimigo: " + inimigo.posX);
      println("bala:" + nave.balaX);
      inimigos.remove(i); // remove o inimigo da lista de inimigos
      bala = nave.posY;
      nave.atirando = false;
      pointer+=50; // aumenta a pontuação do jogador
    }
  }
}


void mostrarBarraDeEnergia() {
  fill(200);
  rect(0, height*0.8, width, height*0.2);
  fill(50);
  textSize(16);
  text("ENERGY:", 0.3*width, height*0.855);
  fill(180);
  rect(0.8*width/2, height*0.83, 200, 20);
  fill(0, 255, 0);
  rect(0.8*width/2, height*0.83, nave.balas*2, 20);
  fill(0, 0, 255);
  textSize(30);
  text(pointer, 0.5*width, height*0.95);
}
