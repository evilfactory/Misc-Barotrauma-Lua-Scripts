--[[
    This example shows how to create a chat command that removes all your items.
--]]

if CLIENT and Game.IsMultiplayer then return end -- lets this run if on the server-side, if it's multiplayer, doesn't let it run on the client, and if it's singleplayer, lets it run on the client.


Hook.Add("chatMessage", "examples.removeItemCommand", function (message, client)
    if message ~= "!removeitems" then return end

    if SERVER then
        if client.Character == nil then return end

        for item in client.Character.Inventory.AllItems do
            Entity.Spawner.AddEntityToRemoveQueue(item)
        end 
    else
        if Character.Controlled == nil then return end

        for item in Character.Controlled.Inventory.AllItemsMod do
            item.Remove()
        end 
    end

    return true -- returning true allows us to hide the message
end)