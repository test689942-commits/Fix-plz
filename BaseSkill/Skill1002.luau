-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _ = game:GetService("Players").LocalPlayer
local GameMgr, _, _, New = _G.GameMgr, _G.DataMgr, _G.EventMgr, _G.New
local t2 = {
    1803, 1804, 1805, 1806, 1807
}
local _ = workspace.CurrentCamera

return {
    OnInit = function(p1) -- OnInit | line: 13
        -- upvalues: New (copy)
        p1.trove:Add(p1.player:AddEvent("CutSkill", function() -- line: 14
            -- upvalues: p1 (copy)
            p1.Animations.Skill:Stop()
            p1.stateTrove:Clean()
        end))
        p1.stateTrove = New("Utility.Trove")()
    end,
    OnEnter = function(p2) -- OnEnter | line: 21
        if p2:OnCoolDown() then
            p2.isEnter = false
        else
            p2:ToCoolDown(p2.data.cd / p2.player.skill_speed, function(_) -- line: 27
            end)
            p2.stateTrove:Add(p2.player:CanMove(false))
            p2.Animations.Skill:Play()
            p2.stateTrove:Add(p2.player:SetState("action", true))
            p2.stateTrove:Add(function() -- line: 34
                -- upvalues: p2 (copy)
                p2:Fire("Exit")
            end)
            p2.player:AttackAdsorption()
            p2:Fire("Enter")
        end
    end,
    OnExit = function(_) -- OnExit | line: 41
    end,
    Use = function(_) -- Use | line: 45
    end,
    Atk = function(p6, p7) -- Atk | line: 49
        -- upvalues: GameMgr (copy), t2 (copy)
        if not p7 or #p7 == 0 then
            return
        end

        p6.player.CameraShaker:ShakeOnce(1, 20, 0, 0.5, 0, 0)

        for _, v1 in p7 do
            if v1[1] and v1[1].PrimaryPart then
                GameMgr:PlayWorldSound(v1[1].PrimaryPart.CFrame, t2[math.random(#t2)])
                GameMgr:ShowEffect("Sword_Atk_Hit", v1[1].PrimaryPart.CFrame)
                GameMgr:ShowEffect("BroadcastEffect", v1[1].PrimaryPart.CFrame, v1[2])
                p6.player:TrigerEvent("Atk", v1[2], v1[1])
            end
        end
    end,
    OnEquip = function(p8) -- OnEquip | line: 63
        -- upvalues: GameMgr (copy)
        p8:LoadAnimation("Skill", p8.data.animation, Enum.AnimationPriority.Action3):GetMarkerReachedSignal("Atk"):Connect(function(_) -- line: 64
            -- upvalues: p8 (copy), GameMgr (copy)
            local v2 = p8.player.Humanoid.RootPart.CFrame * CFrame.new(0, -3, -6)

            p8:Fire("Atk", v2)
            GameMgr:BroadcastEffect("裂地击_Atk", v2)
        end)
        p8.Animations.Skill.Stopped:Connect(function() -- line: 70
            -- upvalues: p8 (copy)
            p8.stateTrove:Clean()
        end)
    end,
    OnUnequip = function(p10) -- OnUnequip | line: 75
        p10.stateTrove:Clean()
    end
}
