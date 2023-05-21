--[[
    This example shows how to make items with custom wiring. Related XML code is in luaitems.xml.
--]]


Hook.Add("signalReceived.luadevice", "examples.customWiring", function(signal, connection)
    if connection.Name == "input" then
        connection.Item.SendSignal(tostring(math.random(0, 100)), "output")
    end
end)

