-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local New = _G.New

game:GetService("UserInputService")

function t1.new(p1, p2, p3, p4) -- line: 5
    -- upvalues: New (copy)
    p1.back = p2
    p1.bar = p3
    p1.button = p4
    p1.ScreenGui = p1.back:FindFirstAncestorOfClass("ScreenGui")

    if p4 then
        local UIDragDetector = Instance.new("UIDragDetector", p4)

        UIDragDetector.BoundingUI = p2
        UIDragDetector.DragStyle = Enum.UIDragDetectorDragStyle.TranslateLine
        UIDragDetector.ReferenceUIInstance = p2
        UIDragDetector.ResponseStyle = Enum.UIDragDetectorResponseStyle.Offset
        p4.AnchorPoint = Vector2.new(0, p4.AnchorPoint.Y)
        p4.Position = UDim2.new(0, 0, p4.Position.Y.Scale, p4.Position.Y.Offset)
        UIDragDetector.DragContinue:Connect(function() -- line: 20
            -- upvalues: p1 (copy), p4 (copy)
            p1:Move(p4.Position.X.Offset / (p4.Parent.AbsoluteSize.X - p4.AbsoluteSize.X - 1))
        end)
    end

    p1.OnValueChange = New("CS.Action")()
    p1:SetValueNotChange(0)
end

function t1.SetValue(p5, p6) -- line: 29
    local v1 = math.clamp(p6, 0, 1)

    if p5.button then
        p5.button.Position = UDim2.new(0, (p5.button.Parent.AbsoluteSize.X - p5.button.AbsoluteSize.X) * v1, p5.button.Position.Y.Scale, p5.button.Position.Y.Offset)
    end

    if p5.bar then
        p5.bar.Size = UDim2.new(v1, 0, p5.bar.Size.Y.Scale, p5.bar.Size.Y.Offset)
    end

    p5.value = v1
    p5.OnValueChange:Invoke(p5:GetValue())
end

function t1.SetValueNotChange(p7, p8) -- line: 41
    local v2 = math.clamp(p8, 0, 1)

    if p7.button then
        p7.button.Position = UDim2.new(0, (p7.button.Parent.AbsoluteSize.X - p7.button.AbsoluteSize.X) * v2, p7.button.Position.Y.Scale, p7.button.Position.Y.Offset)
    end

    if p7.bar then
        p7.bar.Size = UDim2.new(v2, 0, p7.bar.Size.Y.Scale, p7.bar.Size.Y.Offset)
    end

    p7.value = v2
end

function t1.GetValue(p9) -- line: 52
    return p9.min and p9.min + p9.value * (p9.max - p9.min) or p9.value
end

function t1.SetLimit(p10, p11, p12) -- line: 56
    p10.min = p11

    if not (p12 < p11) or not p11 then
        p10.max = p12
    else
        p10.max = p11
    end

    p10.OnValueChange:Invoke(p10:GetValue())
end

function t1.AddValue(p13, p14) -- line: 62
    if not (p13.value < 1) then
        return
    end

    p13:SetValue(p13.value + (p13.min and p14 / (p13.max - p13.min) or p14))
end

function t1.RemoveValue(p15, p16) -- line: 68
    if not (p15.value > 0) then
        return
    end

    p15:SetValue(p15.value - (p15.min and p16 / (p15.max - p15.min) or p16))
end

function t1.Move(p17, p18) -- line: 74
    local v3 = if p18 > 1 then 1 else p18

    if v3 == p17.value then
        return
    end

    if p17.bar then
        p17.bar.Size = UDim2.new(v3, 0, p17.bar.Size.Y.Scale, p17.bar.Size.Y.Offset)
    end

    p17.value = v3
    p17.OnValueChange:Invoke(p17:GetValue())
end

return t1
