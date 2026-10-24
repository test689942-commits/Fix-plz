-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local t2 = {}

function t1.__iter(p1) -- line: 4
    local n1 = 0

    return function() -- line: 7
        -- upvalues: p1 (copy), n1 (ref)
        local v1 = n1

        if v1 < p1.count then
            n1 += 1

            return n1, p1._stack[n1]
        end
    end
end

function t1.CreatType(p2, p3) -- line: 16
    -- upvalues: t1 (copy), t2 (copy)
    if p3 == nil then
        if p2.Type == nil then
            error("Stack is not Have Type")
        end

        return p2
    end

    local v2 = t2[p3]

    if v2 == nil then
        v2 = {}
        v2.Type = p3
        v2.isGeneric = true
        v2.__index = v2
        v2.__iter = t1.__iter
        t2[p3] = v2
        setmetatable(v2, t1)
    end

    return v2
end

function t1.new(p4) -- line: 36
    p4.count = 0
    p4._stack = {}
end

function t1.IsEmpty(p5) -- line: 67
    return #p5._stack == 0
end

function t1.Push(p6, p7) -- line: 72
    p6.count += 1
    table.insert(p6._stack, p7)
end

function t1.Pop(p8) -- line: 78
    if p8:IsEmpty() then
        return nil
    end

    p8.count -= 1

    return table.remove(p8._stack, #p8._stack)
end

function t1.Remove(p9, p10) -- line: 87
    if p9:IsEmpty() then
        return nil
    end

    for i = p9.count, 1, -1 do
        if p9._stack[i] == p10 then
            p9:RemoveAt(i)

            return
        end
    end
end

function t1.RemoveAt(p11, p12) -- line: 99
    if p11:IsEmpty() then
        return nil
    end

    if p12 < 1 or p11.count < p12 then
        return
    end

    p11.count -= 1

    return table.remove(p11._stack, p12)
end

function t1.Clear(p13) -- line: 110
    p13.count = 0
    p13._stack = {}
end

return t1
