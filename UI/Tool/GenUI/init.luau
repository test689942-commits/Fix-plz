-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

return function(_, p2, ...) -- line: 3
    -- upvalues: t1 (copy)
    if t1[p2] == nil then
        t1[p2] = require(script:FindFirstChild(p2))
    end

    return t1[p2](...)
end
