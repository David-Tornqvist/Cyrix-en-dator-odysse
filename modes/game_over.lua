local menu = require "screen_related.menu"
local gameOver = {}

gameOver.load = function ()

    if score > highScore then
        highScore = score;
    end

    time = 0;
    local menuHover = false;
    
    love.mousepressed = function ()
        loadMainMenu();
    end

    love.mousereleased = function ()
    end

    love.wheelmoved = function ()
    end

    love.update = function ()
    end

    love.mousemoved = function (x,y)

        x = x / screenScale;
        y = y / screenScale;

        if x > 845 and x < 1045 and
           y > 600 and y < 630 then
            menuHover = true;
        else
            menuHover = false;    
        end
        
    end

    love.draw = function ()

        love.graphics.scale(screenScale, screenScale);

        love.graphics.setColor(0,1,0,1);
        love.graphics.print("Tiden tog slut!",750,200,0,4,4);
        love.graphics.print("score: " .. score, 870, 400, 0, 2, 2);
        love.graphics.print("highScore: " .. highScore, 845, 440, 0, 2, 2);

        if menuHover then
            love.graphics.setColor(1,0,0,1)
        end

        love.graphics.print("Till huvudmenyn", 845, 600, 0, 2, 2);

    end
end

return gameOver