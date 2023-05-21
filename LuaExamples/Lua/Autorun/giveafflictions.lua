--[[
    This example shows how to create a command that gives afflictions to a character.
--]]

if CLIENT and Game.IsMultiplayer then return end -- lets this run if on the server-side, if it's multiplayer, doesn't let it run on the client, and if it's singleplayer, lets it run on the client.

local burnPrefab = AfflictionPrefab.Prefabs["burn"]

Hook.Add("chatMessage", "examples.giveAfflictions", function (message, client)
    if message ~= "!giveaffliction" then return end

    local character
    if SERVER then
        character = client.Character
    else
        character = Character.Controlled
    end

    if character == nil then return end

    local limb = character.AnimController.GetLimb(LimbType.Head)

    -- give 50 of burns to the head of the character
    character.CharacterHealth.ApplyAffliction(limb, burnPrefab.Instantiate(50))

    return true -- returning true allows us to hide the message
end)