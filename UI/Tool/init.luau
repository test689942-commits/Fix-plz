-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("UserInputService")

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local _, _, GameMgr, New = _G.DataMgr, _G.PoolMgr, _G.GameMgr, _G.New

function t1.new(_) -- line: 10
    -- upvalues: t1 (copy)
    return t1
end

function t1.WheelTurn(_, p3, p4, p5, p6, p7) -- line: 14
    -- upvalues: RunService (copy)
    local v1 = p3 / p4
    local n1 = 0
    local connection

    connection = RunService.Stepped:Connect(function(_, p9) -- line: 19
        -- upvalues: p3 (ref), p5 (copy), p6 (copy), p7 (copy), v1 (copy), n1 (ref), connection (ref)
        if p3 <= v1 * p5 / 2 then
            n1 -= p9 / p5

            if n1 < 0.05 then
                n1 = 0.05
            end
        elseif n1 < 1 then
            n1 += p9 / p5
        else
            n1 = 1
        end

        if p3 > 0 then
            local v5 = v1 * p9 * n1

            p3 -= v5
            p6(v5)
        else
            connection:Disconnect()
            connection = nil
            p7()
        end
    end)

    return connection
end

function t1.SetButtonAnimation(_, p11, p12, p13, p14) -- line: 43
    -- upvalues: t1 (copy), TweenService (copy), GameMgr (copy)
    local v6 = p12
    local v7 = p14
    local v8 = p13 or 0.1

    v7 = p14 or 0.1
    p12 = p12 or p11
    v6 = p12

    local Sel = p12:FindFirstChild("Sel")

    if p12.AutomaticSize == Enum.AutomaticSize.None then
        local Size = p12.Size

        p11.MouseEnter:Connect(function() -- line: 50
            -- upvalues: v6 (ref), v8 (copy), v7 (ref), Sel (copy), Size (copy), t1 (copy), TweenService (copy), GameMgr (copy)
            TweenService:Create(v6, TweenInfo.new(v8), {
                Size = t1:UDim2Mul(Size, 1 + v7)
            }):Play()

            if Sel then
                GameMgr:PlaySound(1080)
                Sel.Visible = true
            end
        end)

        if p11:IsA("ImageButton") or p11:IsA("TextButton") then
            p11.MouseButton1Down:Connect(function() -- line: 58
                -- upvalues: v6 (ref), v8 (copy), v7 (ref), Size (copy), t1 (copy), TweenService (copy)
                TweenService:Create(v6, TweenInfo.new(v8), {
                    Size = t1:UDim2Mul(Size, 1 - v7)
                }):Play()
            end)
        end

        p11.MouseLeave:Connect(function() -- line: 62
            -- upvalues: v6 (ref), v8 (copy), Sel (copy), Size (copy), TweenService (copy)
            TweenService:Create(v6, TweenInfo.new(v8), {
                Size = Size
            }):Play()

            if Sel then
                Sel.Visible = false
            end
        end)
    else
        Instance.new("UIScale").Parent = p12
        p11.MouseEnter:Connect(function() -- line: 71
            -- upvalues: Sel (copy), GameMgr (copy)
            if Sel then
                GameMgr:PlaySound(1080)
                Sel.Visible = true
            end
        end)

        if p11:IsA("ImageButton") or p11:IsA("TextButton") then
            p11.MouseButton1Down:Connect(function() -- line: 79
            end)
        end

        p11.MouseLeave:Connect(function() -- line: 83
            -- upvalues: Sel (copy)
            if Sel then
                Sel.Visible = false
            end
        end)
    end

    return p11
end

function t1.UDim2Mul(_, p16, p17) -- line: 96
    return UDim2.new(p16.X.Scale * p17, p16.X.Offset * p17, p16.Y.Scale * p17, p16.Y.Offset * p17)
end

function t1.PositionToScale(_, p19, p20) -- line: 100
    local AbsoluteSize, AbsolutePosition = p20.AbsoluteSize, p20.AbsolutePosition
    local v10 = Vector2.new((p19.x - AbsolutePosition.x) / AbsoluteSize.X, (p19.Y - AbsolutePosition.Y) / AbsoluteSize.Y)

    return UDim2.new(v10.X, 0, v10.Y, 0)
end

function t1.SizeToScale(_, p22, p23) -- line: 108
    return UDim2.new(p22.X / p23.AbsoluteSize.X, 0, p22.Y / p23.AbsoluteSize.Y)
end

function t1.SFQuickJump(_, p25, p26, p27, p28) -- line: 113
    -- upvalues: TweenService (copy)
    if p27 then
        TweenService:Create(p25, p28 or TweenInfo.new(0.8), {
            CanvasPosition = p25.CanvasPosition + p26.AbsolutePosition - p25.AbsolutePosition
        }):Play()
    else
        p25.CanvasPosition += p26.AbsolutePosition - p25.AbsolutePosition
    end
end

local Star = script.Star

