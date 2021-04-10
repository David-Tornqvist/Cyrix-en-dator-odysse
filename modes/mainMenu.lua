local level = require "modes.level";
local frenzyMode = require "modes.frenzyMode"
local tutorial = require "modes.tutorial"

loadMainMenu = function ()

    local tutorialHover = false;
    local spelaHover = false;

    love.mousemoved = function (x, y)
        if x > 886 and x < 948 and
           y > 502 and y < 532 then
            spelaHover = true;
        else
            spelaHover = false;    
        end
        if  x > 880 and x < 966 and
            y > 402 and y < 432 then
            tutorialHover = true;
        else
            tutorialHover = false;        
        end
    end

    love.mousepressed = function (x,y)

        if x > 886 and x < 948 and
           y > 502 and y < 532 then
            
            frenzyMode.load();

        end
        
        if  x > 880 and x < 966 and
            y > 402 and y < 432 then
        
            tutorial.load()

        end        

    end

    function love.keypressed(key)

        love.filesystem.write("hScore", highscore);

        if (key == "escape") then love.event.quit(); end
    
    end

    love.draw = function ()
        love.graphics.setColor(0,1,0,1);
        love.graphics.print("Cyrix, en dator odyssé",650,200,0,4,4);
        if tutorialHover then
            love.graphics.setColor(1,0,0,1); 
        end
        love.graphics.print("tutorial",880,400,0,2,2);
        love.graphics.setColor(0,1,0,1);
        if spelaHover then
            love.graphics.setColor(1,0,0,1);
        end
        love.graphics.print("spela",886,500,0,2,2);
        love.graphics.setColor(0,1,0,1);

        love.graphics.print("Highscore: " .. highscore, 845, 600, 0, 2, 2);
        love.graphics.print("Grafik, programmering och musik: David Törnqvist", 0, 1060);
    end
end