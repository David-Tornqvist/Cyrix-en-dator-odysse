local camera = require "screen_related.camera";
local gates = require "world_related.gates"
local startingBlock = {};



startingBlock.load = function ()

    arrStartBlock = {};
    startName = 10000000000000;
    firstStartBlockName = 10000000000000;

end



startingBlock.create = function (x, y, nOutput)

    arrStartBlock[#arrStartBlock+1] =  {coords = {x = x, y = y}, dimensions = {width = (nOutput + 1)*50, height = 100}, output = {}, name = startName};

    startName = startName + nOutput;


    for i = 1, nOutput do
        arrStartBlock[#arrStartBlock].output[i] = {connect = {name = nil, port = nil}, coords = {x = i*50, y = -40}, status = false, clicked = false};
    end
end



startingBlock.draw = function ()

    love.graphics.setColor(0, 1, 0, 1);
    love.graphics.setLineWidth(5);
    
    for i = 1, #arrStartBlock do

        love.graphics.rectangle("line", arrStartBlock[i].coords.x, arrStartBlock[i].coords.y, arrStartBlock[i].dimensions.width, arrStartBlock[i].dimensions.height);

        for b = 1, #arrStartBlock[i].output do

            if(arrStartBlock[i].output[b].status) then love.graphics.setColor(1, 0, 0, 1); end
            love.graphics.line( arrStartBlock[i].coords.x + arrStartBlock[i].output[b].coords.x, arrStartBlock[i].coords.y,
                                arrStartBlock[i].coords.x + arrStartBlock[i].output[b].coords.x, arrStartBlock[i].coords.y + arrStartBlock[i].output[b].coords.y);
            
            
            love.graphics.circle("fill", arrStartBlock[i].coords.x + arrStartBlock[i].output[b].coords.x, arrStartBlock[i].coords.y+arrStartBlock[i].dimensions.height/2,20)
            love.graphics.setColor(0, 1, 0, 1);

            if(arrStartBlock[i].output[b].clicked)then
                love.graphics.setColor(0, 0, 1, 1);
                love.graphics.circle("line", arrStartBlock[i].coords.x + arrStartBlock[i].output[b].coords.x, arrStartBlock[i].coords.y + arrStartBlock[i].output[b].coords.y, 20);
                love.graphics.setColor(0, 1, 0, 1);
            
            end    
        end
    end
end


--epic fail
startingBlock.getIndex = function (name)
    for i = 1, #arrStartBlock do
       -- print(name);
       -- print(arrStartBlock[i].name);
       -- print(name == arrStartBlock[i].name);

       -- if(arrStartBlock[i].name == name) then
            
       --     return i;
       -- end        
    end
    return (1);
end


--basically the same as gates.click but it checks all the outputs of the starting block
startingBlock.click = function (mouseX, mouseY, button)

    local x =  camera.screenToWorldcords(love.mouse.getX(), love.mouse.getY()).x;
    local y =  camera.screenToWorldcords(love.mouse.getX(), love.mouse.getY()).y;

    for i = #arrStartBlock, 1, -1 do
        for b = 1, #(arrStartBlock[i].output) do
        
            if(button == 1 and  x > (arrStartBlock[i].coords.x + arrStartBlock[i].output[b].coords.x - 10) and 
                                x < (arrStartBlock[i].coords.x + arrStartBlock[i].output[b].coords.x + 10) and 
                                y > (arrStartBlock[i].coords.y + arrStartBlock[i].output[b].coords.y - 10) and 
                                y < (arrStartBlock[i].coords.y + arrStartBlock[i].output[b].coords.y + 10)) then
                arrStartBlock[i].output[b].clicked = true;
                portUpdate = true; 
                gates.simulate();
              
                
            end    

            if(button == 1 and  x > (arrStartBlock[i].coords.x + arrStartBlock[i].output[b].coords.x - 20) and 
                                x < (arrStartBlock[i].coords.x + arrStartBlock[i].output[b].coords.x + 20) and 
                                y > (arrStartBlock[i].coords.y+arrStartBlock[i].dimensions.height/2 - 20) and 
                                y < (arrStartBlock[i].coords.y+arrStartBlock[i].dimensions.height/2 + 20)) then

                arrStartBlock[i].output[b].status = not arrStartBlock[i].output[b].status;
                gates.simulate();

            end    

        end    
    end
end



return startingBlock