-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

local function linear(p1, p2, p3, p4) -- line: 5
    return p3 * p1 / p4 + p2
end

t1.Linear = function(p5) -- line: 9
    return 1 * p5 / 1 + 0
end

local function constant(p6, _, _, p9) -- line: 13
    if p6 == p9 then
        return 1
    end

    return 0
end

t1.Constant = function(p10) -- line: 17
    if p10 == 1 then
        return 1
    end

    return 0
end

local function inSine(p11, p12, p13, p14) -- line: 21
    return -p13 * math.cos(p11 / p14 * 1.5707963267948966) + p13 + p12
end

local function outSine(p15, p16, p17, p18) -- line: 24
    return p17 * math.sin(p15 / p18 * 1.5707963267948966) + p16
end

local function inOutSine(p19, p20, p21, p22) -- line: 27
    return -p21 / 2 * (math.cos(3.141592653589793 * p19 / p22) - 1) + p20
end

local function outInSine(p23, p24, p25, p26) -- line: 30
    if p23 < p26 / 2 then
        local v6 = p23 * 2

        return p25 / 2 * math.sin(v6 / p26 * 1.5707963267948966) + p24
    end

    local v9 = p23 * 2 - p26
    local v10 = p24 + p25 / 2
    local v11 = p25 / 2

    return -v11 * math.cos(v9 / p26 * 1.5707963267948966) + v11 + v10
end

t1.SineIn = function(p27) -- line: 38
    return -1 * math.cos(p27 / 1 * 1.5707963267948966) + 1 + 0
end

t1.SineOut = function(p28) -- line: 41
    return 1 * math.sin(p28 / 1 * 1.5707963267948966) + 0
end

t1.SineInOut = function(p29) -- line: 44
    return -0.5 * (math.cos(3.141592653589793 * p29 / 1) - 1) + 0
end

t1.SineOutIn = function(p30) -- line: 47
    if p30 < 0.5 then
        return 0.5 * math.sin(p30 * 2 / 1 * 1.5707963267948966) + 0
    end

    return -0.5 * math.cos((p30 * 2 - 1) / 1 * 1.5707963267948966) + 0.5 + 0.5
end

local function inQuad(p31, p32, p33, p34) -- line: 51
    return p33 * math.pow(p31 / p34, 2) + p32
end

local function outQuad(p35, p36, p37, p38) -- line: 55
    local v20 = p35 / p38

    return -p37 * v20 * (v20 - 2) + p36
end

local function inOutQuad(p39, p40, p41, p42) -- line: 59
    local v21 = p39 / p42 * 2

    if v21 < 1 then
        return p41 / 2 * math.pow(v21, 2) + p40
    end

    return -p41 / 2 * ((v21 - 1) * (v21 - 3) - 1) + p40
end

local function outInQuad(p43, p44, p45, p46) -- line: 67
    if p43 < p46 / 2 then
        local v22 = p43 * 2
        local v23 = p45 / 2
        local v24 = v22 / p46

        return -v23 * v24 * (v24 - 2) + p44
    end

    local v25 = p43 * 2 - p46
    local v26 = p44 + p45 / 2

    return p45 / 2 * math.pow(v25 / p46, 2) + v26
end

t1.QuadIn = function(p47) -- line: 75
    return 1 * math.pow(p47 / 1, 2) + 0
end

t1.QuadOut = function(p48) -- line: 78
    local v30 = p48 / 1

    return -1 * v30 * (v30 - 2) + 0
end

t1.QuadInOut = function(p49) -- line: 81
    local v31 = p49 / 1 * 2

    if v31 < 1 then
        return 0.5 * math.pow(v31, 2) + 0
    end

    return -0.5 * ((v31 - 1) * (v31 - 3) - 1) + 0
end

t1.QuadOutIn = function(p50) -- line: 84
    if p50 < 0.5 then
        local v32 = p50 * 2 / 1

        return -0.5 * v32 * (v32 - 2) + 0
    end

    return 0.5 * math.pow((p50 * 2 - 1) / 1, 2) + 0.5
