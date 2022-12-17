--[[
    This example shows you how to use XML Hooks, please also look at luaitems.xml so you can see how they are defined. <LuaHook name="...">
--]]


local luaMoonPrefab = ItemPrefab.GetItemPrefab("luamoon")

Hook.Add("luaRevolver.onUse", "examples.xmlHooks", function(effect, deltaTime, item, targets, worldPosition)
    -- the targets here are the targets specified in the xml status effect, so in this case, its specified as target="Character", so it should be the character using the revolver.
    if targets[1] == nil then return end

    print(targets[1].Name .. " Used the Lua Revolver!")

    targets[1].SetStun(2, false, true)

    local explosion = Explosion(500, 50000, 5, 1, 0, 0, 0)
    explosion.Explode(item.WorldPosition - Vector2(0, 50), item)
end)

Hook.Add("luaRevolverRound.onImpact", "examples.xmlHooks", function(effect, deltaTime, item, targets, worldPosition)
    if CLIENT and Game.IsMultiplayer then return end

    Entity.Spawner.AddItemToSpawnQueue(luaMoonPrefab, item.WorldPosition, nil, nil, function(item)
        print(item)
    end)

    local target = targets[1]

    if tostring(target) == "Human" then
        local explosion = Explosion(25, 50, 5000, 1000, 0, 0, 0)
        explosion.Explode(target.WorldPosition, item)
    end

    print("We hit a " .. tostring(targets[1]))
end)
