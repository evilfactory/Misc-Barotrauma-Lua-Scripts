local toolgunModes = {}

Hook.Add("luaToolGun.onImpact", "examples.toolgun", function(effect, deltaTime, item, targets, worldPosition)
    if CLIENT and Game.IsMultiplayer then return end

    if effect.user == nil then return end

    local projectile = item.GetComponentString("Projectile")
    local launcher = projectile.Launcher

    if toolgunModes[launcher] == nil then toolgunModes[launcher] = "teleport" end

    if toolgunModes[launcher] == "teleport" then
        local position = item.WorldPosition

        if tostring(targets[1]) == "Human" then
            targets[1].TeleportTo(effect.user.WorldPosition)
        end

        effect.user.TeleportTo(position)
    elseif toolgunModes[launcher] == "impulse" then
        if tostring(targets[3]) == "Barotrauma.Limb" then
            local direction = Vector2.Normalize(targets[2].WorldPosition - launcher.WorldPosition)

            targets[3].body.ApplyForce(direction * 10000, 1000)
            targets[1].Stun = 1
        end
    elseif toolgunModes[launcher] == "delete" then
        if targets[1] then
            Entity.Spawner.AddEntityToRemoveQueue(targets[1])
        end
    end
end)

Hook.Add("luaToolGun.teleportMode", "examples.toolgun", function(effect, deltaTime, item, targets, worldPosition)
    toolgunModes[item] = "teleport"
end)

Hook.Add("luaToolGun.impulseMode", "examples.toolgun", function(effect, deltaTime, item, targets, worldPosition)
    toolgunModes[item] = "impulse"
end)

Hook.Add("luaToolGun.deleteMode", "examples.toolgun", function(effect, deltaTime, item, targets, worldPosition)
    toolgunModes[item] = "delete"
end)