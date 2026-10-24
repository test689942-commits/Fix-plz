-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

game:GetService("Players")

local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"))
local self = setmetatable({}, BaseCharacterController)

self.__index = self

function self.new() -- line: 17
    -- upvalues: BaseCharacterController (copy), self (copy)
    local v3 = setmetatable(BaseCharacterController.new(), self)

    v3.isFollowStick = false
    v3.thumbstickFrame = nil
    v3.moveTouchObject = nil
    v3.onTouchMovedConn = nil
    v3.onTouchEndedConn = nil
    v3.screenPos = nil
    v3.stickImage = nil
    v3.thumbstickSize = nil

    return v3
end

function self.Enable(p1, p2, p3) -- line: 32
    if p2 == nil then
        return false
    end

    local v4 = not not p2

    if p1.enabled == v4 then
        return true
    end

    p1.moveVector = Vector3.new(0, 0, 0)
    p1.isJumping = false

    if v4 then
        if not p1.thumbstickFrame then
            p1:Create(p3)
        end

        p1.thumbstickFrame.Visible = true
    else
        p1.thumbstickFrame.Visible = false
        p1:OnInputEnded()
    end

    p1.enabled = v4
end

function self.OnInputEnded(p4) -- line: 53
    p4.thumbstickFrame.Position = p4.screenPos
    p4.stickImage.Position = UDim2.new(0, p4.thumbstickFrame.Size.X.Offset / 2 - p4.thumbstickSize / 4, 0, p4.thumbstickFrame.Size.Y.Offset / 2 - p4.thumbstickSize / 4)
    p4.moveVector = Vector3.new(0, 0, 0)
    p4.isJumping = false
    p4.thumbstickFrame.Position = p4.screenPos
    p4.moveTouchObject = nil
end

