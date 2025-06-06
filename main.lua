Window = require("src.window")
Audio = require("src.audio")
Player = require("src.player")
Bullets = require("src.bullets")
Game = require("src.game")

function love.load()
    Window.load()
    Audio.load()
    Player.load()
    Bullets.load()
    Game.load()
end

function love.update(dt)
    Game.update(dt)
end

function love.draw()
    Game.draw()
end

function love.mousepressed(x, y, button, istouch, presses)
    if Game.mousepressed then
        Game.mousepressed(x, y, button)
    end
end

function love.keypressed(key)
    if Game.keypressed then
        Game.keypressed(key)
    end
end
