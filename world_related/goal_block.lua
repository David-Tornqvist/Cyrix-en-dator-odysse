local gates = require "world_related.gates";
local camera = require "screen_related.camera";
local tools = require "world_related.tools";

local goalblock = {};


goalblock.load = function ()

    goalblockFirstStart = 1000000000000;

    iGoalblock = {
        create = function (x,y,nInput)

            iGoalblock.entity = {coords = {x = x, y = y}, dimensions = {width = (nInput + 1)*50, height = 100}, inputs = {}, name = goalblockFirstStart};
            
            for i = 1, nInput do
                iGoalblock.entity.inputs[i] = {connect = nil, coords = {x = i*50, y = 140}, status = false, clicked = false};
            end
        end,



        draw = function ()
            love.graphics.setColor(0, 1, 0, 1);
            love.graphics.setLineWidth(5);

            love.graphics.rectangle("line", iGoalblock.entity.coords.x, iGoalblock.entity.coords.y, iGoalblock.entity.dimensions.width, iGoalblock.entity.dimensions.height);

            for b = 1, #iGoalblock.entity.inputs do

                if(iGoalblock.entity.inputs[b].status) then love.graphics.setColor(1, 0, 0, 1); end
                    
                love.graphics.line( iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x, iGoalblock.entity.coords.y + iGoalblock.entity.dimensions.height,
                                    iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x, iGoalblock.entity.coords.y + iGoalblock.entity.inputs[b].coords.y);
            
            
                love.graphics.circle("fill", iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x, iGoalblock.entity.coords.y + iGoalblock.entity.dimensions.height/2,20)
                love.graphics.setColor(0, 1, 0, 1);

                if(iGoalblock.entity.inputs[b].clicked)then

                    love.graphics.setColor(0, 0, 1, 1);
                    love.graphics.circle("line", iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x, iGoalblock.entity.coords.y + iGoalblock.entity.inputs[b].coords.y, 20);
                    love.graphics.setColor(0, 1, 0, 1);
            
                end    
            end
        end,

        click = function (button)
            local x =  camera.screenToWorldcords(love.mouse.getX(), love.mouse.getY()).x;
            local y =  camera.screenToWorldcords(love.mouse.getX(), love.mouse.getY()).y;

            for b = 1, #iGoalblock.entity.inputs do
        
                if(button == 2 and  x > (iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x - 10) and 
                                    x < (iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x + 10) and 
                                    y > (iGoalblock.entity.coords.y + iGoalblock.entity.inputs[b].coords.y - 10) and 
                                    y < (iGoalblock.entity.coords.y + iGoalblock.entity.inputs[b].coords.y + 10)) then
                
                    if isDelete == false then
                        gates.IOrelease("inputs");
                        iGoalblock.entity.inputs[b].clicked = true;
                        portUpdate = true;
                    else
                        if iGoalblock.entity.inputs[b].connect ~= nil then
                            if arrGates[getindex(iGoalblock.entity.inputs[b].connect)].type ~= "node" then
                                tools.delete(iGoalblock.entity.name,b);
                            else
                                tools.deleteNodeWire(iGoalblock.entity.inputs[b].connect,tools.findNodeOutputIndex(iGoalblock.entity.inputs[b].connect,iGoalblock.entity.name));
                            end
                        end
                    end
                end    
            end    
        end,

        findPortThatConnect = function (gateName)
        
            for i = 1, #iGoalblock.entity.inputs do
                if iGoalblock.entity.inputs[i].connect == gateName then
                    return i;
                end
            end
            
        end
    }
end

return goalblock