-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local PoolMgr = _G.PoolMgr

return {
    Show = function(p1, p2) -- Show | line: 4
        -- upvalues: PoolMgr (copy)
        local v1 = PoolMgr:Get("Effect_ShotHitEffect", script["击中建筑特效"])

        v1.Parent = workspace.FX
        v1.CFrame = p2
        p1.effect = v1
        p1:Emit(v1)
        task.delay(1, function() -- line: 10
            -- upvalues: p1 (copy), PoolMgr (copy)
            PoolMgr:Push("Effect_ShotHitEffect", p1.effect)
        end)
    end,
    Hide = function(p3) -- Hide | line: 15
        -- upvalues: PoolMgr (copy)
        if p3.weld then
            p3.weld:Destroy()
        end

        PoolMgr:Push("Effect_Skill" .. p3.value, p3.effect)
    end
}
