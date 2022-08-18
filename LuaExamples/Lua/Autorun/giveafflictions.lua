--[[
    This example shows how to create a command that gives afflictions to a character.
--]]

if CLIENT then return end -- stops this wrong running on the client

local burnPrefab = AfflictionPrefab.Prefabs["burn"]

Hook.Add("chatMessage", "examples.giveAfflictions", function (message, client)
    if message ~= "!giveaffliction" then return end

    local character = client.Character

    if character == nil then return end

    local limb = character.AnimController.GetLimb(LimbType.Head)

    -- give 50 of burns to the head of the character
    character.CharacterHealth.ApplyAffliction(limb, burnPrefab.Instantiate(50))
end)