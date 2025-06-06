-- src/window.lua

local Window = {}

function Window.load()
    local icon = love.image.newImageData("res/ico.png")
    love.window.setIcon(icon)
    love.window.setFullscreen(false)

    Window.width = love.graphics.getWidth()
    Window.height = love.graphics.getHeight()

    -- Load default fonts
    Window.font_medium = love.graphics.newFont("res/jackeyfont.ttf", math.floor(Window.height * 0.045))
    Window.font_title = love.graphics.newFont("res/HeartbitXX2Px.ttf", math.floor(Window.height * 0.08))
    Window.font_subtitle = love.graphics.newFont("res/HeartbitXX2Px.ttf", math.floor(Window.height * 0.065))

    -- Load flag images
    Window.flags = {
        br = love.graphics.newImage("res/brazilflag.png"),
        jp = love.graphics.newImage("res/japanflag.png"),
        us = love.graphics.newImage("res/usaflag.png")
    }

    Window.flag_sizes = {
        br = { w = Window.flags.br:getWidth(), h = Window.flags.br:getHeight() },
        jp = { w = Window.flags.jp:getWidth(), h = Window.flags.jp:getHeight() },
        us = { w = Window.flags.us:getWidth(), h = Window.flags.us:getHeight() }
    }
end

function Window.updateFonts(lang)
    local h = Window.height
    if lang == "jp" then
        Window.font_medium = love.graphics.newFont("res/jackeyfont.ttf", math.floor(h * 0.045))
        Window.font_title = love.graphics.newFont("res/jackeyfont.ttf", math.floor(h * 0.08))
        Window.font_subtitle = love.graphics.newFont("res/jackeyfont.ttf", math.floor(h * 0.065))
    else
        Window.font_medium = love.graphics.newFont("res/jackeyfont.ttf", math.floor(h * 0.045))
        Window.font_title = love.graphics.newFont("res/HeartbitXX2Px.ttf", math.floor(h * 0.08))
        Window.font_subtitle = love.graphics.newFont("res/HeartbitXX2Px.ttf", math.floor(h * 0.065))
    end
end

return Window
