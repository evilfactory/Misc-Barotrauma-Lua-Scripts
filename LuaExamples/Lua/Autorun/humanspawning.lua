--[[
    This example shows how to create a chat command called !humanspawning that will spawn you a new character with the assistant job and give you control to it.
--]]

if CLIENT then return end -- stops this wrong running on the client


Hook.Add("chatMessage", "examples.humanSpawning", function (message, client)
    if message ~= "!humanspawning" then return end

    local info = CharacterInfo("human", "Robert")
    info.Job = Job(JobPrefab.Get("assistant"))

    local position = Submarine.MainSub.WorldPosition

    local character = Character.Create(info, position, info.Name, 0, true, false)
    character.TeamID = CharacterTeamType.Team1
    character.GiveJobItems()

    client.SetClientCharacter(character)
end)