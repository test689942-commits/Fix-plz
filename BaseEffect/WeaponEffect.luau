-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _ = _G.PoolMgr

return {
    Show = function(p1, p2, p3, p4, p5) -- Show | line: 5
        local v1 = script:FindFirstChild(p3)

        if v1 ~= nil then
            local EffectPart = p2:FindFirstChild("Handle"):FindFirstChild("EffectPart")

            if EffectPart ~= nil then
                local t2 = {}

                p1.effect = t2

                for _, child in v1:GetChildren() do
                    local clone = child:Clone()

                    clone.Parent = EffectPart
                    table.insert(t2, clone)
                end

                if p4 == -1 then
                    p1.value = p3

                    return p1
                end

                if p5 then
                    for _, descendant in EffectPart:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant.Enabled = true
                        end
                    end
                else
                    for _, descendant in EffectPart:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant:Emit(descendant:GetAttribute("EmitCount") or 1)
                        end
                    end
                end

                task.delay(p4 or 1.5, function() -- line: 39
                    -- upvalues: p5 (copy), EffectPart (copy), t2 (copy)
                    if p5 then
                        for _, descendant in EffectPart:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false
                            end
                        end
                    end

                    for _, v2 in t2 do
                        v2:Destroy()
                    end
                end)
            end
        end
    end,
    Hide = function(p6) -- Hide | line: 54
        for _, v3 in p6.effect do
            v3:Destroy()
        end
    end
}
