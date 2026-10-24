-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local v1, v2 = _G.Genericity(1)
local DataMgr, New, Type = _G.DataMgr, _G.New, _G.Type

v1.equipCount = 1
v1.bagCount = 50
v1.equip = Type("CS.List")(v2)
v1.bag = Type("CS.List")(v2)

function v1.new(p1, p2, p3) -- line: 11
    -- upvalues: New (copy)
    p1.equipCount = p2
    p1.bagCount = p3
    p1.equip = New(p1.equip)(p2)
    p1.bag = New(p1.bag)()
end

function v1.AutoChange(p4, p5, p6, p7, p8, ...) -- line: 18
    if p5 == "equip" or p5 == "bag" then
        p4[p5]:AutoChange(p6, p7, p8, ...)
    else
        p4[p5][p6][p7] = p8
    end
end

function v1.ClientSet(p9, p10, p11, p12, p13, ...) -- line: 26
    -- upvalues: DataMgr (copy)
    if p11 == "Change" then
        p9:ClientChange(p10, p12, p13, ...)
    elseif p11 == "equip" or p11 == "bag" then
        p9[p11]:AutoSet(p12, p13, function(p14, p15) -- line: 30
            -- upvalues: p10 (copy), p11 (copy), DataMgr (copy)
            DataMgr:TrigerDataChangeEvent(p10, p11, p14, p15)
        end)
    else
        p9[p11] = p12
        DataMgr:TrigerDataChangeEvent(p10, p11, p12)
    end
end

function v1.ClientChange(p16, p17, p18, p19, p20, p21, ...) -- line: 39
    -- upvalues: DataMgr (copy)
    p16:AutoChange(p18, p19, p20, p21, ...)
    DataMgr:TrigerItemChangeEvent(p17, p18, p19, p20, p21, ...)
end

function v1.SyncSet(p22, p23, p24, p25, p26, p27) -- line: 44
    -- upvalues: DataMgr (copy)
    p22[p25]:AutoSet(p26, p27, function(p28, p29) -- line: 45
        -- upvalues: p23 (copy), p24 (copy), p25 (copy), DataMgr (copy)
        DataMgr:TrigerDataChangeEvent(p23, p24, p25, p28, p29)
    end)
end

function v1.SyncAdd(p30, p31, p32, p33, p34) -- line: 50
    -- upvalues: DataMgr (copy)
    p30[p33]:Add(p34)
    DataMgr:TrigerDataChangeEvent(p31, p32, p33, p30[p33].count, p34)
end

function v1.SyncRemove(p35, p36, p37, p38, p39, p40) -- line: 55
    -- upvalues: DataMgr (copy)
    if p40 == nil or not (p40 < p35[p38][p39].amount) then
        p35[p38]:AutoRemove(p39, function(p41, p42) -- line: 59
            -- upvalues: p36 (copy), p37 (copy), p38 (copy), DataMgr (copy)
            DataMgr:TrigerDataChangeEvent(p36, p37, p38, p41, p42)
        end)
    else
        p35[p38]:SyncChange(p36, p37, p39, "amount", p35[p38][p39].amount - p40)
    end
end

function v1.SyncChange(p43, p44, p45, p46, p47, p48, p49, ...) -- line: 65
    -- upvalues: DataMgr (copy)
    p43:AutoChange(p46, p47, p48, p49, ...)
    DataMgr:TrigerItemChangeEvent(p44, p45, p46, p47, p48, p49, ...)
end

return v1
