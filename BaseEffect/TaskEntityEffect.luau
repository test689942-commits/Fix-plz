-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("RunService")

local PoolMgr = _G.PoolMgr
local _ = game:GetService("Players").LocalPlayer

function t1.Show(p1, p2) -- line: 6
    -- upvalues: PoolMgr (copy)
    p1.effect = PoolMgr:Get("Effect_TaskEntity", script.TaskIcon)
    p1.effect.Parent = p2
    p1.effect.Adornee = p2
end

function t1.Hide(p3) -- line: 21
    -- upvalues: PoolMgr (copy)
    if p3.effect then
        PoolMgr:Push("Effect_TaskEntity", p3.effect)
    end

    p3.effect = nil
end

return t1
