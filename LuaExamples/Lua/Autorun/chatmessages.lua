--[[
    This example shows how to create a command that sends a message to everyone.
    Multiplayer Only.
--]]

if CLIENT then return end -- stops this from running on the client


Hook.Add("chatMessage", "examples.chatMessages", function (message, client)
    if message ~= "!announce" then return end

    for key, client in pairs(Client.ClientList) do
        -- Note: this ChatMessage cannot be reused multiple times, you need to create a new one for each new message to each client
        local chatMessage = ChatMessage.Create("John", "Hi Everyone!", ChatMessageType.Default, nil, nil)
        chatMessage.Color = Color(255, 255, 0, 255)
        Game.SendDirectChatMessage(chatMessage, client)
    end

    return true -- returning true allows us to hide the message
end)