-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t2 = {}
local t1 = {}

t1.__index = t1

function t1.CreatType(p1, p2) -- line: 6
    -- upvalues: t1 (copy), t2 (copy)
    if p2 == nil then
        if p1.Type == nil then
            error("Queue is not Have Type")
        end

        return p1
    end

    local v1 = t2[p2]

    if v1 == nil then
        v1 = {}
        v1.Type = p2
        v1.isGeneric = true
        v1.__index = v1
        t2[p2] = v1
        setmetatable(v1, t1)
    end

    return v1
end

function t1.new(p3) -- line: 25
    p3.count = 0
    p3.index = 1
    p3._queue = {}
    p3._queue2 = {}
end

function t1.Instance(p4, p5) -- line: 32
    -- upvalues: t1 (copy)
    if p5._base then
        return p5
    end

    if p4.Type.Name ~= nil then
        for _, v2 in pairs(p5._queue) do
            p4.Type:Instance(v2)
        end

        for _, v3 in pairs(p5._queue2) do
            p4.Type:Instance(v3)
        end
    end

    setmetatable(p5, t1)

    return p5
end

function t1.IsEmpty(p6) -- line: 49
    return p6.count == 0
end

function t1.Enqueue(p7, p8) -- line: 54
    p7.count += 1
    table.insert(p7._queue, p8)
end

function t1.Dequeue(p9) -- line: 60
    if p9:IsEmpty() then
        return nil
    end

    if p9.index > #p9._queue2 then
        p9.index = 1
        p9._queue2 = p9._queue
        p9._queue = {}
    end

    local v4 = p9._queue2[p9.index]

    p9.index += 1
    p9.count -= 1

    return v4
end

function t1.Clear(p10) -- line: 76
    p10.count = 0
    p10.index = 1
    p10._queue = {}
    p10._queue2 = {}
end

return t1
