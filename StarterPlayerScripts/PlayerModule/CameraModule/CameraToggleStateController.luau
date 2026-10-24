-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

game:GetService("Players")
game:GetService("UserInputService")
UserSettings():GetService("UserGameSettings")

local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local CameraUI = require(script.Parent:WaitForChild("CameraUI"))
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local v1 = false
local v2 = tick()
local v3 = false
local v4 = false
local v5 = false

CameraUI.setCameraModeToastEnabled(false)

return function(p1) -- line: 20
    -- upvalues: CameraInput (copy), CameraUI (copy), CameraUtils (copy), v1 (ref), v2 (ref), v3 (ref), v4 (ref), v5 (ref)
    local v6 = CameraInput.getTogglePan()

    if p1 and v6 ~= v1 then
        v3 = true
    end

    if v1 ~= v6 or tick() - v2 > 3 then
        local v7

        if v6 then
            local v11 = tick()
            local v12 = v2

            v7 = v11 - v12 < 3
        else
            v7 = v6
        end

        CameraUI.setCameraModeToastOpen(v7)

        if v6 then
            v3 = false
        end

        v2 = tick()
        v1 = v6
    end

    if p1 ~= v5 then
        if p1 then
            v4 = CameraInput.getTogglePan()
            CameraInput.setTogglePan(true)
        elseif not v3 then
            CameraInput.setTogglePan(v4)
        end
    end

    if p1 then
        if CameraInput.getTogglePan() then
            CameraUtils.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
            CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
        else
            CameraUtils.restoreMouseIcon()
            CameraUtils.restoreMouseBehavior()
        end

        CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative)
    elseif CameraInput.getTogglePan() then
        CameraUtils.setMouseIconOverride("rbxasset://textures/Cursors/CrossMouseIcon.png")
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
        CameraUtils.setRotationTypeOverride(Enum.RotationType.MovementRelative)
    elseif CameraInput.getHoldPan() then
        CameraUtils.restoreMouseIcon()
        CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
        CameraUtils.setRotationTypeOverride(Enum.RotationType.MovementRelative)
    else
        CameraUtils.restoreMouseIcon()
        CameraUtils.restoreMouseBehavior()
        CameraUtils.restoreRotationType()
    end

    v5 = p1
end
