local gates = require "world_related.gates";
local starting_block = require "world_related.starting_block"

local wires = {};



wires.load = function ()
    
end


--checks for connected gates and connection to the starting block and draws the corresponding wires
wires.draw = function ()

    love.graphics.setLineWidth(5);
    love.graphics.setColor(0, 1, 0, 1);

    for i = 1, #rectangles do
        
        if(rectangles[i].input.a.connect ~= nil) then

            love.graphics.setColor(0, 1, 0, 1);

            if(rectangles[i].input.a.status) then love.graphics.setColor(1, 0, 0, 1); end

            if(rectangles[i].input.a.connect < firstStartBlockName) then

                local currentIndexOfOutputGate = gates.getIndex(rectangles[i].input.a.connect);
                love.graphics.line( rectangles[i].x + rectangles[i].input.a.coords.x,
                                    rectangles[i].y + rectangles[i].input.a.coords.y,
                                    rectangles[currentIndexOfOutputGate].x + rectangles[currentIndexOfOutputGate].output.q.coords.x,
                                    rectangles[currentIndexOfOutputGate].y + rectangles[currentIndexOfOutputGate].output.q.coords.y);
            
            else

                local currentIndexOfOutputGate = starting_block.getIndex(rectangles[i].input.a.connect);   
               
                love.graphics.line( rectangles[i].x + rectangles[i].input.a.coords.x,
                                    rectangles[i].y + rectangles[i].input.a.coords.y,

                                    arrStartBlock[currentIndexOfOutputGate].coords.x + 
                                        arrStartBlock[currentIndexOfOutputGate].output[rectangles[i].input.a.connect-firstStartBlockName].coords.x,

                                    arrStartBlock[currentIndexOfOutputGate].coords.y + 
                                        arrStartBlock[currentIndexOfOutputGate].output[rectangles[i].input.a.connect-firstStartBlockName].coords.y);    
            end    
        end  
        
        if(rectangles[i].input.b.connect ~= nil) then

            love.graphics.setColor(0,1,0,1);

            if(rectangles[i].input.b.status) then love.graphics.setColor(1, 0, 0, 1); end
            
            if(rectangles[i].input.b.connect < firstStartBlockName) then
                local currentIndexOfOutputGate = gates.getIndex(rectangles[i].input.b.connect);
               
                love.graphics.line( rectangles[i].x + rectangles[i].input.b.coords.x, 
                                    rectangles[i].y + rectangles[i].input.b.coords.y,
                                    
                                    rectangles[currentIndexOfOutputGate].x + 
                                        rectangles[currentIndexOfOutputGate].output.q.coords.x,
                                    
                                    rectangles[currentIndexOfOutputGate].y + 
                                        rectangles[currentIndexOfOutputGate].output.q.coords.y);
            
                else
                local currentIndexOfOutputGate = starting_block.getIndex(rectangles[i].input.b.connect);
       
                love.graphics.line( rectangles[i].x + rectangles[i].input.b.coords.x,
                                    rectangles[i].y + rectangles[i].input.b.coords.y,
                                    
                                    arrStartBlock[currentIndexOfOutputGate].coords.x + 
                                        arrStartBlock[currentIndexOfOutputGate].output[rectangles[i].input.b.connect-firstStartBlockName].coords.x,
                                        
                                    arrStartBlock[currentIndexOfOutputGate].coords.y + 
                                        arrStartBlock[currentIndexOfOutputGate].output[rectangles[i].input.b.connect-firstStartBlockName].coords.y);    
            end    
        end 
    end
end



return wires;