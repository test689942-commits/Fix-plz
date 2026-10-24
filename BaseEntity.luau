-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local RunService = game:GetService("RunService")

game:GetService("TweenService")

local PathfindingService = game:GetService("PathfindingService")
local _, _, New = _G.New, _G.GameMgr, _G.New

New("Utility.Tool")()

local v1 = RaycastParams.new()

v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = { workspace.Map }
t1.entityList = {}

local function InitBuff(p1) -- line: 17
    -- upvalues: RunService (copy), New (copy)
    p1.tempBuff = New("CS.List")("BaseBuff")()
    p1.trove:Add(RunService.Stepped:Connect(function(_, p3) -- line: 19
        -- upvalues: p1 (copy)
        if p1.tempBuff.count == 0 then
            return
        end

        for i = p1.tempBuff.count, 1, -1 do
            p1.tempBuff[i].time -= p3

            if p1.tempBuff[i].time <= 0 then
                p1:RemoveBuff(p1.tempBuff[i].id)
            end
        end
    end))
    p1.trove:Add(function() -- line: 31
        -- upvalues: p1 (copy)
        for _, v2 in p1.buff do
            v2:Destroy()
        end
    end)
end

function t1.new(p4, p5, ...) -- line: 38
    -- upvalues: t1 (copy), New (copy)
    t1.entityList[p5] = p4
    p4.Character = p5
    p4.eventMgr = New("Utility.EventMgr")()
    p4.atk = New("Attribute")(1, function(p6, _) -- line: 43
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("atk", p6)
    end)
    p4.maxHp = New("Attribute")(100, function(p8, p9) -- line: 46
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("maxHp", p8)

        if p4.Humanoid then
            p4.Humanoid.MaxHealth = p8
            p4.Humanoid.Health = p4.Humanoid.Health * p8 / p9
        end

        p4.hp = p4.hp * p8 / p9
        p4.OnAttributeChange:Invoke("hp", p4.hp)
    end)
    p4.def = New("Attribute")(1, function(p10, _) -- line: 56
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("def", p10)
    end)
    p4.physics_resistance = New("Attribute")(0, function(p12, _) -- line: 59
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("physics_resistance", p12)
    end):SetLimit(-100, 75):SetRatio(100)
    p4.magic_resistance = New("Attribute")(0, function(p14, _) -- line: 62
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("magic_resistance", p14)
    end):SetLimit(-100, 75):SetRatio(100)
    p4.life_recovery_per = New("Attribute")(100, function(p16, _) -- line: 66
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("life_recovery_per", p16)
    end):SetRatio(100)
    p4.speed = New("Attribute")(16, function(p18, _) -- line: 70
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("speed", p18)
    end)
    p4.atkSpeed = New("Attribute")(100, function(p20, _) -- line: 74
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("atkSpeed", p20)
    end):SetRatio(100)
    p4.atk_per = New("Attribute")(100, function(p22, _) -- line: 78
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("atk_per", p22)
    end):SetRatio(100)
    p4.ex_physics = New("State")(0, function(p24, _) -- line: 82
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("ex_physics", p24)
    end)
    p4.ex_magic = New("State")(0, function(p26, _) -- line: 85
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("ex_magic", p26)
    end)
    p4.ex_physics_per = New("State")(0, function(p28, _) -- line: 89
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("ex_physics_per", p28)
    end):SetRatio(100)
    p4.ex_magic_per = New("State")(0, function(p30, _) -- line: 93
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("ex_magic_per", p30)
    end):SetRatio(100)
    p4.add_physics_per = New("State")(0, function(p32, _) -- line: 97
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("add_physics_per", p32)
    end):SetRatio(100)
    p4.add_magic_per = New("State")(0, function(p34, _) -- line: 101
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("add_magic_per", p34)
    end):SetRatio(100)
    p4.crit = New("State")(0, function(p36, _) -- line: 105
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("crit", p36)
    end):SetRatio(100)
    p4.crit_damage = New("State")(0, function(p38, _) -- line: 109
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("crit_damage", p38)
    end):SetRatio(100)
    p4.atk_vulnerable = New("Attribute")(100, function(p40, _) -- line: 113
        -- upvalues: p4 (copy)
        p4.OnAttributeChange:Invoke("atk_vulnerable", p40)
    end):SetRatio(100)
    p4.hp = p4.maxHp.current
    p4.invincible = 0
    p4.State = {}
    p4.buff = New("CS.Dictionary")("string", "BaseBuff")()
    p4.buff_limit = {}
    p4.OnAttributeChange = New("CS.Action")()
    p4.OnDestroy = New("CS.Action")()
    p4.trove = New("Utility.Trove")()
    p4.trove:Add(function() -- line: 128
        -- upvalues: p5 (copy), t1 (copy)
        t1.entityList[p5] = nil
    end)
    p4.OnDestroy:Add(function() -- line: 131
        -- upvalues: p4 (copy)
        p4.trove:Clean()
    end)
    p4:AddEvent("Atk", function(p42, p43) -- line: 135
        p43({
            def = p42.def(),
            physics_resistance = p42.physics_resistance(),
            magic_resistance = p42.magic_resistance(),
            atk_vulnerable = p42.atk_vulnerable()
        })
    end, 1)
    p4:AddEvent("Atk", function(p44, p45) -- line: 144
        -- upvalues: p4 (copy)
        p44:Hurt(p4, p45)
    end, 10)
    p4:AddEvent("Hurt", function(_, p47) -- line: 148
        -- upvalues: p4 (copy)
        if p47.isHurt == false then
            return
        end

        p47.isCrit = math.random() < p47.crit

        local Value = p47:GetValue()

        if p4.Humanoid and p4.Humanoid.Health > 1 then
            p4.Humanoid:TakeDamage(p4.Humanoid.Health - math.max(p4.Humanoid.Health - Value, 1))
        end

        p4.hp = math.max(p4.hp - Value, 0)

        if Value / p4.maxHp > 0.01 then
            p47.isDizziness = math.random() < (1 + p47.dizziness_probability) * Value / p4.maxHp
        else
            p47.isDizziness = false
        end

        p4.OnAttributeChange:Invoke("hp", p4.hp)
    end, 10)
    p4:AddEvent("Hurt", function(p48, p49) -- line: 162
        -- upvalues: p4 (copy)
        if p4.hp <= 0 then
            p4:Die(p48, p49)

            if p4.isDie and p48 then
                p48:Kill(p4, p49)
            end
        end
    end, 15)
    p4:AddEvent("Die", function(p50, _) -- line: 171
        -- upvalues: p4 (copy)
        if not (p4.hp > 0) then
            p4.isDie = true
            p4.OnDestroy:Invoke(p50)
        end
    end, 10)
    p4:AddEvent("AddBuff", function(p52) -- line: 179
        -- upvalues: p4 (copy), New (copy)
        local v5 = p4.buff[p52.id]

        if v5 then
            v5.own = p52.own

            if p52.t == nil and v5.time then
                p4.tempBuff:Remove(v5)
            end

            if v5.amount and p52.amount then
                local v6 = v5.config.max_stack + (p4.buff_limit[p52.id] or 0)

                if v5.amount < v6 then
                    p52.amount = math.clamp(p52.amount, 0, v6 - v5.amount)
                    v5.amount += p52.amount
                else
                    p52.amount = 0
                end
            end

            v5.time = p52.t
            v5:Add(p52.amount, p52.data)
        else
            local v8 = New("BaseBuff")(p52.id, p4, p52.own or p4)

            p4.buff[p52.id] = v8

            if p52.amount and v8.config then
                p52.amount = math.clamp(p52.amount, 0, v8.config.max_stack + (p4.buff_limit[p52.id] or 0))
            end

            v8.amount = p52.amount
            v8.time = p52.t

            if p52.t then
                p4.tempBuff:Add(v8)
            end

            v8:Init(p52.data)
            v8:Add(p52.amount, p52.data)
        end
    end, 10)
