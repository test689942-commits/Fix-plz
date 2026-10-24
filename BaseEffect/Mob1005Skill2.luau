-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local RunService = game:GetService("RunService")
local PoolMgr, New = _G.PoolMgr, _G.New
local v1 = RaycastParams.new()

v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = { workspace.Map }

function t1.Show(p1, p2) -- line: 10
    -- upvalues: RunService (copy), PoolMgr (copy), New (copy), v1 (copy)
    local v2 = PoolMgr:Get("Mob1005Skill2", script.Effect)

    p1.effect = v2
    p1.trove = New("Utility.Trove")()
    v2:PivotTo(p2)
    p1:Emit(v2.Slash)
    p1:SetEnabled(v2.Bullet, true)
    v2.PrimaryPart.Anchored = true
    p1.trove:Add(RunService.Stepped:Connect(function(_, p4) -- line: 20
        -- upvalues: p1 (copy), v2 (copy), v1 (copy)
        v2.PrimaryPart.CFrame *= CFrame.new(0, 0, -100 * p4)

        if workspace:Raycast(v2.PrimaryPart.CFrame.Position, v2.PrimaryPart.CFrame.LookVector * p4 * 5, v1) then
            p1:Destroy()
        end
    end))
    v2.Parent = workspace.FX
    p1.trove:Add(task.delay(0.75, function() -- line: 29
        -- upvalues: p1 (copy)
        p1:Destroy()
    end))
end

function t1.Hide(p5) -- line: 34
    -- upvalues: PoolMgr (copy)
    p5.trove:Clean()
    p5:SetEnabled(p5.effect.Bullet, false)
    task.delay(1.5, function() -- line: 37
        -- upvalues: p5 (copy), PoolMgr (copy)
        PoolMgr:Push("Mob1005Skill2", p5.effect)
    end)
end

return t1
