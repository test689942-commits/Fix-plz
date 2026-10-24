-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DataMgr = _G.DataMgr
local t1 = {
    common = { 1, 0 },
    elite = { 1, 1 },
    epic = { 2, 1 },
    legend = { 3, 1 }
}
local t2 = {
    1, 2, 4, 6, 10, 15, 30
}

return function(p1) -- line: 14
    -- upvalues: DataMgr (copy), t1 (copy), t2 (copy)
    local Config = DataMgr:GetConfig("ItemData", p1.id)
    local v1 = p1.level * 0.1
    local v2 = t1[p1.quality]
    local v3, v4

    if not p1.modifier then
        v4 = 0
        v3 = 0

        return (Config.price * (v2[1] + v3 * v2[2]) + v4) * v1 * (1 + p1.reinforce / 100)
    end

    local n1 = 0
    local n2 = 0

    v4 = 0
    v3 = 0

    for v5, v6 in p1.modifier do
        if v5 == "prefix" or v5 == "suffix" then
            n2 += #v6
        end

        v3 = n2

        for _, v8 in v6 do
            n1 += DataMgr:GetConfig("ModifierData", v8.id).price * t2[v8.quality] * (1 + v8.value * 0.1)
        end

        v4 = n1
    end

    return (Config.price * (v2[1] + v3 * v2[2]) + v4) * v1 * (1 + p1.reinforce / 100)
end