end

function t1.UpdateData(p53, p54) -- line: 215
    p53.data = p54
end

function t1.AddBuff(p55, p56, p57, p58, p59, p60) -- line: 219
    -- upvalues: InitBuff (copy)
    if not p55.initBuff then
        InitBuff(p55)
        p55.initBuff = true
    end

    p55:TrigerEvent("AddBuff", {
        id = p56,
        data = p57,
        own = p58,
        t = p59,
        amount = p60 and math.ceil(p60)
    })

    if p58 then
        p58:TrigerEvent("ToAddBuff", p55, p56, p57, p58, p59, p60)
    end
end

function t1.RemoveBuff(p61, p62, p63) -- line: 232
    local v10 = p61.buff[p62]

    if v10 then
        if p63 and p63 < v10.amount then
            local v11 = math.ceil(p63)

            v10.amount -= v11
            v10:Remove(v11)
            p61:TrigerEvent("RemoveBuff", p62, v11)
        else
            if v10.time then
                p61.tempBuff:Remove(v10)
            end

            p61.buff[p62] = nil

            local amount = p63

            if v10.amount then
                amount = v10.amount
                v10.amount = 0
            end

            v10:Remove(amount)
            v10:Destroy()
            p61:TrigerEvent("RemoveBuff", p62, amount)
        end
    end