end

local function inCubic(p51, p52, p53, p54) -- line: 88
    return p53 * math.pow(p51 / p54, 3) + p52
end

local function outCubic(p55, p56, p57, p58) -- line: 92
    return p57 * (math.pow(p55 / p58 - 1, 3) + 1) + p56
end

local function inOutCubic(p59, p60, p61, p62) -- line: 96
    local v36 = p59 / p62 * 2

    if v36 < 1 then
        return p61 / 2 * v36 * v36 * v36 + p60
    end

    local v37 = v36 - 2

    return p61 / 2 * (v37 * v37 * v37 + 2) + p60
end

local function outInCubic(p63, p64, p65, p66) -- line: 105
    if p63 < p66 / 2 then
        local v38 = p63 * 2

        return p65 / 2 * (math.pow(v38 / p66 - 1, 3) + 1) + p64
    end

    local v41 = p63 * 2 - p66
    local v42 = p64 + p65 / 2

    return p65 / 2 * math.pow(v41 / p66, 3) + v42
end

t1.CubicIn = function(p67) -- line: 113
    return 1 * math.pow(p67 / 1, 3) + 0
end

t1.CubicOut = function(p68) -- line: 116
    return 1 * (math.pow(p68 / 1 - 1, 3) + 1) + 0
end

t1.CubicInOut = function(p69) -- line: 119
    local v47 = p69 / 1 * 2

    if v47 < 1 then
        return 0.5 * v47 * v47 * v47 + 0
    end

    local v48 = v47 - 2

    return 0.5 * (v48 * v48 * v48 + 2) + 0
end

t1.CubicOutIn = function(p70) -- line: 122
    if p70 < 0.5 then
        return 0.5 * (math.pow(p70 * 2 / 1 - 1, 3) + 1) + 0
    end

    return 0.5 * math.pow((p70 * 2 - 1) / 1, 3) + 0.5
end

local function inQuart(p71, p72, p73, p74) -- line: 126
    return p73 * math.pow(p71 / p74, 4) + p72
end

local function outQuart(p75, p76, p77, p78) -- line: 130
    local v52 = p75 / p78 - 1

    return -p77 * (math.pow(v52, 4) - 1) + p76
end

local function inOutQuart(p79, p80, p81, p82) -- line: 134
    local v53 = p79 / p82 * 2

    if v53 < 1 then
        return p81 / 2 * math.pow(v53, 4) + p80
    end

    local v54 = v53 - 2

    return -p81 / 2 * (math.pow(v54, 4) - 2) + p80
end

local function outInQuart(p83, p84, p85, p86) -- line: 143
    if p83 < p86 / 2 then
        local v55 = p83 * 2
        local v56 = p85 / 2
        local v57 = v55 / p86 - 1

        return -v56 * (math.pow(v57, 4) - 1) + p84
    end

    local v58 = p83 * 2 - p86
    local v59 = p84 + p85 / 2

    return p85 / 2 * math.pow(v58 / p86, 4) + v59
end

t1.QuartIn = function(p87) -- line: 151
    return 1 * math.pow(p87 / 1, 4) + 0
end

t1.QuartOut = function(p88) -- line: 154
    return -1 * (math.pow(p88 / 1 - 1, 4) - 1) + 0
end

t1.QuartInOut = function(p89) -- line: 157
    local v64 = p89 / 1 * 2

    if v64 < 1 then
        return 0.5 * math.pow(v64, 4) + 0
    end

    return -0.5 * (math.pow(v64 - 2, 4) - 2) + 0
end

t1.QuartOutIn = function(p90) -- line: 160
    if p90 < 0.5 then
        return -0.5 * (math.pow(p90 * 2 / 1 - 1, 4) - 1) + 0
    end

    return 0.5 * math.pow((p90 * 2 - 1) / 1, 4) + 0.5
end

local function inQuint(p91, p92, p93, p94) -- line: 164
    return p93 * math.pow(p91 / p94, 5) + p92
end

local function outQuint(p95, p96, p97, p98) -- line: 168
    return p97 * (math.pow(p95 / p98 - 1, 5) + 1) + p96
