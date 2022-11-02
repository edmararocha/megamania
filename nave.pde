class Nave {
  float posX; // posição Y da nave
  float posY; // posição X da nave
  int balas; // quantidade de balas
  float balaX; // recebe a posição X da bola
  boolean atirando; // atirando ou não
  PImage imgNave;

  Nave () {
    posX = width/2;
    posY = height*0.67;
    balas = 100;
    atirando = false;
    imgNave = loadImage("nave.png");
  }

  void desenha(float bala) {
    move(); // chama a movimentação para desenhar de acordo com ela.
    balaX= posX+30;
    fill(255, 0, 0);
    //rect(balaX, bala-2.5, 4, 12); -> com circle
    rect(balaX, bala+25, 4, 12);
    fill(255);
    //circle(posX, posY, 30); 
    image(imgNave, posX, posY, 60, 100);
  }

  void move () {
    // Colisões [raio + 5(valor adicionado ao mover)] -> com circle
    //if (posX > width-20) posX = width-20;
    //if (posX < 20) posX = 20;

    if (posX > width-50) posX = width-50;
    if (posX < 0) posX = 0;
    
    // Movimentação
    if (keyPressed) {
      if (keyCode == LEFT)posX-=5;
      if (keyCode == RIGHT)posX+=5 ;
    }
  }

  void atirar () {
    println(balas);
    // Se tiver balas atire
    if (balas != 0) {
      atirando = true;
      balaX = posX; // recebe a posição X no momento exato em que atirou.
    }
    balas--; 
  }
}
