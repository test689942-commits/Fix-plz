-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local RunService = game:GetService("RunService")
local _, _, New = _G.GameMgr, _G.PoolMgr, _G.New
local v1 = RaycastParams.new()

v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = {
    workspace.Map,
    workspace.EItem,
    workspace.Entity
}

local v2 = OverlapParams.new()

v2.FilterType = Enum.RaycastFilterType.Include
v2.FilterDescendantsInstances = {
    workspace.EItem,
    workspace.Entity
}

function t1.Show(p1, p2, p3, p4) -- line: 14
    -- upvalues: RunService (copy), New (copy), v1 (copy), v2 (copy)
    local v3 = p2
    local v4 = CFrame.lookAlong(p2.Position, p3.Unit)

    v3 = v4

    local Magnitude = p3.Magnitude

    p1.trove = New("Utility.Trove")()
    p1.onHit = New("CS.Action")()

    local t2 = {}
    local pierce = p4.pierce
    local v5 = if not pierce then workspace:Raycast(v4.Position - p3.Unit * 6, p3.Unit * 6, v1) else nil

    if pierce or not v5 then
        p1.trove:Add(RunService.Stepped:Connect(function(_, p6) -- line: 31
            -- upvalues: v3 (ref), p1 (copy), p3 (copy), p4 (copy), Magnitude (copy), t2 (copy), v1 (copy), v2 (copy)
            v3 *= CFrame.new(0, 0, -Magnitude * p6)

            if p1.root then
                p1.root.CFrame *= CFrame.new(0, 0, -Magnitude * p6)
            end

            if p4.pierce then
                for _, v7 in (workspace:GetPartBoundsInBox(p1.root.CFrame, Vector3.new(8, 6, 6), v2)) do
                    local Model = v7:FindFirstAncestorWhichIsA("Model")

                    if Model ~= nil and not t2[Model] then
                        t2[Model] = true
                        p1.onHit(v7)
                    end
                end
            else
                local v8 = workspace:Raycast(v3.Position, p3 * p6 * 1.5, v1)

                if v8 then
                    p1.hit = v8
                    p1.onHit(v8.Instance)
                    p1:Destroy()
                end
            end
        end))

        local clone = script.Arow:Clone()

        p1.effect = clone

        for v9, _ in p4 do
            local v10 = script:FindFirstChild(v9)

            if v10 then
                v10:Clone().Parent = clone
            end
        end

        if clone:IsA("Model") then
            clone:PivotTo(v3)
            clone.PrimaryPart.Anchored = true
            p1.root = clone.PrimaryPart
        else
            clone.CFrame = v3
            clone.Anchored = true
            p1.root = clone
        end

        clone.Parent = workspace.FX
        p1.trove:Add(task.delay(5, function() -- line: 74
            -- upvalues: p1 (copy)
            p1:Destroy()
        end))
    else
        task.defer(function() -- line: 23
            -- upvalues: p1 (copy), v5 (copy)
            p1.hit = v5
            p1.onHit(v5.Instance)
            p1:Destroy()
        end)
    end
end

function t1.Hide(p7) -- line: 79
    p7.trove:Clean()

    if p7.effect then
        p7.effect:Destroy()
    end
end

return t1