end

function t1.GetBuff(p64, p65) -- line: 256
    return p64.buff[p65]
end

function t1.ChangeBuffLimit(p66, p67, p68) -- line: 260
    local v12 = math.floor(p68)

    if p66.buff_limit[p67] then
        p66.buff_limit[p67] += v12
    else
        p66.buff_limit[p67] = v12
    end

    p66:TrigerEvent("ChangeBuffLimit", p67, v12)
end

function t1.GetBuffLimit(p69, p70) -- line: 270
    return p69.buff_limit[p70] or 0
end

function t1.SetState(p71, p72, p73) -- line: 274
    if p73 then
        if p71.State[p72] then
            if p71.State[p72] == 0 then
                p71:TrigerEvent("StateChange", p72, true)
            end

            p71.State[p72] += 1
        else
            p71:TrigerEvent("StateChange", p72, true)
            p71.State[p72] = 1
        end
    elseif p71.State[p72] and p71.State[p72] > 0 then
        p71.State[p72] -= 1

        if p71.State[p72] == 0 then
            p71:TrigerEvent("StateChange", p72, false)
        end
    end
end

function t1.ChackState(p74, p75) -- line: 298
    return p74.State[p75] and p74.State[p75] ~= 0
end

function t1.AddEvent(p76, p77, p78, p79) -- line: 302
    return p76.eventMgr:AddEvent(p77, p78, p79)
end

function t1.RemoveEvent(p80, p81, p82) -- line: 306
    p80.eventMgr:RemoveEvent(p81, p82)
end

function t1.TrigerEvent(p83, p84, ...) -- line: 310
    p83.eventMgr:Triger(p84, ...)
end

function t1.Atk(p85, p86, p87, ...) -- line: 314
    p85:TrigerEvent("Atk", p86, p87, ...)
end

function t1.Hurt(p88, p89, p90) -- line: 319
    if not p88.isDie and not p88.isFall and p88.invincible == 0 then
        p88:TrigerEvent("Hurt", p89, p90)
    else
        p90.isHurt = false
    end
end

function t1.Cure(p91, p92) -- line: 327
    if p91.isDie or p92 <= 0 or p91.hp == p91.maxHp then
        return
    end

    p91.hp = math.clamp(p91.hp + p92 * p91.life_recovery_per, 0, p91.maxHp())

    if p91.Humanoid then
        p91.Humanoid.Health = p91.hp
    end

    p91.OnAttributeChange:Invoke("hp", p91.hp)
end

function t1.ConsumeHp(p93, p94) -- line: 338
    if p93.isDie or p94 <= 0 then
        return
    end

    local v15 = p93.hp - math.clamp(p93.hp - p94, 1, p93.maxHp())

    if v15 < 1 then
        return
    end

    p93.hp -= v15

    if p93.Humanoid then
        p93.Humanoid.Health = p93.hp
    end

    p93.OnAttributeChange:Invoke("hp", p93.hp)

    return v15
end

function t1.AddVelocity(p95, p96) -- line: 354
    for _, child in p95.Character:GetChildren() do
        if child:IsA("BasePart") then
            child.AssemblyLinearVelocity = p96
        end
    end
end

function t1.Die(p97, p98, p99) -- line: 363
    if not p97.isDie then
        p97:TrigerEvent("Die", p98, p99)
    end
end

function t1.Kill(p100, p101, p102) -- line: 370
    p100:TrigerEvent("Kill", p101, p102)
end

function t1.Destroy(p103) -- line: 374
    p103.trove:Clean()
    p103.Character:Destroy()
end

function t1.AddPower(p104, p105, p106) -- line: 379
    local BodyVelocity = Instance.new("BodyVelocity")

    BodyVelocity.MaxForce = Vector3.new(1E+05, 0, 1E+05)
    BodyVelocity.Velocity = p105
    BodyVelocity.Parent = p104.HumanoidRootPart
    task.delay(p106, function() -- line: 384
        -- upvalues: BodyVelocity (copy)
        BodyVelocity:Destroy()
    end)
