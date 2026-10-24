-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local Players = game:GetService("Players")

game:GetService("TweenService")

local RunService = game:GetService("RunService")
local floor, log10, rshift = math.floor, math.log10, bit32.rshift

function t1.new(_) -- line: 9
    -- upvalues: t1 (copy)
    return t1
end

function t1.AN(_, p3, p4) -- line: 13
    -- upvalues: t1 (copy)
    return t1:AbbreviateNumber(p3, p4)
end

function t1.TN(_, p6) -- line: 17
    -- upvalues: t1 (copy)
    return t1:ThousandNumber(p6)
end

function t1.STT(_, p8) -- line: 21
    -- upvalues: t1 (copy)
    return t1:SecondToTime(p8)
end

function t1.NTP(_, p10, p11, p12) -- line: 25
    if p10 * 10 ^ p11 * 100 > 1 then
        return math.floor(p10 * 10 ^ p11 * 100) / 10 ^ p11 .. "%"
    end

    local v3 = math.max(p11, p12 or 4)

    for i = p11 + 1, v3 do
        if p10 * 10 ^ i > 1 then
            return math.floor(p10 * 10 ^ i) / 10 ^ i .. "%"
        end
    end

    return 1 / 10 ^ v3 .. "%"
end

function t1.RTF(_, p14) -- line: 39
    -- upvalues: t1 (copy)
    return t1:Region_code_to_flag(p14)
end

function t1.GetAmount(_, p16) -- line: 43
    local v5 = math.floor(p16)

    return v5 + (if math.random() < p16 - v5 then 1 else 0)
end

function t1.BitwiseAnd(_, p18, p19) -- line: 49
    -- upvalues: floor (copy)
    local v7 = p19
    local n1 = 0

    for _ = 1, 200 do
        local v9 = floor(p18 % 2)
        local v11 = floor(v7 % 2)
        local v12 = if v9 == 1 and v11 == 1 then 1 else 0

        n1 *= 2

        if v12 == 1 then
            n1 += 1
        end

        p18 = floor(p18 / 2)
        v7 = floor(v7 / 2)

        if p18 == 0 or v7 == 0 then
            break
        end
    end

    return n1
end

function t1.Split(_, p21, p22) -- line: 77
    local t2 = {}
    local v15, v16 = string.find(p21, p22, 1)
    local n2 = 1

    while v15 do
        table.insert(t2, (string.sub(p21, n2, v15 - 1)))
        n2 = v16 + 1
        v15, v16 = string.find(p21, p22, n2)
    end

    table.insert(t2, (string.sub(p21, n2)))

    return t2
end

function t1.Dichotomy(_, p24, p25, p26, p27, p28) -- line: 91
    -- upvalues: rshift (copy)
    if p24 == p25 then
        return p24
    end

    local v20

    if p27 then
        v20 = p24

        local v21 = p25
        local v22

        while true do
            if v20 == v21 then
                return v20
            end

            v22 = rshift(v20 + v21, 1)

            local v24 = p28(v22)

            if v24 == p26 then
                break
            end

            local v25, v26

            if p26 < v24 then
                v26 = v22
                v25 = v20
            else
                v26 = v21
                v25 = v22 + 1
            end

            v21 = v26
            v20 = v25
        end

        return v22
    end

    v20 = p24

    local v27 = p25
    local v28

    while true do
        if v20 == v27 then
            return v20
        end

        v28 = rshift(v20 + v27, 1)

        local v30 = p28(v28)

        if v30 == p26 then
            break
        end

        local v31, v32

        if v30 < p26 then
            v32 = v28
            v31 = v20
        else
            v32 = v27
            v31 = v28 + 1
        end

        v27 = v32
        v20 = v31
    end

    return v28
end

function t1.FisherYates(_, p30) -- line: 125
    local v33 = #p30

    for i = 1, v33 do
        local v34 = math.random(i, v33)
        local v35 = p30[i]

        p30[i] = p30[v34]
        p30[v34] = v35
    end

    return p30
end

function t1.BoxCatch(_, p32, p33, p34, p35) -- line: 138
    local v36 = OverlapParams.new()

    v36.FilterType = p34 or Enum.RaycastFilterType.Exclude
    v36.FilterDescendantsInstances = p35 or {}

    return workspace:GetPartBoundsInBox(p32, p33, v36)
end

function t1.BoxCatchHumanoid(_, p37, p38, p39, p40) -- line: 146
    -- upvalues: t1 (copy)
    local t3 = {}

    for _, v37 in ipairs(t1:BoxCatch(p37, p38, p39, p40)) do
        if v37.Parent:FindFirstChildOfClass("Humanoid") and table.find(t3, v37.Parent) == nil then
            table.insert(t3, v37.Parent)
        end
    end

    return t3
end

local t4 = {
    "K",
    "M",
    "B",
    "T"
}

