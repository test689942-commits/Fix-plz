-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local PoolMgr = _G.PoolMgr

return {
    Show = function(_, p2) -- Show | line: 5
        -- upvalues: PoolMgr (copy)
        local v1 = PoolMgr:Get("Effect_LevelUp", script.Effect)

        v1.Parent = workspace.FX
        v1.CFrame = CFrame.new(p2)

        for _, descendant in v1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant:Emit(descendant:GetAttribute("EmitCount") or 1)
            end
        end

        task.delay(1.5, function() -- line: 14
            -- upvalues: v1 (copy), PoolMgr (copy)
            PoolMgr:Push("Effect_LevelUp", v1)
        end)
    end
}
