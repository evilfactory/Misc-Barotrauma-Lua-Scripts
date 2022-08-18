--[[
    This example shows how to create a chat command that kills your character.
--]]

if CLIENT then return end -- stops this wrong running on the client


Hook.Add("chatMessage", "examples.killCommand", function (message, client)
    if message ~= "!kill" then return end

    if client.Character == nil then return end

    client.Character.Kill(CauseOfDeathType.Unknown)
end)