end

function t1.AlignPosition(p107, p108, p109, p110) -- line: 389
    -- upvalues: v1 (copy)
    if p107.alignPosition == nil then
        p107.alignPosition = Instance.new("AlignPosition")
        p107.alignPosition.Parent = Instance.new("Attachment", p107.Character.PrimaryPart)
        p107.alignPosition.Attachment0 = p107.alignPosition.Parent
        p107.alignPosition.Mode = Enum.PositionAlignmentMode.OneAttachment
        p107.alignPosition.RigidityEnabled = true
        p107.alignPosition.MaxForce = 1E+05
        p107.alignPosition.Responsiveness = 20
    end

    local v16 = workspace:Raycast(p107.HumanoidRootPart.CFrame.Position, p108.Position - p107.HumanoidRootPart.CFrame.Position, v1)
    local v17

    if v16 then
        if (v16.Position - p107.HumanoidRootPart.CFrame.Position).Magnitude < 2 then
            return
        end

        v17 = CFrame.new(v16.Position)
    else
        v17 = p108
    end

    p107.alignPosition.Position = v17.Position
    p107.alignPosition.MaxVelocity = p109 or 36
    p107.alignPosition.Enabled = true
    p107.alignPositionTick = tick() + (p110 or 0.1)

    if p107.alignPositionCon == nil then
        p107.alignPositionCon = task.spawn(function() -- line: 413
            -- upvalues: p107 (copy)
            while true do
                if p107.alignPosition.Parent then
                    task.wait(0.1)

                    if tick() > p107.alignPositionTick then
                        break
                    end

                    continue
                end

                return
            end

            p107.alignPositionCon = nil
            p107.alignPosition.Enabled = false
        end)
    end
end

function t1.AlignOrientation(p111, p112, p113) -- line: 426
    -- upvalues: RunService (copy)
    if p111.alignOrientation == nil then
        p111.alignOrientation = Instance.new("AlignOrientation")
        p111.alignOrientation.Parent = Instance.new("Attachment", p111.Character.PrimaryPart)
        p111.alignOrientation.Attachment0 = p111.alignOrientation.Parent
        p111.alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
        p111.alignOrientation.RigidityEnabled = true
        p111.alignOrientation.MaxAngularVelocity = 1000
        p111.alignOrientation.MaxTorque = 1e999
        p111.alignOrientation.Responsiveness = 40
    end

    if typeof(p112) == "CFrame" then
        p111.alignOrientation.CFrame = p112
        p111.alignOrientationTarget = nil
    else
        p111.alignOrientationTarget = p112

        local CFramePosition = p111.Character.PrimaryPart.CFrame.Position
        local CFramePosition2 = p111.alignOrientationTarget.CFrame.Position

        p111.alignOrientation.CFrame = CFrame.lookAt(Vector3.new(CFramePosition.X, 0, CFramePosition.Z), (Vector3.new(CFramePosition2.X, 0, CFramePosition2.Z)))
    end

    p111.alignOrientation.Enabled = true
    p111.alignOrientationTick = tick() + (p113 or 0.3)

    if p111.alignOrientationCon == nil then
        p111.alignOrientationCon = RunService.Stepped:Connect(function() -- line: 449
            -- upvalues: p111 (copy)
            if p111.alignOrientation.Parent == nil or tick() > p111.alignOrientationTick then
                p111.alignOrientationCon:Disconnect()
                p111.alignOrientationCon = nil

                if p111.alignOrientation.Parent then
                    p111.alignOrientation.Enabled = false
                end
            elseif p111.alignOrientationTarget then
                if p111.alignOrientationTarget.Parent ~= nil then
                    local CFramePosition = p111.Character.PrimaryPart.CFrame.Position
                    local CFramePosition2 = p111.alignOrientationTarget.CFrame.Position

                    p111.alignOrientation.CFrame = CFrame.lookAt(Vector3.new(CFramePosition.X, 0, CFramePosition.Z), (Vector3.new(CFramePosition2.X, 0, CFramePosition2.Z)))
                else
                    p111.alignOrientationCon:Disconnect()
                    p111.alignOrientationCon = nil

                    if p111.alignOrientation.Parent then
                        p111.alignOrientation.Enabled = false
                    end
                end
            end
        end)
    end
