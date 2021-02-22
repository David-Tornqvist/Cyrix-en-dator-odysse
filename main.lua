local camera = require "camera"
--gammal windows style



love.load = function()

    camera = require "camera";
    camera.load();

    rectangles = {};
  
end    


function love.mousepressed(mousex,mousey,button)
  

    local x =  camera.screenToWorldcords(mousex,mousey).x;
    local y =  camera.screenToWorldcords(mousex,mousey).y;

    for i = #rectangles, 1, -1 do


        if(button == 1 and x > rectangles[i].x and x < (rectangles[i].x + rectangles[i].width) and y > rectangles[i].y and y < (rectangles[i].y + rectangles[i].height)) then
            if (rectangles[i].clicked == false) then    
                rectangles[i].clicked = true;

            end
    
            rectangles[i].clickedOffsetX = x - rectangles[i].x;
            rectangles[i].clickedOffsetY = y - rectangles[i].y;

            rectangles = setfirst(rectangles,i);
            break
        end 
    end
   

    if(button == 1 and mousex/screenScale > 0 and mousex/screenScale < 40 and mousey/screenScale > 0 and mousey/screenScale < 40) then
        createrectangle();
    end    

    camera.update("mPush",button);
end

function love.mousereleased(x,y,button)
    if(button == 1) then
        for i = 1, #rectangles do
            rectangles[i].clicked = false;
        end
    end    

    

    camera.update("mRel",button);
end

function love.keypressed(key)

    if(key == "escape")then love.event.quit(); end

    if(key == "q")then translate.x = translate.x + 10; end

end

function love.wheelmoved(x,y)

    camera.update("scrl",y);

end

love.update = function(dt)

    local x = camera.screenToWorldcords(love.mouse.getX(),love.mouse.getY()).x;
    local y = camera.screenToWorldcords(love.mouse.getX(),love.mouse.getY()).y;

    for i = 1, #rectangles do
        if(rectangles[i].clicked) then


            rectangles[i].x = x - rectangles[i].clickedOffsetX;
            rectangles[i].y = y - rectangles[i].clickedOffsetY;
        end 
    end

    camera.update("pan");

end

love.draw = function()

    love.graphics.scale(screenScale,screenScale);

    love.graphics.push();

    love.graphics.scale(zoom,zoom);
    love.graphics.translate(translate.x,translate.y);

    for i = 1, #rectangles do
    
        love.graphics.setColor(1,1,1,1);
        love.graphics.rectangle("fill", rectangles[i].x,rectangles[i].y,rectangles[i].width,rectangles[i].height);
        if(rectangles[i].clicked) then
            love.graphics.setColor(0,0,1,1);
            love.graphics.setLineWidth(10)
            love.graphics.rectangle("line",rectangles[i].x,rectangles[i].y,rectangles[i].width,rectangles[i].height);
        end
        

    end

    love.graphics.pop();

    love.graphics.setColor(0,1,0,1);
    love.graphics.circle("fill",20,20,20);
        
end

function createrectangle()


    rectangles[#rectangles + 1] = {x = love.mouse.getX(), y = love.mouse.getY(), width = 100, height = 100, clicked = true,clickedOffsetY = 50, clickedOffsetX = 50}; 
    
end

function setfirst(arr,index)

    
    local topindex = table.remove(arr,index);
    arr[#arr+1] = topindex;
    return arr;
end

