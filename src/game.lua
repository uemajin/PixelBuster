-- src/game.lua
Game = {}

function Game.load()
    Game.version = "Ver. 0.01"
    Game.language = "br"
    Game.state = "menu"

    Game.alpha = 0
    Game.fade_in = true
    Game.fade_out = false
    Game.transition_to = nil

    Game.bg = love.graphics.newImage("res/bgt.png")
    Game.bgrot = 0

    Game.mouse_on_play = false
    Game.flag_hover = false
    Game.flag_area_expanded = false

    Game.mouse_on_play_again = false
    Game.mouse_on_exit = false

    Audio.bg:play()
end

function Game.keypressed(key)
    if Game.state == "playing" then
        if key == "f" and Player.alive1 and not Bullets.fired1 then
            Bullets.fired1 = true
            Bullets.x1 = Player.x1 + Player.width / 2 - Bullets.width / 2
            Bullets.y1 = Player.y1 + Player.height / 2 - Bullets.height / 2
            Audio.shoot:play()
        elseif key == "space" and Player.alive2 and not Bullets.fired2 then
            Bullets.fired2 = true
            Bullets.x2 = Player.x2 + Player.width / 2 - Bullets.width / 2
            Bullets.y2 = Player.y2 + Player.height / 2 - Bullets.height / 2
            Audio.shoot:play()
        end
    end
end

function Game.update(dt)
    Game.bgrot = Game.bgrot + dt * 0.1

    if Game.fade_in then
        Game.alpha = Game.alpha + dt
        if Game.alpha >= 2 then
            Game.alpha = 2
            Game.fade_in = false
        end
    end

    if Game.fade_out then
        Game.alpha = Game.alpha - dt
        if Game.alpha <= 0 then
            Game.alpha = 0
            Game.fade_out = false
            Game.state = Game.transition_to or "playing"
            Game.fade_in = true
        end
    end

    local mx, my = love.mouse.getPosition()

    if Game.state == "menu" then
        local px = Window.width / 2.3
        local py = Window.height / 1.5
        Game.mouse_on_play = mx >= px and mx <= px + 150 and my >= py and my <= py + 50

        local flag_x = Window.width - Window.width * 0.05
        local flag_y = Window.height - Window.height * 0.05
        local flag_size = Window.height * 0.06
        local hover_height = flag_size * 3
        Game.flag_hover = mx >= flag_x - flag_size and mx <= flag_x + flag_size and my >= flag_y - flag_size and my <= flag_y + hover_height
    end

    if Game.state == "gameover" then
        local btn_w, btn_h = 200, 50
        local btn_x = (Window.width - btn_w) / 2
        local btn_y1 = Window.height / 1.8
        local btn_y2 = btn_y1 + 60

        Game.mouse_on_play_again = mx >= btn_x and mx <= btn_x + btn_w and my >= btn_y1 and my <= btn_y1 + btn_h
        Game.mouse_on_exit = mx >= btn_x and mx <= btn_x + btn_w and my >= btn_y2 and my <= btn_y2 + btn_h
    end

    if Game.state == "playing" then
        Bullets.update(dt)

        if Player.alive1 then
            if love.keyboard.isDown("d") then Player.x1 = Player.x1 + dt * Player.vel1 end
            if love.keyboard.isDown("a") then Player.x1 = Player.x1 - dt * Player.vel1 end
            if love.keyboard.isDown("w") then Player.y1 = Player.y1 - dt * Player.vel1 end
            if love.keyboard.isDown("s") then Player.y1 = Player.y1 + dt * Player.vel1 end

            -- Clamp Player 1
            Player.x1 = math.max(0, math.min(Player.x1, Window.width - Player.width))
            Player.y1 = math.max(0, math.min(Player.y1, Window.height - Player.height))

        end

        if Player.alive2 then
            if love.keyboard.isDown("right") then Player.x2 = Player.x2 + dt * Player.vel2 end
            if love.keyboard.isDown("left") then Player.x2 = Player.x2 - dt * Player.vel2 end
            if love.keyboard.isDown("up") then Player.y2 = Player.y2 - dt * Player.vel2 end
            if love.keyboard.isDown("down") then Player.y2 = Player.y2 + dt * Player.vel2 end

            -- Clamp Player 2
            Player.x2 = math.max(0, math.min(Player.x2, Window.width - Player.width))
            Player.y2 = math.max(0, math.min(Player.y2, Window.height - Player.height))
        end

        local b1_hit = Bullets.fired1 and Player.alive2 and Bullets.x1 > Player.x2 and Bullets.x1 < Player.x2 + Player.width and Bullets.y1 > Player.y2 and Bullets.y1 < Player.y2 + Player.height
        local b2_hit = Bullets.fired2 and Player.alive1 and Bullets.x2 > Player.x1 and Bullets.x2 < Player.x1 + Player.width and Bullets.y2 > Player.y1 and Bullets.y2 < Player.y1 + Player.height

        if b1_hit then
            Player.hp2 = Player.hp2 - 1
            Audio.exp:play()
            Bullets.fired1 = false
        end
        if b2_hit then
            Player.hp1 = Player.hp1 - 1
            Audio.exp:play()
            Bullets.fired2 = false
        end

        if Player.hp1 <= 0 and Player.alive1 then
            Player.alive1 = false
            Game.state = "gameover"
            Audio.rip:play()
        end
        if Player.hp2 <= 0 and Player.alive2 then
            Player.alive2 = false
            Game.state = "gameover"
            Audio.rip:play()
        end
    end
