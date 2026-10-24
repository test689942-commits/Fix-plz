-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

t1.__add = function(p1, p2) -- line: 4
    if type(p2) ~= "function" then
        error("you add not function at Action")
    end

    p1:Add(p2)

    return p1
end

t1.__sub = function(p3, p4) -- line: 12
    p3:Remove(p4)

    return p3
end

function t1.new(p5) -- line: 17
    p5._action = {}
    p5._wait = {}
    p5._waitRemove = {}
end

function t1.Add(p6, p7) -- line: 23
    if p6.onInvoke then
        table.insert(p6._wait, p7)
    else
        table.insert(p6._action, p7)
    end

    return {
        Disconnect = function() -- Disconnect | line: 29
            -- upvalues: p6 (copy), p7 (copy)
            p6:Remove(p7)
        end
    }
end

function t1.Remove(p8, p9) -- line: 32
    if p8.onInvoke then
        table.insert(p8._waitRemove, p9)
    else
        for v1, v2 in ipairs(p8._action) do
            if v2 == p9 then
                local v3 = #p8._action

                if v1 ~= v3 then
                    p8._action[v1] = p8._action[v3]
                end

                p8._action[v3] = nil
            end
        end
    end
end

function t1.Invoke(p10, ...) -- line: 48
    p10.onInvoke = true

    for _, v4 in pairs(p10._action) do
        v4(...)
    end

    p10.onInvoke = false

    if #p10._wait ~= 0 then
        for _, v5 in p10._wait do
            table.insert(p10._action, v5)
        end

        p10._wait = {}
    end

    if p10._waitRemove[1] ~= nil then
        for _, v6 in p10._waitRemove do
            p10:Remove(v6)
        end

        p10._waitRemove = {}
    end
end

return t1
