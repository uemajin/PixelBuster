require "players"
require "janela"

function love.load(arg)
  
  -- Versão
  vers = "1.1"
  love.window.setTitle("Choose your language")

  -- Carrega o Background
  background = love.graphics.newImage("res/bgt.png");
  bgrot = 0
  
  -- Contadores
  tiro_cont = false;
  tiro2_cont = false;
  hp_1 = 30;
  hp_2 = 30;
  player1_vivo = true;
  player2_vivo = true;
  rip_p = true; -- Som de explosão 
  game_over = false; -- Algum Player Morreu
  game_start = false; -- Começa o Game
  idiomas = true; -- Menu de idiomas
  alfa = 0; -- fade do background
  sobe_alfa = true; -- Controle do alfa
  desce_alfa = false;
  sonzin_menu = true;
  clicker = true;
  c_br = true
  c_jp = true
  c_us = true
  string_selecionada = true
  
end

function love.mousepressed(x, y, button, istouch, presses)
  if clicker then
    if idiomas then
      if not sobe_alfa then
        if button == 1 then
          -- Brazil flag
          if x <= (largura_tela/4) + 65 and x >= (largura_tela/4) - 63 and y >= (altura_tela/1.6) and y <= (altura_tela/1.6) + 84 then
            confirma_br = true
            som_menu_select:play()
            clicker = false
          -- USA flag
          else if x <= (largura_tela/2) + 65 and x >= (largura_tela/2) - 63 and y >= (altura_tela/1.6) and y <= (altura_tela/1.6) + 84 then
            confirma_us = true
            som_menu_select:play()
            clicker = false
          -- Japan flag
          else if x <= (largura_tela*(3/4)) + 65 and x >= (largura_tela*(3/4)) - 63 and y >= (altura_tela/1.6) and y <= (altura_tela/1.6) + 84 then
            confirma_jp = true
            som_menu_select:play()
            clicker = false
              end
            end
          end
        end
      end
    end 
  end
end

function testealfa()
   -- Fade do background (Menu Idioma)
   alfa = 0
  while alfa <= 2 do
    alfa = alfa + 0.1
  end
end
  

function love.keypressed(key)
  -- Atalho de Finalizar o Jogo
  if key == "escape" then
    love.event.quit();
  end
  
  -- Atalho de Reiniciar o Jogo
  if key == "r" then
    if game_over then
      hp_1 = 30
      hp_2 = 30
      player1_vivo = true
      player2_vivo = true
      rip_p = true
      game_over = false
      menu_set = false
      player2_x = largura_tela - 75;
      player2_y = altura_tela / 2;
      player1_x = 30;
      player1_y = altura_tela/2;
    end
  end

if game_start then -- Verifica se o game começou

  -- Controle dos Tiros
  if not game_over then
    
      -- Contador Tiro 1
      if player1_vivo then
        if key == "space" then
          if not tiro_cont then
            som_bala:play()
            tiro_cont = true
          end
          if tiro_cont then
          end
        end
      end
      
      -- Contador Tiro 2
      if player2_vivo then
        if key == "m" then
          if not tiro2_cont then
            som_bala:play()
            tiro2_cont = true
          end
          if tiro2_cont then
          end
        end
      end
    end
  end
end

function love.update(dt)
  
  -- Retorna posição do mouse
  mouse_x, mouse_y = love.mouse.getPosition()
  
  -- String do menu de idiomas
  
  -- String BR
if string_selecionada then

    if mouse_x <= (largura_tela/4) + 65 and mouse_x >= (largura_tela/4) - 63 and mouse_y >= (altura_tela/1.6) and mouse_y <= (altura_tela/1.6) + 84 then
      
      string_idioma_br = true
      string_idioma_en = false
      string_idioma_jp = false
    end
    
    if mouse_x <= (largura_tela/2) + 65 and mouse_x >= (largura_tela/2) - 63 and mouse_y >= (altura_tela/1.6) and mouse_y <= (altura_tela/1.6) + 84 then
      
      string_idioma_br = false
      string_idioma_en = true
      string_idioma_jp = false   
    end
      
    if mouse_x <= (largura_tela*(3/4)) + 65 and mouse_x >= (largura_tela*(3/4)) - 63 and mouse_y >= (altura_tela/1.6) and mouse_y <= (altura_tela/1.6) + 84 then
      
      string_idioma_br = false
      string_idioma_en = false
      string_idioma_jp = true
    end
    
