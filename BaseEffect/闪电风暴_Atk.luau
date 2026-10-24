-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local RunService = game:GetService("RunService")
local v1 = RunService:IsClient()
local GameMgr, _, PoolMgr, New = _G.GameMgr, _G.EventMgr, _G.PoolMgr, _G.New
local v2 = OverlapParams.new()

v2.FilterType = Enum.RaycastFilterType.Include
v2.FilterDescendantsInstances = {
    workspace.EItem,
    workspace.Entity
}

function t1.Show(p1, p2, p3, p4) -- line: 13
    -- upvalues: RunService (copy), v1 (copy), GameMgr (copy), PoolMgr (copy), New (copy)
    if not v1 then
        GameMgr:BroadcastEffect("闪电风暴_Atk", p2, p3, p4)
    end

    p1.pos = p2

    local connection = RunService.Stepped:Connect(function(_, p6) -- line: 19
        -- upvalues: p1 (copy), p3 (copy), v1 (copy)
        if p3 then
            local v3 = p3.CFrame.Position - p1.pos

            if v3.Magnitude > 0.3 then
                p1.pos += v3.Unit * p6 * 12
            end
        end

        if v1 then
            p1.effect:PivotTo(CFrame.new(p1.pos + Vector3.new(0, -3, 0)))
        end
    end)

    p1.onHit = New("CS.Action")()

    if v1 then
        p1.effect = PoolMgr:Get("Effect_闪电风暴_Atk", script.Effect)
        p1.effect:PivotTo(CFrame.new(p1.pos + Vector3.new(0, -3, 0)))
        p1.effect.Parent = workspace.FX
    end

    task.delay(p4, function() -- line: 37
        -- upvalues: p1 (copy), connection (copy), v1 (copy)
        if v1 then
            p1:SetEnabled(p1.effect, false)
        end

        connection:Disconnect()
    end)

    if not v1 then
        return
    end

    local v4 = p4 + p1:SetEnabled(p1.effect, true)

    task.delay(v4, function() -- line: 46
        -- upvalues: p1 (copy), PoolMgr (copy)
        PoolMgr:Push("Effect_闪电风暴_Atk", p1.effect)
    end)
end

function t1.Hide(_) -- line: 52
end

return t1
