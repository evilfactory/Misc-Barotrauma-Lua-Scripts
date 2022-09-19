--[[
    This example shows how to create a command that sends a message to everyone.
--]]

if CLIENT then return end -- stops this from running on the client


Hook.Add("chatMessage", "examples.chatMessages", function (message, client)
    if message ~= "!announce" then return end

    for key, client in pairs(Client.ClientList) do
        local chatMessage = ChatMessage.Create("John", "Hi Everyone!", ChatMessageType.Default, nil, nil)
        chatMessage.Color = Color(255, 255, 0, 255)
        Game.SendDirectChatMessage(chatMessage, client)
    end
end)