--[[
    This example shows how to create a chat command called !itemspawning, that will spawn a diving mask with an oxygen tank inside of it.
--]]

if CLIENT and Game.IsMultiplayer then return end -- lets this run if on the server-side, if it's multiplayer, doesn't let it run on the client, and if it's singleplayer, lets it run on the client.

local divingMaskPrefab = ItemPrefab.GetItemPrefab("divingmask")
local oxygenTankPrefab = ItemPrefab.GetItemPrefab("oxygentank")

Hook.Add("chatMessage", "examples.itemSpawning", function (message, client)
    if message ~= "!itemspawning" then return end

    local character
    if client == nil then
        character = Character.Controlled
    else
        character = client.Character
    end

    if character == nil then return end

    Entity.Spawner.AddItemToSpawnQueue(divingMaskPrefab, character.Inventory, nil, nil, function(item)
        Entity.Spawner.AddItemToSpawnQueue(oxygenTankPrefab, item.OwnInventory, nil, nil, function(item2)

        end)
    end)

    return true -- returning true allows us to hide the message
end)