end
  -- Nome da janela
  if lingua == "pt-br" or lingua == "en-us" then
    love.window.setTitle("Pixel Buster")
  end

  if lingua == "np-jp" then
    love.window.setTitle("ピクセルバスター")
  end
  
  -- Confirmação de lingua
  if confirma_br then
    
    lingua = 'pt-br'
    bandeira_brazil = false
    if c_br then
    desce_alfa = true
    c_br = false
    end
    
  end
    
  if confirma_us then
    
    lingua = 'en-us'
    bandeira_usa = false
    if c_us then
    desce_alfa = true
    end
    
  end
    
  if confirma_jp then
    
    lingua = 'np-jp'
    bandeira_japan = false
    if c_jp then
    desce_alfa = true
    end
    
  end
  
  if game_start then
    
    -- Controle de Morte do jogador
    if hp_1 <= 0 then
      player1_vivo = false
      game_over = true
      if rip_p then
        som_rip:play()
        rip_p = false
      end
    end
    if hp_2 <= 0 then
      player2_vivo = false
      game_over = true
      if rip_p then
        som_rip:play()
        rip_p = false
      end
    end
    
    -- Variáveis das balas
    bala1_xf = bala1_x + bala1_largura
    bala2_xf = bala2_x + bala2_largura
    
    -- Controle dos Jogadores
    if not game_over then
    
      -- Controles Jogador 1
      if player1_vivo then
        
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
      if player2_vivo then
        
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
    if not tiro_cont then
      bala1_y = player1_y + player1_altura / 2;
      bala1_x = player1_x + player1_largura
    end
    if tiro_cont then
      bala1_x = bala1_x + 20
      bala1_y = bala1_y
      if bala1_x > largura_tela then
        tiro_cont = false
      end
    end
    
    -- Controle do tiro 2
    if not tiro2_cont then
      bala2_x = player2_x
      bala2_y = player2_y + player2_altura / 2  
    end
    if tiro2_cont then
      bala2_x = bala2_x - 20
      bala2_y = bala2_y
      if bala2_x < 0 then
        tiro2_cont = false
      end
    end
    
    -- Colisão
    player1_xf = player1_x + 48
    player1_yf = player1_y + 45
    
    if player1_vivo then
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

    if player2_vivo then
      if bala1_xf > player2_x and bala1_xf < player2_xf then
        if bala1_y > player2_y and bala1_y < player2_yf then
          hp_2 = hp_2 - 1
          som_exp:play()
        end
      end
    end
  end
  
  -- Spin do background
  bgrot = bgrot + 0.00001
  
  -- Fade do background (Menu Idioma)
  if sobe_alfa then
    alfa = alfa + (dt)
    if alfa >= 2 then
      sobe_alfa = false
    end
  end
  
  -- Unfade do background (Menu Idioma)
  if desce_alfa then
    alfa = alfa - (dt)
    if alfa <= 0 then
      desce_alfa = false
      bandeira_brazil = false
      bandeira_japan = false
      bandeira_usa = false
      string_selecionada = false
      string_idioma_br = false
      string_idioma_en = false
      string_idioma_jp = false
      menu_set = true
      sobe_alfa = true
    end
  end
  
   -- Mostrar menu
  if menu_set then
  end
  
end

function love.draw()
   
  -- Limpa a tela
  love.graphics.clear(0, 0, 0, 255);
  
  -- Mantém a fonte
  love.graphics.setFont(texto_medio)
  
  -- Desenha o Background
  love.graphics.setColor(255, 255, 255, alfa)
  love.graphics.draw(background,largura_tela/2,altura_tela/2,math.deg(bgrot),1,1,background:getWidth()/2,background:getHeight()/2)
  
  -- Desenha os idiomas
  if bandeira_usa then
      love.graphics.draw(bandeira_usa,(largura_tela/2) - 63,altura_tela/1.6)
  end
  if bandeira_brazil then
    love.graphics.draw(bandeira_brazil,(largura_tela/4) - 63, altura_tela/1.6)  
  end
  if bandeira_japan then
    love.graphics.draw(bandeira_japan,(largura_tela*(3/4)) - 63, altura_tela/1.6)
  end
  
  -- Desenha as string do menu de Idiomas
  
  if string_idioma_br then
    idioma_string = "Por favor, Escolha um idioma!"
    love.graphics.print(idioma_string,(largura_tela/10),(altura_tela/4))
  end
  
  if string_idioma_en then
    idioma_string = "Please, Select an language!"
    love.graphics.print(idioma_string,(largura_tela/10),(altura_tela/4))
  end
  
  if string_idioma_jp then
    idioma_string = "言語を選択してください。"
    love.graphics.print(idioma_string,(largura_tela/5),(altura_tela/4))
  end
    
  if game_start then
  
    -- Print Strings
    love.graphics.print(vers,largura_tela/16,(altura_tela/2)+(altura_tela/3)+(altura_tela/11))
    if love.window.getFullscreen() then
      love.graphics.print("PIXELBUSTER",largura_tela/2.45)
    else
      love.graphics.print("ピクセルバスター",largura_tela/3)
    end
    
    love.graphics.print(hp_1,largura_tela/6.5,0)
    love.graphics.print(hp_2,largura_tela/1.2,0)
    
    -- Retorna o final de jogo
    if game_over then
      if player1_vivo then
        love.graphics.print("Jogador 1 Ganhou!",largura_tela/3.6,altura_tela/3)
      end
      if player2_vivo then
        love.graphics.print("Jogador 2 Ganhou!",largura_tela/3.6,altura_tela/3)
      end
      love.graphics.print("Pressione 'r' para reiniciar o jogo",largura_tela/13,altura_tela/3 + altura_tela/3)
    end

    -- Desenha os jogadores
    if player1_vivo then
      love.graphics.draw(player1, player1_x, player1_y);
    end
    if player2_vivo then
      love.graphics.draw(player2, player2_x, player2_y);
    end
      
    -- Desenha os tiros
    if tiro_cont then
      love.graphics.draw(bala1,bala1_x,bala1_y)
    end
    if tiro2_cont then
      love.graphics.draw(bala2,bala2_x,bala2_y)
    end
  end
  
  -- Menu Principal
  if menu_set then
    if lingua == "pt-br" then
      love.graphics.setFont(texto_titulo)
      love.graphics.print("Pixel Buster",largura_tela/3,altura_tela/5)
      love.graphics.setFont(texto_subtitulo)
      love.graphics.print("Jogar",largura_tela/2.3,altura_tela/1.5)
    end
    
  end
  
end
