--[[
    This example shows how to create a chat command called !itemspawning, that will spawn a diving mask with an oxygen tank inside of it.
--]]

if CLIENT then return end -- stops this wrong running on the client

local divingMaskPrefab = ItemPrefab.GetItemPrefab("divingmask")
local oxygenTankPrefab = ItemPrefab.GetItemPrefab("oxygentank")

Hook.Add("chatMessage", "examples.itemSpawning", function (message, client)
    if message ~= "!itemspawning" then return end

    local character = client.Character

    if character == nil then return end

    Entity.Spawner.AddItemToSpawnQueue(divingMaskPrefab, character.Inventory, nil, nil, function(item)
        Entity.Spawner.AddItemToSpawnQueue(oxygenTankPrefab, item.OwnInventory, nil, nil, function(item2)

        end)
    end)
end)