-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local PoolMgr = _G.PoolMgr

return {
    Show = function(p1, p2, p3) -- Show | line: 4
        -- upvalues: PoolMgr (copy)
        local v1 = PoolMgr:Get("Effect_Quality", script.Effect)

        v1.Parent = workspace.FX
        v1.CFrame = p2

        for _, descendant in v1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Color = ColorSequence.new(p3 or Color3.new(0, 1, 0.0666667))
            end
        end

        p1.effect = v1

        local v2 = p1:Emit(v1)

        task.delay(v2, function() -- line: 15
            -- upvalues: p1 (copy), PoolMgr (copy)
            PoolMgr:Push("Effect_Quality", p1.effect)
        end)
    end
}
