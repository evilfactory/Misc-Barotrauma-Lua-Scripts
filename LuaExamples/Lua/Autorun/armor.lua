--[[
    This example adds a special type of armor that can absorb damage, and when it's condition reaches 0, it breaks.
--]]


Hook.Add("character.applyDamage", "LuaArmor.ApplyDamage", function (characterHealth, attackResult, hitLimb)
    if hitLimb.type ~= LimbType.Torso then return end

    local character = characterHealth.Character
    if character.Inventory == nil then return end
    local armor = character.Inventory.GetItemInLimbSlot(InvSlotType.OuterClothes)

    if armor == nil or armor.Prefab.Identifier ~= "luaarmor" then return end

    local damage = 0

    for affliction in attackResult.Afflictions do
        damage = damage + affliction.Strength
    end

    armor.Condition = armor.Condition - damage

    if armor.Condition > 0 then
        return true
    else
        Entity.Spawner.AddEntityToRemoveQueue(armor)
    end
end)