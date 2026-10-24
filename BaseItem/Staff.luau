-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t2 = {
    Enum.KeyCode.Q,
    Enum.KeyCode.F,
    Enum.KeyCode.R
}

return {
    OnUnequip = function(_) -- OnUnequip | line: 5
    end,
    OnEquip = function(p2) -- OnEquip | line: 9
        -- upvalues: t2 (copy)
        p2:LoadAnimation("Equip", 1015, Enum.AnimationPriority.Action2):Play()
        p2:LoadAnimation("Idle", 1016, Enum.AnimationPriority.Action, true):Play()
        p2.trove:Add(p2.player:AddSkill(103, Enum.UserInputType.MouseButton1, p2, {
            1017, 1018
        }))

        if p2.detail.skill then
            for v1, v2 in p2.detail.skill do
                p2.trove:Add(p2.player:AddSkill(v2.id, t2[v1], p2))
            end
        end
    end
}
