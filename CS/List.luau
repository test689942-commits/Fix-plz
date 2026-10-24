-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DataMgr, New = _G.DataMgr, _G.New
local t2 = {}
local t1 = {}

t1.PLACEHOLDER = -1

function t1.__index(p1, p2) -- line: 8
    -- upvalues: t1 (copy)
    if t1[p2] then
        return t1[p2]
    end

    if type(p2) == "number" then
        return if p1._array[p2] ~= -1 then p1._array[p2] else nil
    end

    error(("%q is not a valid member of List"):format((tostring(p2))), 2)
end

function t1.__newindex(p3, p4, p5) -- line: 22
    p3:Set(p4, p5)
end

function t1.__iter(p6) -- line: 26
    local n1 = 0

    return function() -- line: 29
        -- upvalues: p6 (copy), n1 (ref)
        local v1 = n1

        if not (v1 < p6.count) then
            return
        end

        n1 += 1

        if p6._array[n1] == -1 then
            return n1, nil
        end

        return n1, p6._array[n1]
    end
end

function t1.CreatType(p7, p8) -- line: 42
    -- upvalues: t1 (copy), t2 (copy)
    if p8 == nil then
        if p7.Type == nil then
            error("List is not Have Type")
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

        local function __index(p9, p10) -- line: 54
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

function t1.new(p11, p12) -- line: 69
    rawset(p11, "count", p12 or 0)
    rawset(p11, "_array", {})

    for i = 1, p11.count do
        p11._array[i] = -1
    end
end

function t1.Instance(p13, p14) -- line: 77
    if p14._base then
        return p14
    end

    if p14._array ~= nil then
        if p13.Type.Name == nil then
            if p14.count == nil then
                p14.count = #p14._array
            end

            return (setmetatable(p14, p13))
        end

        for v8, v9 in pairs(p14._array) do
            if v9 ~= nil then
                if v9 ~= -1 then
                    p14._array[v8] = p13.Type:Instance(v9)
                end
            else
                p14._array[v8] = -1
            end
        end
    else
        local t5 = {}

        for v6, v7 in pairs(p14) do
            t5[v6] = v7

            if p13.Type.Name ~= nil then
                t5[v6] = p13.Type:Instance(v7)
            end
        end

        table.clear(p14)
        p14._array = t5
    end

    if p14.count == nil then
        p14.count = #p14._array
    end

    setmetatable(p14, p13)

    return p14
end

function t1.IsEmpty(p15) -- line: 118
    return p15.count == 0
end

function t1.Get(p16, p17) -- line: 122
    return if p16._array[p17] ~= -1 then p16._array[p17] else nil
end

function t1.Set(p18, p19, p20) -- line: 130
    if type(p19) ~= "number" then
        error("Both arguments must be numbers")
    end

    if p19 < 1 or p18.count < p19 then
        error("The index number exceeds the boundary:count = " .. p18.count .. " inedx = " .. p19)
    end

    if p20 ~= nil then
        p18._array[p19] = p20
    else
        p18._array[p19] = -1
    end
end

function t1.Add(p21, p22) -- line: 145
    p21.count += 1

    if p22 ~= nil then
        p21._array[p21.count] = p22
    else
        p21._array[p21.count] = -1
    end
end

function t1.Inset(p23, p24, p25) -- line: 155
    if type(p25) ~= "number" then
        error("The index must be numbers")
    end

    if p25 < 1 or p23.count < p25 then
        error("The index number exceeds the boundary:count = " .. p23.count .. " inedx = " .. p25)
    end

    if p24 ~= nil then
        table.insert(p23._array, p25, p24)
    else
        table.insert(p23._array, p25, -1)
    end

    p23.count += 1
end

function t1.Remove(p26, p27) -- line: 170
    for v10, v11 in ipairs(p26._array) do
        if v11 == p27 then
            p26:RemoveAt(v10)

            return
        end
    end
end

function t1.RemoveAt(p28, p29) -- line: 180
    if type(p29) ~= "number" then
        error("The index must be numbers")
    end

    if p29 < 1 or p28.count < p29 then
        error("The index number exceeds the boundary")
    end

    table.remove(p28._array, p29)
    p28.count -= 1
end

function t1.Clear(p30) -- line: 191
    p30._array = {}
    p30.count = 0
end

