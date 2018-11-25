-- Características Tela 
love.window.setTitle("Pixel Buster - ピクセルバスター")
icone = love.image.newImageData("res/ico.png")
love.window.setIcon(icone)
-- love.window.setFullscreen(true)

-- Valores Tela  
largura_tela = love.graphics.getWidth()
altura_tela = love.graphics.getHeight()

-- Configurações do Texto  
texto_medio = love.graphics.newFont("res/HeartbitXX2Px.ttf",60)
texto_titulo = love.graphics.newFont("res/HeartbitXX2Px.ttf",40)

-- Audio
som_bg = love.audio.newSource("musica/background.mp3","static")
som_bg:setVolume(0.5)
som_bg:play()

som_exp = love.audio.newSource("musica/explodir.wav","static")
som_exp:setVolume(0.5)

som_rip = love.audio.newSource("musica/morte.wav","static")