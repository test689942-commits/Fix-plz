-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _ = game:GetService("Players").LocalPlayer
local GameMgr, _, _, New = _G.GameMgr, _G.DataMgr, _G.EventMgr, _G.New
local _ = workspace.CurrentCamera

return {
    OnInit = function(p1) -- OnInit | line: 11
        -- upvalues: New (copy)
        p1.trove:Add(p1.player:AddEvent("CutSkill", function() -- line: 12
            -- upvalues: p1 (copy)
            p1.Animations.Skill:Stop()
            p1.stateTrove:Clean()
        end))
        p1.stateTrove = New("Utility.Trove")()
    end,
    OnEnter = function(p2) -- OnEnter | line: 19
        if p2:ChackUse(0.3) then
            p2.isEnter = false
        else
            p2:ToCoolDown(p2.data.cd / p2.player.skill_speed, function(_) -- line: 25
            end)
            p2.stateTrove:Add(p2.player:CanMove(false))
            p2.Animations.Skill:Play()
            p2.stateTrove:Add(p2.player:SetState("action", true))
            p2.player:AttackAdsorption()
            p2:Fire("Enter")
        end
    end,
    OnExit = function(_) -- OnExit | line: 35
    end,
    Use = function(_) -- Use | line: 39
    end,
    Atk = function(p6, p7) -- Atk | line: 43
        -- upvalues: GameMgr (copy)
        if not p7 or #p7 == 0 then
            return
        end

        p6.player.CameraShaker:ShakeOnce(1, 20, 0, 0.5, 0, 0)

        for _, v1 in p7 do
            if v1[1] and v1[1].PrimaryPart then
                GameMgr:PlayWorldSound(v1[1].PrimaryPart.CFrame, 1862)
                GameMgr:ShowEffect("灵魂摄取HIT", v1[1].PrimaryPart.CFrame)
                GameMgr:ShowEffect("BroadcastEffect", v1[1].PrimaryPart.CFrame, v1[2])
                p6.player:TrigerEvent("Atk", v1[2], v1[1])
            end
        end
    end,
    OnEquip = function(p8) -- OnEquip | line: 57
        p8:LoadAnimation("Skill", p8.data.animation, Enum.AnimationPriority.Action3):GetMarkerReachedSignal("Atk"):Connect(function(_) -- line: 58
            -- upvalues: p8 (copy)
            p8:Fire("Atk", p8.player.Humanoid.RootPart.CFrame)
        end)
        p8.Animations.Skill.Stopped:Connect(function() -- line: 62
            -- upvalues: p8 (copy)
            p8.stateTrove:Clean()
        end)
    end,
    OnUnequip = function(p10) -- OnUnequip | line: 67
        p10.stateTrove:Clean()
    end
}
