local tools = {};

tools.load = function ()
    isDelete = false;
end

tools.activate = function (tool)
    if(tool == "delete")then
        isDelete = not isDelete;
    end
end

tools.delete = function (gateName,port)

    local gate = arrGates[getindex(gateName)];


    if (port == "a" and (gate.input.a.connect ~= nil)) then

            
        if (gate.input.a.connect - firstStartBlockName) < 0 then
            if(arrGates[getindex(gate.input.a.connect)].type ~= "node") then
                arrGates[getindex(gate.input.a.connect)].output.q.connect.name = nil;
                arrGates[getindex(gate.input.a.connect)].output.q.connect.port = nil;
            end
        else
            arrStartBlock[starting_block_getIndex(gateName)].output[gate.input.a.connect - firstStartBlockName].connect.name = nil;
            arrStartBlock[starting_block_getIndex(gateName)].output[gate.input.a.connect - firstStartBlockName].connect.port = nil;
        end
     
        
        arrGates[getindex(gateName)].input.a.connect = nil;
    
    elseif (port == "b" and (gate.input.b.connect ~= nil)) then

        
        if (gate.input.b.connect - firstStartBlockName) < 0 then
            if(arrGates[getindex(gate.input.b.connect)].type ~= "node") then
                arrGates[getindex(gate.input.b.connect)].output.q.connect.name = nil;
                arrGates[getindex(gate.input.b.connect)].output.q.connect.port = nil;
            end
        else
            arrStartBlock[starting_block_getIndex(gateName)].output[gate.input.b.connect - firstStartBlockName].connect.name = nil;
            arrStartBlock[starting_block_getIndex(gateName)].output[gate.input.b.connect - firstStartBlockName].connect.port = nil;
        end    

        arrGates[getindex(gateName)].input.b.connect = nil;
            
    end
        


    if gateName < firstStartBlockName then
        if (port == "q") then
            if(gate.output.q.connect.port == "a" and arrGates[getindex(gate.output.q.connect.name)] ~= nil) then
                arrGates[getindex(gate.output.q.connect.name)].input.a.connect = nil;
                arrGates[getindex(gate.output.q.connect.name)].input.a.status = false;
            end
    
            if(gate.output.q.connect.port == "b" and arrGates[getindex(gate.output.q.connect.name)] ~= nil) then
                arrGates[getindex(gate.output.q.connect.name)].input.b.connect = nil;
                arrGates[getindex(gate.output.q.connect.name)].input.b.status = false;
            end
            
            arrGates[getindex(gateName)].output.q.connect.name = nil;
            arrGates[getindex(gateName)].output.q.connect.port = nil;
        end
    else
        
        if( arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.port == "a" and 
            arrGates[getindex(arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name)] ~= nil) then

                arrGates[getindex(arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name)].input.a.connect = nil;
                arrGates[getindex(arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name)].input.a.status = false;

        end

        if( arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.port == "b" and 
            arrGates[getindex(arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name)] ~= nil) then

                arrGates[getindex(arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name)].input.b.connect = nil;
                arrGates[getindex(arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name)].input.b.status = false;

        end

        

        arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.name = nil;
        arrStartBlock[starting_block_getIndex(gateName)].output[port].connect.port = nil;
        
    end
end

tools.deleteGate = function (gateName)

    tools.delete(gateName,"a");
    tools.delete(gateName,"b");
    tools.delete(gateName,"q");

    table.remove(arrGates,getindex(gateName));
    
end



return tools