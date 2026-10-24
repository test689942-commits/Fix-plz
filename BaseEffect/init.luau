-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local EventMgr, DataMgr, PoolMgr, New = _G.EventMgr, _G.DataMgr, _G.PoolMgr, _G.New
local Sound = game:GetService("SoundService").Game.Sound
local t2 = {}
local t3 = {}
local t1 = {}

t1.particleList = nil

local t4 = {
    Texture = function(p1, p2) -- Texture | line: 12
        p1.Texture = p2
    end,
    MeshPart = function(p3, p4) -- MeshPart | line: 15
        p3.MeshId = p4
    end,
    Decal = function(p5, p6) -- Decal | line: 18
        p5.Texture = p6
    end,
    ImageLabel = function(p7, p8) -- ImageLabel | line: 21
        p7.Image = p8
    end,
    ImageButton = function(p9, p10) -- ImageButton | line: 24
        p9.Image = p10
    end,
    ImageHandleAdornment = function(p11, p12) -- ImageHandleAdornment | line: 27
        p11.Image = p12
    end
}

local function Emit(p13) -- line: 32
    -- upvalues: Sound (copy), t4 (copy)
    if p13:IsA("ParticleEmitter") then
        local EmitDelay = p13:GetAttribute("EmitDelay")

        if EmitDelay == 0 then
            p13:Emit(p13:GetAttribute("EmitCount") or 1)

            return p13.Lifetime.Max
        end

        task.delay(EmitDelay, function() -- line: 36
            -- upvalues: p13 (copy)
            p13:Emit(p13:GetAttribute("EmitCount") or 1)
        end)

        return EmitDelay + p13.Lifetime.Max
    end

    if p13:IsA("Sound") then
        p13.SoundGroup = Sound

        local EmitDelay = p13:GetAttribute("EmitDelay")

        if not EmitDelay or EmitDelay == 0 then
            p13.Play()

            return EmitDelay
        end

        task.delay(EmitDelay, function() -- line: 48
            -- upvalues: p13 (copy)
            p13:Play()
        end)

        return EmitDelay + p13.TimeLength
    end

    local v1 = t4[p13.ClassName]

    if v1 ~= nil then
        if (p13:IsA("ImageLabel") or p13:IsA("ImageButton")) and p13:GetAttribute("ifFlip") then
            local FlipSize = p13:GetAttribute("FlipSize")
            local FlipGrid = p13:GetAttribute("FlipGrid")
            local frameTime = p13:GetAttribute("frameTime")
            local delayTime = p13:GetAttribute("delayTime")
            local t5 = {}

            t5[1] = 0
            p13.ImageRectSize = FlipSize
            task.spawn(function() -- line: 71
                -- upvalues: p13 (copy), FlipSize (copy), FlipGrid (copy), frameTime (copy), delayTime (copy), t5 (copy)
                if delayTime > 0 then
                    task.wait(delayTime)
                end

                while t5[1] ~= FlipGrid.X * FlipGrid.Y do
                    p13.ImageRectOffset = Vector2.new(FlipSize.X * (t5[1] % 4), FlipSize.Y * math.floor(t5[1] / 4))
                    task.wait(frameTime)
                    t5[1] += 1
                end
            end)
        else
            local frame = p13:GetAttribute("frame")

            if frame ~= nil and frame ~= 0 then
                local frameTime = p13:GetAttribute("frameTime")

                task.spawn(function() -- line: 90
                    -- upvalues: p13 (copy), v1 (copy), frame (copy), frameTime (copy)
                    if p13:GetAttribute("delayTime") ~= 0 then
                        task.wait(p13:GetAttribute("delayTime"))
                    end

                    for i = 1, frame do
                        local Attribute = p13:GetAttribute("frame" .. i)

                        if Attribute ~= nil then
                            v1(p13, Attribute)
                        end

                        task.wait(frameTime)
                    end

                    if frame >= 1 then
                        v1(p13, p13:GetAttribute("frame1"))
                    end
                end)
            end
        end
    end
