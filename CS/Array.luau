-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t2 = {}
local t1 = {}

function t1.__index(p1, p2) -- line: 3
    -- upvalues: t1 (copy)
    if t1[p2] then
        return t1[p2]
    end

    if type(p2) == "number" then
        return p1._array[p2]
    end

    error(("%q is not a valid member of Array"):format((tostring(p2))), 2)
end

function t1.__newindex(p3, p4, p5) -- line: 13
    p3:Set(p4, p5)
end

function t1.__iter(p6) -- line: 17
    local n1 = 0

    return function() -- line: 20
        -- upvalues: p6 (copy), n1 (ref)
        local v1 = n1

        if v1 < p6.count then
            n1 += 1

            return n1, p6._array[n1]
        end
    end
end

function t1.CreatType(p7, p8) -- line: 29
    -- upvalues: t1 (copy), t2 (copy)
    if p8 == nil then
        if p7.Type == nil then
            error("Array is not Have Type")
        end

        return p7
    end

    local v2 = t2[p8]
    local v3 = v2

    if v2 == nil then
        local t3 = {}

        v3 = t3
        t3.Type = p8
        t3.isGeneric = true

        local function __index(p9, p10) -- line: 41
            -- upvalues: v3 (ref), t1 (copy)
            if p10 == "Type" then
                return v3.Type
            end

            return t1.__index(p9, p10)
        end

        local v4 = v3

        v4.__index = __index
        v4.__newindex = t1.__newindex
        v4.__iter = t1.__iter
        t2[p8] = v3
        setmetatable(v4, t1)
    end

    return v3
end

function t1.new(p11, p12, p13) -- line: 56
    local v5 = if p12 == nil then 1 else p12

    if type(v5) ~= "number" then
        error("The count must be numbers")
    end

    rawset(p11, "count", v5)
    rawset(p11, "_array", {})

    if p13 ~= nil and type(p13) == "function" then
        for i = 1, v5 do
            p11._array[i] = p13(i)
        end
    end
end

function t1.Instance(p14, p15) -- line: 74
    if p15._base then
        return p15
    end

    if p15._array ~= nil then
        if p14.Type.Name ~= nil then
            for v8, v9 in pairs(p15._array) do
                p15._array[v8] = p14.Type:Instance(v9)
            end
        end
    else
        local t5 = {}

        for v6, v7 in pairs(p15) do
            t5[v6] = v7

            if p14.Type.Name ~= nil then
                t5[v6] = p14.Type:Instance(v7)
            end
        end

        table.clear(p15)
        p15._array = t5
    end

    p15.count = #p15._array
    setmetatable(p15, p14)

    return p15
end

function t1.IsEmpty(p16) -- line: 101
    return p16.count == 0
end

function t1.Set(p17, p18, p19) -- line: 105
    if type(p18) ~= "number" then
        error("The index must be numbers")
    end

    if p18 < 1 or p17.count < p18 then
        error("The index number exceeds the boundary")
    end

    p17._array[p18] = p19
end

function t1.Get(p20, p21) -- line: 115
    if p21 < 1 and p20.count < p21 then
        error("The index number exceeds the boundary")
    end

    return p20._array[p21]
end

return t1
