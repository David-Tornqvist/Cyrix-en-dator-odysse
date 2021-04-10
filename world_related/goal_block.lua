local gates = require "world_related.gates";
local camera = require "screen_related.camera";
local tools = require "world_related.tools";
local starting_block = require "world_related.starting_block"

local goalblock = {};


goalblock.load = function ()

    goalblockFirstStart = 1000000000000;

    iGoalblock = {
        create = function (x,y,nInput)

            iGoalblock.entity = {coords = {x = x, y = y}, dimensions = {width = (nInput + 1)*50, height = 100}, inputs = {}, name = goalblockFirstStart,
                                truthTable = {}};
            
            for i = 1, nInput do
                iGoalblock.entity.inputs[i] = {connect = nil, coords = {x = i*50, y = 140}, status = false, clicked = false, hover = false, correct = false};
                iGoalblock.entity.truthTable[i] = {};
                for b = 0, tools.pow(2,#arrStartBlock[1].output) - 1 do
                    if love.math.random() > 0.5 then
                        iGoalblock.entity.truthTable[i][b] = true;
                    else
                        iGoalblock.entity.truthTable[i][b] = false;    
                    end
                    
                end
            end
        end,

        simulate = function ()

            local inputs = starting_block.getOutputs();
            local status = {};

            for i = 1, #inputs do
                if inputs[i] then
                    status[i] = 1;
                else
                    status[i] = 0;
                end
            end

            for i = 1, #iGoalblock.entity.inputs do

                if iGoalblock.entity.truthTable[i][tools.binaryToDecimal(inputs)] == iGoalblock.entity.inputs[i].status then
                    iGoalblock.entity.inputs[i].correct = true;
                else
                    iGoalblock.entity.inputs[i].correct = false;    
                end
            end
        end,



        draw = function ()
            love.graphics.setColor(0, 1, 0, 1);
            love.graphics.setLineWidth(5);

            love.graphics.rectangle("line", iGoalblock.entity.coords.x, iGoalblock.entity.coords.y, iGoalblock.entity.dimensions.width, iGoalblock.entity.dimensions.height);
            love.graphics.rectangle("line", iGoalblock.entity.coords.x, iGoalblock.entity.coords.y - iGoalblock.entity.dimensions.height, iGoalblock.entity.dimensions.width, iGoalblock.entity.dimensions.height);
            

            for b = 1, #iGoalblock.entity.inputs do

                if(iGoalblock.entity.inputs[b].status) then love.graphics.setColor(1, 0, 0, 1); end
                    
                love.graphics.line( iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x, iGoalblock.entity.coords.y + iGoalblock.entity.dimensions.height,
                                    iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x, iGoalblock.entity.coords.y + iGoalblock.entity.inputs[b].coords.y);
            
            
                love.graphics.circle("fill", iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x, iGoalblock.entity.coords.y + iGoalblock.entity.dimensions.height/2,20);
                love.graphics.print("Y" .. (b - 1), iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x, iGoalblock.entity.coords.y + iGoalblock.entity.dimensions.height/2 + 30);
                love.graphics.setColor(0, 1, 0, 1);



                if(iGoalblock.entity.inputs[b].correct) then love.graphics.setColor(1, 0, 0, 1); end

                love.graphics.circle(   "fill", iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x, 
                                        iGoalblock.entity.coords.y + iGoalblock.entity.dimensions.height/2 - iGoalblock.entity.dimensions.height,20);

                love.graphics.setColor(0, 1, 0, 1);

                if(iGoalblock.entity.inputs[b].clicked or iGoalblock.entity.inputs[b].hover)then

                    love.graphics.setColor(0, 0, 1, 1);
                    love.graphics.circle("line", iGoalblock.entity.coords.x + iGoalblock.entity.inputs[b].coords.x, iGoalblock.entity.coords.y + iGoalblock.entity.inputs[b].coords.y, 20);
                    love.graphics.setColor(0, 1, 0, 1);
            
                end    
            end
        end,

        truthTableDraw = function ()

            --local height = 20;
            love.graphics.setColor(0, 1, 0, 1);

            love.graphics.setLineWidth(1);
            --love.graphics.rectangle("line",0, 1080-height, 55, height);
            --love.graphics.print("outputs",4,1080-height+2);
            
            
            local x = 0;
            local y = 380;
            local rowheight = 20;

            local inputsWidth = 50;
            if (25 * #arrStartBlock[1].output > 50)  then
                inputsWidth = 25 * (#arrStartBlock[1].output) 
            end

            local outputsWidth = 55;
            if (25 * #iGoalblock.entity.inputs > 50)  then
                outputsWidth = 25 * (#iGoalblock.entity.inputs) 
            end


            local tableWidth = inputsWidth + outputsWidth;
            local inputSlotWidth = inputsWidth/#arrStartBlock[1].output;
            local outputSlotWidth = outputsWidth/#iGoalblock.entity.inputs;

            local a = starting_block.getOutputs();
            local status = {};
            for i = 1, #arrStartBlock[1].output do
                if a[i] then
                    status[i] = 1;
                else
                    status[i] = 0;    
                end
            end

            love.graphics.setColor(1, 1, 0, 1);
            love.graphics.rectangle("fill",x, y + rowheight * tools.binaryToDecimal(status) + 2 * rowheight,inputsWidth,rowheight);
            love.graphics.setColor(0, 1, 0, 1);

            levelComplete = true;

            for i = 1, tools.pow(2,#arrStartBlock[1].output) + 1 do
                love.graphics.line(x,y + i*rowheight, x + tableWidth, y + i*rowheight);
            
                if i < tools.pow(2,#arrStartBlock[1].output) + 1 then

                    starting_block.setOutputs(tools.decimalToBinary(i - 1,#arrStartBlock[1].output));
                    gates.simulate();
                    iGoalblock.simulate();

                    for b = 1, #arrStartBlock[1].output do
                        love.graphics.print(tools.findBinaryDigit(i - 1,b),x + inputsWidth - (b * inputSlotWidth) + inputSlotWidth/2 -5, y + rowheight * (i + 1) + 3);
                    end
                
                    for b = 1, #iGoalblock.entity.inputs do

                        if iGoalblock.entity.inputs[b].correct then
                            love.graphics.setColor(1, 1, 0, 1);
                            love.graphics.rectangle("fill", x + inputsWidth + outputSlotWidth * (b - 1), y + rowheight * (i + 1),outputSlotWidth,rowheight);
                            love.graphics.setColor(0, 1, 0, 1);
                        else
                            levelComplete = false;    
                        end

                        if iGoalblock.entity.truthTable[b][i - 1] then
                            love.graphics.print(1,x + inputsWidth + outputSlotWidth * b - outputSlotWidth/2 - 5, y + rowheight * (i + 1) + 3);
                        else
                            love.graphics.print(0,x + inputsWidth + outputSlotWidth * b - outputSlotWidth/2 - 5, y + rowheight * (i + 1) + 3);
                        end      
                    end
                end    
            end

            starting_block.setOutputs(status);
            gates.simulate();
            iGoalblock.simulate();

            for i = 1, #arrStartBlock[1].output do
                love.graphics.line(x + i * inputSlotWidth, y + rowheight, x + i * inputSlotWidth, y + (tools.pow(2,#arrStartBlock[1].output)*rowheight + 2*rowheight));
                love.graphics.print(tools.numTolet(i),x + (i - 1) * inputSlotWidth + inputSlotWidth/2 - 5, y + rowheight + 3);
            end

            for i = 1, #iGoalblock.entity.inputs do
                love.graphics.line(x + inputsWidth + outputSlotWidth * i, y + rowheight, x + inputsWidth + outputSlotWidth * i, y + (tools.pow(2,#arrStartBlock[1].output)*rowheight + 2*rowheight));
                love.graphics.print("Y" .. (i - 1),x + inputsWidth + (i - 1) * outputSlotWidth + outputSlotWidth/2 - 7, y + rowheight + 3);
            end

            love.graphics.setLineWidth(1);
            love.graphics.rectangle("line",x,y, tableWidth, (tools.pow(2,#arrStartBlock[1].output)*rowheight + 2*rowheight));
            love.graphics.line(inputsWidth, y, inputsWidth, y + (tools.pow(2,#arrStartBlock[1].output)*rowheight + 2*rowheight));
            love.graphics.print("inputs", x + 4, y + 2);
            love.graphics.print("outputs", x + inputsWidth + 4, y + 2);

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
                            if iGoalblock.entity.inputs[b].connect < firstStartBlockName then
                                if arrGates[getindex(iGoalblock.entity.inputs[b].connect)].type ~= "node" then
                                    tools.delete(iGoalblock.entity.name,b);
                                else
                                    tools.deleteNodeWire(iGoalblock.entity.inputs[b].connect,tools.findNodeOutputIndex(iGoalblock.entity.inputs[b].connect,iGoalblock.entity.name,b));
                                end 
                            else
                                tools.delete(iGoalblock.entity.name,b);
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