end

local function Enable(p14, p15) -- line: 108
    -- upvalues: Sound (copy), t4 (copy)
    if p14:IsA("ParticleEmitter") then
        p14.Enabled = p15

        return p14.Lifetime.Max
    end

    if p14:IsA("Beam") or p14:IsA("Light") then
        p14.Enabled = p15
    elseif p14:IsA("Sound") then
        p14.SoundGroup = Sound

        if p15 then
            p14:Play()
        else
            p14:Stop()
        end
    else
        local v4 = t4[p14.ClassName]

        if v4 ~= nil then
            local VFXEnable = p14:GetAttribute("VFXEnable")

            if VFXEnable ~= nil and VFXEnable ~= p15 then
                p14:SetAttribute("VFXEnable", p15)
            end

            if p15 ~= false then
                if (p14:IsA("ImageLabel") or p14:IsA("ImageButton")) and p14:GetAttribute("ifFlip") then
                    local FlipSize = p14:GetAttribute("FlipSize")
                    local FlipGrid = p14:GetAttribute("FlipGrid")
                    local frameTime = p14:GetAttribute("frameTime")
                    local delayTime = p14:GetAttribute("delayTime")
                    local n1 = 0

                    p14.ImageRectSize = FlipSize
                    task.spawn(function() -- line: 145
                        -- upvalues: p14 (copy), FlipSize (copy), FlipGrid (copy), frameTime (copy), delayTime (copy), n1 (ref)
                        local v5 = false

                        p14:GetAttributeChangedSignal("VFXEnable"):Once(function() -- line: 147
                            -- upvalues: v5 (ref)
                            v5 = true
                        end)

                        if delayTime > 0 then
                            task.wait(delayTime)
                        end

                        while not v5 and p14.Parent do
                            p14.ImageRectOffset = Vector2.new(FlipSize.X * (n1 % 4), FlipSize.Y * math.floor(n1 / 4))
                            task.wait(frameTime)
                            n1 += 1

                            if n1 == FlipGrid.X * FlipGrid.Y then
                                n1 = 0
                            end
                        end
                    end)
                else
                    local frame = p14:GetAttribute("frame")

                    if frame ~= nil then
                        local frameTime = p14:GetAttribute("frameTime")
                        local v9 = false

                        p14:GetAttributeChangedSignal("VFXEnable"):Once(function() -- line: 175
                            -- upvalues: v9 (ref)
                            v9 = true
                        end)

                        local n2 = 1

                        while not v9 do
                            local Attribute = p14:GetAttribute("frame" .. n2)

                            if Attribute == nil then
                                Attribute = ""
                                p14:SetAttribute("frame" .. n2, "")
                            end

                            v4(p14, Attribute)
                            n2 += 1

                            if frame < n2 then
                                n2 = 1
                            end

                            task.wait(frameTime)
                        end
                    end
                end
            end
        end
    end
end

function t1.new(_, p17, ...) -- line: 194
    -- upvalues: t1 (copy), t2 (copy)
    if typeof(p17) == "Instance" then
        return (setmetatable({
            obj = p17
        }, t1))
    end

    local v10 = t2[p17]

    if v10 == nil then
        local v11 = script:FindFirstChild(p17)

        v10 = if v11 == nil then {} else require(v11)
        setmetatable(v10, t1)
        v10.__index = v10
        v10.id = p17
        t2[p17] = v10
    end

    local self = setmetatable({}, v10)

    self:Show(...)

    return self
end

