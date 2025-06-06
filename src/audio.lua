-- src/audio.lua

local Audio = {}

function Audio.load()
    Audio.bg = love.audio.newSource("musica/background.mp3", "static")
    Audio.bg:setLooping(true)
    Audio.bg:setVolume(0.5)

    Audio.exp = love.audio.newSource("musica/explodir.wav", "static")
    Audio.exp:setVolume(0.5)

    Audio.rip = love.audio.newSource("musica/morte.wav", "static")
    Audio.rip:setVolume(0.5)

    Audio.menu = love.audio.newSource("musica/menu_select.wav", "static")
    Audio.menu:setVolume(0.5)

    Audio.menu_select = love.audio.newSource("musica/menu_selected.wav", "static")
    Audio.menu_select:setVolume(0.5)

    Audio.shoot = love.audio.newSource("musica/tiro.wav", "static")
    Audio.shoot:setVolume(0.5)
end

return Audio
