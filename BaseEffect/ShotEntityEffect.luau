-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local PoolMgr = _G.PoolMgr

return {
    Show = function(p1, p2) -- Show | line: 4
        -- upvalues: PoolMgr (copy)
        local v1 = PoolMgr:Get("Effect_ShotEntityEffect", script["击中人物特效"])

        v1.Parent = workspace.FX
        v1.CFrame = p2
        p1.effect = v1
        p1:Emit(v1)
        task.delay(1, function() -- line: 10
            -- upvalues: p1 (copy), PoolMgr (copy)
            PoolMgr:Push("Effect_ShotEntityEffect", p1.effect)
        end)
    end
}
