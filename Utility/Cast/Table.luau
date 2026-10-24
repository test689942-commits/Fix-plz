-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local v1 = Random.new()
local _table = table
local t1 = {}

t1.contains = function(p1, p2) -- line: 27
    -- upvalues: t1 (copy)
    return t1.indexOf(p1, p2) ~= nil
end

t1.indexOf = function(p3, p4) -- line: 32
    -- upvalues: t1 (copy)
    local v2 = table.find(p3, p4)

    if v2 then
        return v2
    end

    return t1.keyOf(p3, p4)
end

t1.keyOf = function(p5, p6) -- line: 41
    for v3, v4 in pairs(p5) do
        if v4 == p6 then
            return v3
        end
    end

    return nil
end

t1.insertAndGetIndexOf = function(p7, p8) -- line: 51
    p7[#p7 + 1] = p8

    return #p7
end

t1.skip = function(p9, p10) -- line: 57
    return table.move(p9, p10 + 1, #p9, 1, table.create(#p9 - p10))
end

t1.take = function(p11, p12) -- line: 62
    return table.move(p11, 1, p12, 1, table.create(p12))
end

t1.range = function(p13, p14, p15) -- line: 67
    return table.move(p13, p14, p15, 1, table.create(p15 - p14 + 1))
end

t1.skipAndTake = function(p16, p17, p18) -- line: 72
    return table.move(p16, p17 + 1, p17 + p18, 1, table.create(p18))
end

t1.random = function(p19) -- line: 77
    -- upvalues: v1 (copy)
    return p19[v1:NextInteger(1, #p19)]
end

t1.join = function(p20, p21) -- line: 82
    local v5 = table.create(#p20 + #p21)

    table.move(p20, 1, #p20, 1, v5)

    return table.move(p21, 1, #p21, #p20 + 1, v5)
end

t1.removeObject = function(p22, p23) -- line: 89
    -- upvalues: t1 (copy)
    local v6 = t1.indexOf(p22, p23)

    if v6 then
        table.remove(p22, v6)
    end
end

return (setmetatable({}, {
    __index = function(_, p25) -- __index | line: 97
        -- upvalues: _table (copy), t1 (copy)
        if t1[p25] == nil then
            return _table[p25]
        end

        return t1[p25]
    end,
    __newindex = function(_, _, _) -- __newindex | line: 105
        error("Add new table entries by editing the Module itself.")
    end
}))