end

function Game.mousepressed(x, y, button)
    if button ~= 1 then return end
    if Game.fade_in or Game.fade_out then return end -- prevent interaction while fading

    if Game.state == "menu" then
        local px = Window.width / 2.3
        local py = Window.height / 1.5
        if x >= px and x <= px + 150 and y >= py and y <= py + 50 then
            Game.transition_to = "playing"
            Game.fade_out = true
            Audio.menu_select:play()
        end

        local flag_size = Window.height * 0.06
        local base_x = Window.width - Window.width * 0.05
        local base_y = Window.height - Window.height * 0.05
        local spacing = flag_size + 10

        local flags = { "br", "us", "jp" }

        for i, code in ipairs(flags) do
            if Window.flags and Window.flags[code] then
                local img = Window.flags[code]
                local y_flag = base_y - (i - 1) * spacing
                local scale = flag_size / img:getHeight()
                local w = img:getWidth() * scale
                local h = img:getHeight() * scale
                if x >= base_x - w/2 and x <= base_x + w/2 and y >= y_flag - h/2 and y <= y_flag + h/2 then
                    Game.language = code
                    Window.updateFonts(Game.language)
                    Audio.menu:play()
                end
            end
        end
    elseif Game.state == "gameover" then
        local btn_w, btn_h = 200, 50
        local btn_x = (Window.width - btn_w) / 2
        local btn_y1 = Window.height / 1.8
        local btn_y2 = btn_y1 + 60

        if x >= btn_x and x <= btn_x + btn_w and y >= btn_y1 and y <= btn_y1 + btn_h then
            Game.transition_to = "playing"
            Game.fade_out = true
            Player.reset()
            Bullets.reset()
            Audio.menu_select:play()
        elseif x >= btn_x and x <= btn_x + btn_w and y >= btn_y2 and y <= btn_y2 + btn_h then
            Game.transition_to = "menu"
            Game.fade_out = true
            Player.reset()
            Bullets.reset()
            Audio.menu:play()
        end
    end
end

