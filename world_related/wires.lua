local gates = require "world_related.gates";
local starting_block = require "world_related.starting_block";
local tools = require "world_related.tools"
local goal_block = require "world_related.goal_block"

local wires = {};



wires.load = function ()
    
end


--checks for connected gates and connection to the starting block and draws the corresponding wires
wires.draw = function ()

    love.graphics.setLineWidth(5);
    love.graphics.setColor(0, 1, 0, 1);

    for i = 1, #arrGates do
        
        if(arrGates[i].input.a.connect ~= nil) then

            love.graphics.setColor(0, 1, 0, 1);

            if(arrGates[i].input.a.status) then love.graphics.setColor(1, 0, 0, 1); end

            if(arrGates[i].input.a.connect < firstStartBlockName) then

                local currentIndexOfOutputGate = getindex(arrGates[i].input.a.connect);
                love.graphics.line( arrGates[i].x + arrGates[i].input.a.coords.x,
                                    arrGates[i].y + arrGates[i].input.a.coords.y,
                                    arrGates[currentIndexOfOutputGate].x + arrGates[currentIndexOfOutputGate].output.q.coords.x,
                                    arrGates[currentIndexOfOutputGate].y + arrGates[currentIndexOfOutputGate].output.q.coords.y);
            
            else

                local currentIndexOfOutputGate = starting_block_getIndex(arrGates[i].input.a.connect);   
               
                love.graphics.line( arrGates[i].x + arrGates[i].input.a.coords.x,
                                    arrGates[i].y + arrGates[i].input.a.coords.y,
                                    arrStartBlock[currentIndexOfOutputGate].coords.x + 
                                        arrStartBlock[currentIndexOfOutputGate].output[arrGates[i].input.a.connect-firstStartBlockName].coords.x,
                                    arrStartBlock[currentIndexOfOutputGate].coords.y + 
                                        arrStartBlock[currentIndexOfOutputGate].output[arrGates[i].input.a.connect-firstStartBlockName].coords.y);    
            end    
        end  
        
        if(arrGates[i].input.b.connect ~= nil) then

            love.graphics.setColor(0,1,0,1);

            if(arrGates[i].input.b.status) then love.graphics.setColor(1, 0, 0, 1); end
            
            if(arrGates[i].input.b.connect < firstStartBlockName) then
                local currentIndexOfOutputGate = getindex(arrGates[i].input.b.connect);
               
                love.graphics.line( arrGates[i].x + arrGates[i].input.b.coords.x, 
                                    arrGates[i].y + arrGates[i].input.b.coords.y,
                                    arrGates[currentIndexOfOutputGate].x + 
                                        arrGates[currentIndexOfOutputGate].output.q.coords.x,
                                    arrGates[currentIndexOfOutputGate].y + 
                                        arrGates[currentIndexOfOutputGate].output.q.coords.y);
            
                else

                local currentIndexOfOutputGate = starting_block_getIndex(arrGates[i].input.b.connect);
       
                love.graphics.line( arrGates[i].x + arrGates[i].input.b.coords.x,
                                    arrGates[i].y + arrGates[i].input.b.coords.y,
                                    arrStartBlock[currentIndexOfOutputGate].coords.x + 
                                        arrStartBlock[currentIndexOfOutputGate].output[arrGates[i].input.b.connect-firstStartBlockName].coords.x,
                                    arrStartBlock[currentIndexOfOutputGate].coords.y + 
                                        arrStartBlock[currentIndexOfOutputGate].output[arrGates[i].input.b.connect-firstStartBlockName].coords.y);    
            end    
        end 
    end

    for b = 1, #iGoalBlock.entity.inputs do

        if iGoalBlock.entity.inputs[b].connect ~= nil then
            
            love.graphics.setColor(0,1,0,1);

            if(iGoalBlock.entity.inputs[b].status) then love.graphics.setColor(1, 0, 0, 1); end
        
            if(iGoalBlock.entity.inputs[b].connect < firstStartBlockName) then
                local currentIndexOfOutputGate = getindex(iGoalBlock.entity.inputs[b].connect);
           
                love.graphics.line( iGoalBlock.entity.coords.x + iGoalBlock.entity.inputs[b].coords.x, 
                                    iGoalBlock.entity.coords.y + iGoalBlock.entity.inputs[b].coords.y,
                                    arrGates[currentIndexOfOutputGate].x + 
                                        arrGates[currentIndexOfOutputGate].output.q.coords.x,
                                    arrGates[currentIndexOfOutputGate].y + 
                                        arrGates[currentIndexOfOutputGate].output.q.coords.y);
        
            else
                local currentIndexOfOutputGate = starting_block_getIndex(iGoalBlock.entity.inputs[b].connect);
   
                love.graphics.line( iGoalBlock.entity.coords.x + iGoalBlock.entity.inputs[b].coords.x,
                                    iGoalBlock.entity.coords.y + iGoalBlock.entity.inputs[b].coords.y,
                                    arrStartBlock[currentIndexOfOutputGate].coords.x + 
                                        arrStartBlock[currentIndexOfOutputGate].output[iGoalBlock.entity.inputs[b].connect-firstStartBlockName].coords.x,
                                    arrStartBlock[currentIndexOfOutputGate].coords.y + 
                                        arrStartBlock[currentIndexOfOutputGate].output[iGoalBlock.entity.inputs[b].connect-firstStartBlockName].coords.y);    
            end
        end
    end
