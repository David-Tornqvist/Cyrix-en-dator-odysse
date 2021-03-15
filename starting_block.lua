local camera = require "camera";

local starting_block = {};



starting_block.load = function ()
    arrStart_block = {};
    startName = 10000000000000;
    first_startname = 10000000000000;
end



starting_block.create = function (x,y,nOutput)

    arrStart_block[#arrStart_block+1] =  {coords = {x = x, y = y},dimensions = {width = (nOutput + 1)*50, height = 100},output = {},name = startName};

    startName = startName + nOutput;


    for i = 1, nOutput do
        arrStart_block[#arrStart_block].output[i] = {connect = {name = nil, port = nil}, coords = {x = i*50, y = -40},status = false,clicked = false};
    end

end



starting_block.draw = function ()
    love.graphics.setColor(0,1,0,1);
    love.graphics.setLineWidth(5);
    
    for i = 1, #arrStart_block do
        love.graphics.rectangle("line",arrStart_block[i].coords.x,arrStart_block[i].coords.y,arrStart_block[i].dimensions.width,arrStart_block[i].dimensions.height);
        for b = 1, #arrStart_block[i].output do
            if(arrStart_block[i].output[b].status) then love.graphics.setColor(1,0,0,1); end
            love.graphics.line(arrStart_block[i].coords.x + arrStart_block[i].output[b].coords.x,arrStart_block[i].coords.y,arrStart_block[i].coords.x + arrStart_block[i].output[b].coords.x,arrStart_block[i].coords.y + arrStart_block[i].output[b].coords.y);
            
            
            love.graphics.circle("fill",arrStart_block[i].coords.x + arrStart_block[i].output[b].coords.x,arrStart_block[i].coords.y+arrStart_block[i].dimensions.height/2,20)
            love.graphics.setColor(0,1,0,1);

            if(arrStart_block[i].output[b].clicked)then
                love.graphics.setColor(0,0,1,1);
                love.graphics.circle("line",arrStart_block[i].coords.x + arrStart_block[i].output[b].coords.x,arrStart_block[i].coords.y + arrStart_block[i].output[b].coords.y,20);
                love.graphics.setColor(0,1,0,1);
            
            end    
        end
    end
    
end



starting_block.getIndex = function (name)
    for i = 1, #arrStart_block do
       -- print(name);
       -- print(arrStart_block[i].name);
       -- print(name == arrStart_block[i].name);

       -- if(arrStart_block[i].name == name) then
            
       --     return i;
       -- end        
    end
    return (1);
end



starting_block.click = function (mousex,mousey,button)
    local x =  camera.screenToWorldcords(love.mouse.getX(),love.mouse.getY()).x;
    local y =  camera.screenToWorldcords(love.mouse.getX(),love.mouse.getY()).y;

    

    for i = #arrStart_block, 1, -1 do
        
        

        for b = 1, #(arrStart_block[i].output) do
        
        
        

            if(button == 1 and x > (arrStart_block[i].coords.x + arrStart_block[i].output[b].coords.x - 10) and x < (arrStart_block[i].coords.x + arrStart_block[i].output[b].coords.x + 10) and y > (arrStart_block[i].coords.y + arrStart_block[i].output[b].coords.y - 10) and y < (arrStart_block[i].coords.y + arrStart_block[i].output[b].coords.y + 10)) then
                arrStart_block[i].output[b].clicked = true;
                portUpdate = true; 
              
                
            end    

            if(button == 1 and x > (arrStart_block[i].coords.x + arrStart_block[i].output[b].coords.x - 20) and x < (arrStart_block[i].coords.x + arrStart_block[i].output[b].coords.x + 20) and y > (arrStart_block[i].coords.y+arrStart_block[i].dimensions.height/2 - 20) and y < (arrStart_block[i].coords.y+arrStart_block[i].dimensions.height/2 + 20)) then
                arrStart_block[i].output[b].status = not arrStart_block[i].output[b].status;
           
                
            end    

        end    

    end
end



return starting_block