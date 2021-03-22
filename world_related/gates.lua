local camera = require "screen_related.camera";
local starting_block = require "world_related.starting_block"

local gates = {};



gates.load = function ()

    rectangles = {};

    and_gate_img = {file = love.graphics.newImage("graphics/And_gate.png"),width = 1080,height = 1080};
    or_gate_img = {file = love.graphics.newImage("graphics/Or_gate.png"),width = 1080,height = 1080};

    gate_name = 1;

end



gates.click = function (mousex,mousey,button)

    local x =  camera.screenToWorldcords(mousex,mousey).x;
    local y =  camera.screenToWorldcords(mousex,mousey).y;
    
    --loops through all currently created gates
    for i = #rectangles, 1, -1 do

                --checks if either of the two inputs a,b or the output q is clicked
        if(     button == 1 and x > (rectangles[i].x + rectangles[i].input.a.coords.x - 10) and x < (rectangles[i].x + rectangles[i].input.a.coords.x + 10) 
                and y > (rectangles[i].y + rectangles[i].input.a.coords.y - 10) and y < (rectangles[i].y + rectangles[i].input.a.coords.y + 10)) then

                    rectangles[i].input.a.clicked = true;
                    portUpdate = true;

        elseif (button == 1 and x > (rectangles[i].x + rectangles[i].input.b.coords.x - 10) and x < (rectangles[i].x + rectangles[i].input.b.coords.x + 10) 
                and y > (rectangles[i].y + rectangles[i].input.b.coords.y - 10) and y < (rectangles[i].y + rectangles[i].input.b.coords.y + 10)) then  
          
                    rectangles[i].input.b.clicked = true;
                    portUpdate = true;

        elseif (button == 1 and x > (rectangles[i].x + rectangles[i].output.q.coords.x - 10) and x < (rectangles[i].x + rectangles[i].output.q.coords.x + 10) 
                and y > (rectangles[i].y + rectangles[i].output.q.coords.y - 10) and y < (rectangles[i].y + rectangles[i].output.q.coords.y + 10)) then

                    rectangles[i].output.q.clicked = true;
                    portUpdate = true;
            
                --or if the gate itseld where clicked
        elseif( button == 1 and x > rectangles[i].x and x < (rectangles[i].x + rectangles[i].width) and y > rectangles[i].y and y < (rectangles[i].y + rectangles[i].height)) then
              
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

    for i = 1, #arrStart_block do
        for b = 1, #arrStart_block[i].output do
            if(arrStart_block[i].output[b].clicked)then
                gatepair.output.gate_name = arrStart_block[i].name + b;
                gatepair.output.currentIndex = i;
                gatepair.output.rank = 0;
            end    
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
        if(gatepair.output.gate_name >= first_startname) then 

            arrStart_block[starting_block.getIndex(gatepair.output.gate_name)].output[gatepair.output.gate_name-first_startname].connect = {name = gatepair.input.gate_name, port = gatepair.input.port};
        else
            rectangles[gatepair.output.currentIndex].output.q.connect = {name = gatepair.input.gate_name, port = gatepair.input.port};  
        end

        gates.IOrelease();
 
    end    
end



gates.IOrelease = function ()
    for i = 1, #rectangles do
        rectangles[i].input.a.clicked = false;
        rectangles[i].input.b.clicked = false;
        rectangles[i].output.q.clicked = false;

    end

    for i = 1, #arrStart_block do
        for b = 1, #arrStart_block[i].output do
            arrStart_block[i].output[b].clicked = false;
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
    end
end



gates.getIndex = function (name)
    for i = 1, #rectangles do
    
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
        output = {q = {connect = {name = nil, port = nil}, coords = {x = 102, y = 10},status = false,clicked = false}}, rank = 1, name = gate_name}; 
    elseif(type == "or") then
        local width = 200;
        local height = 200;
        rectangles[#rectangles + 1] = {x = love.mouse.getX(), y = love.mouse.getY(), width = width, height = height, clicked = true,clickedOffsetY = height/2, clickedOffsetX = width/2, 
        type = "or", input = {a = {connect = nil, coords = {x = 76, y = 175},status = false,clicked = false}, b = {connect = nil, coords = {x = 125, y = 175},status = false,clicked = false}}, 
        output = {q = {connect = {name = nil, port = nil}, coords = {x = 102, y = 10},status = false,clicked = false}}, rank = 1, name = gate_name}; 
    end

    gate_name = gate_name + 1;

