local gravityAnomalies = {}

Hook.Add("luaGrenade", "examples.grenade", function(effect, deltaTime, item, targets, worldPosition)
    gravityAnomalies[item] = Timer.GetTime() + 4
end)

Hook.Add("think", "examples.gravityAnomaly", function ()
    for item, time in pairs(gravityAnomalies) do
        if Timer.GetTime() > time then
            gravityAnomalies[item] = nil
        else
            local position = item.WorldPosition

            for key, value in pairs(Character.CharacterList) do
                local distance = Vector2.Distance(position, value.WorldPosition)
                if distance < 1000 then
                    local direction = Vector2.Normalize(position - value.WorldPosition)
                    value.AnimController.MainLimb.body.ApplyForce(direction * 1000)
                    value.Stun = math.max(value.Stun, 0.5)
                end
            end
        end
    end
end)