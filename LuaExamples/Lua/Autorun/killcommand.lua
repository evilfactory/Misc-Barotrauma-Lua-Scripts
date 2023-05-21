--[[
    This example shows how to create a chat command that kills your character.
--]]

if CLIENT and Game.IsMultiplayer then return end -- lets this run if on the server-side, if it's multiplayer, doesn't let it run on the client, and if it's singleplayer, lets it run on the client.


Hook.Add("chatMessage", "examples.killCommand", function (message, client)
    if message ~= "!kill" then return end

    local character
    if client == nil then
        character = Character.Controlled
    else
        character = client.Character
    end

    character.Kill(CauseOfDeathType.Unknown)

    return true -- returning true allows us to hide the message
end)