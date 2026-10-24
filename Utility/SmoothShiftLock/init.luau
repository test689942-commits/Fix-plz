-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

game:GetService("ContextActionService")
game:GetService("UserInputService")

local New, InputMgr = _G.New, _G.InputMgr
local Maid = require(script:WaitForChild("Maid"))
local Spring = require(script:WaitForChild("Spring"))
local LocalPlayer = Players.LocalPlayer

LocalPlayer:GetMouse()

local CurrentCamera = Workspace.CurrentCamera
local t2 = {
    MOBILE_SUPPORT = true,
    SMOOTH_CHARACTER_ROTATION = true,
    CHARACTER_ROTATION_SPEED = 3,
    TRANSITION_SPRING_DAMPER = 0.7,
    CAMERA_TRANSITION_IN_SPEED = 10,
    CAMERA_TRANSITION_OUT_SPEED = 14,
    LOCKED_CAMERA_OFFSET = Vector3.new(2, 0.75, 0),
    LOCKED_MOUSE_ICON = "rbxasset://textures/MouseLockedCursor.png",
    SHIFT_LOCK_KEYBINDS = {
        Enum.KeyCode.LeftShift,
        Enum.KeyCode.RightShift
    }
}

function t1.new(p1) -- line: 57
    -- upvalues: RunService (copy), New (copy), Maid (copy), Spring (copy), CurrentCamera (copy), t2 (copy)
    p1._runtimeMaid = Maid.new()
    p1._shiftlockTrove = New("Utility.Trove")()
    p1._cameraOffsetSpring = Spring.new((Vector3.new(0, 0, 0)))
    p1._cameraOffsetSpring.Damper = t2.TRANSITION_SPRING_DAMPER
    p1.Enabled = false
    p1.MouseLock = true
    p1:_refreshCharacterVariables()
    p1._runtimeMaid:GiveTask(RunService.RenderStepped:Connect(function() -- line: 79
        -- upvalues: p1 (copy), CurrentCamera (copy)
        if not (p1.Head.LocalTransparencyModifier > 0.6) then
            local _CFrame = CurrentCamera.CFrame

            if (p1.Head.Position - _CFrame.p).magnitude > 1 then
                CurrentCamera.CFrame *= CFrame.new(p1._cameraOffsetSpring.Position)
            end
        end
    end))
end

function t1.Destroy(p2) -- line: 92
    p2._runtimeMaid:DoCleaning()
    p2._shiftlockTrove:Clean()
end

function t1._refreshCharacterVariables(p3) -- line: 101
    -- upvalues: LocalPlayer (copy)
    p3.Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    p3.RootPart = p3.Character:WaitForChild("HumanoidRootPart")
    p3.Humanoid = p3.Character:WaitForChild("Humanoid")
    p3.Head = p3.Character:WaitForChild("Head")
end

function t1._transitionLockOffset(p4) -- line: 109
    -- upvalues: t2 (copy)
    if p4.Enabled then
        p4._cameraOffsetSpring.Speed = t2.CAMERA_TRANSITION_IN_SPEED
        p4._cameraOffsetSpring.Target = t2.LOCKED_CAMERA_OFFSET
    else
        p4._cameraOffsetSpring.Speed = t2.CAMERA_TRANSITION_OUT_SPEED
        p4._cameraOffsetSpring.Target = Vector3.new(0, 0, 0)
    end
end

function t1.IsEnabled(p5) -- line: 120
    return p5.Enabled
end

function t1.ToggleShiftLock(p6, p7) -- line: 125
    -- upvalues: RunService (copy), InputMgr (copy), CurrentCamera (copy), t2 (copy)
    if p7 ~= nil then
        if p6.Enabled == p7 then
            return
        end

        p6.Enabled = p7
    else
        p6.Enabled = not p6.Enabled
    end

    p6:_transitionLockOffset()

    if p6.Enabled then
        p6._shiftlockTrove:Add(RunService.RenderStepped:Connect(function(p8) -- line: 136
            -- upvalues: p6 (copy), CurrentCamera (copy), t2 (copy)
            if p6.Humanoid and p6.RootPart then
                p6.Humanoid.AutoRotate = false
            end

            if not p6.Humanoid.Sit then
                if t2.SMOOTH_CHARACTER_ROTATION then
                    local _, v1 = CurrentCamera.CFrame:ToOrientation()

                    p6.RootPart.CFrame = p6.RootPart.CFrame:Lerp(CFrame.new(p6.RootPart.Position) * CFrame.Angles(0, v1, 0), p8 * 5 * t2.CHARACTER_ROTATION_SPEED)
                else
                    local _, v2 = CurrentCamera.CFrame:ToOrientation()

                    p6.RootPart.CFrame = CFrame.new(p6.RootPart.Position) * CFrame.Angles(0, v2, 0)
                end
            end
        end))
        p6._shiftlockTrove:Add(InputMgr:LockMouse(true))
    else
        p6.Humanoid.AutoRotate = true
        p6._shiftlockTrove:Clean()
    end
end

return t1
