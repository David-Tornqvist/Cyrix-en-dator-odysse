local camera = require "screen_related.camera";
local tools = require "world_related.tools"




local gates = {};

getindex = function (name)
    for i = 1, #arrGates do
    
        if(arrGates[i].name == name) then
            return i;
        end        
    end
end



gates.load = function ()

    arrGates = {};

    andGateImg = {file = love.graphics.newImage("graphics/And_gate.png"), width = 1080, height = 1080};
    orGateImg = {file = love.graphics.newImage("graphics/Or_gate.png"), width = 1080, height = 1080};
    norGateImg = {file = love.graphics.newImage("graphics/Nor_gate.png"), width = 1080, height = 1080};
    nandGateImg = {file = love.graphics.newImage("graphics/Nand_gate.png"), width = 1080, height = 1080};
    xorGateImg = {file = love.graphics.newImage("graphics/Xor_gate.png"), width = 1080, height = 1080};
    xnorGateImg = {file = love.graphics.newImage("graphics/Xnor_gate.png"), width = 1080, height = 1080};
    notGateImg = {file = love.graphics.newImage("graphics/not_gate.png"), width = 1080, height = 1080};

    gateName = 1;

    

end



gates.click = function (mouseX, mouseY, button)

    local x =  camera.screenToWorldcords(mouseX, mouseY).x;
    local y =  camera.screenToWorldcords(mouseX, mouseY).y;
    
    --loops through all currently created gates
    for i = #arrGates, 1, -1 do

        if((arrGates[i].type ~= "not") and (arrGates[i].type ~= "node") )then
                --checks if either of the two inputs a,b or the output q is clicked
            if( button == 2 and x > (arrGates[i].x + arrGates[i].input.a.coords.x - 10) and x < (arrGates[i].x + arrGates[i].input.a.coords.x + 10) 
                and y > (arrGates[i].y + arrGates[i].input.a.coords.y - 10) and y < (arrGates[i].y + arrGates[i].input.a.coords.y + 10)) then

                if isDelete == false then
                    gates.IOrelease("inputs");    
                    arrGates[i].input.a.clicked = true;
                    portUpdate = true;
                else
                    tools.delete(arrGates[i].name,"a");
                end
            end        

            if (button == 2 and x > (arrGates[i].x + arrGates[i].input.b.coords.x - 10) and x < (arrGates[i].x + arrGates[i].input.b.coords.x + 10) 
                    and y > (arrGates[i].y + arrGates[i].input.b.coords.y - 10) and y < (arrGates[i].y + arrGates[i].input.b.coords.y + 10)) then  
                
                if isDelete == false then
                    gates.IOrelease("inputs");        
                    arrGates[i].input.b.clicked = true;
                    portUpdate = true;
                else
                    tools.delete(arrGates[i].name,"b");        
                end
            end 

            if (button == 2 and x > (arrGates[i].x + arrGates[i].output.q.coords.x - 10) and x < (arrGates[i].x + arrGates[i].output.q.coords.x + 10) 
                    and y > (arrGates[i].y + arrGates[i].output.q.coords.y - 10) and y < (arrGates[i].y + arrGates[i].output.q.coords.y + 10)) then
        
                if isDelete == false then
                    gates.IOrelease("outputs");         
                    arrGates[i].output.q.clicked = true;
                    portUpdate = true;
                else
                    tools.delete(arrGates[i].name,"q");
                end        
            end    
            
                --or if the gate itself where clicked
            if( button == 1 and x > arrGates[i].x and x < (arrGates[i].x + arrGates[i].width) and y > arrGates[i].y and y < (arrGates[i].y + arrGates[i].height)) then
              
                if isDelete == false then
                    
                    if (arrGates[i].clicked == false) then    
                
                        arrGates[i].clicked = true;
                        
    
                    end

                    arrGates[i].clickedOffsetX = x - arrGates[i].x;
                    arrGates[i].clickedOffsetY = y - arrGates[i].y;

                    arrGates = gates.setFirst(arrGates, i);

                else
                    tools.deleteGate(arrGates[i].name);    
                end
        
                break   
                      
            end   


        elseif(arrGates[i].type == "not") then
            if( button == 2 and x > (arrGates[i].x + arrGates[i].input.a.coords.x - 10) and x < (arrGates[i].x + arrGates[i].input.a.coords.x + 10) 
                and y > (arrGates[i].y + arrGates[i].input.a.coords.y - 10) and y < (arrGates[i].y + arrGates[i].input.a.coords.y + 10)) then

                if isDelete == false then
                    gates.IOrelease("inputs");     
                    arrGates[i].input.a.clicked = true;
                    portUpdate = true;
                else
                    tools.delete(arrGates[i].name,"a");
                end
                
            elseif (button == 2 and x > (arrGates[i].x + arrGates[i].output.q.coords.x - 10) and x < (arrGates[i].x + arrGates[i].output.q.coords.x + 10) 
                    and y > (arrGates[i].y + arrGates[i].output.q.coords.y - 10) and y < (arrGates[i].y + arrGates[i].output.q.coords.y + 10)) then

                if isDelete == false then
                    gates.IOrelease("outputs"); 
                    arrGates[i].output.q.clicked = true;
                    portUpdate = true;
                else
                    tools.delete(arrGates[i].name,"q");
                end
               
                
            elseif( button == 1 and x > arrGates[i].x and x < (arrGates[i].x + arrGates[i].width) and y > arrGates[i].y and y < (arrGates[i].y + arrGates[i].height)) then
              
                if (arrGates[i].clicked == false) then    
                
                    arrGates[i].clicked = true;

                end
    
                arrGates[i].clickedOffsetX = x - arrGates[i].x;
                arrGates[i].clickedOffsetY = y - arrGates[i].y;

                arrGates = gates.setFirst(arrGates, i);
        
                break   

            end



        elseif(arrGates[i].type == "node") then
            
            if( button == 1 and x > arrGates[i].x and x < (arrGates[i].x + arrGates[i].width) and y > arrGates[i].y and y < (arrGates[i].y + arrGates[i].height)) then
                
                if (arrGates[i].clicked == false) then    
                
                    arrGates[i].clicked = true;

                end

                arrGates = gates.setFirst(arrGates, i);
                
                break
            
            elseif ( button == 2 and x > arrGates[i].x and x < (arrGates[i].x + arrGates[i].width) and y > arrGates[i].y and y < (arrGates[i].y + arrGates[i].height)) then
                
                

                local inputHasBeenClicked = false;
                local outputHasBeenclicked = false;

                for b = 1, #arrGates do

                    if(arrGates[b].type ~= "node") then
                        if(arrGates[b].input.a.clicked or arrGates[b].input.b.clicked) then
                            inputHasBeenClicked = true;
                        end
    
                        if(arrGates[b].output.q.clicked) then
                            outputHasBeenclicked = true;    
                        end
                    end
                end

                for c = 1, #arrStartBlock do
                    for d = 1, #arrStartBlock[c].output do
                        if(arrStartBlock[c].output[d].clicked) then
                           outputHasBeenclicked = true; 
                        end
                    end
                end

                if(outputHasBeenclicked) then
                    arrGates[i].input.a.clicked = true;
                end

                if(inputHasBeenClicked) then
                    arrGates[i].output.q.clicked = true;
                end

            end
        end
    end
