-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _ = game:GetService("Players").LocalPlayer
local GameMgr, _, _, _ = _G.GameMgr, _G.DataMgr, _G.EventMgr, _G.New
local _ = {
    1803, 1804, 1805, 1806, 1807
}

return {
    OnInit = function(_) -- OnInit | line: 9
    end,
    OnEnter = function(p2) -- OnEnter | line: 15
        -- upvalues: GameMgr (copy)
        if p2:ChackUse(0.3) then
            p2.isEnter = false
        else
            p2:ToCoolDown(p2.data.cd / p2.player.skill_speed, function(_) -- line: 21
            end)
            p2:Fire("Enter")
            GameMgr:BroadcastEffect("铠甲", p2.player.Character.PrimaryPart, p2:GetValue(2))
            GameMgr:PlayWorldSound(p2.player.Humanoid.RootPart.CFrame, 1704)
        end
    end,
    OnExit = function(_) -- OnExit | line: 33
    end,
    Use = function(_) -- Use | line: 37
    end,
    Atk = function(_, _) -- Atk | line: 41
    end,
    OnEquip = function(_) -- OnEquip | line: 45
    end,
    OnUnequip = function(_) -- OnUnequip | line: 56
    end
}
