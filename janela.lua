
-- Características Tela 

icone = love.image.newImageData("res/ico.png")
love.window.setIcon(icone)
love.window.setFullscreen(true)

-- Valores Tela  
largura_tela = love.graphics.getWidth()
altura_tela = love.graphics.getHeight()

-- Configurações do Texto  
texto_medio = love.graphics.newFont("res/jackeyfont.ttf",45)
texto_titulo = love.graphics.newFont("res/HeartbitXX2Px.ttf",80)
texto_subtitulo = love.graphics.newFont("res/HeartbitXX2Px.ttf",65)

-- Audio
som_bg = love.audio.newSource("musica/background.mp3","static")
som_bg:setVolume(0.5)
som_bg:play()

som_exp = love.audio.newSource("musica/explodir.wav","static")
som_exp:setVolume(0.5)

som_rip = love.audio.newSource("musica/morte.wav","static")

som_menu = love.audio.newSource("musica/menu_select.wav","static")

som_menu_select = love.audio.newSource("musica/menu_selected.wav","static")

-- Bandeiras dos idiomas

  bandeira_brazil = love.graphics.newImage("res/brazilflag.png");
  bandeira_japan = love.graphics.newImage("res/japanflag.png");
  bandeira_usa = love.graphics.newImage("res/usaflag.png");
  
  bandeira_brazil_largura = bandeira_brazil:getWidth();
  bandeira_brazil_altura = bandeira_brazil:getHeight();
  
  bandeira_japan_largura = bandeira_japan:getWidth();
  bandeira_japan_altura = bandeira_japan:getHeight();
  
  bandeira_usa_largura = bandeira_usa:getWidth();
  bandeira_usa_altura = bandeira_usa:getHeight();
  
