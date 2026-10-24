-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local RunService = game:GetService("RunService")
local PoolMgr, New = _G.PoolMgr, _G.New
local v1 = RaycastParams.new()

v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = { workspace.Map }

local t2 = {}

function t1.Show(p1, p2, p3, p4) -- line: 10
    -- upvalues: RunService (copy), PoolMgr (copy), New (copy), v1 (copy), t2 (copy)
    if not t2[p2] then
        t2[p2] = script:FindFirstChild(p2)
    end

    p1.value = p2

    local v2 = PoolMgr:Get("Effect_Throw" .. p2, t2[p2])

    v2.Parent = workspace.FX
    p1.effect = v2
    p1.trove = New("Utility.Trove")()

    if v2:IsA("Model") then
        v2:PivotTo(p3)

        for _, descendant in v2:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.AssemblyLinearVelocity = p4
            end
        end

        p1.trove:Add(RunService.Stepped:Connect(function(_, p6) -- line: 28
            -- upvalues: p1 (copy), v2 (copy), v1 (copy)
            if v2.PrimaryPart ~= nil then
                if workspace:Raycast(v2.PrimaryPart.CFrame.Position, v2.PrimaryPart.AssemblyLinearVelocity * p6, v1) then
                    p1:Destroy()
                end
            else
                p1.trove:Clean()
            end
        end))
    else
        v2.CFrame = p3
        v2.AssemblyLinearVelocity = p4
        v2.CollisionGroup = "NoCollisions"
        p1.trove:Add(RunService.Stepped:Connect(function(_, p8) -- line: 41
            -- upvalues: p1 (copy), v2 (copy), v1 (copy)
            if v2 == nil then
                p1.trove:Clean()
            end

            if workspace:Raycast(v2.CFrame.Position, v2.AssemblyLinearVelocity * p8, v1) then
                p1:Destroy()
            end
        end))
    end

    p1.trove:Add(task.delay(5, function() -- line: 51
        -- upvalues: p1 (copy)
        p1:Destroy()
    end))
end

function t1.Hide(p9) -- line: 56
    -- upvalues: PoolMgr (copy)
    p9.trove:Clean()
    PoolMgr:Push("Effect_Throw" .. p9.value, p9.effect)
end

return t1
