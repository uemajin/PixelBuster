-- src/player.lua

local Player = {}

function Player.load()
    Player.img1 = love.graphics.newImage("jogadores/player1.png")
    Player.img2 = love.graphics.newImage("jogadores/player2.png")

    Player.width = Player.img1:getWidth()
    Player.height = Player.img1:getHeight()

    Player.x1 = 30
    Player.y1 = love.graphics.getHeight() / 2
    Player.vel1 = 250
    Player.hp1 = 30
    Player.alive1 = true

    Player.x2 = love.graphics.getWidth() - 75
    Player.y2 = love.graphics.getHeight() / 2
    Player.vel2 = 250
    Player.hp2 = 30
    Player.alive2 = true
end

function Player.reset()
    Player.x1 = 30
    Player.y1 = love.graphics.getHeight() / 2
    Player.hp1 = 30
    Player.alive1 = true

    Player.x2 = love.graphics.getWidth() - 75
    Player.y2 = love.graphics.getHeight() / 2
    Player.hp2 = 30
    Player.alive2 = true
end

return Player
