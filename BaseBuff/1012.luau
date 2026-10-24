-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _ = _G.GameMgr

return {
    Init = function(p1, _) -- Init | line: 4
        p1.trove:Add(p1.entity:AddEvent("Shoot", function(p3) -- line: 5
            p3.lightning = true
        end))
    end,
    Add = function(_, _) -- Add | line: 10
    end,
    Remove = function(_, _) -- Remove | line: 14
    end
}