function t1.AbbreviateNumber(_, p42, p43) -- line: 158
    -- upvalues: floor (copy), log10 (copy), t4 (copy)
    local v38 = p43 or 3

    if p42 < 1 then
        local n3 = 1

        for _ = 1, v38 do
            n3 /= 10
        end

        while p42 < n3 and v38 < 10 do
            v38 += 1
            n3 /= 10
        end

        return floor(p42 * 10 ^ v38) / 10 ^ v38
    end

    if p42 < 1000 then
        return floor(p42 * 10 ^ v38) / 10 ^ v38
    end

    local v41 = log10(p42)
    local v42 = v41 - v41 % 3
    local v44 = t4[math.floor(v42 / 3)]

    if v44 == nil then
        local v46 = math.floor(v42 / 3)

        for i = #t4 + 1, v46 do
            t4[i] = string.char(math.ceil((i - 4) / 26) + 64) .. string.char(math.ceil((i - 5) % 26) + 96 + 1)
        end

        v44 = t4[v46]
    end

    return floor(p42 / 10 ^ v42 * 10 ^ v38) / 10 ^ v38 .. v44
end

function t1.ThousandNumber(_, p45) -- line: 188
    local v53 = math.floor(p45)
    local v54 = math.floor(v53)
    local v55 = "" .. tostring(v54)
    local v57 = math.floor((v53 - v54) * 1000)
    local v58 = #v55 - 3

    while v58 > 0 do
        v55 = v55:sub(1, v58) .. "," .. v55:sub(v58 + 1)
        v58 -= 3
    end

    if v57 > 0 then
        v55 ..= "." .. tostring(v57)
    end

    return v55
end

function t1.SecondToTime(_, p47) -- line: 211
    local v59 = if p47 < 0 then 0 else p47
    local v61 = math.floor(v59 / 3600)
    local v62 = v59 % 3600
    local v64 = math.floor(v62 / 60)
    local v66 = math.floor(v62 % 60)

    if v61 == 0 then
        v64 = v64 < 10 and "0" .. v64 or v64
        v66 = v66 < 10 and "0" .. v66 or v66

        return v64 .. ":" .. v66
    end

    local v68 = math.floor(v61 / 24)

    if v68 == 0 then
        v64 = v64 < 10 and "0" .. v64 or v64
        v66 = v66 < 10 and "0" .. v66 or v66

        return v61 .. ":" .. v64 .. ":" .. v66
    end

    local v69 = v61 % 24

    v64 = v64 < 10 and "0" .. v64 or v64
    v66 = v66 < 10 and "0" .. v66 or v66

    return v68 .. " day " .. v69 .. ":" .. v64 .. ":" .. v66
end

function t1.Region_code_to_flag(_, p49) -- line: 233
    if #p49 ~= 2 or not p49:match("^%a%a$") then
        return nil
    end

    local v70 = ""

    for i = 1, 2 do
        local v71 = p49:sub(i, i):upper()

        v70 ..= utf8.char(utf8.codepoint(v71) + 127397)
    end

    return v70
end

function t1.GetPlayerWhihPart(_, p51) -- line: 246
    -- upvalues: Players (copy)
    local Model = p51:FindFirstAncestorWhichIsA("Model")

    return if Model then Players:GetPlayerFromCharacter(Model) else nil
end

local t5 = {}

function t1.TrigerCoolDown(_, p53, p54) -- line: 257
    -- upvalues: t5 (copy)
    if t5[p53] then
        return false
    end

    t5[p53] = true
    task.delay(p54 or 0.5, function() -- line: 262
        -- upvalues: p53 (copy), t5 (copy)
        t5[p53] = false
    end)

    return true
end

local t6 = { "D", "C", "B", "A", "S", "SS", "SSS", "SP" }

function t1.NumberToLevel(_, p56) -- line: 269
    -- upvalues: t6 (copy)
    return t6[p56]
end

function t1.GetLevelWithExp(_, p58) -- line: 273
    -- upvalues: t1 (copy)
    local EntityStateData = _G.DataMgr:GetConfig("EntityStateData")

    if EntityStateData[100].level_up_exp <= p58 then
        return 100
    end

    return t1:Dichotomy(2, 100, p58, true, function(p59) -- line: 278
        -- upvalues: EntityStateData (copy)
        return EntityStateData[p59].level_up_exp
    end) - 1
end

function t1.GetExpwithLevel(_, p61) -- line: 281
    return _G.DataMgr:GetConfig("EntityStateData", (math.clamp(p61, 0, 100))).level_up_exp
end

function t1.GetGeneToLevel(_, p63) -- line: 285
    if p63 == 0 then
        return 0
    end

    return (math.min(10, (math.floor(((p63 + 1) ^ 0.5405405405405405 + 1) / 2))))
end