end    




gates.IOrelease = function (IO)
    if(IO == nil) then
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

    if(IO == "inputs") then
        for i = 1, #arrGates do
            
            arrGates[i].input.a.clicked = false;
            arrGates[i].input.b.clicked = false;

        end
    end

    if(IO == "outputs") then

        for i = 1, #arrGates do
        
            arrGates[i].output.q.clicked = false;

        end
        
        for i = 1, #arrStartBlock do
            for b = 1, #arrStartBlock[i].output do
                arrStartBlock[i].output[b].clicked = false;
            end
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
    
        love.graphics.setColor(0, 1, 0, 1);
        if(arrGates[i].type == "and") then
            love.graphics.draw(andGateImg.file, arrGates[i].x, arrGates[i].y, 0, arrGates[i].width/andGateImg.width, arrGates[i].height/andGateImg.width);
        elseif(arrGates[i].type == "or") then
            love.graphics.draw(orGateImg.file, arrGates[i].x, arrGates[i].y, 0, arrGates[i].width/orGateImg.width, arrGates[i].height/orGateImg.width);
        elseif(arrGates[i].type == "nor") then
            love.graphics.draw(norGateImg.file, arrGates[i].x, arrGates[i].y, 0, arrGates[i].width/norGateImg.width, arrGates[i].height/norGateImg.width);
        elseif(arrGates[i].type == "nand") then
            love.graphics.draw(nandGateImg.file, arrGates[i].x, arrGates[i].y, 0, arrGates[i].width/nandGateImg.width, arrGates[i].height/nandGateImg.width);
        elseif(arrGates[i].type == "xor") then
            love.graphics.draw(xorGateImg.file, arrGates[i].x, arrGates[i].y, 0, arrGates[i].width/xorGateImg.width, arrGates[i].height/xorGateImg.width);
        elseif(arrGates[i].type == "xnor") then
            love.graphics.draw(xnorGateImg.file, arrGates[i].x, arrGates[i].y, 0, arrGates[i].width/xnorGateImg.width, arrGates[i].height/xnorGateImg.width);
        elseif(arrGates[i].type == "not") then
            love.graphics.draw(notGateImg.file, arrGates[i].x, arrGates[i].y, 0, arrGates[i].width/notGateImg.width, arrGates[i].height/notGateImg.width);
        elseif(arrGates[i].type == "node") then
            if(arrGates[i].input.a.status)then
                love.graphics.setColor(1, 0, 0, 1);
            end
            love.graphics.circle("fill", arrGates[i].x + arrGates[i].width/2, arrGates[i].y + arrGates[i].width/2, arrGates[i].width/2);     
        end    

        love.graphics.setColor(0, 0, 1, 1);
        love.graphics.setLineWidth(5);

        if(arrGates[i].type ~= "node")then
            if(arrGates[i].clicked) then
                
                love.graphics.setLineWidth(10)
                love.graphics.rectangle("line", arrGates[i].x, arrGates[i].y, arrGates[i].width, arrGates[i].height);

            end
    
            if(arrGates[i].input.a.clicked) then
                love.graphics.circle("line", arrGates[i].x + arrGates[i].input.a.coords.x, arrGates[i].y + arrGates[i].input.a.coords.y, 20);
            end

            if (arrGates[i].input.b.clicked) then  
                love.graphics.circle("line", arrGates[i].x + arrGates[i].input.b.coords.x, arrGates[i].y + arrGates[i].input.b.coords.y, 20);
            end    
            
            if (arrGates[i].output.q.clicked) then   
                love.graphics.circle("line", arrGates[i].x + arrGates[i].output.q.coords.x, arrGates[i].y + arrGates[i].output.q.coords.y, 20);
                
            end     
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



    elseif(type == "nor") then

        local width = 200;
        local height = 200;
        
        arrGates[#arrGates + 1] = {
            x = love.mouse.getX(), y = love.mouse.getY(), width = width, height = height, 
            clicked = true, clickedOffsetY = height/2, clickedOffsetX = width/2, 
            type = "nor",    
                input = {
                        a = {connect = nil, coords = {x = 76, y = 175},     status = false, clicked = false}, 
                        b = {connect = nil, coords = {x = 125, y = 175},    status = false, clicked = false}}, 
                output = {
                        q = {connect = {name = nil, port = nil}, coords = {x = 102, y = 10}, status = false, clicked = false}}, 
            rank = 1, --unused variable 
            name = gateName}; 


    
    elseif(type == "nand") then

        local width = 200;
        local height = 200;
        
        arrGates[#arrGates + 1] = {
            x = love.mouse.getX(), y = love.mouse.getY(), width = width, height = height, 
            clicked = true, clickedOffsetY = height/2, clickedOffsetX = width/2, 
            type = "nand",    
                input = {
                        a = {connect = nil, coords = {x = 76, y = 175},     status = false, clicked = false}, 
                        b = {connect = nil, coords = {x = 125, y = 175},    status = false, clicked = false}}, 
                output = {
                        q = {connect = {name = nil, port = nil}, coords = {x = 102, y = 10}, status = false, clicked = false}}, 
            rank = 1, --unused variable 
            name = gateName}; 



    elseif(type == "xor") then

        local width = 200;
        local height = 200;
        
        arrGates[#arrGates + 1] = {
            x = love.mouse.getX(), y = love.mouse.getY(), width = width, height = height, 
            clicked = true, clickedOffsetY = height/2, clickedOffsetX = width/2, 
            type = "xor",    
                input = {
                        a = {connect = nil, coords = {x = 76, y = 175},     status = false, clicked = false}, 
                        b = {connect = nil, coords = {x = 125, y = 175},    status = false, clicked = false}}, 
                output = {
                        q = {connect = {name = nil, port = nil}, coords = {x = 102, y = 10}, status = false, clicked = false}}, 
            rank = 1, --unused variable 
            name = gateName}; 



    elseif(type == "xnor") then

        local width = 200;
        local height = 200;
        
        arrGates[#arrGates + 1] = {
            x = love.mouse.getX(), y = love.mouse.getY(), width = width, height = height, 
            clicked = true, clickedOffsetY = height/2, clickedOffsetX = width/2, 
            type = "xnor",    
                input = {
                        a = {connect = nil, coords = {x = 76, y = 175},     status = false, clicked = false}, 
                        b = {connect = nil, coords = {x = 125, y = 175},    status = false, clicked = false}}, 
                output = {
                        q = {connect = {name = nil, port = nil}, coords = {x = 102, y = 10}, status = false, clicked = false}}, 
            rank = 1, --unused variable 
            name = gateName};


            
    elseif(type == "not") then

        local width = 200;
        local height = 200;
        
        arrGates[#arrGates + 1] = {
            x = love.mouse.getX(), y = love.mouse.getY(), width = width, height = height, 
            clicked = true, clickedOffsetY = height/2, clickedOffsetX = width/2, 
            type = "not",    
                input = {
                        a = {connect = nil, coords = {x = 102, y = 175},     status = false, clicked = false}, 
                        b = {connect = nil, coords = {x = nil, y = nil},    status = false, clicked = false}}, 
                output = {
                        q = {connect = {name = nil, port = nil}, coords = {x = 103, y = 40}, status = false, clicked = false}}, 
            rank = 1, --unused variable 
            name = gateName};
            


    elseif(type == "node") then

        local width = 30;
        local height = 30;
        
        arrGates[#arrGates + 1] = {
            x = love.mouse.getX(), y = love.mouse.getY(), width = width, height = height, 
            clicked = true, clickedOffsetY = height/2, clickedOffsetX = width/2, 
            type = "node",    
                input = {
                        a = {connect = nil, coords = {x = 15, y = 15},     status = false, clicked = false}, 
                        b = {connect = nil, coords = {x = nil, y = nil},    status = false, clicked = false}}, 
                output = {
                        q = {connect = {}, coords = {x = 15, y = 15}, status = false, clicked = false}}, 
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



--First it sets all the gates connected to starting block acording to the outputs of the starting block
--Then it loops through all the gates and sets their inputs acording to their outputs multiple times until all the signals have propagated through the circuit
gates.simulate = function ()

    for i = 1, #arrStartBlock do
        for b = 1, #arrStartBlock[i].output do
            if(arrStartBlock[i].output[b].connect.name ~= nil) then

                if(arrStartBlock[i].output[b].connect.port == "a") then
                    arrGates[getindex(arrStartBlock[i].output[b].connect.name)].input.a.status = arrStartBlock[i].output[b].status;
                end

                if(arrStartBlock[i].output[b].connect.port == "b") then
                    arrGates[getindex(arrStartBlock[i].output[b].connect.name)].input.b.status = arrStartBlock[i].output[b].status;
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


            
        elseif(arrGates[b].type == "or") then
                    
            if(arrGates[b].input.a.status or arrGates[b].input.b.status) then
                arrGates[b].output.q.status = true;
            else
                arrGates[b].output.q.status = false;   
            end    



        elseif(arrGates[b].type == "nand") then
                           
                if(not(arrGates[b].input.a.status and arrGates[b].input.b.status)) then
                    arrGates[b].output.q.status = true;
                else
                    arrGates[b].output.q.status = false;   
                end   
                

                
        elseif(arrGates[b].type == "nor") then
                    
            if(not(arrGates[b].input.a.status or arrGates[b].input.b.status)) then
                arrGates[b].output.q.status = true;
            else
                arrGates[b].output.q.status = false;   
            end         
        

        
        elseif(arrGates[b].type == "xor") then
                    
            if((arrGates[b].input.a.status or arrGates[b].input.b.status) and (not (arrGates[b].input.a.status and arrGates[b].input.b.status))) then
                arrGates[b].output.q.status = true;
            else
                arrGates[b].output.q.status = false;   
            end



        elseif(arrGates[b].type == "xnor") then
                    
            if(not((arrGates[b].input.a.status or arrGates[b].input.b.status) and (not (arrGates[b].input.a.status and arrGates[b].input.b.status)))) then
                arrGates[b].output.q.status = true;
            else
                arrGates[b].output.q.status = false;   
            end
            


        elseif(arrGates[b].type == "not") then
                    
            arrGates[b].output.q.status = not(arrGates[b].input.a.status);



        elseif(arrGates[b].type == "node") then

            arrGates[b].output.q.status = arrGates[b].input.a.status;

        end    



        if (arrGates[b].type ~= "node") then

            if(arrGates[b].output.q.connect.port == "a") then
                arrGates[getindex(arrGates[b].output.q.connect.name)].input.a.status = arrGates[b].output.q.status;
            end  
    
            if(arrGates[b].output.q.connect.port == "b") then
                arrGates[getindex(arrGates[b].output.q.connect.name)].input.b.status = arrGates[b].output.q.status;
            end    
        end

        if (arrGates[b].type == "node") then

            for c = 1, #arrGates[b].output.q.connect do
                
                if(arrGates[b].output.q.connect[c].port == "a") then
                    arrGates[getindex(arrGates[b].output.q.connect[c].name)].input.a.status = arrGates[b].output.q.status;
                end 

                if(arrGates[b].output.q.connect[c].port == "b") then
                    arrGates[getindex(arrGates[b].output.q.connect[c].name)].input.b.status = arrGates[b].output.q.status;
                end 

            end
            
            
        end
        


        b = b + 1;
        if(b > #arrGates) then b = 1 end

    end
end 



return gates;