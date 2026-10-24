-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _ = _G.GameMgr

return {
    Init = function(p1, _) -- Init | line: 4
        p1.trove:Add(p1.entity:AddEvent("Shoot", function(_, p4) -- line: 5
            -- upvalues: p1 (copy)
            if p4 then
                task.spawn(function() -- line: 9
                    -- upvalues: p1 (copy)
                    task.wait(0.2 / p1.entity.atkSpeed)
                    p1.entity:TrigerEvent("ToShoot")
                end)
            end
        end))
    end,
    Add = function(_, _) -- Add | line: 16
    end,
    Remove = function(_, _) -- Remove | line: 20
    end
}
