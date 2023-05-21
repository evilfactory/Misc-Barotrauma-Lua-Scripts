--[[
    This example shows how to create a script that sends the chat messages in barotrauma to a discord webhook
--]]

if CLIENT then return end -- stops this from running on the client


local discordWebHook = "your discord webhook here"

local function escapeQuotes(str)
    return str:gsub("\"", "\\\"")
end

Hook.Add("chatMessage", "examples.simpleDiscordChat", function (msg, client)
    local escapedName = escapeQuotes(client.Name)
    local escapedMessage = escapeQuotes(msg)

    Networking.RequestPostHTTP(discordWebHook, function(result) end, '{\"content\": \"'..escapedMessage..'\", \"username\": \"'..escapedName..'\"}')
end)