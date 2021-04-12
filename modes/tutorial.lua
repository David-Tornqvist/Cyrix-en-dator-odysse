local tutorial = {}

tutorial.load = function ()

    tutImage = love.graphics.newImage("graphics/tutorial/slide_1.png")

    slide = 1;
        
    love.mousemoved = function ()
    end

    love.mousepressed = function ()

        slide = slide + 1;
        
        if slide == 15 then
                loadMainMenu();
            end
            if slide < 15 then
                tutImage = love.graphics.newImage("graphics/tutorial/slide_" .. slide .. ".png");
            end

        end

        love.keypressed = function (key)

            if key == "escape" then
                loadMainMenu();
            end

        end

        love.graphics.setColor(1,1,1,1);

        love.draw = function ()

            love.graphics.scale(screenScale, screenScale);
            love.graphics.draw(tutImage,0,0,0,0.5,0.5);
            
        end
    end

return tutorial;