if CLIENT then return end

local minMutiny = 3

local mutinyStarted = false
local mutinyCharacter = {}

local function SendMessage(text, color, client)
    if client == nil then
        for key, value in pairs(Client.ClientList) do
            local chatMessage = ChatMessage.Create("", text, ChatMessageType.Default, nil, nil)
            chatMessage.Color = color
            Game.SendDirectChatMessage(chatMessage, value)
        end
    else
        local chatMessage = ChatMessage.Create("", text, ChatMessageType.Default, nil, nil)
        chatMessage.Color = color
        Game.SendDirectChatMessage(chatMessage, client)
    end
end

local function PrintMutinyMembers()
    local text = "Mutiny Members: "

    for key, value in pairs(mutinyCharacter) do
        text = text .. "\"" .. key.Name .. "\" "
    end

    return text
end

local function StartMutiny(character)
    mutinyCharacter[character] = true

    Game.Log(character.Name .. " has joined the mutiny!", ServerLogMessageType.Chat)

    local amountMutiny = 0

    for key, value in pairs(mutinyCharacter) do
        amountMutiny = amountMutiny + 1
    end

    if amountMutiny >= minMutiny and not mutinyStarted then
        mutinyStarted = true

        SendMessage("A mutiny has started!\n" .. PrintMutinyMembers(), Color.Red)
        Game.Log("A mutiny has started.", ServerLogMessageType.Chat)

        for k, v in pairs(mutinyCharacter) do
            k.SetOriginalTeam(CharacterTeamType.Team2)
            k.UpdateTeam()
        end
    elseif amountMutiny >= minMutiny then
        SendMessage(character.Name .. " has joined the mutiny!", Color.Red)
        character.SetOriginalTeam(CharacterTeamType.Team2)
        character.UpdateTeam()
    end
end

Hook.Add("chatMessage", "MutinyMod.ChatMessage", function (message, client)
    if message == "!mutiny" then
        if client.Character == nil or client.Character.IsDead or not client.Character.IsHuman then
            SendMessage(PrintMutinyMembers(), Color.Cyan, client)
            return true
        end

        if client.Character.IsSecurity or client.Character.IsCaptain then
            if not mutinyStarted then
                SendMessage("You cannot mutiny as captain or security!", Color.Cyan, client)
                return true
            else
                SendMessage(PrintMutinyMembers(), Color.Cyan, client)
                return true
            end
        end

        if mutinyCharacter[client.Character] then
            SendMessage("You are already in the mutiny.\n" .. PrintMutinyMembers(), Color.Cyan, client)
            return true
        end

        StartMutiny(client.Character)

        SendMessage("You have entered the mutiny.\n" .. PrintMutinyMembers(), Color.Cyan, client)

        return true
    end
end)

Hook.Add("roundEnd", "MutinyMod.Clear", function ()
    mutinyStarted = false
    mutinyCharacter = {}
end)