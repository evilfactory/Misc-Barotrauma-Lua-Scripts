--[[
    This example shows how to create a chat command called !humanspawning that will spawn you a new character with the assistant job and give you control to it.
--]]

if CLIENT and Game.IsMultiplayer then return end -- lets this run if on the server-side, if it's multiplayer, doesn't let it run on the client, and if it's singleplayer, lets it run on the client.


Hook.Add("chatMessage", "examples.humanSpawning", function (message, client)
    if message ~= "!humanspawning" then return end

    local info = CharacterInfo("human", "Robert")
    info.Job = Job(JobPrefab.Get("assistant"))

    local position = Submarine.MainSub.WorldPosition

    local character = Character.Create(info, position, info.Name, 0, false, false)
    character.TeamID = CharacterTeamType.Team1
    character.GiveJobItems()

    if CLIENT then
        Character.Controlled = character
    else
        client.SetClientCharacter(character)
    end
end)