function t1.GetLevelToGene(_, p65) -- line: 289
    if p65 == 0 then
        return 0
    end

    return (math.floor((p65 * 2 - 1) ^ 1.85))
end

local function RecursiveDivisionMaze(p66, p67, p68) -- line: 294
    -- upvalues: RecursiveDivisionMaze (copy)
    if p68[1] - p67[1] < 4 or p68[2] - p67[2] < 4 then
        return
    end

    local v77 = p67[1] + math.random(1, math.ceil((p68[1] - p67[1]) / 2) - 1) * 2
    local v80 = p67[2] + math.random(1, math.ceil((p68[2] - p67[2]) / 2) - 1) * 2

    for i = p67[1] + 1, p68[1] - 1 do
        p66[i][v80] = 1
    end

    for i = p67[2] + 1, p68[2] - 1 do
        p66[v77][i] = 1
    end

    local v81 = math.random(1, 5)

    if v81 ~= 1 then
        p66[p67[1] + math.random(1, (math.floor((v77 - p67[1]) / 2))) * 2 - 1][v80] = 0
    end

    if v81 ~= 2 then
        p66[v77 + math.random(1, (math.floor((p68[1] - v77) / 2))) * 2 - 1][v80] = 0
    end

    if v81 ~= 3 then
        local v87 = p67[2] + math.random(1, (math.floor((v80 - p67[2]) / 2))) * 2 - 1

        p66[v77][v87] = 0
    end

    if v81 ~= 4 then
        local v89 = v80 + math.random(1, (math.floor((p68[2] - v80) / 2))) * 2 - 1

        p66[v77][v89] = 0
    end

    RecursiveDivisionMaze(p66, p67, { v77, v80 })
    RecursiveDivisionMaze(p66, {
        v77,
        p67[2]
    }, {
        p68[1],
        v80
    })
    RecursiveDivisionMaze(p66, {
        p67[1],
        v80
    }, {
        v77,
        p68[2]
    })
    RecursiveDivisionMaze(p66, { v77, v80 }, p68)

    return p66
end

function t1.RDM(_, p70, p71) -- line: 331
    -- upvalues: RecursiveDivisionMaze (copy)
    if type(p70) == "table" then
        return RecursiveDivisionMaze(p70, { 0, 0 }, {
            #p70 + 1,
            #p70[1] + 1
        })
    end

    local t7 = {}

    for i = 1, p70 do
        table.insert(t7, {})

        for j = 1, p71 do
            t7[i][j] = 0
        end
    end

    return RecursiveDivisionMaze(t7, { 0, 0 }, {
        p70 + 1,
        p71 + 1
    })
end

function t1.PasteTerrain(_, p73, p74) -- line: 346
    if typeof(p74) ~= "TerrainRegion" then
        local v90 = if typeof(p73) ~= CFrame or not p73 then p73.CFrame else p73
        local v91 = v90.Rotation * Vector3.new(1, 2, 3)
        local v95 = Vector3.new(math.round(v91.X), math.round(v91.Y), (math.round(v91.Z)))
        local t9 = {}
        local t10 = {}
        local t11 = {}
        local t12 = {}

        t12[math.abs(v95.X)] = t9
        t12[math.abs(v95.Y)] = t10
        t12[math.abs(v95.Z)] = t11
        t9[1] = p74.Size.X
        t10[1] = p74.Size.Y
        t11[1] = p74.Size.Z

        local v99 = Vector3.new(t12[1][1], t12[2][1], t12[3][1])
        local v100 = v90.Position - v99 * 2
        local v104 = Vector3.new(math.round(v100.X), math.round(v100.Y), (math.round(v100.Z)))
        local v105 = v90.Position + v99 * 2
        local v109 = Vector3.new(math.round(v105.X), math.round(v105.Y), (math.round(v105.Z)))
        local v110 = Region3.new(v104, v109):ExpandToGrid(4)
        local v111 = v110.Size / 4
        local t13 = {}
        local t14 = {}
        local t15 = {}

        for i = 1, v111.X do
            table.insert(t13, {})
            table.insert(t14, {})
            table.insert(t15, {})
            t9[1] = if not (v95.X > 0) or not i then v111.X - i + 1 else i

            for j = 1, v111.Y do
                table.insert(t13[i], {})
                table.insert(t14[i], {})
                table.insert(t15[i], {})
                t10[1] = if not (v95.Y > 0) or not j then v111.Y - j + 1 else j

                for k = 1, v111.Z do
                    t11[1] = if not (v95.Z > 0) or not k then v111.Z - k + 1 else k

                    local v115 = p74.SolidMaterial[t12[1][1]]

                    if v115 then
                        local v116 = v115[t12[2][1]]

                        v115 = v116 and v116[t12[3][1]]
                    end

                    local v117 = p74.SolidOccupancy[t12[1][1]]

                    if v117 then
                        local v118 = v117[t12[2][1]]

                        v117 = v118 and v118[t12[3][1]]
                    end

                    local v119 = p74.LiquidOccupancy[t12[1][1]]

                    if v119 then
                        local v120 = v119[t12[2][1]]

                        v119 = v120 and v120[t12[3][1]]
                    end

                    table.insert(t13[i][j], v115 or Enum.Material.Air)
                    table.insert(t14[i][j], v117 or 0)
                    table.insert(t15[i][j], v119 or 0)
                end
            end
        end

        local t22 = {
            SolidMaterial = t13,
            SolidOccupancy = t14,
            LiquidOccupancy = t15
        }

        workspace.Terrain:WriteVoxelChannels(v110, 4, t22)

        return {
            Destroy = function() -- Destroy | line: 426
                -- upvalues: v110 (copy)
                workspace.Terrain:FillRegion(v110, 4, Enum.Material.Air)
            end
        }
    end

    local v127 = (typeof(p73) == CFrame and p73.Position or p73.CFrame.Position) / 4 - p74.SizeInCells / 2

    workspace.Terrain:PasteRegion(p74, Vector3int16.new(v127.X, v127.Y, v127.Z), false)
