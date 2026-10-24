-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local New = _G.New

return {
    new = function(p1) -- new | line: 4
        p1.Event = {}
    end,
    Triger = function(p2, p3, ...) -- Triger | line: 8
        local v1 = p2.Event[p3]

        if v1 ~= nil then
            v1:Invoke(...)
        end
    end,
    AddEvent = function(p4, p5, p6, p7) -- AddEvent | line: 15
        -- upvalues: New (copy)
        local v2 = p4.Event[p5]

        if v2 ~= nil then
            if p7 and v2.Name == "Action" then
                v2 = New("WeightAction")(v2)
                p4.Event[p5] = v2
            end
        else
            v2 = if p7 then New("WeightAction")() else New("Action")()
            p4.Event[p5] = v2
        end

        v2:Add(p6, p7)

        return {
            Disconnect = function() -- Disconnect | line: 29
                -- upvalues: p4 (copy), p5 (copy), p6 (copy)
                p4:RemoveEvent(p5, p6)
            end
        }
    end,
    RemoveEvent = function(p8, p9, p10) -- RemoveEvent | line: 35
        local v4 = p8.Event[p9]

        if v4 ~= nil then
            v4:Remove(p10)
        end
    end,
    Clear = function(p11, p12) -- Clear | line: 43
        if p12 then
            p11.Event[p12] = nil
        else
            p11.Event = {}
        end
    end
}