function t1.Show(p18, p19, p20) -- line: 222
    -- upvalues: DataMgr (copy), PoolMgr (copy), t3 (copy), Emit (copy)
    if p19 == nil then
        return
    end

    if not t3[p18.id] then
        local Asset = DataMgr:GetAsset("Effect/" .. p18.id)

        if Asset == nil then
            return
        end

        t3[p18.id] = Asset
    end

    local v14 = PoolMgr:Get("Effect_Skill" .. p18.id, t3[p18.id])

    v14.Parent = workspace.FX
    p18.effect = v14

    if typeof(p19) == "CFrame" then
        if v14:IsA("Model") then
            v14:PivotTo(p19)
        else
            v14.CFrame = p19
            v14.Anchored = true
        end
    elseif typeof(p19) == "Vector3" then
        if v14:IsA("Model") then
            v14:PivotTo(CFrame.new(p19))
        else
            v14.CFrame = CFrame.new(p19)
            v14.Anchored = true
        end
    elseif typeof(p19) == "Instance" then
        if v14:IsA("Model") then
            v14:PivotTo(p19.CFrame)
            v14.PrimaryPart.Anchored = false
            p18.weld = p18:Weld(p19, v14.PrimaryPart)
        else
            v14.CFrame = p19.CFrame
            v14.Anchored = false
            p18.weld = p18:Weld(p19, v14)
        end
    end

    if p20 == -1 then
        return p18
    end

    local n3 = 1.5

    for _, descendant in v14:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            n3 = math.max(Emit(descendant), n3)
        end
    end

    task.delay(n3, function() -- line: 272
        -- upvalues: p18 (copy), PoolMgr (copy)
        if p18.weld then
            p18.weld:Destroy()
        end

        PoolMgr:Push("Effect_" .. p18.id, p18.effect)
    end)
end

function t1.Hide(p21) -- line: 281
    -- upvalues: PoolMgr (copy)
    if p21.weld then
        p21.weld:Destroy()
    end

    PoolMgr:Push("Effect_Skill" .. p21.id, p21.effect)
end

function t1.Destroy(p22) -- line: 288
    p22:Hide()
end

function t1.Emit(_, p24) -- line: 292
    -- upvalues: Emit (copy)
    local VFXTime = p24:GetAttribute("VFXTime")

    if VFXTime then
        Emit(p24)

        for _, descendant in p24:GetDescendants() do
            Emit(descendant)
        end

        return VFXTime
    end

    local v16 = Emit(p24) or 0

    for _, descendant in p24:GetDescendants() do
        v16 = math.max(Emit(descendant) or 0, v16)
    end

    p24:SetAttribute("VFXTime", v16)

    return v16
end

function t1.SetEnabled(_, p26, p27) -- line: 310
    -- upvalues: Enable (copy)
    local VFXTime = p26:GetAttribute("VFXTime")

    if VFXTime then
        Enable(p26, p27)

        for _, descendant in p26:GetDescendants() do
            Enable(descendant, p27)
        end

        return VFXTime
    end

    local v18 = Enable(p26, p27) or 0

    for _, descendant in p26:GetDescendants() do
        v18 = math.max(Enable(descendant, p27) or 0, v18)
    end

    p26:SetAttribute("VFXTime", v18)

    return v18
end

function t1.Register(p28, p29, p30) -- line: 327
    if p29:IsA("ParticleEmitter") then
        table.insert(p30, p29)
    end

    for _, child in ipairs(p29:GetChildren()) do
        p28:Register(child, p30)
    end

    return p30
end

function t1.TrigerEvent(_, p32, ...) -- line: 337
    -- upvalues: EventMgr (copy)
    EventMgr:Triger(p32, ...)
end

function t1.Weld(_, p34, p35, p36, p37) -- line: 341
    -- upvalues: New (copy)
    return New("Utility.Weld")(p34, p35, p36, p37)
end

function t1.GetColorFromRay(_, p39) -- line: 345
    if p39.Instance ~= workspace.Terrain then
        return p39.Instance.Color
    end

    if p39.Material == Enum.Material.Water then
        return workspace.Terrain.WaterColor
    end

    return workspace.Terrain:GetMaterialColor(p39.Material)
end

return t1
