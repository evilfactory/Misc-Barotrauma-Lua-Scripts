--[[
    This example shows how to give AI objectives using code.
--]]

if CLIENT and Game.IsMultiplayer then return end -- lets this run if on the server-side, if it's multiplayer, doesn't let it run on the client, and if it's singleplayer, lets it run on the client.

function ManRandomTurret()
    local orderPrefab = OrderPrefab.Prefabs["operateweapons"]

    local periscopes = {}
    for key, value in pairs(Submarine.MainSub.GetItems(true)) do
        if value.Prefab.Identifier.Value == "periscope" then
            table.insert(periscopes, value)
        end
    end

    for key, value in pairs(Character.CharacterList) do
        if value.IsBot and value.IsHuman then
            local periscope = periscopes[math.random(1, #periscopes)]

            local order = Order(orderPrefab, periscope, periscope.GetComponentString("Controller")).WithManualPriority(CharacterInfo.HighestManualOrderPriority)

            print("Order to man " .. tostring(periscope))

            value.SetOrder(order, true, false, true)
        end
    end
end

function FollowMe(target)
    local orderPrefab = OrderPrefab.Prefabs["follow"]

    for key, value in pairs(Character.CharacterList) do
        if value.IsBot and value.IsHuman then
            local order = Order(orderPrefab, nil, target).WithManualPriority(CharacterInfo.HighestManualOrderPriority)

            value.SetOrder(order, true, false, true)
        end
    end
end

Hook.Add("chatMessage", "examples.aiOrders", function (message, client) 
    local target = client and client.Character or Character.Controlled

    if message == "!manrandomturret" then
        ManRandomTurret()
    end

    if message == "!followme" then
        FollowMe(target)
    end
end)
