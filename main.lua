require "players"
require "janela"

function love.load(arg)
  
  -- Versão
  vers = "por: Uema"

  -- Carrega o Background
  background = love.graphics.newImage("res/bgt.png");
  bgrot = 0
  
  -- Contadores
  tiro_cont = 0;
  tiro2_cont = 0;
  hp_1 = 30;
  hp_2 = 30;
  player1_vivo = 1;
  player2_vivo = 1;
  rip_p = 1; -- Som de explosão 
  game_over = 0; -- Algum Player Morreu
  
end


function love.keypressed(key)
  -- Atalho de Finalizar o Jogo
  if key == "escape" then
    love.event.quit();
  end
  
  -- Atalho de Reiniciar o Jogo
  if key == "r" then
    if game_over == 1 then
      hp_1 = 30
      hp_2 = 30
      player1_vivo = 1
      player2_vivo = 1
      rip_p = 1
      game_over = 0
      player2_x = largura_tela - 75;
      player2_y = altura_tela / 2;
      player1_x = 30;
      player1_y = altura_tela/2;
    end
  end

  -- Controle dos Tiros
  if game_over == 0 then
    
    -- Contador Tiro 1
    if player1_vivo == 1 then
      if key == "space" then
        if tiro_cont == 0 then
          som_bala:play()
          tiro_cont = 1
        end
        if tiro_cont == 1 then
        end
      end
    end
    
    -- Contador Tiro 2
    if player2_vivo == 1 then
      if key == "rctrl" then
        if tiro2_cont == 0 then
          som_bala:play()
          tiro2_cont = 1
        end
        if tiro2_cont == 1 then
        end
      end
    end
  end
end

function love.update(dt)
  
  -- Controle de Morte do jogador
  if hp_1 <= 0 then
    player1_vivo = 0
    game_over = 1
    if rip_p == 1 then
      som_rip:play()
      rip_p = 0
    end
  end
  if hp_2 <= 0 then
    player2_vivo = 0
    game_over = 1
    if rip_p == 1 then
      som_rip:play()
      rip_p = 0
    end
  end
  
  -- Variáveis das balas
  bala1_xf = bala1_x + bala1_largura
  bala2_xf = bala2_x + bala2_largura
  
  -- Controle dos Jogadores
  if game_over == 0 then
  
    -- Controles Jogador 1
    if player1_vivo == 1 then
      
      -- Controle de esquerda/direita Jogador 1
      if (love.keyboard.isDown("d")) then
        player1_x = player1_x + dt * player1_vel;
      elseif (love.keyboard.isDown("a")) then
        player1_x = player1_x - dt * player1_vel;
      end
      
      -- Controle de cima/baixo Jogador 1
      if (love.keyboard.isDown("w")) then
        player1_y = player1_y - dt * player1_vel;
      elseif (love.keyboard.isDown("s")) then
        player1_y = player1_y + dt * player1_vel
      end
      
      -- Controle de tela no eixo x do Jogador 1
      if player1_x < 0 then
        player1_x = 0
      elseif player1_x > (largura_tela/2) - 150 then
        player1_x = (largura_tela/2) - 150
      end
      
      -- Controle de tela no eixo y do Jogador 1
      if player1_y < 0 then
        player1_y = 0
      elseif player1_y > altura_tela - 45 then
        player1_y = altura_tela - 45
      end
    end
    
    -- Controles Jogador 2
    if player2_vivo == 1 then
      
      -- Controle de esquerda/direita Jogador 2
      if (love.keyboard.isDown("right")) then
        player2_x = player2_x + dt * player2_vel;
      elseif (love.keyboard.isDown("left")) then
        player2_x = player2_x - dt * player2_vel;
      end

      -- Controle de cima/baixo Jogador 2
      if (love.keyboard.isDown("up")) then
        player2_y = player2_y - dt * player2_vel;
      elseif (love.keyboard.isDown("down")) then
        player2_y = player2_y + dt * player2_vel;
      end
      
      -- Controle de tela no eixo x do Jogador 2
      if player2_x < (largura_tela/2) + 100 then
        player2_x = (largura_tela/2) + 100
      elseif player2_x > largura_tela - 48 then
        player2_x = largura_tela - 48
      end
      
      -- Controle de tela no eixo y do Jogador 2
      if player2_y < 0 then
        player2_y = 0
      elseif player2_y > altura_tela - 45 then
        player2_y = altura_tela - 45
      end
    end
  end
  
  -- Controle do tiro 1
  if tiro_cont == 0 then
    bala1_y = player1_y + player1_altura / 2;
    bala1_x = player1_x + player1_largura
  end
  if tiro_cont == 1 then
    bala1_x = bala1_x + 20
    bala1_y = bala1_y
    if bala1_x > largura_tela then
      tiro_cont = 0
    end
  end
  
  -- Controle do tiro 2
  if tiro2_cont == 0 then
    bala2_x = player2_x
    bala2_y = player2_y + player2_altura / 2  
  end
  if tiro2_cont == 1 then
    bala2_x = bala2_x - 20
    bala2_y = bala2_y
    if bala2_x < 0 then
      tiro2_cont = 0
    end
  end
  
  -- Colisão
  player1_xf = player1_x + 48
  player1_yf = player1_y + 45
  
  if player1_vivo == 1 then
    if bala2_xf > player1_x and bala2_xf < player1_xf then
      if bala2_y > player1_y and bala2_y < player1_yf then
        hp_1 = hp_1 - 1
        som_exp:play()
        end
    end
  end
  
  
  -- Pontos de colisão Jogador 2
  player2_xf = player2_x + 48
  player2_yf = player2_y + 45

  if player2_vivo == 1 then
    if bala1_xf > player2_x and bala1_xf < player2_xf then
      if bala1_y > player2_y and bala1_y < player2_yf then
        hp_2 = hp_2 - 1
        som_exp:play()
      end
    end
  end
  
  -- Spin do background
  bgrot = bgrot + 0.00001
  