end

local t3 = {
    { 9999, 2 },
    { 40, 1 },
    { 15, 0.5 },
    { 8, 0.25 }
}

function t1.Capture(p114, p115) -- line: 482
    -- upvalues: t3 (copy)
    local t4 = {
        part = p115
    }

    task.spawn(function() -- line: 486
        -- upvalues: p114 (copy), t4 (copy), t3 (copy)
        p114:StartMove(t4.part.CFrame.Position)

        while true do
            if t4.isDestroy then
                return
            end

            if t4.part == nil or t4.part.Parent == nil then
                break
            end

            if t4.stop then
                task.wait(0.3)
            else
                p114:StartMove(t4.part.CFrame.Position)

                local Magnitude = (p114.HumanoidRootPart.CFrame.Position - t4.part.CFrame.Position).Magnitude
                local n1 = 3

                for _, v20 in t3 do
                    if v20[1] <= Magnitude then
                        break
                    end

                    n1 = v20[2]
                end

                task.wait(n1)
            end
        end

        p114:TrigerEvent("FinishMove")
    end)

    t4.Destroy = function() -- line: 510
        -- upvalues: p114 (copy), t4 (copy)
        t4.isDestroy = true
        p114:StartMove()
    end

    t4.Stop = function(_, p117) -- line: 515
        -- upvalues: p114 (copy), t4 (copy)
        t4.stop = p117

        if p117 then
            p114:StartMove()
        end
    end

    return t4
end

local t5 = {
    [Enum.HumanoidStateType.Seated] = true,
    [Enum.HumanoidStateType.None] = true,
    [Enum.HumanoidStateType.Running] = true,
    [Enum.HumanoidStateType.Climbing] = true,
    [Enum.HumanoidStateType.Swimming] = true
}

