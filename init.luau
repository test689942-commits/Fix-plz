-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local t2 = {
    script,
    script.Data
}

local function GetTypes(p1) -- line: 4
    -- upvalues: t1 (copy)
    local t3 = {}

    for _, v1 in p1 do
        table.insert(t3, t1:GetType(v1))
    end

    return t3
end

_G.Object = t1
_G.Enum = {}

_G.New = function(p2, p3) -- line: 13
    -- upvalues: t1 (copy), GetTypes (copy)
    local Type = t1:GetType(p2)
    local t4 = {}

    t4[1] = Type

    return function(p4, ...) -- line: 15
        -- upvalues: p3 (copy), t4 (copy), GetTypes (copy)
        if p4 == nil then
            local self = setmetatable({}, t4[1])

            return self:new(p4, ...) or self
        end

        local v4 = t4[1].CreatType == nil
        local isGeneric = if not v4 then rawget(t4[1], "isGeneric") else nil

        if v4 or isGeneric then
            if p3 then
                return t4[1]:Instance(p4, ...)
            end

            local self = setmetatable({}, t4[1])

            return self:new(p4, ...) or self
        end

        t4[1] = t4[1]:CreatType(unpack((GetTypes({
            p4,
            ...
        }))))

        return function(p5, ...) -- line: 31
            -- upvalues: p3 (copy), t4 (copy)
            if p5 == nil then
                local self = setmetatable({}, t4[1])

                return self:new(p5, ...) or self
            end

            if p3 then
                return t4[1]:Instance(p5, ...)
            end

            local self = setmetatable({}, t4[1])

            return self:new(p5, ...) or self
        end
    end
end

_G.SubClass = function(p6, p7) -- line: 47
    -- upvalues: t1 (copy)
    local Type = t1:GetType(p6)

    p7 = p7 or {}

    local __iter = rawget(Type, "__iter")

    if __iter then
        rawset(Type, "__iter", nil)
    end

    for v15, v16 in Type do
        if type(v16) == "function" then
            p7[v15] = v16
        end
    end

    if __iter then
        rawset(Type, "__iter", __iter)
        p7.__iter = __iter
    end

    p7.__index = p7

    return (setmetatable(p7, Type))
end

_G.Type = function(p8) -- line: 75
    -- upvalues: t1 (copy), GetTypes (copy)
    local Type = t1:GetType(p8)

    if not Type.CreatType then
        return Type
    end

    return function(...) -- line: 78
        -- upvalues: Type (copy), t1 (copy), GetTypes (copy)
        local t9 = { ... }

        for _, v17 in t9 do
            if type(v17) == "table" and v17._type == "GenericVariables" then
                return {
                    _type = "GenericVariables",
                    array = t9,
                    Creat = function(p9, p10) -- Creat | line: 85
                        -- upvalues: Type (copy), t1 (copy)
                        for v18, v19 in p9.array do
                            if type(v19) == "table" and v19._type == "GenericVariables" then
                                p9.array[v18] = v19:Creat(p10)
                            elseif type(v19) == "string" then
                                p9.array[v18] = t1:GetType(v19)
                            end
                        end

                        return Type:CreatType(unpack(p9.array))
                    end
                }
            end
        end

        return Type:CreatType(unpack((GetTypes(t9))))
    end
end