function t1.AutoSet(p31, p32, p33, p34) -- line: 197
    if p32 ~= nil then
        if p33 ~= nil then
            if p31.Type.Instance then
                p31.Type:Instance(p33)
            end

            while p31.count < p32 do
                p31:Add()
            end

            p31[p32] = p33
        elseif p32 < p31.count then
            p31[p32] = nil
        elseif p32 == p31.count then
            p31:RemoveAt(p32)
        end

        p34(p32, p33)
    else
        table.sort(p33, function(p35, p36) -- line: 199
            return p35[1] > p36[1]
        end)

        for _, v12 in p33 do
            if v12[2] == -1 then
                v12[2] = nil

                if v12[1] < p31.count then
                    p31[v12[1]] = nil
                elseif v12[1] == p31.count then
                    p31:RemoveAt(v12[1])
                end
            else
                if v12[2] and p31.Type.Instance then
                    p31.Type:Instance(v12[2])
                end

                while v12[1] > p31.count do
                    p31:Add()
                end

                p31[v12[1]] = v12[2]
            end

            p34(v12[1], v12[2])
        end
    end
end

function t1.AutoChange(p37, p38, p39, p40, ...) -- line: 239
    -- upvalues: New (copy)
    if p37[p38] == nil then
        return
    end

    if type(p37[p38]) == "table" and p37[p38].AutoChange then
        p37[p38]:AutoChange(p39, p40, ...)

        return
    end

    if type(p37[p38][p39]) == "table" and p37[p38][p39].Name then
        New(p37[p38][p39].Name, true)(p40)
    end

    p37[p38][p39] = p40
end

function t1.ClientSet(p41, p42, p43, p44, ...) -- line: 253
    -- upvalues: DataMgr (copy)
    if p43 == "Change" then
        p41:ClientChange(p42, p44, ...)
    else
        p41:AutoSet(p43, p44, function(p45, p46) -- line: 258
            -- upvalues: p42 (copy), DataMgr (copy)
            DataMgr:TrigerDataChangeEvent(p42, p45, p46)
        end)
    end
end

function t1.ClientChange(p47, p48, p49, p50, p51, ...) -- line: 263
    -- upvalues: DataMgr (copy)
    p47:AutoChange(p49, p50, p51, ...)
    DataMgr:TrigerItemChangeEvent(p48, p49, p50, p51)
end

function t1.SyncSet(p52, p53, p54, p55, p56) -- line: 269
    -- upvalues: DataMgr (copy)
    while p52.count < p55 do
        p52:Add()
    end

    if p56 ~= nil or p52.count ~= p55 then
        p52[p55] = p56
    else
        p52:RemoveAt(p55)
    end

    DataMgr:TrigerDataChangeEvent(p53, p54, p55, p56)
end

function t1.SyncAdd(p57, p58, p59, p60) -- line: 281
    -- upvalues: DataMgr (copy)
    p57:Add(p60)
    DataMgr:TrigerDataChangeEvent(p58, p59, p57.count, p60)
end

function t1.AutoRemove(p61, p62, p63) -- line: 286
    if type(p62) == "table" then
        table.sort(p62, function(p64, p65) -- line: 288
            return p65 < p64
        end)

        local t6 = {}

        for _, v15 in p62 do
            if not (p61.count < v15) then
                if v15 == p61.count then
                    p61:RemoveAt(p61.count)
                    t6[v15] = -1
                else
                    p61[v15] = p61[p61.count]
                    t6[v15] = p61[v15]
                    t6[p61.count] = -1
                    p61:RemoveAt(p61.count)
                end
            end
        end

        local t7 = {}

        for v16, v17 in t6 do
            table.insert(t7, {
                v16,
                v17
            })
        end

        p63(nil, t7)
    elseif not (p61.count < p62) then
        if p62 == p61.count then
            p61:RemoveAt(p61.count)
            p63(p61.count + 1, nil)
        else
            p61[p62] = p61[p61.count]
            p61:RemoveAt(p61.count)
            p63(nil, {
                {
                    p62,
                    p61[p62]
                },
                {
                    p61.count + 1,
                    -1
                }
            })
        end
    end
end

function t1.SyncRemove(p66, p67, p68, p69, p70) -- line: 325
    -- upvalues: DataMgr (copy)
    if type(p69) ~= "table" and p70 ~= nil and p70 < p66[p69].amount then
        p66:SyncChange(p67, p68, p69, "amount", p66[p69].amount - p70)
    else
        p66:AutoRemove(p69, function(p71, p72) -- line: 329
            -- upvalues: p67 (copy), p68 (copy), DataMgr (copy)
            DataMgr:TrigerDataChangeEvent(p67, p68, p71, p72)
        end)
    end
end

function t1.SyncChange(p73, p74, p75, p76, p77, p78, ...) -- line: 335
    -- upvalues: DataMgr (copy)
    p73:AutoChange(p76, p77, p78, ...)
    DataMgr:TrigerItemChangeEvent(p74, p75, p76, p77, p78)
end

return t1
