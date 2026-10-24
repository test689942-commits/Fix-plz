-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DataMgr, New = _G.DataMgr, _G.New
local t2 = {}
local t1 = {}

t1._array = {}
t1.count = 0

function t1.__index(p1, p2) -- line: 8
    -- upvalues: t1 (copy)
    if t1[p2] then
        return t1[p2]
    end

    return p1._array[p2]
end

function t1.__newindex(p3, p4, p5) -- line: 16
    p3:Set(p4, p5)
end

function t1.__iter(p6) -- line: 20
    return pairs(p6._array)
end

function t1.CreatType(p7, p8, p9) -- line: 25
    -- upvalues: t1 (copy), t2 (copy)
    if p8 ~= nil and p9 ~= nil then
        local v1

        if t2[p8] == nil or t2[p8][p9] == nil then
            local t3 = {}

            v1 = t3
            t3.TKey = p8
            t3.TValue = p9
            t3.isGeneric = true

            local function __index(p10, p11) -- line: 38
                -- upvalues: v1 (ref), t1 (copy)
                if p11 == "TKey" then
                    return v1.TKey
                end

                if p11 == "TValue" then
                    return v1.TValue
                end

                return t1.__index(p10, p11)
            end

            local v2 = v1

            v2.__index = __index
            v2.__newindex = t1.__newindex
            v2.__iter = t1.__iter

            if t2[p8] == nil then
                t2[p8] = {}
            end

            t2[p8][p9] = v2
            setmetatable(v2, t1)
        else
            v1 = t2[p8][p9]
        end

        return v1
    end

    if p7.TKey == nil or p7.TValue == nil then
        error("Dic is not Have Type")
    end

    return p7
end

function t1.new(p12) -- line: 60
    rawset(p12, "count", 0)
    rawset(p12, "_array", {})
end

function t1.Instance(p13, p14) -- line: 65
    if p14._base then
        return p14
    end

    if p14._array ~= nil then
        if p13.TKey == "number" then
            local t6 = {}

            for v7, v8 in pairs(p14._array) do
                local v9 = tonumber(v7)

                if p13.TValue.Name ~= nil then
                    t6[v9] = p13.TValue:Instance(v8)
                else
                    t6[v9] = v8
                end
            end

            p14._array = t6
        else
            for v10, v11 in pairs(p14._array) do
                if p13.TKey.Name ~= nil then
                    p13.TKey:Instance(v10)
                end

                if p13.TValue.Name ~= nil then
                    p14._array[v10] = p13.TValue:Instance(v11)
                end
            end
        end
    else
        local t5 = {}
        local n1 = 0

        for v4, v5 in pairs(p14) do
            local v6 = v4

            if p13.TKey.Name ~= nil then
                p13.TKey:Instance(v4)
            elseif p13.TKey == "number" then
                v6 = tonumber(v4)
            end

            if p13.TValue.Name ~= nil then
                t5[v6] = p13.TValue:Instance(v5)
            else
                t5[v6] = v5
            end

            n1 += 1
        end

        table.clear(p14)
        p14._array = t5
        p14.count = n1
    end

    setmetatable(p14, p13)

    return p14
end

function t1.IsEmpty(p15) -- line: 115
    return p15.count == 0
end

function t1.ContainsKey(p16, p17) -- line: 119
    return p16._array[p17] ~= nil
end

function t1.ContainsValue(p18, p19) -- line: 123
    for _, v12 in pairs(p18._array) do
        if v12 == p19 then
            return true
        end
    end

    return false
end

function t1.Get(p20, p21) -- line: 132
    return if p20._array[p21] ~= nil then p20._array[p21] else nil
end

function t1.TryGetValue(p22, p23) -- line: 139
    if p22._array[p23] == nil then
        return false, nil
    end

    return true, p22._array[p23]
end

function t1.Set(p24, p25, p26) -- line: 146
    if p24._array[p25] ~= nil then
        if p26 == nil then
            p24.count -= 1
        end

        p24._array[p25] = p26
    elseif p26 ~= nil then
        p24.count += 1
        p24._array[p25] = p26
    end
end

function t1.Add(p27, p28, p29) -- line: 162
    if p27._array[p28] ~= nil then
        error("Add the same Key on the Dictionary!")
    end

    p27.count += 1
    p27._array[p28] = p29
end

function t1.TryAdd(p30, p31, p32) -- line: 170
    if p30._array[p31] ~= nil then
        return false
    end

    p30.count += 1
    p30._array[p31] = p32

    return true
end

function t1.Remove(p33, p34) -- line: 179
    if p33._array[p34] == nil then
        error("The key is nil")
    end

    p33.count -= 1
    p33._array[p34] = nil
end

function t1.TryRemove(p35, p36) -- line: 187
    if p35._array[p36] == nil then
        return false
    end

    p35.count -= 1
    p35._array[p36] = nil

    return true
end

function t1.ValueToArray(p37) -- line: 196
    local t7 = {}

    for _, v13 in pairs(p37._array) do
        table.insert(t7, v13)
    end

    return t7
end

function t1.Clear(p38) -- line: 204
    p38.count = 0
    p38._array = {}
end

function t1.AutoChange(p39, p40, p41, p42, ...) -- line: 209
    -- upvalues: New (copy)
    if p39[p40] == nil then
        return
    end

    if type(p39[p40]) == "table" and p39[p40].AutoChange then
        p39[p40]:AutoChange(p41, p42, ...)

        return
    end

    if type(p39[p40][p41]) == "table" and p39[p40][p41].Name then
        New(p39[p40][p41].Name, true)(p42)
    end

    p39[p40][p41] = p42
end

function t1.ClientSet(p43, p44, p45, p46, ...) -- line: 223
    -- upvalues: DataMgr (copy)
    if p45 == "Change" then
        p43:ClientChange(p44, p46, ...)
    else
        if p46 and p43.TValue.Instance then
            p43.TValue:Instance(p46)
        end

        p43:Set(p45, p46)
        DataMgr:TrigerDataChangeEvent(p44, p45, p46)
    end
end

function t1.SyncSet(p47, p48, p49, p50, p51) -- line: 235
    -- upvalues: DataMgr (copy)
    p47:Set(p50, p51)
    DataMgr:TrigerDataChangeEvent(p48, p49, p50, p51)
end

function t1.ClientChange(p52, p53, p54, p55, p56) -- line: 240
    -- upvalues: DataMgr (copy)
    if p52[p54] ~= nil then
        p52:AutoChange(p54, p55, p56)
        DataMgr:TrigerItemChangeEvent(p53, p54, p55, p56)
    end
end

function t1.SyncChange(p57, p58, p59, p60, p61, p62) -- line: 248
    -- upvalues: DataMgr (copy)
    if p57[p60] ~= nil then
        p57:AutoChange(p60, p61, p62)
        DataMgr:TrigerItemChangeEvent(p58, p59, p60, p61, p62)
    end
end

return t1
