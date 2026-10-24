-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local _ = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local GameMgr, _, _, New = _G.GameMgr, _G.DataMgr, _G.EventMgr, _G.New
local t2 = {
    1803, 1804, 1805, 1806, 1807
}
local _ = workspace.CurrentCamera
local v1 = OverlapParams.new()

v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = { workspace.Entity }

function t1.OnInit(p1) -- line: 17
    -- upvalues: New (copy)
    p1.trove:Add(p1.player:AddEvent("CutSkill", function() -- line: 18
        -- upvalues: p1 (copy)
        p1.Animations.Skill:Stop()
        p1.stateTrove:Clean()
    end))
    p1.stateTrove = New("Utility.Trove")()
end

function t1.OnEnter(p2) -- line: 25
    if p2:OnCoolDown() then
        p2.isEnter = false
    else
        p2:ToCoolDown(p2.data.cd / p2.player.skill_speed, function(_) -- line: 31
        end)
        p2.Animations.Skill:Play()
        p2.stateTrove:Add(p2.player:CanMove(false))
        p2.stateTrove:Add(p2.player:SetState("action", true))
        p2.stateTrove:Add(function() -- line: 37
            -- upvalues: p2 (copy)
            p2:Fire("Exit")
        end)
        p2.player:AttackAdsorption()

        local v2 = if p2.player.atkTarget then p2.player.atkTarget.PrimaryPart.CFrame.Position - p2.player.HumanoidRootPart.CFrame.Position else p2.player.HumanoidRootPart.CFrame.LookVector

        p2.player:AddPower(-v2.Unit * 36, 0.2)
        p2:Fire("Enter")
    end
end

function t1.OnExit(_) -- line: 51
end

function t1.Use(_) -- line: 55
end

function t1.Atk(p6, p7) -- line: 59
    -- upvalues: GameMgr (copy), t2 (copy)
    if not p7 or #p7 == 0 then
        return
    end

    p6.player.CameraShaker:ShakeOnce(1, 20, 0, 0.5, 0, 0)

    for _, v3 in p7 do
        if v3[1] and v3[1].PrimaryPart then
            GameMgr:PlayWorldSound(v3[1].PrimaryPart.CFrame, t2[math.random(#t2)])
            GameMgr:ShowEffect("Sword_Atk_Hit", v3[1].PrimaryPart.CFrame)
            GameMgr:ShowEffect("BroadcastEffect", v3[1].PrimaryPart.CFrame, v3[2])
            p6.player:TrigerEvent("Atk", v3[2], v3[1])
        end
    end
end

function t1.OnEquip(p8) -- line: 73
    -- upvalues: RunService (copy), GameMgr (copy), v1 (copy)
    p8:LoadAnimation("Skill", p8.data.animation, Enum.AnimationPriority.Action3):GetMarkerReachedSignal("Atk"):Connect(function(_) -- line: 74
        -- upvalues: p8 (copy), RunService (copy), GameMgr (copy), v1 (copy)
        local v4 = GameMgr:BroadcastEffect("爆气斩_Atk", p8.player.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4))
        local t3 = {}
        local t4 = {}

        v4.trove:Add(RunService.RenderStepped:Connect(function(_) -- line: 78
            -- upvalues: v4 (copy), t3 (copy), t4 (ref), p8 (copy), v1 (copy)
            local PartsInPart = workspace:GetPartsInPart(v4.effect.Bullet, v1)

            t4 = {}

            for _, v5 in PartsInPart do
                local Model = v5:FindFirstAncestorWhichIsA("Model")

                if Model ~= nil and not t3[Model] then
                    t3[Model] = true
                    table.insert(t4, Model)
                end
            end

            if #t4 ~= 0 then
                p8:Fire("Atk", t4)
            end
        end))
    end)
    p8.Animations.Skill.Stopped:Connect(function() -- line: 95
        -- upvalues: p8 (copy)
        p8.stateTrove:Clean()
    end)
end

function t1.OnUnequip(p11) -- line: 100
    p11.stateTrove:Clean()
end

return t1
