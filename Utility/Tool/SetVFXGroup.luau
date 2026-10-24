-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local t2 = {
    Texture = function(p1, p2) -- Texture | line: 5
        p1.Texture = p2
    end,
    MeshPart = function(p3, p4) -- MeshPart | line: 8
        p3.MeshId = p4
    end,
    Decal = function(p5, p6) -- Decal | line: 11
        p5.Texture = p6
    end,
    ImageLabel = function(p7, p8) -- ImageLabel | line: 14
        p7.Image = p8
    end,
    ImageButton = function(p9, p10) -- ImageButton | line: 17
        p9.Image = p10
    end,
    ImageHandleAdornment = function(p11, p12) -- ImageHandleAdornment | line: 20
        p11.Image = p12
    end
}

local function Emit(p13) -- line: 25
    -- upvalues: t2 (copy)
    if p13:IsA("ParticleEmitter") then
        local EmitCount = p13:GetAttribute("EmitCount")

        if EmitCount ~= nil then
            local v1 = p13:GetAttribute("EmitDelay") or 0

            if v1 == 0 then
                p13:Emit(EmitCount)
            else
                task.delay(v1, function() -- line: 33
                    -- upvalues: p13 (copy), EmitCount (copy)
                    p13:Emit(EmitCount)
                end)
            end
        end
    else
        local v2 = t2[p13.ClassName]

        if v2 then
            local frame = p13:GetAttribute("frame")

            if frame == nil then
                return
            end

            local frameTime = p13:GetAttribute("frameTime")
            local v3 = p13:GetAttribute("delayTime") or 0

            task.spawn(function() -- line: 48
                -- upvalues: p13 (copy), v2 (copy), frame (copy), frameTime (copy), v3 (copy)
                if v3 ~= 0 then
                    task.wait(v3)
                end

                for i = 1, frame do
                    local Attribute = p13:GetAttribute("frame" .. i)

                    if Attribute == nil then
                        Attribute = ""
                        p13:SetAttribute("frame" .. i, "")
                    end

                    v2(p13, Attribute)
                    task.wait(frameTime)
                end

                if frame >= 1 then
                    v2(p13, p13:GetAttribute("frame1"))
                end
            end)
        end
    end
end

local function Enable(p14, p15) -- line: 69
    -- upvalues: t2 (copy)
    if p14:IsA("ParticleEmitter") or p14:IsA("Beam") then
        p14.Enabled = p15
    else
        local v4 = t2[p14.ClassName]

        if v4 ~= nil then
            if p14:GetAttribute("VFXEnable") ~= p15 then
                p14:SetAttribute("VFXEnable", p15)
            end

            if p15 ~= false then
                local frame = p14:GetAttribute("frame")

                if frame ~= nil then
                    local frameTime = p14:GetAttribute("frameTime")
                    local _ = p14:GetAttribute("delayTime") or 0
                    local n1 = 1
                    local v5 = false

                    p14:GetAttributeChangedSignal("VFXEnable"):Once(function() -- line: 94
                        -- upvalues: v5 (ref)
                        v5 = true
                    end)
                    task.spawn(function() -- line: 97
                        -- upvalues: p14 (copy), v4 (copy), frame (copy), frameTime (copy), n1 (ref), v5 (ref)
                        local t3 = {}

                        for i = 1, frame do
                            local Attribute = p14:GetAttribute("frame" .. i)

                            if Attribute == nil then
                                Attribute = ""
                                p14:SetAttribute("frame" .. i, "")
                            end

                            table.insert(t3, Attribute)
                        end

                        while not v5 do
                            v4(p14, t3[n1])
                            n1 += 1

                            if n1 > frame then
                                n1 = 1
                            end

                            task.wait(frameTime)
                        end
                    end)
                end
            end
        end
    end
end

return function(p16) -- line: 119
    -- upvalues: t1 (copy), t2 (copy), Emit (copy), Enable (copy)
    if p16:IsA("BoolValue") then
        if p16.Name == "VFXEmit" then
            t1[p16] = true
            p16:GetPropertyChangedSignal("Value"):Connect(function() -- line: 125
                -- upvalues: p16 (copy), Emit (copy)
                Emit(p16.Parent)

                for _, descendant in p16.Parent:GetDescendants() do
                    Emit(descendant)
                end
            end)
            p16.AncestryChanged:Connect(function() -- line: 131
                -- upvalues: p16 (copy), t1 (copy)
                t1[p16] = nil
            end)
        elseif p16.Name == "VFXEnable" then
            t1[p16] = true
            p16:GetPropertyChangedSignal("Value"):Connect(function() -- line: 136
                -- upvalues: p16 (copy), Enable (copy)
                Enable(p16.Parent, p16.Value)

                for _, descendant in p16.Parent:GetDescendants() do
                    Enable(descendant, p16.Value)
                end
            end)
            p16.AncestryChanged:Connect(function() -- line: 142
                -- upvalues: p16 (copy), t1 (copy), t2 (copy)
                t1[p16] = nil

                if p16.Value then
                    local Parent = p16.Parent

                    if Parent:IsA("ParticleEmitter") or Parent:IsA("Beam") then
                        Parent.Enabled = false
                    elseif t2[Parent.ClassName] ~= nil and Parent:GetAttribute("VFXEnable") ~= false then
                        Parent:SetAttribute("VFXEnable", false)
                    end

                    for _, descendant in p16.Parent:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                            descendant.Enabled = false
                        elseif t2[descendant.ClassName] ~= nil and descendant:GetAttribute("VFXEnable") ~= false then
                            descendant:SetAttribute("VFXEnable", false)
                        end
                    end
                end
            end)
        end
    end
end