function t1.StartMove(p118, p119, p120) -- line: 533
    -- upvalues: RunService (copy), PathfindingService (copy), v1 (copy), t5 (copy)
    if p119 ~= nil then
        if p118.path == nil then
            local BoundingBox, BoundingBox2 = p118.Character:GetBoundingBox()

            p118.cf = BoundingBox
            p118.size = BoundingBox2
            p118.path = PathfindingService:CreatePath(p120 or {
                AgentRadius = 2,
                AgentCanJump = true,
                AgentHeight = p118.size.Y * p118.Character:GetScale()
            })
        end

        local v22 = workspace:Raycast(p118.HumanoidRootPart.CFrame.Position, p119 - p118.HumanoidRootPart.CFrame.Position, v1)

        p118.pathPos = {
            {
                Position = p118.HumanoidRootPart.Position
            },
            {
                Position = p119
            },
            {
                Position = p119
            }
        }

        if v22 and v22.Instance then
            p118.path:ComputeAsync(p118.HumanoidRootPart.CFrame.Position, p119)

            if p118.path.Status == Enum.PathStatus.Success then
                p118.pathPos = p118.path:GetWaypoints()
            else
                p118.pathPos = {
                    {
                        Position = p118.HumanoidRootPart.Position
                    },
                    {
                        Position = p119
                    },
                    {
                        Position = p119
                    }
                }
            end

            if p118.findPath then
                p118.findPath(p118.path.Status)
            end

            p118.pathIndex = #p118.pathPos > 3 and 3 or 2

            if p118.pathCon then
                p118.pathCon:Disconnect()
                p118.pathCon = nil
            end

            if p118.pathIndex >= #p118.pathPos then
                p118.Character.Humanoid:Move((Vector3.new(0, 0, 0)))
            else
                local _ = p118.HumanoidRootPart.CFrame.LookVector

                p118.jumpTime = math.max((p118.HumanoidRootPart.CFrame.Position - p118.pathPos[p118.pathIndex].Position).Magnitude / p118.Humanoid.WalkSpeed * 2, 0.5)
                p118.pathCon = RunService.Stepped:Connect(function(_, p122) -- line: 609
                    -- upvalues: p118 (copy), t5 (copy)
                    if p118.Character.Parent == nil or p118.pathPos[p118.pathIndex] == nil or p118.pathIndex >= #p118.pathPos then
                        p118.pathCon:Disconnect()
                        p118.pathCon = nil

                        return
                    end

                    local v25 = p118.pathPos[p118.pathIndex].Position + Vector3.new(0, p118.size.Y / 2 - 0.5, 0) - p118.HumanoidRootPart.Position

                    p118.jumpTime -= p122

                    while v25.Magnitude < 2 or p118.jumpTime <= 0 do
                        if p118.jumpTime <= 0 and t5[p118.Humanoid:GetState()] and p118.Humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
                            p118.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end

                        p118.jumpTime = math.max((p118.HumanoidRootPart.CFrame.Position - p118.pathPos[p118.pathIndex].Position).Magnitude / p118.Humanoid.WalkSpeed * 2, 0.5)
                        p118.pathIndex += 1

                        if not (p118.pathIndex >= #p118.pathPos) then
                            v25 = p118.pathPos[p118.pathIndex].Position + Vector3.new(0, p118.size.Y / 2 - 0.5, 0) - p118.HumanoidRootPart.Position
                            continue
                        end

                        p118.pathCon:Disconnect()
                        p118.pathCon = nil
                        p118.pathEnd = p118.pathEnd and p118.pathEnd + 1 or 1
                        p118.Character.Humanoid:Move((Vector3.new(0, 0, 0)))

                        return
                    end

                    p118.Character.Humanoid:Move(v25.Unit)
                end)
            end
        elseif p118.range and (p119 - p118.HumanoidRootPart.Position).Magnitude < p118.range() then
            if p118.pathCon then
                p118.pathCon:Disconnect()
                p118.pathCon = nil
                p118.Character.Humanoid:Move((Vector3.new(0, 0, 0)))
            end

            p118:TrigerEvent("FinishMove")
        else
            p118.pathPos = {
                {
                    Position = p118.HumanoidRootPart.Position
                },
                {
                    Position = p119
                },
                {
                    Position = p119
                }
            }

            if p118.findPath then
                p118.findPath(Enum.PathStatus.Success)
            end

            p118.pathIndex = #p118.pathPos > 3 and 3 or 2

            if p118.pathCon then
                p118.pathCon:Disconnect()
                p118.pathCon = nil
            end

            if p118.pathIndex >= #p118.pathPos then
                p118.Character.Humanoid:Move((Vector3.new(0, 0, 0)))
            else
                local _ = p118.HumanoidRootPart.CFrame.LookVector

                p118.jumpTime = math.max((p118.HumanoidRootPart.CFrame.Position - p118.pathPos[p118.pathIndex].Position).Magnitude / p118.Humanoid.WalkSpeed * 2, 0.5)
                p118.pathCon = RunService.Stepped:Connect(function(_, p124) -- line: 609
                    -- upvalues: p118 (copy), t5 (copy)
                    if p118.Character.Parent == nil or p118.pathPos[p118.pathIndex] == nil or p118.pathIndex >= #p118.pathPos then
                        p118.pathCon:Disconnect()
                        p118.pathCon = nil

                        return
                    end

                    local v30 = p118.pathPos[p118.pathIndex].Position + Vector3.new(0, p118.size.Y / 2 - 0.5, 0) - p118.HumanoidRootPart.Position

                    p118.jumpTime -= p124

                    while v30.Magnitude < 2 or p118.jumpTime <= 0 do
                        if p118.jumpTime <= 0 and t5[p118.Humanoid:GetState()] and p118.Humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping) then
                            p118.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end

                        p118.jumpTime = math.max((p118.HumanoidRootPart.CFrame.Position - p118.pathPos[p118.pathIndex].Position).Magnitude / p118.Humanoid.WalkSpeed * 2, 0.5)
                        p118.pathIndex += 1

                        if not (p118.pathIndex >= #p118.pathPos) then
                            v30 = p118.pathPos[p118.pathIndex].Position + Vector3.new(0, p118.size.Y / 2 - 0.5, 0) - p118.HumanoidRootPart.Position
                            continue
                        end

                        p118.pathCon:Disconnect()
                        p118.pathCon = nil
                        p118.pathEnd = p118.pathEnd and p118.pathEnd + 1 or 1
                        p118.Character.Humanoid:Move((Vector3.new(0, 0, 0)))

                        return
                    end

                    p118.Character.Humanoid:Move(v30.Unit)
                end)
            end
        end
    elseif p118.pathCon then
        p118.pathCon:Disconnect()
        p118.pathCon = nil
        p118.Character.Humanoid:Move((Vector3.new(0, 0, 0)))
    end
end

return t1
