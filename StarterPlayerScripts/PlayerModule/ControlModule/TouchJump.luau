-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"))
local self = setmetatable({}, BaseCharacterController)

self.__index = self

function self.new() -- line: 20
    -- upvalues: BaseCharacterController (copy), self (copy)
    local v3 = setmetatable(BaseCharacterController.new(), self)

    v3.parentUIFrame = nil
    v3.jumpButton = nil
    v3.characterAddedConn = nil
    v3.humanoidStateEnabledChangedConn = nil
    v3.humanoidJumpPowerConn = nil
    v3.humanoidParentConn = nil
    v3.externallyEnabled = false
    v3.jumpPower = 0
    v3.jumpStateEnabled = true
    v3.isJumping = false
    v3.humanoid = nil

    return v3
end

function self.EnableButton(p1, p2) -- line: 38
    -- upvalues: Players (copy)
    if p2 then
        if not p1.jumpButton then
            p1:Create()
        end

        local v4 = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

        if v4 and p1.externallyEnabled and p1.externallyEnabled and v4.JumpPower > 0 then
            p1.jumpButton.Visible = true
        end
    else
        p1.jumpButton.Visible = false
        p1.isJumping = false
        p1.jumpButton.ImageRectOffset = Vector2.new(1, 146)
    end
end

function self.UpdateEnabled(p3) -- line: 58
    if not (p3.jumpPower > 0 and p3.jumpStateEnabled) then
        p3:EnableButton(false)
    else
        p3:EnableButton(true)
    end
end

function self.HumanoidChanged(p4, p5) -- line: 66
    -- upvalues: Players (copy)
    local v5 = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

    if v5 then
        if p5 == "JumpPower" then
            p4.jumpPower = v5.JumpPower
            p4:UpdateEnabled()
        elseif p5 == "Parent" and not v5.Parent then
            p4.humanoidChangeConn:Disconnect()
        end
    end
end

function self.HumanoidStateEnabledChanged(p6, p7, p8) -- line: 80
    if p7 == Enum.HumanoidStateType.Jumping then
        p6.jumpStateEnabled = p8
        p6:UpdateEnabled()
    end
end

function self.CharacterAdded(p9, p10) -- line: 87
    if p9.humanoidChangeConn then
        p9.humanoidChangeConn:Disconnect()
        p9.humanoidChangeConn = nil
    end

    p9.humanoid = p10:FindFirstChildOfClass("Humanoid")

    while not p9.humanoid do
        p10.ChildAdded:wait()
        p9.humanoid = p10:FindFirstChildOfClass("Humanoid")
    end

    p9.humanoidJumpPowerConn = p9.humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function() -- line: 99
        -- upvalues: p9 (copy)
        p9.jumpPower = p9.humanoid.JumpPower
        p9:UpdateEnabled()
    end)
    p9.humanoidParentConn = p9.humanoid:GetPropertyChangedSignal("Parent"):Connect(function() -- line: 104
        -- upvalues: p9 (copy)
        if p9.humanoid.Parent then
            return
        end

        p9.humanoidJumpPowerConn:Disconnect()
        p9.humanoidJumpPowerConn = nil
        p9.humanoidParentConn:Disconnect()
        p9.humanoidParentConn = nil
    end)
    p9.humanoidStateEnabledChangedConn = p9.humanoid.StateEnabledChanged:Connect(function(p11, p12) -- line: 113
        -- upvalues: p9 (copy)
        p9:HumanoidStateEnabledChanged(p11, p12)
    end)
    p9.jumpPower = p9.humanoid.JumpPower
    p9.jumpStateEnabled = p9.humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping)
    p9:UpdateEnabled()
end

function self.SetupCharacterAddedFunction(p13) -- line: 122
    -- upvalues: Players (copy)
    p13.characterAddedConn = Players.LocalPlayer.CharacterAdded:Connect(function(p14) -- line: 123
        -- upvalues: p13 (copy)
        p13:CharacterAdded(p14)
    end)

    if Players.LocalPlayer.Character then
        p13:CharacterAdded(Players.LocalPlayer.Character)
    end
end

function self.Enable(p15, p16, p17) -- line: 131
    if p17 then
        p15.parentUIFrame = p17
    end

    p15.externallyEnabled = p16
    p15:EnableButton(p16)
end

function self.Create(p18) -- line: 139
    -- upvalues: GuiService (copy)
    if p18.parentUIFrame then
        if p18.jumpButton then
            p18.jumpButton:Destroy()
            p18.jumpButton = nil
        end

        local v6 = math.min(p18.parentUIFrame.AbsoluteSize.x, p18.parentUIFrame.AbsoluteSize.y) <= 500
        local v7 = if v6 then 70 else 120

        p18.jumpButton = Instance.new("ImageButton")
        p18.jumpButton.Name = "JumpButton"
        p18.jumpButton.Visible = false
        p18.jumpButton.BackgroundTransparency = 1
        p18.jumpButton.Image = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"
        p18.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        p18.jumpButton.ImageRectSize = Vector2.new(144, 144)
        p18.jumpButton.Size = UDim2.new(0, v7, 0, v7)
        p18.jumpButton.Position = v6 and UDim2.new(1, -(v7 * 1.5 - 10), 1, -v7 - 20) or UDim2.new(1, -(v7 * 1.5 - 10), 1, -v7 * 1.75)

        local v8

        p18.jumpButton.InputBegan:connect(function(p19) -- line: 166
            -- upvalues: p18 (copy), v8 (ref)
            if v8 or p19.UserInputType ~= Enum.UserInputType.Touch or p19.UserInputState ~= Enum.UserInputState.Begin then
                return
            end

            v8 = p19
            p18.jumpButton.ImageRectOffset = Vector2.new(146, 146)
            p18.isJumping = true
        end)
        p18.jumpButton.InputEnded:connect(function(p20) -- line: 185
            -- upvalues: p18 (copy), v8 (ref)
            if p20 ~= v8 then
                return
            end

            v8 = nil
            p18.isJumping = false
            p18.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        end)
        GuiService.MenuOpened:connect(function() -- line: 191
            -- upvalues: p18 (copy), v8 (ref)
            if not v8 then
                return
            end

            v8 = nil
            p18.isJumping = false
            p18.jumpButton.ImageRectOffset = Vector2.new(1, 146)
        end)

        if not p18.characterAddedConn then
            p18:SetupCharacterAddedFunction()
        end

        p18.jumpButton.Parent = p18.parentUIFrame
    end
end

return self