end



gates.setfirst = function (arr,index)
        
    local topindex = table.remove(arr,index);
    arr[#arr+1] = topindex;
    return arr;
    
    
end



gates.simulate = function ()

    local preparedGates = {};
    
    for i = 0, #rectangles do
        preparedGates[i] = {a = false, b = false, handeld = false}
    end

    for i = 1, #arrStart_block do
        for b = 1, #arrStart_block[i].output do
            if(arrStart_block[i].output[b].connect.name ~= nil) then

                if(arrStart_block[i].output[b].connect.port == "a") then
                    rectangles[gates.getIndex(arrStart_block[i].output[b].connect.name)].input.a.status = arrStart_block[i].output[b].status;
                    preparedGates[arrStart_block[i].output[b].connect.name].a = true;
                    
                  
                    
                end  
                if(arrStart_block[i].output[b].connect.port == "b") then
                    rectangles[gates.getIndex(arrStart_block[i].output[b].connect.name)].input.b.status = arrStart_block[i].output[b].status;
                    preparedGates[arrStart_block[i].output[b].connect.name].b = true;

                end    
            end    
        end
    end


    for i = 1, #rectangles do
        if(rectangles[i].input.a.connect ~= nil and rectangles[i].input.b.connect == nil) then
            preparedGates[rectangles[i].name].b = true;
        end 
        if(rectangles[i].input.b.connect ~= nil and rectangles[i].input.a.connect == nil) then
            preparedGates[rectangles[i].name].a = true;
        end    
    end

    for i = 1, #rectangles do
        if(rectangles[i].input.a.connect == nil and rectangles[i].input.b.connect == nil) then
           
            preparedGates[rectangles[i].name].handeld = true;
        end    
    end


    local allGatesHandeld = false
    local i = 0;

    while (allGatesHandeld == false) do

        for i = 1, #preparedGates do
            
                if(preparedGates[i].a and preparedGates[i].b) then
                    if(rectangles[gates.getIndex(i)].type == "and") then
                        if(rectangles[gates.getIndex(i)].input.a.status and rectangles[gates.getIndex(i)].input.b.status) then
                            rectangles[gates.getIndex(i)].output.q.status = true;
                        else
                            rectangles[gates.getIndex(i)].output.q.status = false;   
                        end    
                    end
                    
                    if(rectangles[gates.getIndex(i)].type == "or") then
                        if(rectangles[gates.getIndex(i)].input.a.status or rectangles[gates.getIndex(i)].input.b.status) then
                            rectangles[gates.getIndex(i)].output.q.status = true;
                        else
                            rectangles[gates.getIndex(i)].output.q.status = false;   
                        end    
                    end    
                    if(rectangles[gates.getIndex(i)].output.q.connect.name ~= nil) then
                        if(rectangles[gates.getIndex(i)].output.q.connect.port == "a") then
                            rectangles[gates.getIndex(rectangles[gates.getIndex(i)].output.q.connect.name)].input.a.status = rectangles[gates.getIndex(i)].output.q.status;
                            preparedGates[gates.getIndex(rectangles[gates.getIndex(i)].output.q.connect.name)].a = true;
                        end  
                        if(rectangles[gates.getIndex(i)].output.q.connect.port == "b") then
                            rectangles[gates.getIndex(rectangles[gates.getIndex(i)].output.q.connect.name)].input.b.status = rectangles[gates.getIndex(i)].output.q.status;
                            preparedGates[gates.getIndex(rectangles[gates.getIndex(i)].output.q.connect.name)].b = true;
                        end  
                    end    
                    preparedGates[i].handeld = true;    
                end
            
        end
    
        allGatesHandeld = true;
    
        for i = 1, #preparedGates do
            if(preparedGates[i].handeld == false) then allGatesHandeld = false end
        end


        i = i + 1;
        if(i > 10000)then break end

    end
end   



return gates;