function Game.draw()
    local lang = Game.language or "br"

    love.graphics.setFont(Window.font_medium)
    love.graphics.setColor(1, 1, 1, Game.alpha)
    love.graphics.draw(Game.bg, Window.width / 2, Window.height / 2, Game.bgrot, 1, 1, Game.bg:getWidth() / 2, Game.bg:getHeight() / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if Game.state == "menu" then

        love.graphics.print(Game.version, Window.width / 16, Window.height - 40)

        love.graphics.setFont(Window.font_title)
        local title_texts = {
            ["br"] = "Pixel Buster",
            ["us"] = "Pixel Buster",
            ["jp"] = "ピクセルバスター"
        }
        local title = title_texts[lang]
        local tw = Window.font_title:getWidth(title)
        local th = Window.font_title:getHeight()
        love.graphics.print(title, (Window.width - tw) / 2, Window.height / 5 - th / 2)

        love.graphics.setFont(Window.font_subtitle)
        local px = Window.width / 2.3
        local py = Window.height / 1.5

        if Game.mouse_on_play then
            love.graphics.setColor(1, 1, 0, 1)
        end

        local play_texts = {
            ["br"] = "Jogar",
            ["us"] = "Play",
            ["jp"] = "プレイ"
        }
        local play_label = play_texts[lang]
        local pw = Window.font_subtitle:getWidth(play_label)
        local ph = Window.font_subtitle:getHeight()
        love.graphics.print(play_label, (Window.width - pw) / 2, py - ph / 2)
        love.graphics.setColor(1, 1, 1, 1)

        -- Draw language flags
        local flag_size = Window.height * 0.06
        local base_x = Window.width - Window.width * 0.05
        local base_y = Window.height - Window.height * 0.05
        local spacing = flag_size + 10

        local flags = { "br", "us", "jp" }

        for i, code in ipairs(flags) do
            local img = Window.flags[code]
            if img then
                local y = base_y - (i - 1) * spacing
                local alpha = (code == Game.language) and 1 or 0.4
                love.graphics.setColor(1, 1, 1, alpha)
                local scale = flag_size / img:getHeight()
                love.graphics.draw(img, base_x - (img:getWidth() * scale) / 2, y - (img:getHeight() * scale) / 2, 0, scale, scale)
            end
        end
        love.graphics.setColor(1, 1, 1, 1)
    end

    if Game.state == "playing" or Game.state == "gameover" then
        love.graphics.print(Player.hp1, Window.width / 6.5, 0)
        love.graphics.print(Player.hp2, Window.width / 1.2, 0)

        if Player.alive1 then
            love.graphics.draw(Player.img1, Player.x1, Player.y1)
        end
        if Player.alive2 then
            love.graphics.draw(Player.img2, Player.x2, Player.y2)
        end

        if Bullets.fired1 then
            love.graphics.draw(Bullets.img1, Bullets.x1, Bullets.y1)
        end
        if Bullets.fired2 then
            love.graphics.draw(Bullets.img2, Bullets.x2, Bullets.y2)
        end

        if Game.state == "gameover" then
            love.graphics.setColor(0, 0, 0, 0.7)
            love.graphics.rectangle("fill", 0, 0, Window.width, Window.height)
            love.graphics.setColor(1, 1, 1, 1)

            local win_texts = {
                ["br"] = { p1 = "Jogador 1 Ganhou!", p2 = "Jogador 2 Ganhou!" },
                ["us"] = { p1 = "Player 1 Wins!", p2 = "Player 2 Wins!" },
                ["jp"] = { p1 = "プレイヤー1の勝ち！", p2 = "プレイヤー2の勝ち！" }
            }
            local restart_texts = {
                ["br"] = { again = "Jogar Novamente", exit = "Voltar ao Menu" },
                ["us"] = { again = "Play Again", exit = "Exit to Menu" },
                ["jp"] = { again = "もう一度プレイ", exit = "メニューに戻る" }
            }
            local win_label = Player.alive1 and win_texts[lang].p1 or win_texts[lang].p2
            local rw = Window.font_subtitle:getWidth(win_label)
            love.graphics.print(win_label, (Window.width - rw) / 2, Window.height / 3)

            local btn_w, btn_h = 200, 50
            local btn_x = (Window.width - btn_w) / 2
            local btn_y1 = Window.height / 1.8
            local btn_y2 = btn_y1 + 60

             -- Play Again label
            if Game.mouse_on_play_again then
                love.graphics.setColor(1, 1, 0, 1)
            end
            love.graphics.printf(restart_texts[lang].again, btn_x, btn_y1 + 15, btn_w, "center")
            love.graphics.setColor(1, 1, 1, 1)

            -- Exit label
            if Game.mouse_on_exit then
                love.graphics.setColor(1, 1, 0, 1)
            end
            love.graphics.printf(restart_texts[lang].exit, btn_x, btn_y2 + 15, btn_w, "center")
            love.graphics.setColor(1, 1, 1, 1)

        end
    end

    if Game.fade_in or Game.fade_out then
        love.graphics.setColor(0, 0, 0, 1 - math.min(Game.alpha / 2, 1))
        love.graphics.rectangle("fill", 0, 0, Window.width, Window.height)
        love.graphics.setColor(1, 1, 1, 1)
    end
end

return Game