end

--wires.connect first loops through all the gates and determines which two gates have been clicked. Then, if two gates have been clicked. Connects them
--by setting the connected input/output names of the corresponding ports to the correct names.
wires.connect = function ()
    
    local gatepair = {input = {gateName = nil, port = nil, currentIndex = nil}, output = {gateName = nil, rank = nil, currentIndex = nil}}
    
    for i = 1, #arrGates do

        if(arrGates[i].input.a.clicked) then

            if arrGates[i].input.a.connect == nil then
                gatepair.input.gateName = arrGates[i].name;
                gatepair.input.port = "a";
                gatepair.input.currentIndex = i;
            else
                gates.IOrelease();     
            end

        end

        if (arrGates[i].input.b.clicked) then

            if arrGates[i].input.b.connect == nil then
                gatepair.input.gateName = arrGates[i].name;
                gatepair.input.port = "b"; 
                gatepair.input.currentIndex = i;
            else
                gates.IOrelease(); 
            end
            
        end

        if (arrGates[i].output.q.clicked) then

            if arrGates[i].output.q.connect.name == nil then

                gatepair.output.gateName = arrGates[i].name;
                gatepair.output.currentIndex = i;
                gatepair.output.rank = arrGates[i].rank;  

            else
                gates.IOrelease(); 
            end

        end   
    end

    for i = 1, #arrStartBlock do

        for b = 1, #arrStartBlock[i].output do

            if (arrStartBlock[i].output[b].clicked) then

                if arrStartBlock[i].output[b].connect.name == nil then
                    gatepair.output.gateName = arrStartBlock[i].name + b;
                    gatepair.output.currentIndex = i;
                    gatepair.output.rank = 0;
                else 
                    gates.IOrelease();
                end

            end
        end
    end

    for b = 1, #iGoalBlock.entity.inputs do

        if (iGoalBlock.entity.inputs[b].clicked) then

            if iGoalBlock.entity.inputs[b].connect == nil then
                gatepair.input.gateName = iGoalBlock.entity.name;
                gatepair.input.port = b;
            else
                gates.IOrelease();    
            end

        end
    end

    if((gatepair.input.gateName ~= nil) and (gatepair.output.gateName ~= nil)) then

        if (gatepair.input.gateName >= goalblockFirstStart) then

            if (gatepair.input.port > 0) then
        
                if  (gatepair.output.gateName < firstStartBlockName) then
                
                    tools.delete(gatepair.output.gateName,gatepair.input.port);
                    iGoalBlock.entity.inputs[gatepair.input.port].connect = gatepair.output.gateName;
                
                else

                    iGoalBlock.entity.inputs[gatepair.input.port].connect = gatepair.output.gateName;    

                end
            end
        else

            if(gatepair.input.port == "a") then

                if gatepair.output.gateName < firstStartBlockName then
                    tools.delete(gatepair.input.gateName,gatepair.input.port);
                end
                
                arrGates[gatepair.input.currentIndex].input.a.connect = gatepair.output.gateName;
            
            end
    
            if(gatepair.input.port == "b") then

                if gatepair.output.gateName < firstStartBlockName then
                    tools.delete(gatepair.input.gateName,gatepair.input.port);
                end

                arrGates[gatepair.input.currentIndex].input.b.connect = gatepair.output.gateName;
            
            end
        end

        if(gatepair.output.gateName >= firstStartBlockName) then 

            if gatepair.input.gateName  >= goalblockFirstStart then
                if (iGoalBlock.entity.inputs[gatepair.input.port].connect ~= nil) or 
                   
                    arrStartBlock[starting_block_getIndex(gatepair.output.name)].output[gatepair.output.gateName-firstStartBlockName].connect.name ~= nil then
                    tools.delete(gatepair.output.gateName,gatepair.output.gateName-firstStartBlockName);          
                
                end
            else
                tools.delete(gatepair.output.gateName,gatepair.output.gateName-firstStartBlockName);                    
            end

            arrStartBlock[starting_block_getIndex(gatepair.output.gateName)].output[gatepair.output.gateName-firstStartBlockName].connect = 
            {name = gatepair.input.gateName, port = gatepair.input.port};

        else

            if(arrGates[gatepair.output.currentIndex].type ~= "node") then
                tools.delete(gatepair.output.gateName,"q");
                arrGates[gatepair.output.currentIndex].output.q.connect = {name = gatepair.input.gateName, port = gatepair.input.port};  
            end

            if(arrGates[gatepair.output.currentIndex].type == "node") then
                arrGates[gatepair.output.currentIndex].output.q.connect[#arrGates[gatepair.output.currentIndex].output.q.connect + 1] = 
                {name = gatepair.input.gateName, port = gatepair.input.port};  
            end
        end

        gates.IOrelease();

    end    
end

return wires;