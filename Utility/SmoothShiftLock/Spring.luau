-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

function t1.new(p1, p2) -- line: 38
    -- upvalues: t1 (copy)
    p1 = p1 or 0
    p2 = p2 or os.clock

    return (setmetatable({
        _damper = 1,
        _speed = 1,
        _clock = p2,
        _time0 = p2(),
        _position0 = p1,
        _velocity0 = 0 * p1,
        _target = p1
    }, t1))
end

function t1.Impulse(p3, p4) -- line: 58
    p3.Velocity += p4
end

function t1.TimeSkip(p5, p6) -- line: 67
    local v3 = p5._clock()
    local v4, v5 = p5:_positionVelocity(v3 + p6)

    p5._position0 = v4
    p5._velocity0 = v5
    p5._time0 = v3
end

function t1.__index(p7, p8) -- line: 143
    -- upvalues: t1 (copy)
    if t1[p8] then
        return t1[p8]
    end

    if p8 == "Value" or p8 == "Position" or p8 == "p" then
        return (p7:_positionVelocity(p7._clock()))
    end

    if p8 == "Velocity" or p8 == "v" then
        local _, v6 = p7:_positionVelocity(p7._clock())

        return v6
    end

    if p8 == "Target" or p8 == "t" then
        return p7._target
    end

    if p8 == "Damper" or p8 == "d" then
        return p7._damper
    end

    if p8 == "Speed" or p8 == "s" then
        return p7._speed
    end

    if p8 == "Clock" then
        return p7._clock
    end

    error(("%q is not a valid member of Spring"):format((tostring(p8))), 2)
end

function t1.__newindex(p9, p10, p11) -- line: 165
    local v7 = p9._clock()

    if p10 ~= "Value" and p10 ~= "Position" and p10 ~= "p" then
        if p10 == "Velocity" or p10 == "v" then
            p9._position0 = p9:_positionVelocity(v7)
            p9._velocity0 = p11
            p9._time0 = v7
        elseif p10 == "Target" or p10 == "t" then
            local v8, v9 = p9:_positionVelocity(v7)

            p9._position0 = v8
            p9._velocity0 = v9
            p9._target = p11
            p9._time0 = v7
        elseif p10 == "Damper" or p10 == "d" then
            local v10, v11 = p9:_positionVelocity(v7)

            p9._position0 = v10
            p9._velocity0 = v11
            p9._damper = p11
            p9._time0 = v7
        elseif p10 == "Speed" or p10 == "s" then
            local v12, v13 = p9:_positionVelocity(v7)

            p9._position0 = v12
            p9._velocity0 = v13

            if p11 < 0 then
                p9._speed = 0
            else
                p9._speed = p11
            end

            p9._time0 = v7
        elseif p10 == "Clock" then
            local v14, v15 = p9:_positionVelocity(v7)

            p9._position0 = v14
            p9._velocity0 = v15
            p9._clock = p11
            p9._time0 = p11()
        else
            error(("%q is not a valid member of Spring"):format((tostring(p10))), 2)
        end
    else
        local _, v16 = p9:_positionVelocity(v7)

        p9._position0 = p11
        p9._velocity0 = v16
        p9._time0 = v7
    end
end

function t1._positionVelocity(p12, p13) -- line: 207
    local _position0, _velocity0, _target, _damper = p12._position0, p12._velocity0, p12._target, p12._damper
    local _speed = p12._speed
    local v17 = _speed * (p13 - p12._time0)
    local v18 = _damper * _damper
    local v19, v20, v21

    if v18 < 1 then
        v19 = math.sqrt(1 - v18)

        local v24 = math.exp(-_damper * v17) / v19

        v20 = v24 * math.cos(v19 * v17)
        v21 = v24 * math.sin(v19 * v17)
    elseif v18 == 1 then
        v20 = math.exp(-_damper * v17) / 1
        v19 = 1
        v21 = v20 * v17
    else
        v19 = math.sqrt(v18 - 1)

        local v30 = math.exp((-_damper + v19) * v17) / (2 * v19)
        local v32 = math.exp((-_damper - v19) * v17) / (2 * v19)

        v20 = v30 + v32
        v21 = v30 - v32
    end

    local v33 = v19 * v20 + _damper * v21
    local v34 = 1 - (v19 * v20 + _damper * v21)
    local v35 = v21 / _speed
    local v36 = -_speed * v21
    local v37 = _speed * v21
    local v38 = v19 * v20 - _damper * v21

    return v33 * _position0 + v34 * _target + v35 * _velocity0, v36 * _position0 + v37 * _target + v38 * _velocity0
end

return t1
