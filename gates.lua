local camera = require "camera"

local gates = {};

gates.load = function ()
    rectangles = {};
    and_gate = {file = love.graphics.newImage("And_gate.png"),width = 1080,height = 1080};
end

gates.click = function (mousex,mousey,button)
    local x =  camera.screenToWorldcords(mousex,mousey).x;
    local y =  camera.screenToWorldcords(mousex,mousey).y;

    for i = #rectangles, 1, -1 do


        if(button == 1 and x > rectangles[i].x and x < (rectangles[i].x + rectangles[i].width) and y > rectangles[i].y and y < (rectangles[i].y + rectangles[i].height)) then
            if (rectangles[i].clicked == false) then    
                rectangles[i].clicked = true;

            end
    
            rectangles[i].clickedOffsetX = x - rectangles[i].x;
            rectangles[i].clickedOffsetY = y - rectangles[i].y;

            rectangles = gates.setfirst(rectangles,i);
            break
        end 
    end
end

gates.release = function (button)
    if(button == 1) then
        for i = 1, #rectangles do
            rectangles[i].clicked = false;
        end
    end    
end

gates.update = function ()
    
    local x = camera.screenToWorldcords(love.mouse.getX(),love.mouse.getY()).x;
    local y = camera.screenToWorldcords(love.mouse.getX(),love.mouse.getY()).y;

    for i = 1, #rectangles do
        if(rectangles[i].clicked) then


            rectangles[i].x = x - rectangles[i].clickedOffsetX;
            rectangles[i].y = y - rectangles[i].clickedOffsetY;
        end 
    end

end

gates.draw = function ()
    for i = 1, #rectangles do
    
        if(rectangles[i].type == "and") then
            love.graphics.setColor(0,1,0,1);
            love.graphics.draw(and_gate.file,rectangles[i].x,rectangles[i].y,0,rectangles[i].width/and_gate.width,rectangles[i].height/and_gate.width);
        end
        if(rectangles[i].clicked) then
            love.graphics.setColor(0,0,1,1);
            love.graphics.setLineWidth(10)
            love.graphics.rectangle("line",rectangles[i].x,rectangles[i].y,rectangles[i].width,rectangles[i].height);
        end
        

    end
end

gates.create = function (type)

    if(type == "and") then
        local width = 200;
        local height = 200;
        rectangles[#rectangles + 1] = {x = love.mouse.getX(), y = love.mouse.getY(), width = width, height = height, clicked = true,clickedOffsetY = height/2, clickedOffsetX = width/2, type = "and", input = {a = nil, b = nil}, output = {y = nil}, rank = 1}; 
    end
end

gates.setfirst = function (arr,index)
        
    local topindex = table.remove(arr,index);
    arr[#arr+1] = topindex;
    return arr;
    
    
end

return gates;