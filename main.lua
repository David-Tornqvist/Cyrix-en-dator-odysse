--gammal windows style

love.load = function()

    love.window.setMode(love.graphics.getWidth(),love.graphics.getWidth()*19/16,{fullscreen = true});

    gameWidth = 1920;
    worldScale = 3;
    screenScale = love.graphics.getWidth()/gameWidth;
    mouseScale = 1/screenScale/worldScale;
    rectangles = {};
    
end    

function love.mousepressed(x,y,button)
  
    for i = #rectangles, 1, -1 do

        if(button == 1 and x*mouseScale > rectangles[i].x and x*mouseScale < (rectangles[i].x + rectangles[i].width) and y*mouseScale > rectangles[i].y and y*mouseScale < (rectangles[i].y + rectangles[i].height)) then
            if (rectangles[i].clicked == false) then    
                rectangles[i].clicked = true;

            end
    
            rectangles[i].clickedOffsetX = x*mouseScale - rectangles[i].x;
            rectangles[i].clickedOffsetY = y*mouseScale - rectangles[i].y;

            rectangles = setfirst(rectangles,i);
            break
        end 
    end
   
    if(button == 1 and x/screenScale > 0 and x/screenScale < 40 and y/screenScale > 0 and y/screenScale < 40) then
        createrectangle();
    end    
end

function love.mousereleased(x,y,button)
    if(button == 1) then
        for i = 1, #rectangles do
            rectangles[i].clicked = false;
        end
    end    
end

function love.keypressed(key)

    if(key == "escape")then love.event.quit(); end

end

function love.wheelmoved(x,y)

    worldScale = worldScale + y/10;
    mouseScale = 1/screenScale/worldScale;

    print(worldScale);
    
end

love.update = function(dt)

    for i = 1, #rectangles do
        if(rectangles[i].clicked) then
            rectangles[i].x = love.mouse.getX()*mouseScale - rectangles[i].clickedOffsetX;
            rectangles[i].y = love.mouse.getY()*mouseScale - rectangles[i].clickedOffsetY;
        end 
    end
end

love.draw = function()

    love.graphics.scale(screenScale,screenScale);
    love.graphics.push();

    
    
    
    love.graphics.scale(worldScale,worldScale);

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


    rectangles[#rectangles + 1] = {x = love.mouse.getX()/mouseScale, y = love.mouse.getY()/mouseScale, width = 200, height = 200, clicked = true,clickedOffsetY = 100, clickedOffsetX = 100}; 
    
end

function setfirst(arr,index)

    
    local topindex = table.remove(arr,index);
    arr[#arr+1] = topindex;
    return arr;
end

