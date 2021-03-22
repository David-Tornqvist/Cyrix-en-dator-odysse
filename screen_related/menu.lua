local gates = require "world_related.gates";

local menu = {};

local buttons = {
    {x = 0, y = 0, width = 40, height = 40, color = {0,1,0,1}, graphics = "circle",funct = function ()
        gates.create("and");
    end},

    {x = 0, y = 100,width = 40, height = 40, color = {0,1,0,1}, graphics = "circle",funct = function ()
        gates.create("or");
    end}
};



local function drawMenuElements(button)
    if(button.graphics == "circle") then

        love.graphics.setColor(button.color[1],button.color[2],button.color[3],button.color[4]);
        love.graphics.circle("fill",button.x + button.width/2, button.y + button.height/2, button.width/2);

    end    
end



local function clickTerm(mousex,mousey,button,i)
   
    return (button == 1 and mousex/screenScale > buttons[i].x and mousex/screenScale < buttons[i].x + buttons[i].width and mousey/screenScale > buttons[i].y 
            and mousey/screenScale < buttons[i].y + buttons[i].height);

end



menu.click = function (mousex,mousey,button)
    
    for i = 1, #buttons do
        if(clickTerm(mousex,mousey,button,i)) then
            buttons[i].funct();
        end    
    end
end



menu.draw = function ()
    
    for i = 1, #buttons do
        drawMenuElements(buttons[i]);
    end
end

return menu;