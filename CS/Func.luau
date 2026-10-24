-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

t1.__add = function(p1, p2) -- line: 4
    if type(p2) ~= "function" then
        error("you add not function at Func")
    end

    p1:Add(p2)

    return p1
end

t1.__sub = function(p3, p4) -- line: 12
    p3:Remove(p4)

    return p3
end

t1.__call = function(p5, ...) -- line: 17
    p5:Invoke(...)
end

function t1.new(p6) -- line: 22
    p6._action = {}
    p6.waitRemove = {}
end

function t1.Add(p7, p8) -- line: 27
    table.insert(p7._action, p8)

    return {
        Disconnect = function() -- Disconnect | line: 29
            -- upvalues: p7 (copy), p8 (copy)
            p7:Remove(p8)
        end
    }
end

function t1.Remove(p9, p10) -- line: 32
    if p9.onInvoke then
        table.insert(p9.waitRemove, p10)
    else
        for v1, v2 in ipairs(p9._action) do
            if v2 == p10 then
                local v3 = #p9._action

                p9._action[v1] = p9._action[v3]
                p9._action[v3] = nil

                return
            end
        end
    end
end

function t1.Invoke(p11, ...) -- line: 47
    p11.onInvoke = true

    local t3

    for _, v4 in ipairs(p11._action) do
        t3 = { v4(...) }
    end

    p11.onInvoke = false

    if p11.waitRemove[1] ~= nil then
        for _, v5 in p11.waitRemove do
            p11:Remove(v5)
        end

        p11.waitRemove = {}
    end

    return t3 and unpack(t3)
end

return t1
