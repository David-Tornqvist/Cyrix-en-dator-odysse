local gates = require "gates";

local wires = {};

wires.load = function ()
    
end

wires.draw = function ()
    love.graphics.setLineWidth(5);
    love.graphics.setColor(0,1,0,1);
    for i = 1, #rectangles do
        
        if(rectangles[i].input.a.connect ~= nil) then
            local currentIndexOfOutputGate = gates.getIndex(rectangles[i].input.a.connect);
            love.graphics.line(rectangles[i].x + rectangles[i].input.a.coords.x,rectangles[i].y + rectangles[i].input.a.coords.y,rectangles[currentIndexOfOutputGate].x + rectangles[currentIndexOfOutputGate].output.q.coords.x,rectangles[currentIndexOfOutputGate].y + rectangles[currentIndexOfOutputGate].output.q.coords.y);
        end  
        
        if(rectangles[i].input.b.connect ~= nil) then
            local currentIndexOfOutputGate = gates.getIndex(rectangles[i].input.b.connect);
            love.graphics.line(rectangles[i].x + rectangles[i].input.b.coords.x, rectangles[i].y + rectangles[i].input.b.coords.y,rectangles[currentIndexOfOutputGate].x + rectangles[currentIndexOfOutputGate].output.q.coords.x,rectangles[currentIndexOfOutputGate].y + rectangles[currentIndexOfOutputGate].output.q.coords.y);
        end 
    end
end

return wires;