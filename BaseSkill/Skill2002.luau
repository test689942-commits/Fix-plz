-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local _ = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local GameMgr, _, _, New = _G.GameMgr, _G.DataMgr, _G.EventMgr, _G.New
local _ = workspace.CurrentCamera
local v1 = OverlapParams.new()

v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = { workspace.Entity }

function t1.OnInit(p1) -- line: 16
    -- upvalues: New (copy)
    p1.trove:Add(p1.player:AddEvent("CutSkill", function() -- line: 17
        -- upvalues: p1 (copy)
        p1.Animations.Skill:Stop()
        p1.stateTrove:Clean()
    end))
    p1.stateTrove = New("Utility.Trove")()
end

function t1.OnEnter(p2) -- line: 24
    if p2:ChackUse(0.3) then
        p2.isEnter = false
    else
        p2:ToCoolDown(p2.data.cd / p2.player.skill_speed, function(_) -- line: 30
        end)
        p2.stateTrove:Add(p2.player:CanMove(false))
        p2.Animations.Skill:Play()
        p2.stateTrove:Add(p2.player:SetState("action", true))
        p2.player:AttackAdsorption()
        p2:Fire("Enter")
    end
end

function t1.OnExit(_) -- line: 40
end

function t1.Use(_) -- line: 44
end

function t1.Atk(p6, p7) -- line: 48
    -- upvalues: GameMgr (copy)
    if not p7 or #p7 == 0 then
        return
    end

    p6.player.CameraShaker:ShakeOnce(1, 20, 0, 0.5, 0, 0)

    for _, v2 in p7 do
        if v2[1] and v2[1].PrimaryPart then
            GameMgr:PlayWorldSound(v2[1].PrimaryPart.CFrame, 1857)
            GameMgr:ShowEffect("寒冰弹HIT", v2[1].PrimaryPart.CFrame)
            GameMgr:ShowEffect("BroadcastEffect", v2[1].PrimaryPart.CFrame, v2[2])
            p6.player:TrigerEvent("Atk", v2[2], v2[1])
        end
    end
end

function t1.OnEquip(p8) -- line: 62
    -- upvalues: RunService (copy), GameMgr (copy), v1 (copy)
    p8:LoadAnimation("Skill", p8.data.animation, Enum.AnimationPriority.Action3):GetMarkerReachedSignal("Atk"):Connect(function(_) -- line: 63
        -- upvalues: p8 (copy), RunService (copy), GameMgr (copy), v1 (copy)
        local v3 = GameMgr:BroadcastEffect("LauncherEffect", "寒冰弹", p8.player.HumanoidRootPart.CFrame * CFrame.new(0, 0, -6), p8.player.HumanoidRootPart.CFrame.LookVector * 15, { workspace.Map }, 3)
        local t2 = {}
        local t3 = {}

        v3.trove:Add(RunService.RenderStepped:Connect(function(_) -- line: 67
            -- upvalues: v3 (copy), t2 (copy), t3 (ref), p8 (copy), v1 (copy)
            local PartsInPart = workspace:GetPartsInPart(v3.effect, v1)

            t3 = {}

            for _, v4 in PartsInPart do
                local Model = v4:FindFirstAncestorWhichIsA("Model")

                if Model ~= nil and not t2[Model] then
                    t2[Model] = true
                    table.insert(t3, Model)
                end
            end

            if #t3 ~= 0 then
                p8:Fire("Atk", t3)
            end
        end))
    end)
    p8.Animations.Skill.Stopped:Connect(function() -- line: 85
        -- upvalues: p8 (copy)
        p8.stateTrove:Clean()
    end)
end

function t1.OnUnequip(p11) -- line: 90
    p11.stateTrove:Clean()
end

return t1
