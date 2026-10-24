-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local _, DataMgr, New = _G.PoolMgr, _G.DataMgr, _G.New
local t2 = {}

t2.box = function(p1, p2, p3, p4) -- line: 9
    -- upvalues: TweenService (copy)
    p4.box.Size = Vector3.new(0, 0.001, 0)
    p4.box.CFrame = p4:GetPivot()
    TweenService:Create(p4.box, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {
        Size = Vector3.new(tonumber(p3.state.size) * 1.1, 0.001, p2:GetAttribute("Range")),
        CFrame = p4:GetPivot() * CFrame.new(0, 0, -p2:GetAttribute("Range") / 2)
    }):Play()
    p1.trove:Add(p2:GetAttributeChangedSignal("Target"):Connect(function() -- line: 18
        -- upvalues: p2 (copy), p4 (copy)
        p2:GetAttribute("Target")
        p4:PivotTo(CFrame.lookAlong(p4:GetPivot().Position, p2.PrimaryPart.CFrame.LookVector))
    end))
    p1.trove:Add(p2:GetAttributeChangedSignal("Range"):Connect(function() -- line: 23
        -- upvalues: p2 (copy), p3 (copy), p4 (copy), TweenService (copy)
        TweenService:Create(p4.box, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {
            Size = Vector3.new(tonumber(p3.state.size) * 1.1, 0.001, p2:GetAttribute("Range")),
            CFrame = p4:GetPivot() * CFrame.new(0, 0, -p2:GetAttribute("Range") / 2)
        }):Play()
    end))
end

t2.circle = function(p5, p6, p7, p8) -- line: 31
    -- upvalues: TweenService (copy), RunService (copy)
    p8.pos.Size = Vector3.new(0, 0, 0)
    TweenService:Create(p8.pos, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {
        Size = Vector3.new(tonumber(p7.state.size) * 1.1, 0.001, tonumber(p7.state.size) * 1.1)
    }):Play()

    local Target = p6:GetAttribute("Target")

    if Target then
        p8.pos.CFrame = CFrame.lookAlong(Target, p8.pos.CFrame.LookVector)
    else
        p8.pos.CFrame = CFrame.lookAlong(p8:GetPivot().Position, p8.pos.CFrame.LookVector)
    end

    p5.trove:Add(p6:GetAttributeChangedSignal("Target"):Connect(function() -- line: 41
        -- upvalues: p6 (copy), p8 (copy)
        local Target = p6:GetAttribute("Target")

        p8.pos.CFrame = CFrame.lookAlong(Target, p8.pos.CFrame.LookVector)
    end))
    p5.trove:Add(RunService.RenderStepped:Connect(function(p9) -- line: 45
        -- upvalues: p8 (copy)
        p8.pos.CFrame *= CFrame.Angles(0, 2 * p9, 0)
    end))
end

t2.sector = function(p10, p11, p12, p13) -- line: 53
    -- upvalues: TweenService (copy)
    local v8 = tonumber(p12.state.size)
    local Range = p11:GetAttribute("Range")
    local Range2 = Range

    p13.sector.B1.Width0 = 0
    p13.sector.B1.Width1 = 0
    TweenService:Create(p13.sector.B1, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {
        Width1 = Range / 5 * 7 / 90 * v8,
        Width0 = Range / 5 * 7 / 90 * v8
    }):Play()
    p13.sector.TargetPath.CFrame = CFrame.new(0, 0, -Range) * CFrame.Angles(0, 0, -1.5707963267948966)
    p10.trove:Add(p11:GetAttributeChangedSignal("Target"):Connect(function() -- line: 60
        -- upvalues: p11 (copy), p13 (copy)
        p11:GetAttribute("Target")
        p13:PivotTo(CFrame.lookAlong(p13:GetPivot().Position, p11.PrimaryPart.CFrame.LookVector))
    end))
    p10.trove:Add(p11:GetAttributeChangedSignal("Range"):Connect(function() -- line: 64
        -- upvalues: p11 (copy), p13 (copy), v8 (copy), Range2 (ref), TweenService (copy)
        Range2 = p11:GetAttribute("Range")
        TweenService:Create(p13.sector.B1, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {
            Width1 = Range2 / 5 * 7 / 90 * v8,
            Width0 = Range2 / 5 * 7 / 90 * v8
        }):Play()
        TweenService:Create(p13.sector.TargetPath, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {
            CFrame = CFrame.new(0, 0, -Range2) * CFrame.Angles(0, 0, -1.5707963267948966)
        }):Play()
    end))
end

t2.UnitRange = function(p14, p15, p16) -- line: 71
    -- upvalues: TweenService (copy), RunService (copy)
    local Range = p15:GetAttribute("Range")
    local Range2 = Range

    p16.PrimaryPart.Size = Vector3.new(0, 0, 0)
    TweenService:Create(p16.PrimaryPart, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {
        Size = Vector3.new(Range * 2, 0.01, Range * 2)
    }):Play()
    p14.trove:Add(p15:GetAttributeChangedSignal("Range"):Connect(function() -- line: 75
        -- upvalues: p15 (copy), p16 (copy), Range2 (ref), TweenService (copy)
        Range2 = p15:GetAttribute("Range")
        TweenService:Create(p16.PrimaryPart, TweenInfo.new(0.3, Enum.EasingStyle.Elastic), {
            Size = Vector3.new(Range2 * 2, 0.01, Range2 * 2)
        }):Play()
    end))
    p14.trove:Add(RunService.RenderStepped:Connect(function(p17) -- line: 79
        -- upvalues: p16 (copy)
        p16:PivotTo(p16:GetPivot() * CFrame.Angles(0, 1 * p17, 0))
    end))
end

function t1.Show(p18, p19, p20) -- line: 84
    -- upvalues: DataMgr (copy), New (copy), t2 (copy)
    p18.trove = New("Utility.Trove")()

    local ClickBox = p19:FindFirstChild("ClickBox")
    local BoundingBox, BoundingBox2

    if ClickBox then
        BoundingBox = ClickBox.CFrame
        BoundingBox2 = ClickBox.Size
    else
        BoundingBox, BoundingBox2 = p19:GetBoundingBox()
    end

    local clone = script.UnitRange:Clone()

    clone.Parent = workspace.FX
    clone:PivotTo(BoundingBox * CFrame.new(0, -BoundingBox2.Y / 2 * 0.95, 0))
    t2.UnitRange(p18, p19, clone)
    p18.trove:Add(clone)

    local Config2 = DataMgr:GetConfig("SkillData", DataMgr:GetConfig("TowerData", p20.id).skill)
    local rangeType = Config2.state.rangeType

    if Config2 == nil then
        return
    end

    local clone2 = script:FindFirstChild(rangeType):Clone()

    clone2.Parent = workspace.FX
    clone2:PivotTo(BoundingBox * CFrame.new(0, -BoundingBox2.Y / 2, 0))
    t2[rangeType](p18, p19, Config2, clone2)
    p18.trove:Add(clone2)
end

function t1.SetSize(_, _) -- line: 114
end

function t1.Hide(p23) -- line: 118
    p23.trove:Clean()
end

return t1
