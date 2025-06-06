-- src/bullets.lua

local Bullets = {}

function Bullets.load()
    Bullets.img1 = love.graphics.newImage("res/bala1.png")
    Bullets.img2 = love.graphics.newImage("res/bala2.png")

    Bullets.width = Bullets.img1:getWidth()
    Bullets.height = Bullets.img1:getHeight()

    Bullets.x1 = 0
    Bullets.y1 = 0
    Bullets.fired1 = false

    Bullets.x2 = 0
    Bullets.y2 = 0
    Bullets.fired2 = false

    Bullets.speed = 600
end

function Bullets.update(dt)
    if Bullets.fired1 then
        Bullets.x1 = Bullets.x1 + Bullets.speed * dt
        if Bullets.x1 > love.graphics.getWidth() then
            Bullets.fired1 = false
        end
    end

    if Bullets.fired2 then
        Bullets.x2 = Bullets.x2 - Bullets.speed * dt
        if Bullets.x2 < 0 then
            Bullets.fired2 = false
        end
    end
end

function Bullets.fire1(x, y)
    if not Bullets.fired1 then
        Bullets.x1 = x
        Bullets.y1 = y
        Bullets.fired1 = true
    end
end

function Bullets.fire2(x, y)
    if not Bullets.fired2 then
        Bullets.x2 = x
        Bullets.y2 = y
        Bullets.fired2 = true
    end
end

function Bullets.reset()
    Bullets.fired1 = false
    Bullets.fired2 = false
    Bullets.x1 = 0
    Bullets.y1 = 0
    Bullets.x2 = 0
    Bullets.y2 = 0
end


return Bullets
