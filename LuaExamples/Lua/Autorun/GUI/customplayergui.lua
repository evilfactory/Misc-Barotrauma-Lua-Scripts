--[[
    This example shows how to create a GUI that adds more options to the player menu. It makes use of networking to communicate actions.
--]]

if SERVER then
    Networking.Receive("explode", function (message, client)
        local characterID = message.ReadUInt16()

        local character = Entity.FindEntityByID(characterID)

        print(characterID)

        if character == nil then return end

        local explosion = Explosion(50, 999, 999, 999, 999, 999, 999)
        explosion.Explode(character.WorldPosition, nil)
    end)

elseif CLIENT then

    local function AddGUI(frame, client)
        local tickBox = GUI.TickBox(GUI.RectTransform(Vector2(1, 0.2), frame.RectTransform), "Evil person!!")
        tickBox.Selected = true
        tickBox.OnSelected = function ()
            print(tickBox.Selected)
        end
    
        local button = GUI.Button(GUI.RectTransform(Vector2(1, 0.2), frame.RectTransform, GUI.Anchor.TopRight), "Make Person Explode!!!", GUI.Alignment.Center, "GUIButtonSmall")
        button.RectTransform.AbsoluteOffset = Point(0, 0)
        button.OnClicked = function ()
            if client.Character == nil then return false end

            local message = Networking.Start("explode")
            message.WriteUInt16(client.Character.ID)
            Networking.Send(message)
        end
    end

    Hook.Patch("Barotrauma.NetLobbyScreen", "SelectPlayer", {"Barotrauma.Networking.Client"}, function(self, ptable)
        local client = ptable["selectedClient"]
        local playerFrame = self.PlayerFrame

        local children = {}
        for child in playerFrame.GetAllChildren() do
            table.insert(children, child)
        end

        local actualFrame = children[5]
        AddGUI(actualFrame, client)
    end, Hook.HookMethodType.After)

end