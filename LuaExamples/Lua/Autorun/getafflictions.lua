--[[
    This example shows how to create a command that gets an affliction of a character
--]]

if CLIENT then return end -- stops this wrong running on the client

Hook.Add("chatMessage", "examples.getAfflictions", function (message, client)
    if message ~= "!getaffliction" then return end

    local character = client.Character

    if character == nil then return end

    local limb = character.AnimController.GetLimb(LimbType.Head)

    local affliction = character.CharacterHealth.GetAffliction("burn", limb)
    local amount = affliction and affliction.Strength or 0 -- get the amount of the affliction

    local chatMessage = ChatMessage.Create("", tostring(amount), ChatMessageType.Default, nil, nil)
    chatMessage.Color = Color(255, 255, 0, 255)
    Game.SendDirectChatMessage(chatMessage, client)
end)