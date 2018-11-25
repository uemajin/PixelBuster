require "janela"

-- Jogador 1

player1 = love.graphics.newImage("jogadores/player1.png");
  
player1_x = 30;
player1_y = altura_tela/2;
player1_vel = 250;
  
player1_largura = player1:getWidth();
player1_altura = player1:getHeight();

centro1 = (player1_largura/2) + (player1_altura/2);

-- Jogador 2

player2 = love.graphics.newImage("jogadores/player2.png");
  
player2_x = largura_tela - 75;
player2_y = altura_tela / 2;
player2_vel = 250;
  
player2_largura = player2:getWidth();
player2_altura = player2:getHeight();

player2_xf = player2_x + 48
player2_yf = player2_y + 45
  
centro2 = (player2_largura/2) + (player2_altura/2);

-- Balas

bala1 = love.graphics.newImage("res/bala1.png");
bala1_x = player1_x + player1_largura
bala1_y = player1_y + player1_altura / 2;

bala1_largura = bala1:getWidth();
bala1_altura = bala1:getHeight();
  
bala2 = love.graphics.newImage("res/bala2.png");
bala2_x = player2_x
bala2_y = player2_y + player2_altura / 2

bala2_largura = bala2:getWidth();
bala2_altura = bala2:getHeight();

som_bala = love.audio.newSource("musica/tiro.wav","static")
