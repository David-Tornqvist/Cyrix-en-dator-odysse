local level = require "modes.level";
local frenzyMode = require "modes.frenzymode"
local tutorial = require "modes.tutorial"

loadMainMenu = function ()

    local tutorialHover = false;
    local spelaHover = false;
    local avslutaHover = false;
    local musicHover = false;

    local exit = function ()
        love.filesystem.write("hScore", highscore);
        love.event.quit(); 
    end

    local toggleMusic = function ()
        if music == true then
            soundtack:pause()
            music = false;
        else
            soundtack:play();
            music = true;    
        end
    end

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

        
        if  x > 886 and x < 976 and
            y > 900 and y < 930 then
            avslutaHover = true;
        else
            avslutaHover = false;        
        end

        if  x > 1800 and x < 1870 and
            y > 50 and y < 80 then
            musicHover = true;
        else
            musicHover = false;        
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
        
        if  x > 886 and x < 976 and
            y > 900 and y < 930 then
    
            exit();

        end

        if  x > 1800 and x < 1870 and
            y > 50 and y < 80 then
            
            toggleMusic();

        end

    end

    function love.keypressed(key)

        

        if (key == "escape") then 
            exit();
        end
    
    end

    love.draw = function ()
        --love.graphics.setColor(1,1,1,1);
        --love.graphics.rectangle("fill", 1800,50,70,30);

        love.graphics.scale(screenScale, screenScale);

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

        if avslutaHover then
            love.graphics.setColor(1,0,0,1);
        end
        love.graphics.print("avsluta",886,900,0,2,2);
        love.graphics.setColor(0,1,0,1);


        if musicHover then
            love.graphics.setColor(1,0,0,1);
        end

        if music == false then
            love.graphics.setColor(1,0,0,1);
            love.graphics.line(1800,50,1870,80);
        end

        love.graphics.print("musik",1800,50,0,2,2);
        love.graphics.setColor(0,1,0,1);




        love.graphics.print("Highscore: " .. highscore, 845, 600, 0, 2, 2);
        love.graphics.print("Grafik, programmering och musik: David Törnqvist", 0, 1060);
    end
end