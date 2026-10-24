-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _ = _G.GameMgr

return {
    Init = function(p1, _) -- Init | line: 4
        p1.trove:Add(p1.entity:AddEvent("Shoot", function(_, p4) -- line: 5
            -- upvalues: p1 (copy)
            if not p1.isTriger and p4 then
                p1.isTriger = true
                task.spawn(function() -- line: 10
                    -- upvalues: p1 (copy)
                    task.wait(0.1 / p1.entity.atkSpeed)
                    p1.entity:TrigerEvent("ToShoot")
                    task.wait(0.1 / p1.entity.atkSpeed)
                    p1.entity:TrigerEvent("ToShoot")
                end)
            end
        end))
    end,
    Add = function(p5, _) -- Add | line: 19
        p5.isTriger = false
    end,
    Remove = function(_, _) -- Remove | line: 23
    end
}
