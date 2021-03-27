local camera = require "screen_related.camera";


local gates = {};



gates.load = function ()

    arrGates = {};

    andGateImg = {file = love.graphics.newImage("graphics/And_gate.png"), width = 1080, height = 1080};
    orGateImg = {file = love.graphics.newImage("graphics/Or_gate.png"), width = 1080, height = 1080};

    gateName = 1;

end



gates.click = function (mouseX, mouseY, button)

    local x =  camera.screenToWorldcords(mouseX, mouseY).x;
    local y =  camera.screenToWorldcords(mouseX, mouseY).y;
    
    --loops through all currently created gates
    for i = #arrGates, 1, -1 do

                --checks if either of the two inputs a,b or the output q is clicked
        if(     button == 1 and x > (arrGates[i].x + arrGates[i].input.a.coords.x - 10) and x < (arrGates[i].x + arrGates[i].input.a.coords.x + 10) 
                and y > (arrGates[i].y + arrGates[i].input.a.coords.y - 10) and y < (arrGates[i].y + arrGates[i].input.a.coords.y + 10)) then

                    arrGates[i].input.a.clicked = true;
                    portUpdate = true;

        elseif (button == 1 and x > (arrGates[i].x + arrGates[i].input.b.coords.x - 10) and x < (arrGates[i].x + arrGates[i].input.b.coords.x + 10) 
                and y > (arrGates[i].y + arrGates[i].input.b.coords.y - 10) and y < (arrGates[i].y + arrGates[i].input.b.coords.y + 10)) then  
          
                    arrGates[i].input.b.clicked = true;
                    portUpdate = true;

        elseif (button == 1 and x > (arrGates[i].x + arrGates[i].output.q.coords.x - 10) and x < (arrGates[i].x + arrGates[i].output.q.coords.x + 10) 
                and y > (arrGates[i].y + arrGates[i].output.q.coords.y - 10) and y < (arrGates[i].y + arrGates[i].output.q.coords.y + 10)) then

                    arrGates[i].output.q.clicked = true;
                    portUpdate = true;
            
                --or if the gate itself where clicked
        elseif( button == 1 and x > arrGates[i].x and x < (arrGates[i].x + arrGates[i].width) and y > arrGates[i].y and y < (arrGates[i].y + arrGates[i].height)) then
              
                    if (arrGates[i].clicked == false) then    
                
                        arrGates[i].clicked = true;

                    end
    
                    arrGates[i].clickedOffsetX = x - arrGates[i].x;
                    arrGates[i].clickedOffsetY = y - arrGates[i].y;

                    arrGates = gates.setFirst(arrGates, i);
        
                    break   
                      
        end   
    end
end



gates.IOrelease = function ()
    for i = 1, #arrGates do
        arrGates[i].input.a.clicked = false;
        arrGates[i].input.b.clicked = false;
        arrGates[i].output.q.clicked = false;

    end

    for i = 1, #arrStartBlock do
        for b = 1, #arrStartBlock[i].output do
            arrStartBlock[i].output[b].clicked = false;
        end
    end
end



gates.release = function (button)
    if(button == 1) then
        for i = 1, #arrGates do
            arrGates[i].clicked = false;

        end
    end    
end



gates.update = function ()
    
    local x = camera.screenToWorldcords(love.mouse.getX(),love.mouse.getY()).x;
    local y = camera.screenToWorldcords(love.mouse.getX(),love.mouse.getY()).y;

    for i = 1, #arrGates do
        if(arrGates[i].clicked) then

            arrGates[i].x = x - arrGates[i].clickedOffsetX;
            arrGates[i].y = y - arrGates[i].clickedOffsetY;

        end 
    end
end



gates.draw = function ()
    for i = 1, #arrGates do
    
        if(arrGates[i].type == "and") then
            love.graphics.setColor(0, 1, 0, 1);
            love.graphics.draw(andGateImg.file, arrGates[i].x, arrGates[i].y, 0, arrGates[i].width/andGateImg.width, arrGates[i].height/andGateImg.width);
        elseif(arrGates[i].type == "or") then
            love.graphics.setColor(0, 1, 0, 1);
            love.graphics.draw(orGateImg.file, arrGates[i].x, arrGates[i].y, 0, arrGates[i].width/orGateImg.width, arrGates[i].height/orGateImg.width);
        end    

        love.graphics.setColor(0, 0, 1, 1);
        love.graphics.setLineWidth(5);

        if(arrGates[i].clicked) then
            love.graphics.setLineWidth(10)
            love.graphics.rectangle("line", arrGates[i].x, arrGates[i].y, arrGates[i].width, arrGates[i].height);

        elseif(arrGates[i].input.a.clicked) then
            love.graphics.circle("line", arrGates[i].x + arrGates[i].input.a.coords.x, arrGates[i].y + arrGates[i].input.a.coords.y, 20);

        elseif (arrGates[i].input.b.clicked) then  
            love.graphics.circle("line", arrGates[i].x + arrGates[i].input.b.coords.x, arrGates[i].y + arrGates[i].input.b.coords.y, 20);
            
        elseif (arrGates[i].output.q.clicked) then   
            love.graphics.circle("line", arrGates[i].x + arrGates[i].output.q.coords.x, arrGates[i].y + arrGates[i].output.q.coords.y, 20);
            
        end    
    end