end

local function inOutQuint(p99, p100, p101, p102) -- line: 172
    local v70 = p99 / p102 * 2

    if v70 < 1 then
        return p101 / 2 * math.pow(v70, 5) + p100
    end

    local v71 = v70 - 2

    return p101 / 2 * (math.pow(v71, 5) + 2) + p100
end

local function outInQuint(p103, p104, p105, p106) -- line: 181
    if p103 < p106 / 2 then
        local v72 = p103 * 2

        return p105 / 2 * (math.pow(v72 / p106 - 1, 5) + 1) + p104
    end

    local v75 = p103 * 2 - p106
    local v76 = p104 + p105 / 2

    return p105 / 2 * math.pow(v75 / p106, 5) + v76
end

t1.QuintIn = function(p107) -- line: 189
    return 1 * math.pow(p107 / 1, 5) + 0
end

t1.QuintOut = function(p108) -- line: 192
    return 1 * (math.pow(p108 / 1 - 1, 5) + 1) + 0
end

t1.QuintInOut = function(p109) -- line: 195
    local v81 = p109 / 1 * 2

    if v81 < 1 then
        return 0.5 * math.pow(v81, 5) + 0
    end

    return 0.5 * (math.pow(v81 - 2, 5) + 2) + 0
end

t1.QuintOutIn = function(p110) -- line: 198
    if p110 < 0.5 then
        return 0.5 * (math.pow(p110 * 2 / 1 - 1, 5) + 1) + 0
    end

    return 0.5 * math.pow((p110 * 2 - 1) / 1, 5) + 0.5
end

local function inSextic(p111, p112, p113, p114) -- line: 202
    return p113 * math.pow(p111 / p114, 6) + p112
end

local function outSextic(p115, p116, p117, p118) -- line: 206
    local v86 = p115 / p118 - 1

    return -p117 * (math.pow(v86, 6) - 1) + p116
end

local function inOutSextic(p119, p120, p121, p122) -- line: 210
    local v87 = p119 / p122 * 2

    if v87 < 1 then
        return p121 / 2 * math.pow(v87, 6) + p120
    end

    local v88 = v87 - 2

    return -p121 / 2 * (math.pow(v88, 6) - 2) + p120
end

local function outInSextic(p123, p124, p125, p126) -- line: 219
    if p123 < p126 / 2 then
        local v89 = p123 * 2
        local v90 = p125 / 2
        local v91 = v89 / p126 - 1

        return -v90 * (math.pow(v91, 6) - 1) + p124
    end

    local v92 = p123 * 2 - p126
    local v93 = p124 + p125 / 2

    return p125 / 2 * math.pow(v92 / p126, 6) + v93
end

t1.SexticIn = function(p127) -- line: 227
    return 1 * math.pow(p127 / 1, 6) + 0
end

t1.SexticOut = function(p128) -- line: 230
    return -1 * (math.pow(p128 / 1 - 1, 6) - 1) + 0
end

t1.SexticInOut = function(p129) -- line: 233
    local v98 = p129 / 1 * 2

    if v98 < 1 then
        return 0.5 * math.pow(v98, 6) + 0
    end

    return -0.5 * (math.pow(v98 - 2, 6) - 2) + 0
end

t1.SexticOutIn = function(p130) -- line: 236
    if p130 < 0.5 then
        return -0.5 * (math.pow(p130 * 2 / 1 - 1, 6) - 1) + 0
    end

    return 0.5 * math.pow((p130 * 2 - 1) / 1, 6) + 0.5
end

local function inExpo(p131, p132, p133, p134) -- line: 240
    if p131 == 0 then
        return p132
    end

    return p133 * math.pow(2, 10 * (p131 / p134 - 1)) + p132 - p133 * 0.001
end

local function outExpo(p135, p136, p137, p138) -- line: 247
    if p135 == p138 then
        return p136 + p137
    end

    return p137 * 1.001 * (-math.pow(2, -10 * p135 / p138) + 1) + p136
