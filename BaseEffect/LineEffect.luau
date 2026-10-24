-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local PoolMgr = _G.PoolMgr

return {
    Show = function(p1, p2, p3) -- Show | line: 4
        -- upvalues: PoolMgr (copy)
        p1.effect = PoolMgr:Get("Effect_Line", script.Line)
        p1.effect.Parent = workspace.FX

        if typeof(p2) == "Instance" then
            p1.effect.Start.Anchored = false
            p1:Weld(p2, p1.effect.Start)
        else
            p1.effect.Start.Anchored = true
            p1.effect.Start.CFrame = p2
        end

        if typeof(p3) == "Instance" then
            p1.effect.End.Anchored = false
            p1:Weld(p3, p1.effect.End)
        else
            p1.effect.End.Anchored = true
            p1.effect.End.CFrame = p3
        end
    end,
    Hide = function(p4) -- Hide | line: 28
        -- upvalues: PoolMgr (copy)
        PoolMgr:Push("Effect_Line", p4.effect)
    end
}