function t1.StarEffect(_, p30, p31, p32, p33) -- line: 122
    -- upvalues: TweenService (copy), Star (copy)
    local v11 = p32
    local v12 = p33 or 0.1

    v11 = p32 or 0.2

    local v13 = task.spawn(function() -- line: 125
        -- upvalues: v11 (ref), v12 (copy), p30 (copy), p31 (copy), TweenService (copy), Star (copy)
        while true do
            task.wait(p31 or 0.5)

            local clone = Star:Clone()

            clone.Parent = p30
            clone.Position = UDim2.new(math.random(), 0, math.random(), 0)
            clone.Size = UDim2.new(0, 0, 0, 0)

            local v14 = math.random() * (v12 - v11) + v11
            local tween = TweenService:Create(clone, TweenInfo.new(1), {
                Size = UDim2.new(v14, 0, v14, 0)
            })
            local v15 = tween

            tween.Completed:Connect(function() -- line: 134
                -- upvalues: clone (copy), v15 (ref), TweenService (copy)
                v15 = TweenService:Create(clone, TweenInfo.new(1), {
                    Size = UDim2.new(0, 0, 0, 0)
                })
                v15.Completed:Connect(function() -- line: 136
                    -- upvalues: clone (copy)
                    clone:Destroy()
                end)
                v15:Play()
            end)
            v15:Play()
        end
    end)

    return {
        Disconnect = function() -- Disconnect | line: 145
            -- upvalues: v13 (copy)
            task.cancel(v13)
            coroutine.close(v13)
        end
    }
end

local t3 = {}

function t1.TweenText(_, p35, p36, p37) -- line: 153
    -- upvalues: New (copy), t3 (copy)
    if t3[p35] then
        t3[p35]:Destroy()
    end

    local v16 = false
    local v17 = New("CS.Action")()

    task.spawn(function() -- line: 159
        -- upvalues: p35 (copy), p36 (copy), p37 (copy), v16 (ref), v17 (copy), t3 (copy)
        local v18 = #p36
        local v19 = p37 / v18

        for i = 1, v18 do
            task.wait(v19)

            if v16 then
                return
            end

            if p35.Parent == nil then
                break
            end

            p35.Text = string.sub(p36, 1, i)
        end

        v17()
        t3[p35] = nil
    end)
    t3[p35] = {
        Destroy = function() -- Destroy | line: 177
            -- upvalues: p35 (copy), p36 (copy), v16 (ref), t3 (copy)
            p35.Text = p36
            v16 = true
            t3[p35] = nil
        end,
        Completed = v17
    }

    return t3[p35]
end

local t5 = {}

function t1.TweenNumberText(_, p39, p40, p41) -- line: 188
    -- upvalues: RunService (copy), New (copy), t5 (copy)
    local v20 = p41

    if t5[p39] then
        t5[p39]:Destroy()
    end

    local t6 = {}

    t6.Destroy = function() -- line: 193
        -- upvalues: p39 (copy), t6 (copy), t5 (copy)
        t5[p39] = nil
        t6.con:Disconnect()
    end

    t6.completed = New("CS.Action")()

    local v21 = tonumber(p39.Text) or 0
    local v22 = v21
    local v23 = (p40 - v21) / p41

    t6.con = RunService.RenderStepped:Connect(function(p42) -- line: 203
        -- upvalues: v20 (ref), p39 (copy), p40 (copy), t6 (copy), v22 (ref), v23 (copy)
        v20 -= p42

        if v20 <= 0 then
            t6.completed()
            t6.Destroy()
            p39.Text = p40
        else
            v22 += p42 * v23
            p39.Text = math.ceil(v22)
        end
    end)
    t5[p39] = t6

    return t6
end

local function SetUIGradientBar(p43, p44) -- line: 219
    if p44 < 0.01 then
        p43.ui.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, p43.endColor),
            ColorSequenceKeypoint.new(1, p43.endColor)
        })
    elseif p44 > 0.99 then
        p43.ui.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, p43.startColor),
            ColorSequenceKeypoint.new(1, p43.startColor)
        })
    else
        p43.ui.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, p43.startColor),
            ColorSequenceKeypoint.new(p44 - 0.005, p43.startColor),
            ColorSequenceKeypoint.new(p44, p43.endColor),
            ColorSequenceKeypoint.new(1, p43.endColor)
        })
    end
end

function t1.CreatUIGradientBar(_, p46, p47, p48) -- line: 237
    -- upvalues: SetUIGradientBar (copy)
    if p46 == nil then
        return
    end

    return {
        ui = p46,
        startColor = p47,
        endColor = p48,
        SetValue = SetUIGradientBar
    }
end

function t1.RotateGUI(_, p50, p51) -- line: 250
    -- upvalues: RunService (copy)
    local v26 = p51 or 40
    local connection

    connection = RunService.RenderStepped:Connect(function(p52) -- line: 253
        -- upvalues: v26 (copy), p50 (copy), connection (ref)
        if p50 == nil or p50.Parent == nil then
            connection:Disconnect()
        else
            p50.Rotation += v26 * p52

            if p50.Rotation > 180 then
                p50.Rotation -= 360
            elseif p50.Rotation < -180 then
                p50.Rotation += 360
            end
        end
    end)

    return {
        Destroy = function() -- Destroy | line: 267
            -- upvalues: connection (ref)
            connection:Disconnect()
        end
    }
end

local UIGradientEffect = require(script.UIGradientEffect)

function t1.UIGradientEffect(_, p54, p55, p56) -- line: 274
    -- upvalues: UIGradientEffect (copy)
    if UIGradientEffect[p55] then
        return UIGradientEffect[p55](p54, p56)
    end
end

t1.RegisterRedDot = require(script.RegisterRedDot)
t1.GenUI = require(script.GenUI)
t1.UIAdaptive = require(script.UIAdaptive)

return t1