end

local function inOutExpo(p139, p140, p141, p142) -- line: 254
    if p139 == 0 then
        return p140
    end

    if p139 == p142 then
        return p140 + p141
    end

    local v105 = p139 / p142 * 2

    if v105 < 1 then
        return p141 / 2 * math.pow(2, 10 * (v105 - 1)) + p140 - p141 * 5E-04
    end

    local v108 = v105 - 1

    return p141 / 2 * 1.0005 * (-math.pow(2, -10 * v108) + 2) + p140
end

local function outInExpo(p143, p144, p145, p146) -- line: 265
    if p143 < p146 / 2 then
        local v111 = p143 * 2
        local v112 = p145 / 2

        if v111 == p146 then
            return p144 + v112
        end

        return v112 * 1.001 * (-math.pow(2, -10 * v111 / p146) + 1) + p144
    end

    local v115 = p143 * 2 - p146
    local v116 = p144 + p145 / 2
    local v117 = p145 / 2

    if v115 == 0 then
        return v116
    end

    return v117 * math.pow(2, 10 * (v115 / p146 - 1)) + v116 - v117 * 0.001
end

t1.ExpoIn = function(p147) -- line: 273
    if p147 == 0 then
        return 0
    end

    return 1 * math.pow(2, 10 * (p147 / 1 - 1)) + 0 - 0.001
end

t1.ExpoOut = function(p148) -- line: 276
    if p148 == 1 then
        return 1
    end

    return 1.001 * (-math.pow(2, -10 * p148 / 1) + 1) + 0
end

t1.ExpoInOut = function(p149) -- line: 279
    if p149 == 0 then
        return 0
    end

    if p149 == 1 then
        return 1
    end

    local v121 = p149 / 1 * 2

    if v121 < 1 then
        return 0.5 * math.pow(2, 10 * (v121 - 1)) + 0 - 5E-04
    end

    return 0.50025 * (-math.pow(2, -10 * (v121 - 1)) + 2) + 0
end

t1.ExpoOutIn = function(p150) -- line: 282
    if p150 < 0.5 then
        local v124 = p150 * 2

        if v124 == 1 then
            return 0.5
        end

        return 0.5005 * (-math.pow(2, -10 * v124 / 1) + 1) + 0
    end

    local v126 = p150 * 2 - 1

    if v126 == 0 then
        return 0.5
    end

    return 0.5 * math.pow(2, 10 * (v126 / 1 - 1)) + 0.5 - 5E-04
end

local function inCirc(p151, p152, p153, p154) -- line: 286
    local v128 = p151 / p154

    return -p153 * (math.sqrt(1 - math.pow(v128, 2)) - 1) + p152
end

local function outCirc(p155, p156, p157, p158) -- line: 290
    return p157 * math.sqrt(1 - math.pow(p155 / p158 - 1, 2)) + p156
end

local function inOutCirc(p159, p160, p161, p162) -- line: 294
    local v133 = p159 / p162 * 2

    if v133 < 1 then
        return -p161 / 2 * (math.sqrt(1 - v133 * v133) - 1) + p160
    end

    local v136 = v133 - 2

    return p161 / 2 * (math.sqrt(1 - v136 * v136) + 1) + p160
end

local function outInCirc(p163, p164, p165, p166) -- line: 303
    if p163 < p166 / 2 then
        local v139 = p163 * 2

        return p165 / 2 * math.sqrt(1 - math.pow(v139 / p166 - 1, 2)) + p164
    end

    local v143 = p163 * 2 - p166
    local v144 = p164 + p165 / 2
    local v145 = p165 / 2
    local v146 = v143 / p166

    return -v145 * (math.sqrt(1 - math.pow(v146, 2)) - 1) + v144
end

t1.CircIn = function(p167) -- line: 311
    return -1 * (math.sqrt(1 - math.pow(p167 / 1, 2)) - 1) + 0
end

t1.CircOut = function(p168) -- line: 314
    return 1 * math.sqrt(1 - math.pow(p168 / 1 - 1, 2)) + 0
end

