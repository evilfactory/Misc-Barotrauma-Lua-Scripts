if SERVER then return end

local states = {}

Hook.Patch("Barotrauma.Items.Components.CustomInterface", "CreateGUI", function (instance, ptable)
    if not instance.originalElement.GetAttributeString("type", "") == "luacustom" then
        return
    end

    local item = instance.Item

    local frame = instance.GuiFrame
    local menuList = GUI.ListBox(GUI.RectTransform(frame.Rect.Size - GUI.GUIStyle.ItemFrameMargin, frame.RectTransform, GUI.Anchor.Center))

    GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.05), menuList.Content.RectTransform), "This is a sample text!", nil, nil, GUI.Alignment.Center)

    for i = 1, 10, 1 do
        local coloredText = GUI.TextBlock(GUI.RectTransform(Vector2(1, 0.025), menuList.Content.RectTransform), "This is some colored text!", nil, nil, GUI.Alignment.Center)
        coloredText.TextColor = Color(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    end

    local tickBox = GUI.TickBox(GUI.RectTransform(Vector2(1, 0.2), menuList.Content.RectTransform), "This is a tick box")
    tickBox.Selected = true
    tickBox.OnSelected = function ()
        states[item] = tickBox.Selected
        print(tickBox.Selected)
    end

end)