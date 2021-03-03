local starting_block = {};

starting_block.load = function ()
    arrStart_block = {};
end

starting_block.create = function (x,y,nOutput)

    arrStart_block[#arrStart_block+1] =  {coords = {x = nil, y = nil},dimensions = {width = nil, height = 100},output = {}};



    for i = 1, nOutput do
        arrStart_block[#arrStart_block].output[i] = {connect = nil, coords = {x = i*50, y = 110},status = false,clicked = false};
    end

end

starting_block.draw = function ()
    
end

return starting_block