t1.CircInOut = function(p169) -- line: 317
    local v153 = p169 / 1 * 2

    if v153 < 1 then
        return -0.5 * (math.sqrt(1 - v153 * v153) - 1) + 0
    end

    local v155 = v153 - 2

    return 0.5 * (math.sqrt(1 - v155 * v155) + 1) + 0
end

t1.CircOutIn = function(p170) -- line: 320
    if p170 < 0.5 then
        return 0.5 * math.sqrt(1 - math.pow(p170 * 2 / 1 - 1, 2)) + 0
    end

    return -0.5 * (math.sqrt(1 - math.pow((p170 * 2 - 1) / 1, 2)) - 1) + 0.5
end

local function inBack(p171, p172, p173, p174, p175) -- line: 324
    p175 = p175 or 1.70158

    local v162 = p171 / p174

    return p173 * v162 * v162 * ((p175 + 1) * v162 - p175) + p172
end

local function outBack(p176, p177, p178, p179, p180) -- line: 329
    p180 = p180 or 1.70158

    local v164 = p176 / p179 - 1

    return p178 * (v164 * v164 * ((p180 + 1) * v164 + p180) + 1) + p177
end

local function inOutBack(p181, p182, p183, p184, p185) -- line: 334
    local v165 = (p185 or 1.70158) * 1.525
    local v166 = p181 / p184 * 2

    if v166 < 1 then
        return p183 / 2 * (v166 * v166 * ((v165 + 1) * v166 - v165)) + p182
    end

    local v167 = v166 - 2

    return p183 / 2 * (v167 * v167 * ((v165 + 1) * v167 + v165) + 2) + p182
end

local function outInBack(p186, p187, p188, p189, p190) -- line: 345
    if p186 < p189 / 2 then
        local v168 = p186 * 2
        local v169 = p188 / 2
        local v170 = p190 or 1.70158
        local v171 = v168 / p189 - 1

        return v169 * (v171 * v171 * ((v170 + 1) * v171 + v170) + 1) + p187
    end

    local v172 = p186 * 2 - p189
    local v173 = p187 + p188 / 2
    local v174 = p188 / 2

    p190 = p190 or 1.70158

    local v176 = v172 / p189

    return v174 * v176 * v176 * ((p190 + 1) * v176 - p190) + v173
end

t1.BackIn = function(p191, p192) -- line: 353
    p192 = p192 or 1.70158

    local v178 = p191 / 1

    return 1 * v178 * v178 * ((p192 + 1) * v178 - p192) + 0
end

t1.BackOut = function(p193, p194) -- line: 356
    p194 = p194 or 1.70158

    local v180 = p193 / 1 - 1

    return 1 * (v180 * v180 * ((p194 + 1) * v180 + p194) + 1) + 0
end

t1.BackInOut = function(p195, p196) -- line: 359
    local v181 = (p196 or 1.70158) * 1.525
    local v182 = p195 / 1 * 2

    if v182 < 1 then
        return 0.5 * (v182 * v182 * ((v181 + 1) * v182 - v181)) + 0
    end

    local v183 = v182 - 2

    return 0.5 * (v183 * v183 * ((v181 + 1) * v183 + v181) + 2) + 0
end

t1.BackOutIn = function(p197, p198) -- line: 362
    if p197 < 0.5 then
        local v184 = p197 * 2
        local v185 = p198 or 1.70158
        local v186 = v184 / 1 - 1

        return 0.5 * (v186 * v186 * ((v185 + 1) * v186 + v185) + 1) + 0
    end

    local v187 = p197 * 2 - 1

    p198 = p198 or 1.70158

    local v189 = v187 / 1

    return 0.5 * v189 * v189 * ((p198 + 1) * v189 - p198) + 0.5
end

