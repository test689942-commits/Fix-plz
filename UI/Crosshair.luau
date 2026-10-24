-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1
game:GetService("RunService")
game:GetService("UserInputService")

local TweenService = game:GetService("TweenService")

local function PosTable_Func(p1) -- line: 35
    return {
        Top = UDim2.new(0, -1, 0, -p1 - 7),
        Left = UDim2.new(0, -p1 - 7, 0, 0),
        Right = UDim2.new(0, p1, 0, 0),
        Bottom = UDim2.new(0, -1, 0, p1)
    }
end

function t1.new(_, p3, p4, p5, p6, p7) -- line: 45
    -- upvalues: t1 (copy)
    local t2 = {}

    setmetatable(t2, t1)
    t2.MainFrame = p3
    t2.Enabled = nil
    t2.EasingStyle = p5 or Enum.EasingStyle.Quint
    t2.EasingDirection = p6 or Enum.EasingDirection.Out
    t2.Lerp = p7 or 1
    t2.Radius = p4 or 50
    t2.Frozen = false
    t2:Disable()
    t2:Set(t2.Radius)

    return t2
end

function t1.Set(p8, p9, p10, p11, p12, p13) -- line: 63
    -- upvalues: TweenService (copy), PosTable_Func (copy)
    if p8.Enabled then
        if typeof(p9) ~= "number" then
            warn("Argument #1 is not a valid radius")

            return
        end

        local v1 = typeof(p10) == "boolean" and p10

        p8.Radius = p9

        local v2 = PosTable_Func(p8.Radius)

        for v3, v4 in pairs(v2) do
            if v1 then
                TweenService:Create(p8.MainFrame[v3], TweenInfo.new(p13 or p8.Lerp, p11 or p8.EasingStyle, p12 or p8.EasingDirection), {
                    Position = v4
                }):Play()
            else
                p8.MainFrame[v3].Position = v4
            end
        end
    end
end

function t1.Shove(p14, p15, p16, p17, p18) -- line: 80
    -- upvalues: TweenService (copy), PosTable_Func (copy)
    if p14.Enabled then
        if typeof(p15) ~= "number" then
            warn("Argument #1 is not a valid radius")

            return
        end

        p14.MainFrame.Top.Position = UDim2.new(0, 0, 0, -p14.Radius - 7 - p15)
        p14.MainFrame.Left.Position = UDim2.new(0, -p14.Radius - 7 - p15, 0, 0)
        p14.MainFrame.Right.Position = UDim2.new(0, p14.Radius + p15, 0, 0)
        p14.MainFrame.Bottom.Position = UDim2.new(0, 0, 0, p14.Radius + p15)

        local v5 = PosTable_Func(p14.Radius)

        for v6, v7 in pairs(v5) do
            TweenService:Create(p14.MainFrame[v6], TweenInfo.new(p18 or p14.Lerp, p16 or p14.EasingStyle, p17 or p14.EasingDirection), {
                Position = v7
            }):Play()
        end
    end
end

function t1.Freeze(p19) -- line: 95
    if p19.Frozen == true then
        warn("Attempt to freeze already frozen crosshair")
    else
        p19.Frozen = true
    end
end

function t1.UnFreeze(p20) -- line: 100
    if p20.Frozen == false then
        warn("Attempt to unfreeze already unfrozen crosshair")
    else
        p20.Frozen = false
    end
end

function t1.Enable(p21, p22) -- line: 105
    -- upvalues: TweenService (copy), PosTable_Func (copy)
    if p21.Enabled then
        return
    end

    p21.Enabled = true
    p21:Set(p22 or p21.Radius, true)

    local v8 = PosTable_Func(p21.Radius)

    for v9, _ in pairs(v8) do
        TweenService:Create(p21.MainFrame[v9], TweenInfo.new(0.25), {
            Transparency = 0
        }):Play()
        TweenService:Create(p21.MainFrame[v9].UIStroke, TweenInfo.new(0.25), {
            Transparency = 0.5
        }):Play()
    end

    TweenService:Create(p21.MainFrame.Center, TweenInfo.new(0.25), {
        Transparency = 0
    }):Play()
    TweenService:Create(p21.MainFrame.Center.UIStroke, TweenInfo.new(0.25), {
        Transparency = 0
    }):Play()
end

function t1.Disable(p23, p24) -- line: 120
    -- upvalues: TweenService (copy), PosTable_Func (copy)
    if p23.Enabled then
        p23:Set(0, true, nil, nil, 0.5)
        p23.Enabled = false

        local v10 = PosTable_Func(p23.Radius)

        for v11, _ in pairs(v10) do
            TweenService:Create(p23.MainFrame[v11], TweenInfo.new(0.25), {
                Transparency = 1
            }):Play()
            TweenService:Create(p23.MainFrame[v11].UIStroke, TweenInfo.new(0.25), {
                Transparency = 1
            }):Play()
        end

        if not p24 then
            TweenService:Create(p23.MainFrame.Center, TweenInfo.new(0.25), {
                Transparency = 1
            }):Play()
            TweenService:Create(p23.MainFrame.Center.UIStroke, TweenInfo.new(0.25), {
                Transparency = 1
            }):Play()
        end
    end
end

function t1.Destroy(p25) -- line: 137
    table.clear(p25)
end

return t1
