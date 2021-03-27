local gates = require "world_related.gates";

local menu = {};

local buttons = {
    {x = 0, y = 0, width = 40, height = 40, color = {0, 1, 0, 1}, graphics = {shape = "circle", text = "and"}, funct = function ()
        gates.create("and");
    end},

    {x = 0, y = 100, width = 40, height = 40, color = {0, 1, 0, 1}, graphics = {shape = "circle", text = "or"}, funct = function ()
        gates.create("or");
    end}
};



local function drawMenuElements(button)

    if(button.graphics.shape == "circle") then

        love.graphics.setColor(button.color[1], button.color[2], button.color[3], button.color[4]);
        love.graphics.circle("fill", button.x + button.width/2, button.y + button.height/2, button.width/2);

        love.graphics.setColor(0,0,0,1);
        love.graphics.print(button.graphics.text, button.x + button.width/4.5, button.y + button.height/3.5);

    end    
end


--returns wether or not the button at [i] was clicked
local function clickTerm(mouseX, mouseY, button, i)
   
    return (button == 1 and mouseX/screenScale > buttons[i].x and mouseX/screenScale < buttons[i].x + buttons[i].width and mouseY/screenScale > buttons[i].y 
            and mouseY/screenScale < buttons[i].y + buttons[i].height);

end



menu.click = function (mouseX, mouseY, button)
    
    for i = 1, #buttons do
        if(clickTerm(mouseX, mouseY, button, i)) then
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