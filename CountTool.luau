-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local t3 = {}
local t2 = {}

t2.Attribute = function(p1, p2, p3, p4) -- line: 7
    -- upvalues: t3 (copy)
    return t3[p1](p2, p3, p4)
end

t3.atk = function(p5, p6, p7) -- line: 11
    return p5.atk * (1 + p6.potential * 0.8) * (1 + p6.atkMul) * (p7 ^ 0.8 * 0.2 + 1)
end

t3.atkCD = function(p8, p9, p10) -- line: 15
    return p8.atkCD * (1 + p9.atkCDMul) - math.min(1, math.floor(p10 * 0.1) / 10)
end

t3.range = function(p11, p12, p13) -- line: 19
    return p11.range * (1 + p12.rangeMul) + math.min(5, (math.floor(p13 * 0.1)))
end

t3.coin = function(p14, _, p16) -- line: 23
    return p14.coin * (p16 ^ 0.8 * 0.2 + 1)
end

t3.hp = function(p17, _, p19) -- line: 27
    return p17.hp * (p19 ^ 0.8 * 0.2 + 1)
end

t3.combat = function(p20, _, p22) -- line: 31
    return p20.atkAdd * (p22 ^ 0.8 * 0.1 + 1)
end

t3.cost = function(p23, _, p25) -- line: 35
    return p23.rarity * 5 * 1.35 ^ p25
end

t3.enchantCost = function(p26, p27, _) -- line: 39
    return p26.rarity * 20 * 1.5 ^ p27.enchantCount
end

t3.dps = function(p29, p30, p31) -- line: 43
    -- upvalues: t3 (copy)
    return t3.atk(p29, p30, p31) / t3.atkCD(p29, p30, p31) * t3.range(p29, p30, p31) / 5
end

local t4 = {
    "D",
    "C",
    "B",
    "A",
    "A+",
    "S",
    "S+"
}
local t5 = {
    0, -0.02, -0.05, -0.08, -0.12, -0.15, -0.2
}
local t6 = {
    0, 0.02, 0.05, 0.08, 0.12, 0.15, 0.2
}
local t8 = { 0, 0.05, 0.1, 0.15, 0.25, 0.35, 0.5 }
local t7 = {
    atk = function(p32) -- atk | line: 62
        -- upvalues: t4 (copy), t8 (copy)
        for v7, v8 in t8 do
            if p32.atkMul < v8 then
                return t4[v7], v7
            end
        end
    end,
    atkCD = function(p33) -- atkCD | line: 69
        -- upvalues: t4 (copy), t5 (copy)
        for v9, v10 in t5 do
            if v10 < p33.atkCDMul then
                return t4[v9], v9
            end
        end
    end,
    range = function(p34) -- range | line: 76
        -- upvalues: t4 (copy), t6 (copy)
        for v11, v12 in t6 do
            if p34.rangeMul < v12 then
                return t4[v11], v11
            end
        end
    end
}

t2.AttQuality = function(p35, p36) -- line: 85
    -- upvalues: t7 (copy)
    return t7[p35](p36)
end

t2.petIndex = function(p37) -- line: 91
    return (math.clamp(math.ceil((p37.atk + p37.def + p37.speed + p37.hp) / 60), 1, 7))
end

function t1.new(_, p39) -- line: 96
    -- upvalues: t2 (copy)
    return t2[p39]
end

return t1
