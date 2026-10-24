-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local New = _G.New

return {
    value = 0,
    current = 0,
    ratio = 1,
    new = function(p1, p2, p3) -- new | line: 10
        -- upvalues: New (copy)
        p1.value = p2
        p1.current = p2
        p1.change = New("CS.Action")()

        if p3 then
            p1.change:Add(p3)
        end
    end,
    GetValue = function(p4) -- GetValue | line: 19
        return p4.current
    end,
    SetValue = function(p5, p6) -- SetValue | line: 23
        local current = p5.current

        p5.value = p6
        p5.current = p5.value / p5.ratio
        p5.change:Invoke(p5.current, current)

        return p5
    end,
    AddValue = function(p7, p8) -- AddValue | line: 31
        local current = p7.current

        if p7.min then
            p7.value = math.clamp(p7.value + p8, p7.min, p7.max) or p7.value + p8
        else
            p7.value += p8
        end

        p7.current = p7.value / p7.ratio
        p7.change:Invoke(p7.current, current)

        return p7
    end,
    SetLimit = function(p9, p10, p11) -- SetLimit | line: 39
        p9.min = p10
        p9.max = p11

        if p9.current < p10 or p11 < p9.current then
            local current = p9.current

            p9.value = math.clamp(p9.value, p10, p11)
            p9.current = p9.value / p9.ratio
            p9.change:Invoke(p9.current, current)
        end

        return p9
    end,
    SetRatio = function(p12, p13) -- SetRatio | line: 51
        p12.ratio = p13
        p12.current = p12.value / p12.ratio

        return p12
    end,
    IsMax = function(p14) -- IsMax | line: 57
        return not p14.max or p14.current >= p14.max
    end,
    IsMin = function(p15) -- IsMin | line: 61
        return not p15.min or p15.current <= p15.min
    end,
    __add = function(p16, p17) -- line: 65
        if type(p16) ~= "table" then
            return p16 + p17.current
        end

        p16:AddValue(p17)

        return p16
    end,
    __sub = function(p18, p19) -- line: 74
        if type(p18) ~= "table" then
            return p18 - p19.current
        end

        p18:AddValue(-p19)

        return p18
    end,
    __mul = function(p20, p21) -- line: 83
        if type(p20) ~= "table" then
            return p20 * p21.current
        end

        p20:SetValue(p20.current * p21)

        return p20
    end,
    __div = function(p22, p23) -- line: 92
        if type(p22) ~= "table" then
            return p22 / p23.current
        end

        p22:SetValue(p22.current / p23)

        return p22
    end,
    __mod = function(p24, p25) -- line: 101
        if type(p24) ~= "table" then
            return p24 % p25.current
        end

        p24:SetValue(p24.current % p25)

        return p24
    end,
    __pow = function(p26, p27) -- line: 110
        if type(p26) ~= "table" then
            return p26 ^ p27.current
        end

        p26:SetValue(p26.current ^ p27)

        return p26
    end,
    __unm = function(p28) -- line: 119
        return -p28.current
    end,
    __eq = function(p29, p30) -- line: 123
        if type(p29) == "table" then
            return p29.current == p30
        end

        return p29 == p30.current
    end,
    __lt = function(p31, p32) -- line: 131
        print("lt")

        if type(p31) == "table" then
            return p31.current < p32
        end

        return p31 < p32.current
    end,
    __le = function(p33, p34) -- line: 140
        print("le")

        if type(p33) == "table" then
            return p34 < p33.current
        end

        return p34.current < p33
    end,
    __call = function(p35) -- line: 149
        return p35.current
    end,
    __tostring = function(p36) -- line: 153
        return (tostring(p36.current))
    end
}
