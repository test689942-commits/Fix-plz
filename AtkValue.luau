-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return {
    atk = 0,
    mul = 1,
    magicMul = 0,
    ex_physics = 0,
    ex_magic = 0,
    ex_physics_per = 0,
    ex_magic_per = 0,
    ex_physics_add = 0,
    ex_magic_add = 0,
    atk_per = 1,
    add_physics_per = 0,
    add_magic_per = 0,
    def = 0,
    physics_resistance = 0,
    magic_resistance = 0,
    atk_vulnerable = 1,
    crit = 0,
    crit_damage = 0,
    dizziness_probability = 0,
    dizziness_time = 0,
    isMagic = false,
    isDie = false,
    isHurt = true,
    isDizziness = false,
    isCrit = false,
    atkType = "skill",
    consumeHp = 0,
    new = function(p1, p2, p3, p4) -- new | line: 38
        if typeof(p2) == "number" then
            p1.atk = p2
        else
            p1({
                atk = p2.atk(),
                atk_per = p2.atk_per(),
                ex_physics = p2.ex_physics(),
                ex_magic = p2.ex_magic(),
                ex_physics_per = p2.ex_physics_per(),
                ex_magic_per = p2.ex_magic_per(),
                add_physics_per = p2.add_physics_per(),
                add_magic_per = p2.add_magic_per(),
                crit = p2.crit(),
                crit_damage = p2.crit_damage(),
                dizziness_probability = p2.dizziness_probability(),
                dizziness_time = p2.dizziness_time()
            })
        end

        p1.mul = p3
        p1.isMagic = p4
    end,
    GetValue = function(p5) -- GetValue | line: 61
        if not p5.isHurt then
            return 0
        end

        if p5.isMagic then
            local v1 = p5.ex_physics * (1 + p5.add_physics_per) * p5.atk_per
            local v2 = (p5.atk + p5.ex_magic) * (1 + p5.add_magic_per) * p5.atk_per

            if v1 == 0 and v2 == 0 then
                return 0
            end

            local v3 = v1 + v2
            local v4 = v1 + (v3 * p5.ex_physics_per + p5.ex_physics_add)
            local v5 = v2 + (v3 * p5.ex_magic_per + p5.ex_magic_add)

            return (v4 * (1 - (p5.def > 0 and p5.def / (p5.def + v4 * 5) or 0)) * (1 - p5.physics_resistance) + v5 * (1 - p5.magic_resistance)) * p5.mul * (p5.isCrit and p5.crit_damage + 2 or 1) * math.max(p5.atk_vulnerable, 0.01)
        end

        local v7 = (p5.atk + p5.ex_physics) * (1 + p5.add_physics_per) * p5.atk_per
        local v9 = p5.ex_magic * (1 + p5.add_magic_per) * p5.atk_per + v7 * math.min(p5.magicMul, 1)
        local v11 = v7 * math.max(1 - p5.magicMul, 0)

        if v11 == 0 and v9 == 0 then
            return 0
        end

        local v12 = v11 + v9
        local v13 = v11 + (v12 * p5.ex_physics_per + p5.ex_physics_add)
        local v14 = v9 + (v12 * p5.ex_magic_per + p5.ex_magic_add)

        return (v13 * (1 - (p5.def > 0 and p5.def / (p5.def + v13 * 5) or 0)) * (1 - p5.physics_resistance) + v14 * (1 - p5.magic_resistance)) * p5.mul * (p5.isCrit and p5.crit_damage + 2 or 1) * math.max(p5.atk_vulnerable, 0.01)
    end,
    GetValueDetails = function(p6) -- GetValueDetails | line: 93
        if p6.isMagic then
            local v16 = p6.ex_physics * (1 + p6.add_physics_per) * p6.atk_per
            local v17 = (p6.atk + p6.ex_magic) * (1 + p6.add_magic_per) * p6.atk_per

            if v16 == 0 and v17 == 0 then
                return 0, 0, 0
            end

            local v18 = v16 + v17
            local v19 = v16 + (v18 * p6.ex_physics_per + p6.ex_physics_add)
            local v20 = v17 + (v18 * p6.ex_magic_per + p6.ex_magic_add)
            local v21 = p6.def > 0 and p6.def / (p6.def + v19 * 5) or 0
            local v22 = p6.mul * math.max(p6.atk_vulnerable, 0.01) * (p6.isCrit and p6.crit_damage + 2 or 1)
            local v23 = v19 * ((1 - p6.physics_resistance) * (1 - v21) * v22)
            local v24 = v20 * ((1 - p6.magic_resistance) * v22)

            return v23 + v24, v23, v24
        end

        local v25 = (p6.atk + p6.ex_physics) * (1 + p6.add_physics_per) * p6.atk_per
        local v27 = p6.ex_magic * (1 + p6.add_magic_per) * p6.atk_per + v25 * math.min(p6.magicMul, 1)
        local v29 = v25 * math.max(1 - p6.magicMul, 0)

        if v29 == 0 and v27 == 0 then
            return 0, 0, 0
        end

        local v30 = v29 + v27
        local v31 = v29 + (v30 * p6.ex_physics_per + p6.ex_physics_add)
        local v32 = v27 + (v30 * p6.ex_magic_per + p6.ex_magic_add)
        local v33 = p6.def > 0 and p6.def / (p6.def + v31 * 5) or 0
        local v34 = p6.mul * math.max(p6.atk_vulnerable, 0.01) * (p6.isCrit and p6.crit_damage + 2 or 1)
        local v35 = v31 * ((1 - p6.physics_resistance) * (1 - v33) * v34)
        local v36 = v32 * ((1 - p6.magic_resistance) * v34)

        return v35 + v36, v35, v36
    end
}
