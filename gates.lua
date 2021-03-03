local camera = require "camera";

local gates = {};

gates.load = function ()
    rectangles = {};
    and_gate_img = {file = love.graphics.newImage("And_gate.png"),width = 1080,height = 1080};
    or_gate_img = {file = love.graphics.newImage("Or_gate.png"),width = 1080,height = 1080};
    gate_name = 0;
end

gates.click = function (mousex,mousey,button)
    local x =  camera.screenToWorldcords(mousex,mousey).x;
    local y =  camera.screenToWorldcords(mousex,mousey).y;
    local portUpdate = false;

    for i = #rectangles, 1, -1 do

        if(button == 1 and x > (rectangles[i].x + rectangles[i].input.a.coords.x - 10) and x < (rectangles[i].x + rectangles[i].input.a.coords.x + 10) and y > (rectangles[i].y + rectangles[i].input.a.coords.y - 10) and y < (rectangles[i].y + rectangles[i].input.a.coords.y + 10)) then
            rectangles[i].input.a.clicked = true;
            portUpdate = true;
            gates.connect();
            break

        elseif (button == 1 and x > (rectangles[i].x + rectangles[i].input.b.coords.x - 10) and x < (rectangles[i].x + rectangles[i].input.b.coords.x + 10) and y > (rectangles[i].y + rectangles[i].input.b.coords.y - 10) and y < (rectangles[i].y + rectangles[i].input.b.coords.y + 10)) then  
            rectangles[i].input.b.clicked = true;
            portUpdate = true;
            gates.connect();
            break

        elseif (button == 1 and x > (rectangles[i].x + rectangles[i].output.q.coords.x - 10) and x < (rectangles[i].x + rectangles[i].output.q.coords.x + 10) and y > (rectangles[i].y + rectangles[i].output.q.coords.y - 10) and y < (rectangles[i].y + rectangles[i].output.q.coords.y + 10)) then    
            rectangles[i].output.q.clicked = true;
            portUpdate = true;
            gates.connect();
            break

        elseif(button == 1 and x > rectangles[i].x and x < (rectangles[i].x + rectangles[i].width) and y > rectangles[i].y and y < (rectangles[i].y + rectangles[i].height)) then
            if (rectangles[i].clicked == false) then    
                rectangles[i].clicked = true;

            end
    
            rectangles[i].clickedOffsetX = x - rectangles[i].x;
            rectangles[i].clickedOffsetY = y - rectangles[i].y;

            rectangles = gates.setfirst(rectangles,i);
        
       
            break     
        end    
    end

    if(portUpdate == false) then
        gates.IOrelease();
    end
end

gates.connect = function ()
    
    local gatepair = {input = {gate_name = nil, port = nil,currentIndex = nil}, output = {gate_name = nil, rank = nil,currentIndex = nil}}
    
    for i = 1, #rectangles do
        if(rectangles[i].input.a.clicked) then
            gatepair.input.gate_name = rectangles[i].name;
            gatepair.input.port = "a";
            gatepair.input.currentIndex = i;
        end    
        if (rectangles[i].input.b.clicked) then
            gatepair.input.gate_name = rectangles[i].name;
            gatepair.input.port = "b"; 
            gatepair.input.currentIndex = i;
        end    
        if (rectangles[i].output.q.clicked) then     
            gatepair.output.gate_name = rectangles[i].name;
            gatepair.output.currentIndex = i;
            gatepair.output.rank = rectangles[i].rank;   
        end      
    end

    if((gatepair.input.gate_name ~= nil) and (gatepair.output.gate_name ~= nil)) then
        if(gatepair.input.port == "a") then
            rectangles[gatepair.input.currentIndex].input.a.connect = gatepair.output.gate_name;
        end
        if(gatepair.input.port == "b") then
            rectangles[gatepair.input.currentIndex].input.b.connect = gatepair.output.gate_name;
        end    
        rectangles[gatepair.input.currentIndex].rank = gatepair.output.rank + 1;
        rectangles[gatepair.output.currentIndex].output.q.connect = {name = gatepair.input.gate_name, port = gatepair.input.port};
        gates.IOrelease();
        print("test");
    end    


end

gates.IOrelease = function ()
    for i = 1, #rectangles do
        rectangles[i].input.a.clicked = false;
        rectangles[i].input.b.clicked = false;
        rectangles[i].output.q.clicked = false;

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
            love.graphics.draw(and_gate_img.file,rectangles[i].x,rectangles[i].y,0,rectangles[i].width/and_gate_img.width,rectangles[i].height/and_gate_img.width);
        elseif(rectangles[i].type == "or") then
            love.graphics.setColor(0,1,0,1);
            love.graphics.draw(or_gate_img.file,rectangles[i].x,rectangles[i].y,0,rectangles[i].width/or_gate_img.width,rectangles[i].height/or_gate_img.width);
        end    

      
        love.graphics.setColor(0,0,1,1);
        love.graphics.setLineWidth(5);


        if(rectangles[i].clicked) then
            love.graphics.setLineWidth(10)
            love.graphics.rectangle("line",rectangles[i].x,rectangles[i].y,rectangles[i].width,rectangles[i].height);

        elseif(rectangles[i].input.a.clicked) then
            love.graphics.circle("line",rectangles[i].x + rectangles[i].input.a.coords.x,rectangles[i].y + rectangles[i].input.a.coords.y,20);

        elseif (rectangles[i].input.b.clicked) then  
            love.graphics.circle("line",rectangles[i].x + rectangles[i].input.b.coords.x,rectangles[i].y + rectangles[i].input.b.coords.y,20);
            
        elseif (rectangles[i].output.q.clicked) then   
            love.graphics.circle("line",rectangles[i].x + rectangles[i].output.q.coords.x,rectangles[i].y + rectangles[i].output.q.coords.y,20);
            
        end    
        
    ;
        
        
        
        

    end
end

gates.getIndex = function (name)
    for i = 1, #rectangles do
        print(rectangles[i].name); 
        if(rectangles[i].name == name) then
            return i;
        end        
    end
end

gates.create = function (type)

    if(type == "and") then
        local width = 200;
        local height = 200;
        rectangles[#rectangles + 1] = {x = love.mouse.getX(), y = love.mouse.getY(), width = width, height = height, clicked = true,clickedOffsetY = height/2, clickedOffsetX = width/2, 
        type = "and", input = {a = {connect = nil, coords = {x = 76, y = 175},status = false,clicked = false}, b = {connect = nil, coords = {x = 125, y = 175},status = false,clicked = false}}, 
        output = {q = {connect = nil, coords = {x = 102, y = 10},status = false,clicked = false}}, rank = 1, name = gate_name}; 
    elseif(type == "or") then
        local width = 200;
        local height = 200;
        rectangles[#rectangles + 1] = {x = love.mouse.getX(), y = love.mouse.getY(), width = width, height = height, clicked = true,clickedOffsetY = height/2, clickedOffsetX = width/2, 
        type = "or", input = {a = {connect = nil, coords = {x = 76, y = 175},status = false,clicked = false}, b = {connect = nil, coords = {x = 125, y = 175},status = false,clicked = false}}, 
        output = {q = {connect = nil, coords = {x = 102, y = 10},status = false,clicked = false}}, rank = 1, name = gate_name}; 
    end

    gate_name = gate_name + 1;

end

gates.setfirst = function (arr,index)
        
    local topindex = table.remove(arr,index);
    arr[#arr+1] = topindex;
    return arr;
    
    
end

return gates;