function self.Create(p5, p6) -- line: 62
    -- upvalues: GuiService (copy), UserInputService (copy)
    if p5.thumbstickFrame then
        p5.thumbstickFrame:Destroy()
        p5.thumbstickFrame = nil

        if p5.onTouchMovedConn then
            p5.onTouchMovedConn:Disconnect()
            p5.onTouchMovedConn = nil
        end

        if p5.onTouchEndedConn then
            p5.onTouchEndedConn:Disconnect()
            p5.onTouchEndedConn = nil
        end
    end

    local v5 = math.min(p6.AbsoluteSize.X, p6.AbsoluteSize.Y) <= 500

    p5.thumbstickSize = v5 and 70 or 120
    p5.screenPos = v5 and UDim2.new(0, p5.thumbstickSize / 2 - 10, 1, -p5.thumbstickSize - 20) or UDim2.new(0, p5.thumbstickSize / 2, 1, -p5.thumbstickSize * 1.75)
    p5.thumbstickFrame = Instance.new("Frame")
    p5.thumbstickFrame.Name = "ThumbstickFrame"
    p5.thumbstickFrame.Active = true
    p5.thumbstickFrame.Visible = false
    p5.thumbstickFrame.Size = UDim2.new(0, p5.thumbstickSize, 0, p5.thumbstickSize)
    p5.thumbstickFrame.Position = p5.screenPos
    p5.thumbstickFrame.BackgroundTransparency = 1

    local ImageLabel = Instance.new("ImageLabel")

    ImageLabel.Name = "OuterImage"
    ImageLabel.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    ImageLabel.ImageRectOffset = Vector2.new()
    ImageLabel.ImageRectSize = Vector2.new(220, 220)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Size = UDim2.new(0, p5.thumbstickSize, 0, p5.thumbstickSize)
    ImageLabel.Position = UDim2.new(0, 0, 0, 0)
    ImageLabel.Parent = p5.thumbstickFrame
    p5.stickImage = Instance.new("ImageLabel")
    p5.stickImage.Name = "StickImage"
    p5.stickImage.Image = "rbxasset://textures/ui/TouchControlsSheet.png"
    p5.stickImage.ImageRectOffset = Vector2.new(220, 0)
    p5.stickImage.ImageRectSize = Vector2.new(111, 111)
    p5.stickImage.BackgroundTransparency = 1
    p5.stickImage.Size = UDim2.new(0, p5.thumbstickSize / 2, 0, p5.thumbstickSize / 2)
    p5.stickImage.Position = UDim2.new(0, p5.thumbstickSize / 2 - p5.thumbstickSize / 4, 0, p5.thumbstickSize / 2 - p5.thumbstickSize / 4)
    p5.stickImage.ZIndex = 2
    p5.stickImage.Parent = p5.thumbstickFrame

    local v7

    local function DoMove(p7) -- line: 115
        -- upvalues: p5 (copy)
        local v8 = p7 / (p5.thumbstickSize / 2)
        local magnitude = v8.magnitude
        local v9

        if magnitude < 0.05 then
            v9 = Vector3.new()
        else
            local v10 = v8.unit * ((magnitude - 0.05) / 0.95)

            v9 = Vector3.new(v10.X, 0, v10.Y)
        end

        p5.moveVector = v9
    end

    local function MoveStick(p8) -- line: 133
        -- upvalues: p5 (copy), v7 (ref)
        local v11 = Vector2.new(p8.X - v7.X, p8.Y - v7.Y)
        local magnitude = v11.magnitude
        local v12 = p5.thumbstickFrame.AbsoluteSize.X / 2

        if not (p5.isFollowStick and v12 < magnitude) then
            local v13 = math.min(magnitude, v12)

            v11 = v11.unit * v13
        else
            local v14 = v11.unit * v12

            p5.thumbstickFrame.Position = UDim2.new(0, p8.X - p5.thumbstickFrame.AbsoluteSize.X / 2 - v14.X, 0, p8.Y - p5.thumbstickFrame.AbsoluteSize.Y / 2 - v14.Y)
        end

        p5.stickImage.Position = UDim2.new(0, v11.X + p5.stickImage.AbsoluteSize.X / 2, 0, v11.Y + p5.stickImage.AbsoluteSize.Y / 2)
    end

    p5.thumbstickFrame.InputBegan:Connect(function(p9) -- line: 150
        -- upvalues: p5 (copy), v7 (ref)
        if p5.moveTouchObject or p9.UserInputType ~= Enum.UserInputType.Touch or p9.UserInputState ~= Enum.UserInputState.Begin then
            return
        end

        p5.moveTouchObject = p9
        p5.thumbstickFrame.Position = UDim2.new(0, p9.Position.X - p5.thumbstickFrame.Size.X.Offset / 2, 0, p9.Position.Y - p5.thumbstickFrame.Size.Y.Offset / 2)
        v7 = Vector2.new(p5.thumbstickFrame.AbsolutePosition.X + p5.thumbstickFrame.AbsoluteSize.X / 2, p5.thumbstickFrame.AbsolutePosition.Y + p5.thumbstickFrame.AbsoluteSize.Y / 2)
        Vector2.new(p9.Position.X - v7.X, p9.Position.Y - v7.Y)
    end)
    p5.onTouchMovedConn = UserInputService.TouchMoved:Connect(function(p10, _) -- line: 165
        -- upvalues: p5 (copy), v7 (ref), MoveStick (copy)
        if p10 ~= p5.moveTouchObject then
            return
        end

        v7 = Vector2.new(p5.thumbstickFrame.AbsolutePosition.X + p5.thumbstickFrame.AbsoluteSize.X / 2, p5.thumbstickFrame.AbsolutePosition.Y + p5.thumbstickFrame.AbsoluteSize.Y / 2)

        local v15 = Vector2.new(p10.Position.X - v7.X, p10.Position.Y - v7.Y) / (p5.thumbstickSize / 2)
        local magnitude = v15.magnitude
        local v16

        if magnitude < 0.05 then
            v16 = Vector3.new()
        else
            local v17 = v15.unit * ((magnitude - 0.05) / 0.95)

            v16 = Vector3.new(v17.X, 0, v17.Y)
        end

        p5.moveVector = v16
        MoveStick(p10.Position)
    end)
    p5.onTouchEndedConn = UserInputService.TouchEnded:Connect(function(p12, _) -- line: 175
        -- upvalues: p5 (copy)
        if p12 == p5.moveTouchObject then
            p5:OnInputEnded()
        end
    end)
    GuiService.MenuOpened:Connect(function() -- line: 181
        -- upvalues: p5 (copy)
        if p5.moveTouchObject then
            p5:OnInputEnded()
        end
    end)
    p5.thumbstickFrame.Parent = p6
end

return self
