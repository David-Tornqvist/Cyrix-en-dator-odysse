local gates = require "gates";

local menu = {};

menu.click = function (mousex,mousey,button)
    if(button == 1 and mousex/screenScale > 0 and mousex/screenScale < 40 and mousey/screenScale > 0 and mousey/screenScale < 40) then
        gates.create();
    end    
end

menu.draw = function ()
    
    love.graphics.setColor(0,1,0,1);
    love.graphics.circle("fill",20,20,20);

end

return menu;