--[[
    This example shows how to create a chat command called !dropitem that drops the item in your right hand.
--]]

if CLIENT and Game.IsMultiplayer then return end -- lets this run if on the server-side, if it's multiplayer, doesn't let it run on the client, and if it's singleplayer, lets it run on the client.


Hook.Add("chatMessage", "examples.dropItem", function (message, client)
    if message ~= "!dropitem" then return end

    local character
    if client == nil then
        character = Character.Controlled
    else
        character = client.Character
    end

    if character == nil then return end

    local item = character.Inventory.GetItemInLimbSlot(InvSlotType.RightHand)
    item.Drop()

    return true -- returning true allows us to hide the message
end)