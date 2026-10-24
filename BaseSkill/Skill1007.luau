-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _ = game:GetService("Players").LocalPlayer
local _, _, _, New = _G.GameMgr, _G.DataMgr, _G.EventMgr, _G.New

return {
    OnInit = function(p1) -- OnInit | line: 8
        -- upvalues: New (copy)
        p1.trove:Add(p1.player:AddEvent("CutSkill", function() -- line: 9
            -- upvalues: p1 (copy)
            p1.Animations.Skill:Stop()
            p1.stateTrove:Clean()
        end))
        p1.stateTrove = New("Utility.Trove")()
    end,
    OnEnter = function(p2) -- OnEnter | line: 16
        if p2:ChackUse(0.3) then
            p2.isEnter = false
        else
            p2:ToCoolDown(p2.data.cd / p2.player.skill_speed, function(_) -- line: 22
            end)
            p2.player.speed:SetValueMul(0.1, "Skill1007")
            p2.stateTrove:Add(function() -- line: 26
                -- upvalues: p2 (copy)
                p2.player.speed:SetValueMul(nil, "Skill1007")
                p2:Fire("Exit")
            end)
            p2.Animations.Skill:Play()
            p2.stateTrove:Add(p2.player:SetState("action", true))
            p2:Fire("Enter")
        end
    end,
    OnExit = function(_) -- OnExit | line: 35
    end,
    Use = function(_) -- Use | line: 39
    end,
    Atk = function(_, _) -- Atk | line: 43
    end,
    OnEquip = function(p8) -- OnEquip | line: 47
        p8:LoadAnimation("Skill", p8.data.animation, Enum.AnimationPriority.Action3):GetMarkerReachedSignal("Atk"):Connect(function(_) -- line: 48
            -- upvalues: p8 (copy)
            p8:Fire("Atk")
        end)
        p8.Animations.Skill.Stopped:Connect(function() -- line: 51
            -- upvalues: p8 (copy)
            p8.stateTrove:Clean()
        end)
    end,
    OnUnequip = function(p10) -- OnUnequip | line: 56
        p10.stateTrove:Clean()
    end
}
