--[[
    This example shows how to make items with custom wiring. Related XML code is in luaitems.xml.
--]]


local buffer = {}
Hook.Add("signalReceived.advancedluadevice", "examples.advancedCustomWiring", function(signal, connection)
    if buffer[connection.Item] == nil then buffer[connection.Item] = {} end

    local itemBuffer = buffer[connection.Item]

    if connection.Name == "input_1" then
        itemBuffer[1] = signal.value
    end

    if connection.Name == "input_2" then
        itemBuffer[2] = signal.value
    end

    if itemBuffer[1] ~= nil and itemBuffer[2] ~= nil then
        local a = (tonumber(itemBuffer[1]) or 0)
        local b = (tonumber(itemBuffer[2]) or 0)

        connection.Item.SendSignal(tostring(a + b), "output")
        itemBuffer[1] = nil
        itemBuffer[2] = nil
    end
end)