end



gates.getIndex = function (name)
    for i = 1, #arrGates do
    
        if(arrGates[i].name == name) then
            return i;
        end        
    end
end



gates.create = function (type)

    if(type == "and") then

        local width = 200;
        local height = 200;

        arrGates[#arrGates + 1] = {
            x = love.mouse.getX(), y = love.mouse.getY(), width = width, height = height, 
            clicked = true, clickedOffsetY = height/2, clickedOffsetX = width/2, 
            type = "and",   
                input = {
                        a = {connect = nil, coords = {x = 76, y = 175},     status = false, clicked = false}, 
                        b = {connect = nil, coords = {x = 125, y = 175},    status = false, clicked = false}}, 
                output = {  
                        q = {connect = {name = nil, port = nil}, coords = {x = 102, y = 10}, status = false, clicked = false}}, 
            rank = 1, --unused variable 
            name = gateName}; 

    elseif(type == "or") then

        local width = 200;
        local height = 200;
        
        arrGates[#arrGates + 1] = {
            x = love.mouse.getX(), y = love.mouse.getY(), width = width, height = height, 
            clicked = true, clickedOffsetY = height/2, clickedOffsetX = width/2, 
            type = "or",    
                input = {
                        a = {connect = nil, coords = {x = 76, y = 175},     status = false, clicked = false}, 
                        b = {connect = nil, coords = {x = 125, y = 175},    status = false, clicked = false}}, 
                output = {
                        q = {connect = {name = nil, port = nil}, coords = {x = 102, y = 10}, status = false, clicked = false}}, 
            rank = 1, --unused variable 
            name = gateName}; 
    end

    gateName = gateName + 1;

end



gates.setFirst = function (arr, index)
        
    local topIndex = table.remove(arr, index);
    arr[#arr + 1] = topIndex;
    return arr;
    
    
end


--hmmm yes, i do not quite understand this one which is why it currently doesn't work. Once i do i will let you know.
--So basically what it does is that it creates an array for all the gates. Then it assigns wether or not the imputs of the gates are ready.
--For example. It starts by handling all of the outputs from the starting block, setting the outputs of the correspongding gates and flagging
--the inputs of the connected gates as ready to be handled.
--Then it sets all non connected inputs as being ready to be handled(If one input is not connected it is considered a logical 0.
--if both inputs are not connected the entire gate is considered handled)
--
--Afterwards it loops through all gates and handles gates which both imputs are ready to be handled until all gates have been handled
--......
--......
--......
--The matrix!

gates.simulate = function ()

    for i = 1, #arrStartBlock do
        for b = 1, #arrStartBlock[i].output do
            if(arrStartBlock[i].output[b].connect.name ~= nil) then

                if(arrStartBlock[i].output[b].connect.port == "a") then
                    print(arrStartBlock[i].output[b].connect.name);
                    arrGates[gates.getIndex(arrStartBlock[i].output[b].connect.name)].input.a.status = arrStartBlock[i].output[b].status;
                end

                if(arrStartBlock[i].output[b].connect.port == "b") then
                    print(arrStartBlock[i].output[b].connect.name);
                    arrGates[gates.getIndex(arrStartBlock[i].output[b].connect.name)].input.b.status = arrStartBlock[i].output[b].status;
                end    
            end    
        end
    end

    local b = 1;
   
    for i = 1, (#arrGates) * (#arrGates) do
        
        if(arrGates[b].type == "and") then
                           
            if(arrGates[b].input.a.status and arrGates[b].input.b.status) then
                arrGates[b].output.q.status = true;
            else
                arrGates[b].output.q.status = false;   
            end    
        end
            
        if(arrGates[b].type == "or") then
                    
            if(arrGates[b].input.a.status or arrGates[b].input.b.status) then
                arrGates[b].output.q.status = true;
            else
                arrGates[b].output.q.status = false;   
            end    
        end    

    
                    
        if(arrGates[b].output.q.connect.port == "a") then
            print(arrGates[b].output.q.connect.name);
            arrGates[gates.getIndex(arrGates[b].output.q.connect.name)].input.a.status = arrGates[b].output.q.status;
        end  

        if(arrGates[b].output.q.connect.port == "b") then
            print(arrGates[b].output.q.connect.name);
            arrGates[gates.getIndex(arrGates[b].output.q.connect.name)].input.b.status = arrGates[b].output.q.status;
        end   

        b = b + 1;
        if(b > #arrGates) then b = 1 end

    end

   

end 



return gates;