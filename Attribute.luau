-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local New = _G.New

return {
    baseValue = 0,
    value = 0,
    valueAdd = 0,
    valueMul = 1,
    changeMul = 1,
    convertValue = 0,
    current = 0,
    ratio = 1,
    new = function(p1, p2, p3) -- new | line: 21
        -- upvalues: New (copy)
        p1.baseValue = p2
        p1.current = p2
        p1.value = p2
        p1.mulList = {}
        p1.onValueChange = New("CS.Action")()
        p1.change = New("CS.Action")()

        if p3 then
            p1.change:Add(p3)
        end
    end,
    GetValue = function(p4, p5) -- GetValue | line: 33
        if p5 == nil then
            return p4.current
        end

        if not p4.min then
            return ((p5 + p4.valueAdd * p4.changeMul) * p4.valueMul * p4.changeMul + p4.convertValue) / p4.ratio
        end

        return math.clamp((p5 + p4.valueAdd * p4.changeMul) * p4.valueMul * p4.changeMul + p4.convertValue, p4.min, p4.max) / p4.ratio
    end,
    SetValue = function(p6, p7) -- SetValue | line: 45
        local current = p6.current

        p6.baseValue = p7
        p6.value = (p6.baseValue + p6.valueAdd * p6.changeMul) * p6.valueMul * p6.changeMul
        p6.current = (if p6.min then math.clamp(p6.value + p6.convertValue, p6.min, p6.max) or p6.value + p6.convertValue else p6.value + p6.convertValue) / p6.ratio
        p6.onValueChange:Invoke(p6)
        p6.change:Invoke(p6.current, current)

        return p6
    end,
    AddBaseValue = function(p8, p9) -- AddBaseValue | line: 55
        local current = p8.current

        p8.baseValue += p9
        p8.value = (p8.baseValue + p8.valueAdd * p8.changeMul) * p8.valueMul * p8.changeMul
        p8.current = (if p8.min then math.clamp(p8.value + p8.convertValue, p8.min, p8.max) or p8.value + p8.convertValue else p8.value + p8.convertValue) / p8.ratio
        p8.onValueChange:Invoke(p8)
        p8.change:Invoke(p8.current, current)

        return p8
    end,
    AddValue = function(p10, p11) -- AddValue | line: 65
        local current = p10.current

        p10.valueAdd += p11
        p10.value = (p10.baseValue + p10.valueAdd * p10.changeMul) * p10.valueMul * p10.changeMul
        p10.current = (if p10.min then math.clamp(p10.value + p10.convertValue, p10.min, p10.max) or p10.value + p10.convertValue else p10.value + p10.convertValue) / p10.ratio
        p10.onValueChange:Invoke(p10)
        p10.change:Invoke(p10.current, current)

        return p10
    end,
    SetValueMul = function(p12, p13, p14) -- SetValueMul | line: 75
        p14 = p14 or 1

        if p12.mulList[p14] ~= nil and p12.mulList[p14] == p13 then
            return
        end

        local current = p12.current

        p12.mulList[p14] = p13
        p12.valueMul = 1

        for _, v9 in p12.mulList do
            p12.valueMul *= v9
        end

        p12.value = (p12.baseValue + p12.valueAdd * p12.changeMul) * p12.valueMul * p12.changeMul
        p12.current = (if p12.min then math.clamp(p12.value + p12.convertValue, p12.min, p12.max) or p12.value + p12.convertValue else p12.value + p12.convertValue) / p12.ratio
        p12.onValueChange:Invoke(p12)
        p12.change:Invoke(p12.current, current)

        return p12
    end,
    AddValueMul = function(p15, p16, p17) -- AddValueMul | line: 93
        local current = p15.current

        p17 = p17 or 1

        if p15.mulList[p17] ~= nil then
            p15.mulList[p17] += p16
        else
            p15.mulList[p17] = 1 + p16
        end

        p15.valueMul = 1

        for _, v13 in p15.mulList do
            p15.valueMul *= v13
        end

        p15.value = (p15.baseValue + p15.valueAdd * p15.changeMul) * p15.valueMul * p15.changeMul
        p15.current = (if p15.min then math.clamp(p15.value + p15.convertValue, p15.min, p15.max) or p15.value + p15.convertValue else p15.value + p15.convertValue) / p15.ratio
        p15.onValueChange:Invoke(p15)
        p15.change:Invoke(p15.current, current)

        return p15
    end,
    AddChangeMul = function(p18, p19) -- AddChangeMul | line: 112
        local current = p18.current

        p18.changeMul += p19
        p18.value = (p18.baseValue + p18.valueAdd * p18.changeMul) * p18.valueMul * p18.changeMul
        p18.current = (if p18.min then math.clamp(p18.value + p18.convertValue, p18.min, p18.max) or p18.value + p18.convertValue else p18.value + p18.convertValue) / p18.ratio
        p18.onValueChange:Invoke(p18)
        p18.change:Invoke(p18.current, current)

        return p18
    end,
    AddConvert = function(p20, p21) -- AddConvert | line: 122
        local current = p20.current

        p20.convertValue += p21
        p20.current = (if p20.min then math.clamp(p20.value + p20.convertValue, p20.min, p20.max) or p20.value + p20.convertValue else p20.value + p20.convertValue) / p20.ratio
        p20.change:Invoke(p20.current, current)

        return p20
    end,
    SetLimit = function(p22, p23, p24) -- SetLimit | line: 130
        p22.min = p23
        p22.max = p24

        if p23 ~= nil then
            if p22.current * p22.ratio < p23 or p24 < p22.current * p22.ratio then
                local current = p22.current

                p22.current = math.clamp(p22.current, p23 / p22.ratio, p24 / p22.ratio)
                p22.onValueChange:Invoke(p22)
                p22.change:Invoke(p22.current, current)
            end
        else
            local current = p22.current

            p22.current = (p22.value + p22.convertValue) / p22.ratio
            p22.onValueChange:Invoke(p22)
            p22.change:Invoke(p22.current, current)
        end

        return p22
    end,
    SetRatio = function(p25, p26) -- SetRatio | line: 149
        p25.ratio = p26
        p25.current = (if p25.min then math.clamp(p25.value + p25.convertValue, p25.min, p25.max) or p25.value + p25.convertValue else p25.value + p25.convertValue) / p25.ratio

        return p25
    end,
    __add = function(p27, p28) -- line: 155
        if type(p27) == "table" then
            return p27.current + p28
        end

        return p27 + p28.current
    end,
    __sub = function(p29, p30) -- line: 163
        if type(p29) == "table" then
            return p29.current - p30
        end

        return p29 - p30.current
    end,
    __mul = function(p31, p32) -- line: 171
        if type(p31) == "table" then
            return p31.current * p32
        end

        return p31 * p32.current
    end,
    __div = function(p33, p34) -- line: 179
        if type(p33) == "table" then
            return p33.current / p34
        end

        return p33 / p34.current
    end,
    __mod = function(p35, p36) -- line: 187
        if type(p35) == "table" then
            return p35.current % p36
        end

        return p35 % p36.current
    end,
    __pow = function(p37, p38) -- line: 195
        if type(p37) == "table" then
            return p37.current ^ p38
        end

        return p37 ^ p38.current
    end,
    __unm = function(p39) -- line: 203
        return -p39.current
    end,
    __eq = function(p40, p41) -- line: 207
        if type(p40) == "table" then
            return p40.current == p41
        end

        return p40 == p41.current
    end,
    __lt = function(p42, p43) -- line: 215
        if type(p42) == "table" then
            return p42.current < p43
        end

        return p42 < p43.current
    end,
    __le = function(p44, p45) -- line: 223
        if type(p44) == "table" then
            return p45 < p44.current
        end

        return p45.current < p44
    end,
    __call = function(p46) -- line: 231
        return p46.current
    end,
    __tostring = function(p47) -- line: 235
        return (tostring(p47.current))
    end
}
