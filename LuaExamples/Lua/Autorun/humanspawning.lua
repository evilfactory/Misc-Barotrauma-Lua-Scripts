--[[
    This example shows how to create a chat command called !humanspawning that will spawn you a new character with the assistant job and give you control to it.
--]]

if CLIENT and Game.IsMultiplayer then return end -- lets this run if on the server-side, if it's multiplayer, doesn't let it run on the client, and if it's singleplayer, lets it run on the client.


Hook.Add("chatMessage", "examples.humanSpawning", function (message, client)
    if message ~= "!humanspawning" then return end

    -- Note: If we plan only running this server-side, we could grab the CharacterInfo from client instead, which will have all their info already set, like name and hair style.
    local info = CharacterInfo("human", "Robert")
    info.Job = Job(JobPrefab.Get("assistant"))

    local submarine = Submarine.MainSub
    -- This method takes a list of CharacterInfo that it will use to choose the correct spawn waypoint
    -- in this case we only have a single info, so we just create a table with just that info in it.
    local spawnPoint = WayPoint.SelectCrewSpawnPoints({info}, submarine)[1]

    if spawnPoint == nil then
        -- we should probably do something if it isn't able to find a spawn point
    end

    local character = Character.Create(info, spawnPoint.WorldPosition, info.Name, 0, false, false)
    character.TeamID = CharacterTeamType.Team1
    character.GiveJobItems()

    if CLIENT then
        Character.Controlled = character
    else
        client.SetClientCharacter(character)
    end

    return true -- returning true allows us to hide the message
end)
