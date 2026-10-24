-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("TweenService")

local PoolMgr = _G.PoolMgr
local t2 = {}

function t1.Show(_, p2, p3) -- line: 6
    -- upvalues: PoolMgr (copy), t2 (copy)
    if not t2[p3] then
        t2[p3] = script:FindFirstChild(p3)
    end

    local v1 = PoolMgr:Get("Effect_Waterspout" .. p3, t2[p3])

    v1.Parent = workspace.FX
    v1.Anchored = true
    v1.Transparency = 1

    if typeof(p2) == "CFrame" then
        v1.CFrame = p2
    else
        v1.CFrame = p2.CFrame
    end

    for _, descendant in ipairs(v1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant.Enabled = true
        end
    end

    task.delay(1.5, function() -- line: 25
        -- upvalues: v1 (copy)
        for _, descendant in ipairs(v1:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = false
            end
        end
    end)
    task.delay(2.5, function() -- line: 32
        -- upvalues: p3 (copy), v1 (copy), PoolMgr (copy)
        PoolMgr:Push("Effect_Waterspout" .. p3, v1)
    end)
end

return t1
