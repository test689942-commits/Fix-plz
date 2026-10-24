-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _ = game:GetService("Players").LocalPlayer
local GameMgr, _, _, _ = _G.GameMgr, _G.DataMgr, _G.EventMgr, _G.New

return {
    OnInit = function(_) -- OnInit | line: 8
    end,
    OnEnter = function(p2) -- OnEnter | line: 14
        -- upvalues: GameMgr (copy)
        if p2:ChackUse(0.3) then
            p2.isEnter = false
        else
            for _, v1 in p2.player.skillList do
                v1.skill:ToCoolDown(0.5)
            end

            p2:ToCoolDown(p2.data.cd / p2.player.skill_speed, function(_) -- line: 24
            end)
            p2:Fire("Enter")
            GameMgr:BroadcastEffect("法术连铳", p2.player.Character.PrimaryPart)
        end
    end,
    OnExit = function(_) -- OnExit | line: 36
    end,
    Use = function(_) -- Use | line: 40
    end,
    Atk = function(_, _) -- Atk | line: 44
    end,
    OnEquip = function(_) -- OnEquip | line: 48
    end,
    OnUnequip = function(_) -- OnUnequip | line: 59
    end
}
