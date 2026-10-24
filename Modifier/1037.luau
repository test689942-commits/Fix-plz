-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return {
    Init = function(p1) -- Init | line: 3
        p1.trove:Add(p1.entity:AddEvent("Shoot", function(_, p3) -- line: 4
            -- upvalues: p1 (copy)
            if p3 then
                task.spawn(function() -- line: 8
                    -- upvalues: p1 (copy)
                    task.wait(0.2 / p1.entity.atkSpeed)
                    p1.entity:TrigerEvent("ToShoot")
                end)
            end
        end))
    end,
    Destroy = function(p4) -- Destroy | line: 15
        p4.trove:Clean()
    end
}