end

function t1.FindOrCreat(_, p76, p77, p78) -- line: 433
    if type(p77) == "table" then
        local v128 = p76
        local v129

        for v130, v131 in p77 do
            local v132 = v128:FindFirstChild(v131)

            if v132 ~= nil then
                v128 = v132
            else
                v128 = Instance.new(p78[v130], v128)
                v128.Name = v131
            end

            v129 = v128
        end

        return v129
    end

    local v133 = p76:FindFirstChild(p77)

    if v133 == nil then
        v133 = Instance.new(p78, p76)
        v133.Name = p77
    end

    return v133
end

function t1.Restrict_Vector(_, p80, p81, p82) -- line: 455
    local v134 = math.rad(p82)
    local v135 = math.cos(v134)
    local v136 = p81:Dot(p80)

    if v135 <= v136 then
        return p80
    end

    local v137 = p80 - v136 * p81
    local Magnitude = v137.Magnitude
    local v138 = v135 * p81
    local v139 = math.sin(v134)
    local v140, v141

    if Magnitude > 1E-10 then
        local v142 = v137 / Magnitude

        if v142 then
            v140 = v142
            v141 = true
        elseif math.abs(p81.X) < 0.9 then
            local Unit = Vector3.new(-p81.Y, p81.X, 0).Unit

            if Unit then
                v140 = Unit
                v141 = true
            else
                v141 = false
            end
        else
            v141 = false
        end
    elseif math.abs(p81.X) < 0.9 then
        local Unit = Vector3.new(-p81.Y, p81.X, 0).Unit

        if Unit then
            v140 = Unit
            v141 = true
        else
            v141 = false
        end
    else
        v141 = false
    end

    if not v141 then
        v140 = Vector3.new(0, -p81.Z, p81.Y).Unit
    end

    return v138 + v139 * v140
end

local t24 = {
    1, 1, 2, 3, 5, 8, 13, 21,
    34, 55, 89, 144, 233, 377, 610, 987,
    1597, 2584, 4181
}

function t1.Fibonacci(_, p84) -- line: 477
    -- upvalues: t24 (copy)
    if not t24[p84] then
        t24[p84] = math.floor((1.618033988749895 ^ p84 - (-0.6180339887498949) ^ p84) / 2.23606797749979)
    end

    return t24[p84]
end

function t1.FormatString(_, p86, ...) -- line: 487
    local t25 = { ... }
    local v147 = t25

    if t25[1] and type(t25[1]) == "table" then
        v147 = t25[1]
    end

    return (p86:gsub("{(%w+)}", function(p87) -- line: 492
        -- upvalues: v147 (ref)
        if v147[p87] then
            return v147[p87]
        end

        local v149 = tonumber(p87)

        if not v149 then
            return "{" .. p87 .. "}"
        end

        local v150 = v147[v149]

        return v150 or "{" .. p87 .. "}"
    end))
end

function t1.WeldInstance(_, p89, p90) -- line: 501
    -- upvalues: RunService (copy)
    if p89 == nil or p90 == nil then
        return
    end

    local connection

    connection = RunService.RenderStepped:Connect(function() -- line: 506
        -- upvalues: p89 (copy), p90 (copy), connection (ref)
        if p89.Parent == nil or p90.Parent == nil then
            connection:Disconnect()
        else
            p89.CFrame = p90.CFrame
        end
    end)

    return connection
end

for _, child in script:GetChildren() do
    local v151 = require(child)

    t1[child.Name] = function(_, ...) -- line: 518
        -- upvalues: v151 (copy)
        return v151(...)
    end
end

return t1
