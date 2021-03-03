
--gammal windows style


local camera = require "camera";
local gates = require "gates";
local menu = require "menu";
local wires = require "wires";
local starting_block = require "starting_block";




love.load = function()

    camera = require "camera";
    gates = require "gates";
    camera.load();
    gates.load();
    starting_block.load();


    starting_block.create(500,500,5);

end    






function love.keypressed(key)

    if(key == "escape")then love.event.quit(); end

    if(key == "q")then translate.x = translate.x + 10; end

end









function love.mousepressed(mousex,mousey,button)

    gates.click(mousex,mousey,button);
  
    menu.click(mousex,mousey,button);

    camera.update("mPush",button);
end











function love.mousereleased(x,y,button)

   gates.release(button);

    camera.update("mRel",button);
end










function love.wheelmoved(x,y)

    camera.update("scrl",y);

end









love.update = function(dt)

    gates.update();

    camera.update("pan");

end






love.draw = function()

    love.graphics.scale(screenScale,screenScale);

    love.graphics.push();

    love.graphics.scale(zoom,zoom);
    love.graphics.translate(translate.x,translate.y);

    gates.draw();
    wires.draw();

    
    love.graphics.pop();

    menu.draw();


end