local function outBounce(p199, p200, p201, p202) -- line: 366
    local v190 = p199 / p202

    if v190 < 0.36363636363636365 then
        return p201 * (7.5625 * v190 * v190) + p200
    end

    if v190 < 0.7272727272727273 then
        local v191 = v190 - 0.5454545454545454

        return p201 * (7.5625 * v191 * v191 + 0.75) + p200
    end

    if v190 < 0.9090909090909091 then
        local v192 = v190 - 0.8181818181818182

        return p201 * (7.5625 * v192 * v192 + 0.9375) + p200
    end

    local v193 = v190 - 0.9545454545454546

    return p201 * (7.5625 * v193 * v193 + 0.984375) + p200
end

local function inBounce(p203, p204, p205, p206) -- line: 381
    -- upvalues: outBounce (copy)
    return p205 - outBounce(p206 - p203, 0, p205, p206) + p204
end

local function inOutBounce(p207, p208, p209, p210) -- line: 384
    -- upvalues: outBounce (copy)
    if p207 < p210 / 2 then
        return (p209 - outBounce(p210 - p207 * 2, 0, p209, p210) + 0) * 0.5 + p208
    end

    return outBounce(p207 * 2 - p210, 0, p209, p210) * 0.5 + p209 * 0.5 + p208
end

local function outInBounce(p211, p212, p213, p214) -- line: 391
    -- upvalues: outBounce (copy)
    if p211 < p214 / 2 then
        return (outBounce(p211 * 2, p212, p213 / 2, p214))
    end

    local v195 = p211 * 2 - p214
    local v196 = p212 + p213 / 2
    local v197 = p213 / 2

    return v197 - outBounce(p214 - v195, 0, v197, p214) + v196
end

t1.BounceIn = function(p215) -- line: 399
    -- upvalues: outBounce (copy)
    return 1 - outBounce(1 - p215, 0, 1, 1) + 0
end

t1.BounceOut = function(p216) -- line: 402
    -- upvalues: outBounce (copy)
    return (outBounce(p216, 0, 1, 1))
end

t1.BounceInOut = function(p217) -- line: 405
    -- upvalues: outBounce (copy)
    if p217 < 0.5 then
        return (1 - outBounce(1 - p217 * 2, 0, 1, 1) + 0) * 0.5 + 0
    end

    return outBounce(p217 * 2 - 1, 0, 1, 1) * 0.5 + 0.5 + 0
end

t1.BounceOutIn = function(p218) -- line: 408
    -- upvalues: outBounce (copy)
    if p218 < 0.5 then
        return (outBounce(p218 * 2, 0, 0.5, 1))
    end

    return 0.5 - outBounce(1 - (p218 * 2 - 1), 0, 0.5, 1) + 0.5
end

local function elastic_blend(p219, p220, p221, p222, p223, p224) -- line: 412
    if p220 == 0 then
        return p224
    end

    local v200 = math.abs(p223)
    local v201 = if p222 == 0 then 0 else p224 * (p222 / math.abs(p220))

    if math.abs(p219 * p221) < v200 then
        local v204 = math.abs(p219 * p221) / v200

        return v201 * v204 + (1 - v204)
    end

    return v201
end

local function inElastic(p225, p226, p227, p228, p229, p230) -- line: 427
    if p225 == 0 then
        return p226
    end

    local v205 = p225 / p228

    if v205 == 1 then
        return p226 + p227
    end

    local v206 = v205 - 1
    local v207 = if not p230 or p230 == 0 then p228 * 0.3 else p230
    local v208, v209, v210

    if not p229 or p229 < math.abs(p227) then
        v208 = v207 / 4

        if p227 == 0 then
            v209 = 1
        else
            local v215 = math.abs(v208)

            v209 = if p229 == 0 then 0 else 1 * (p229 / math.abs(p227))

            if math.abs(v206 * p228) < v215 then
                local v218 = math.abs(v206 * p228) / v215

                v209 = v209 * v218 + (1 - v218)
            end
        end

        v210 = false
    else
        v210 = true
    end

    local v219 = p227

    if v210 then
        v219 = p229
        v208 = v207 / 6.283185307179586 * math.asin(p227 / p229)
        v209 = 1
    end

    return -v209 * (v219 * math.pow(2, 10 * v206) * math.sin((v206 * p228 - v208) * 6.283185307179586 / v207)) + p226
