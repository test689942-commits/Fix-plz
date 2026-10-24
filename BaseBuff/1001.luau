-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local GameMgr = _G.GameMgr

return {
    Init = function(_, _) -- Init | line: 4
    end,
    Add = function(p3, _) -- Add | line: 8
        -- upvalues: GameMgr (copy)
        GameMgr:ShowEffect("怒火增加", p3.entity.Character.PrimaryPart)
    end,
    Remove = function(_, _) -- Remove | line: 12
    end
}
