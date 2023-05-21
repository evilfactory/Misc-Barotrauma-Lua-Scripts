--[[
    This example shows how to create a script that zooms out the camera when aiming with a weapon that has the "zoom" tag, currently only the lua revolver has this tag.
--]]

if SERVER then return end

local function lerp(a,b,t)
    return a * (1 - t) + b * t
end

Hook.Patch("Barotrauma.Character", "ControlLocalPlayer", function (instance, ptable)
    local character = instance

    if not character then return end
    if not character.Inventory then return end

    local rightHand = character.Inventory.GetItemInLimbSlot(InvSlotType.RightHand)
    local leftHand = character.Inventory.GetItemInLimbSlot(InvSlotType.LeftHand)
    local item = rightHand or leftHand

    if not item or not item.HasTag("zoom") then return end

    if not character.AnimController.IsAiming then return end

    Screen.Selected.Cam.OffsetAmount = lerp(Screen.Selected.Cam.OffsetAmount, 1000, 0.5)
end, Hook.HookMethodType.After)