end

local function outElastic(p231, p232, p233, p234, p235, p236) -- line: 446
    if p231 == 0 then
        return p232
    end

    local v226 = p231 / p234

    if v226 == 1 then
        return p232 + p233
    end

    local v227 = -v226
    local v228 = if not p236 or p236 == 0 then p234 * 0.3 else p236
    local v229, v230, v231

    if not p235 or p235 < math.abs(p233) then
        v229 = v228 / 4

        if p233 == 0 then
            v230 = 1
        else
            local v236 = math.abs(v229)

            v230 = if p235 == 0 then 0 else 1 * (p235 / math.abs(p233))

            if math.abs(v227 * p234) < v236 then
                local v239 = math.abs(v227 * p234) / v236

                v230 = v230 * v239 + (1 - v239)
            end
        end

        v231 = false
    else
        v231 = true
    end

    local v240 = p233

    if v231 then
        v240 = p235
        v229 = v228 / 6.283185307179586 * math.asin(p233 / p235)
        v230 = 1
    end

    return v230 * (v240 * math.pow(2, 10 * v227) * math.sin((v227 * p234 - v229) * 6.283185307179586 / v228)) + p233 + p232
end

local function inOutElastic(p237, p238, p239, p240, p241, p242) -- line: 464
    if p237 == 0 then
        return p238
    end

    local v246 = p237 / (p240 / 2)

    if v246 == 2 then
        return p238 + p239
    end

    local v247 = v246 - 1
    local v248 = if not p242 or p242 == 0 then p240 * 0.44999999999999996 else p242
    local v249, v250, v251

    if not p241 or p241 < math.abs(p239) then
        v249 = v248 / 4

        if p239 == 0 then
            v250 = 1
        else
            local v256 = math.abs(v249)

            v250 = if p241 == 0 then 0 else 1 * (p241 / math.abs(p239))

            if math.abs(v247 * p240) < v256 then
                local v259 = math.abs(v247 * p240) / v256

                v250 = v250 * v259 + (1 - v259)
            end
        end

        v251 = false
    else
        v251 = true
    end

    local v260 = p239

    if v251 then
        v260 = p241
        v249 = v248 / 6.283185307179586 * math.asin(p239 / p241)
        v250 = 1
    end

    if v247 < 0 then
        return v250 * -0.5 * (v260 * math.pow(2, 10 * v247) * math.sin((v247 * p240 - v249) * 6.283185307179586 / v248)) + p238
    end

    local v267 = -v247

    return v250 * 0.5 * (v260 * math.pow(2, 10 * v267) * math.sin((v267 * p240 - v249) * 6.283185307179586 / v248)) + p239 + p238
end

local function outInElastic(p243, p244, p245, p246, p247, p248) -- line: 489
    -- upvalues: inElastic (copy), outElastic (copy)
    if p243 < p246 / 2 then
        return (outElastic(p243 * 2, p244, p245 / 2, p246, p247, p248))
    end

    return (inElastic(p243 * 2 - p246, p244 + p245 / 2, p245 / 2, p246, p247, p248))
end

t1.ElasticIn = function(p249, p250, p251) -- line: 497
    -- upvalues: inElastic (copy)
    return (inElastic(p249, 0, 1, 1, p250, p251))
end

t1.ElasticOut = function(p252, p253, p254) -- line: 500
    -- upvalues: outElastic (copy)
    return (outElastic(p252, 0, 1, 1, p253, p254))
end

t1.ElasticInOut = function(p255, p256, p257) -- line: 503
    -- upvalues: inOutElastic (copy)
    return (inOutElastic(p255, 0, 1, 1, p256, p257))
end

t1.ElasticOutIn = function(p258, p259, p260) -- line: 506
    -- upvalues: inElastic (copy), outElastic (copy)
    if p258 < 0.5 then
        return (outElastic(p258 * 2, 0, 0.5, 1, p259, p260))
    end

    return (inElastic(p258 * 2 - 1, 0.5, 0.5, 1, p259, p260))
end

return t1