_G.Genericity = function(p11) -- line: 115
    -- upvalues: t1 (copy)
    local v21 = p11
    local t10 = {}
    local t11 = {}

    p11 = p11 or 1
    v21 = p11

    local t12 = {}

    for i = 1, p11 do
        table.insert(t12, {
            _type = "GenericVariables",
            index = i,
            Creat = function(p12, p13) -- Creat | line: 124
                -- upvalues: t1 (copy)
                return t1:GetType(p13[p12.index])
            end
        })
    end

    function t10.CreatType(p14, ...) -- line: 130
        -- upvalues: v21 (ref), t11 (copy)
        local t14 = { ... }
        local v23 = t11[t14[1]]

        for _ = 2, v21 do
            if v23 == nil then
                break
            end

            v23 = v23[t14[1]]
        end

        if v23 ~= nil then
            return v23
        end

        local t15 = {
            types = t14
        }
        local __iter = rawget(p14, "__iter")

        if __iter then
            rawset(p14, "__iter", nil)
        end

        for v25, v26 in p14 do
            if type(v26) == "table" and v26._type == "GenericVariables" then
                t15[v25] = v26:Creat(t14)
            else
                t15[v25] = v26
            end
        end

        if __iter then
            rawset(p14, "__iter", __iter)
            t15.__iter = __iter
        end

        t15.__index = t15

        if v21 == 1 then
            t11[t14[1]] = t15
        else
            local v27 = t11

            for i = 1, v21 - 1 do
                if v27[t14[i]] == nil then
                    v27[t14[i]] = {}
                end

                v27 = v27[t14[i]]
            end

            v27[t14[v21]] = t15
        end

        t15.isGeneric = true
        setmetatable(t15, (getmetatable(p14)))

        return t15
    end

    return t10, unpack(t12)
end

local t16 = {}

t1.__index = t1

function t1.new(p15) -- line: 184
    if p15.Name == nil then
        error("没有实例化类型")
    end
end

function t1.Instance(p16, p17) -- line: 201
    if p17._base then
        return p17
    end

    for v28, v29 in pairs(p17) do
        if type(p16[v28]) == "table" and p16[v28].Name ~= nil and type(v29) ~= "userdata" and p16[v28].Name ~= v29.Name then
            p17[v28] = p16[v28]:Instance(v29)
        end
    end

    setmetatable(p17, p16)

    return p17
end

local function __call(p18, p19, p20) -- line: 214
    if p19 == nil then
        return pairs(p18)(p18, p20)
    end

    if type(p19) == "table" then
        for v31, v32 in p19 do
            p18[v31] = v32
        end
    end

    return p18
end

function t1.GetType(_, p22) -- line: 227
    -- upvalues: t1 (copy), t2 (copy), t16 (copy), __call (copy)
    if typeof(p22) ~= "string" then
        return p22
    end

    if t16[p22] ~= nil then
        return t16[p22]
    end

    local v33 = string.split(p22, ".")
    local v34

    for _, v35 in t2 do
        local v36 = 1
        local v37 = v35:FindFirstChild(v33[1])

        while v36 < #v33 and v37 do
            v36 += 1
            v37 = v37:FindFirstChild(v33[v36])
        end

        if v37 and v37:IsA("ModuleScript") then
            v34 = require(v37)
            break
        end

        v34 = nil
    end

    if v34 == nil then
        t16[p22] = p22

        return p22
    end

    t16[p22] = v34
    v34.Name = p22

    if v34.__call == nil then
        v34.__call = __call
    end

    if not rawget(v34, "__index") then
        v34.__index = v34
    end

    if getmetatable(v34) then
        v34._base = getmetatable(v34)
    else
        v34._base = t1
        setmetatable(v34, t1)
    end

    return v34
end

function t1.Super(p23, ...) -- line: 275
    local mt = getmetatable(p23)

    setmetatable(p23, p23._base)
    p23.new(p23, ...)
    setmetatable(p23, mt)
end

local function TableDeepClone(p24) -- line: 283
    -- upvalues: TableDeepClone (copy)
    local t17 = {}

    for v38, v39 in p24 do
        if type(v39) == "table" then
            t17[v38] = TableDeepClone(v39)
        else
            t17[v38] = v39
        end
    end

    return t17
end

function t1.Clone(p25, p26) -- line: 295
    -- upvalues: TableDeepClone (copy)
    local v40 = {}

    if p26 then
        for v41, v42 in p25 do
            v40[v41] = v42
        end
    else
        v40 = TableDeepClone(p25)
    end

    getmetatable(p25):Instance(v40)

    return v40
end

function t1.AddAssembly(_, p28, p29) -- line: 308
    -- upvalues: t2 (copy)
    if p29 then
        table.insert(t2, p29, p28)
    else
        table.insert(t2, p28)
    end
end

return t1
