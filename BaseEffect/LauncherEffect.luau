-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local RunService = game:GetService("RunService")
local GameMgr, PoolMgr, New = _G.GameMgr, _G.PoolMgr, _G.New
local v1 = RunService:IsClient()
local v2 = RaycastParams.new()

v2.FilterType = Enum.RaycastFilterType.Include
v2.FilterDescendantsInstances = {
    workspace.Map,
    workspace.EItem,
    workspace.Entity
}

local t2 = {}

function t1.Show(p1, p2, p3, p4, p5, p6) -- line: 12
    -- upvalues: RunService (copy), GameMgr (copy), PoolMgr (copy), New (copy), v1 (copy), v2 (copy), t2 (copy)
    local v3 = p3
    local v4 = p5

    if not v1 then
        GameMgr:BroadcastEffect("LauncherEffect", p2, p3, p4, p5)
    end

    v3 = CFrame.lookAlong(p3.Position, p4.Unit)

    if p5 then
        local v5 = RaycastParams.new()

        v5.FilterType = Enum.RaycastFilterType.Include
        v5.FilterDescendantsInstances = p5
        v4 = v5
    else
        v4 = v2
    end

    local Magnitude = p4.Magnitude

    p1.trove = New("Utility.Trove")()
    p1.trove:Add(RunService.Stepped:Connect(function(_, p8) -- line: 27
        -- upvalues: v3 (ref), v4 (ref), p1 (copy), p4 (copy), Magnitude (copy)
        v3 *= CFrame.new(0, 0, -Magnitude * p8)

        if p1.root then
            p1.root.CFrame *= CFrame.new(0, 0, -Magnitude * p8)
        end

        local v7 = workspace:Raycast(v3.Position, p4 * p8 * 1.5, v4)

        if v7 then
            p1.hit = v7
            p1:Destroy()
        end
    end))

    if v1 then
        if not t2[p2] then
            t2[p2] = script:FindFirstChild(p2)
        end

        p1.value = p2

        local v8 = PoolMgr:Get("Effect_Launcher" .. p2, t2[p2])

        p1.effect = v8

        if v8:IsA("Model") then
            v8:PivotTo(v3)
            v8.PrimaryPart.Anchored = true
            p1.root = v8.PrimaryPart
        else
            v8.CFrame = v3
            v8.Anchored = true
            p1.root = v8
        end

        v8.Parent = workspace.FX
    end

    p1.trove:Add(task.delay(p6 or 5, function() -- line: 58
        -- upvalues: p1 (copy)
        p1:Destroy()
    end))
end

function t1.Hide(p9) -- line: 63
    -- upvalues: PoolMgr (copy)
    p9.trove:Clean()

    if p9.effect then
        PoolMgr:Push("Effect_Launcher" .. p9.value, p9.effect)
    end
end

return t1
