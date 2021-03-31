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
    local gate = arrGates[gates.getIndex(gateName)];

    if gate.type ~= "node" then

        if (port == "a") then

            if(arrGates[gates.getIndex(gate.input.a.connect)].type ~= "node") then
                arrGates[gates.getIndex(gate.input.a.connect)].output.q.connect.name = nil;
                arrGates[gates.getIndex(gate.input.a.connect)].output.q.connect.port = nil
            end  
            
            arrGates[gates.getIndex(gateName)].input.a.connect = nil
        end 

        if (port == "b") then

            if(arrGates[gates.getIndex(gate.input.b.connect)].type ~= "node") then
                arrGates[gates.getIndex(gate.input.b.connect)].output.q.connect.name = nil;
                arrGates[gates.getIndex(gate.input.b.connect)].output.q.connect.port = nil
            end  
            
            arrGates[gates.getIndex(gateName)].input.b.connect = nil
        end
    end
end

return tools