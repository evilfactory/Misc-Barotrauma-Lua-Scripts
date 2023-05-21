-- by Television (most functions were made by Evil Factory, modified by me)
-- sends a message to the server every 500 seconds

if CLIENT then return end

-- CONFIG
local messageIsPopUp = false -- if the tips are popups or not
local time = 0 -- don't change
local tipDelay = 500 -- change 500 to how much longer you want the next tip to be (in seconds)
local TipText = "Pro Tip: " -- make this string blank if you don't want something before the tip

local Tips = {
    "Join our discord!",
    "hi"
}

SendChatMessage = function (client, text, color)
    if not client or not text or text == "" then
        return
    end

    local chatMessage = nil
    text = tostring(text)

    if messageIsPopUp then
        chatMessage = ChatMessage.Create("", text, ChatMessageType.MessageBox)
    else
        chatMessage = ChatMessage.Create("", text, ChatMessageType.Default)
    end
 
    if color then
        chatMessage.Color = color
    end

    Game.SendDirectChatMessage(chatMessage, client)
end

SendTip = function ()
    local tip = Tips[math.random(1, #Tips)]

    for index, value in pairs(Client.ClientList) do
        SendChatMessage(value, TipText .. tip, Color.Blue) -- https://learn.microsoft.com/en-us/dotnet/api/system.windows.media.colors?view=windowsdesktop-7.0 , in the C# colors class, all possible colors
    end
end

Hook.Add("think", "TipThink", function()
    if Timer.GetTime() > time then
        time = Timer.GetTime() + tipDelay -- change 500 to how much longer you want the next tip to be
        SendTip()
    end
end)