end

function love.draw()
   
  -- Limpa a tela
  love.graphics.clear(0, 0, 0, 255);
  
  -- Mantém a fonte
  love.graphics.setFont(texto_medio)
  
  -- Desenha o Background
  love.graphics.draw(background,largura_tela/2,altura_tela/2,math.deg(bgrot),1,1,background:getWidth()/2,background:getHeight()/2)
  
  -- Print Strings
  love.graphics.print(vers,largura_tela/16,(altura_tela/2)+(altura_tela/3)+(altura_tela/11))
  love.graphics.print("PIXELBUSTER",largura_tela/3,0)
  love.graphics.print(hp_1,largura_tela/6.5,0)
  love.graphics.print(hp_2,largura_tela/1.2,0)
  
  -- Retorna o final de jogo
  if game_over == 1 then
    if player1_vivo == 1 then
      love.graphics.print("Jogador 1 Ganhou!",largura_tela/3.6,altura_tela/3)
    end
    if player2_vivo == 1 then
      love.graphics.print("Jogador 2 Ganhou!",largura_tela/3.6,altura_tela/3)
    end
    love.graphics.print("Pressione 'r' para reiniciar o jogo",largura_tela/13,altura_tela/3 + altura_tela/3)
  end

  -- Desenha os jogadores
  if player1_vivo == 1 then
    love.graphics.draw(player1, player1_x, player1_y);
  end
  if player2_vivo == 1 then
    love.graphics.draw(player2, player2_x, player2_y);
  end
    
  -- Desenha os tiros
  if tiro_cont == 1 then
    love.graphics.draw(bala1,bala1_x,bala1_y)
  end
  if tiro2_cont == 1 then
    love.graphics.draw(bala2,bala2_x,bala2_y)
  end
end