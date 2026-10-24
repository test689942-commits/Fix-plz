-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _ = tick
local _ = setmetatable
local sin, cos, _, _ = math.sin, math.cos, math.atan2, math.tan
local _os = os
local t1 = {
    spring = {}
}

function t1.spring.new(p1) -- line: 14
    -- upvalues: sin (copy), cos (copy), _os (copy)
    local v1, v2
    local n1 = 0
    local n2 = 0
    local v3 = _os.clock()

    if p1 then
        v1 = p1.d
        v2 = p1.s
    else
        v1 = 1
        v2 = 1
    end

    local n3 = 0
    local n4 = 0

    local function position() -- line: 34
        -- upvalues: n1 (ref), n2 (ref), v3 (ref), v1 (ref), v2 (ref), n3 (ref), n4 (ref), sin (copy), cos (copy), _os (copy)
        local v4 = _os.clock()
        local v5 = v2 * (v4 - v3)

        if v1 == 1 then
            return (n1 + n2 * v5) / 2.718281828459045 ^ v5 + n3
        end

        return (n1 * cos(n4 * v5) + n2 * sin(n4 * v5)) / 2.718281828459045 ^ (v1 * v5) + n3
    end

    local function velocity() -- line: 44
        -- upvalues: n1 (ref), n2 (ref), v3 (ref), v1 (ref), v2 (ref), n4 (ref), sin (copy), cos (copy), _os (copy)
        local v13 = _os.clock()
        local v15 = v2
        local v14 = v15 * (v13 - v3)

        if v1 == 1 then
            local v16 = n2

            return (v16 * (v2 - v14) - n1) / 2.718281828459045 ^ v14
        end

        local v17 = v2
        local v19 = n4
        local v20 = v19 * n2
        local v21 = n1
        local v23 = (v20 - v21 * v1) * cos(n4 * v14)
        local v25 = n4
        local v26 = v25 * n1
        local v27 = n2

        return v17 * (v23 - (v26 + v27 * v1) * sin(n4 * v14)) / 2.718281828459045 ^ (v1 * v14)
    end

    return {
        target = function(p2, p3, p4) -- target | line: 55
            -- upvalues: n1 (ref), n2 (ref), v3 (ref), v1 (ref), v2 (ref), n3 (ref), n4 (ref), velocity (copy), sin (copy), cos (copy), _os (copy)
            p4 = p4 or v2

            local v30 = _os.clock()
            local v32 = v2
            local v31 = v32 * (v30 - v3)
            local v33

            if v1 == 1 then
                local v34 = n1

                v33 = (v34 + n2 * v31) / 2.718281828459045 ^ v31 + n3
            else
                local v35 = n1
                local v37 = v35 * cos(n4 * v31)
                local v38 = n2

                v33 = (v37 + v38 * sin(n4 * v31)) / 2.718281828459045 ^ (v1 * v31) + n3
            end

            local v40 = velocity() / p4

            v1 = p3 or v1
            v3 = _os.clock()
            n3 = p2
            n1 = v33 - n3

            if v1 == 1 then
                n2 = v40 + n1
            else
                local v41 = v1

                n4 = (1 - v41 * v1) ^ 0.5

                local v42 = n1

                n2 = (v40 + v42 * v1) / n4
            end

            v2 = p4
        end,
        impulse = function(p5) -- impulse | line: 71
            -- upvalues: n1 (ref), n2 (ref), v3 (ref), v1 (ref), v2 (ref), n3 (ref), n4 (ref), velocity (copy), sin (copy), cos (copy), _os (copy)
            local v43 = _os.clock()
            local v45 = v2
            local v44 = v45 * (v43 - v3)
            local v46

            if v1 == 1 then
                local v47 = n1

                v46 = (v47 + n2 * v44) / 2.718281828459045 ^ v44 + n3
            else
                local v48 = n1
                local v50 = v48 * cos(n4 * v44)
                local v51 = n2

                v46 = (v50 + v51 * sin(n4 * v44)) / 2.718281828459045 ^ (v1 * v44) + n3
            end

            local v53 = (velocity() + p5) / v2

            v3 = _os.clock()
            n1 = v46 - n3

            if v1 == 1 then
                n2 = v53 + n1
            else
                local v54 = v1

                n4 = (1 - v54 * v1) ^ 0.5

                local v55 = n1

                n2 = (v53 + v55 * v1) / n4
            end
        end,
        speed = function(p6) -- speed | line: 83
            -- upvalues: v2 (ref)
            v2 = p6
        end,
        p = position,
        v = velocity
    }
end

return t1
