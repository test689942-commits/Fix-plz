-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _ = _G.GameMgr
local t2 = { "ice", "fire", "lightning", "pierce" }

return {
    Init = function(p1, _) -- Init | line: 10
        -- upvalues: t2 (copy)
        local n1 = 0

        p1.trove:Add(p1.entity:AddEvent("Shoot", function(p3) -- line: 12
            -- upvalues: n1 (ref), t2 (copy)
            n1 += 1

            if n1 >= 4 then
                n1 = 0
                p3[t2[math.random(#t2)]] = true
            end
        end))
    end,
    Add = function(_, _) -- Add | line: 21
    end,
    Remove = function(_, _) -- Remove | line: 25
    end
}
