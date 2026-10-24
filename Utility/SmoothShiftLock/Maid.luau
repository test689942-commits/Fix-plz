-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {
    ClassName = "Maid"
}

function t1.new() -- line: 37
    -- upvalues: t1 (copy)
    return (setmetatable({
        _tasks = {}
    }, t1))
end

function t1.isMaid(p1) -- line: 54
    if type(p1) == "table" then
        return p1.ClassName == "Maid"
    end

    return false
end

function t1.__index(p2, p3) -- line: 73
    -- upvalues: t1 (copy)
    if t1[p3] then
        return t1[p3]
    end

    return p2._tasks[p3]
end

function t1.__newindex(p4, p5, p6) -- line: 100
    -- upvalues: t1 (copy)
    if t1[p5] ~= nil then
        error(("Cannot use '%s' as a Maid key"):format((tostring(p5))), 2)
    end

    local _tasks = p4._tasks
    local v1 = _tasks[p5]

    if v1 ~= p6 then
        _tasks[p5] = p6

        if v1 then
            if type(v1) == "function" then
                v1()
            elseif type(v1) == "thread" then
                task.cancel(v1)
            elseif typeof(v1) == "RBXScriptConnection" then
                v1:Disconnect()
            elseif v1.Destroy then
                v1:Destroy()
            end
        end
    end
end

function t1.GiveTask(p7, p8) -- line: 133
    if not p8 then
        error("Task cannot be false or nil", 2)
    end

    local v2 = #p7._tasks + 1

    p7[v2] = p8

    if type(p8) == "table" and not p8.Destroy then
        warn("[Maid.GiveTask] - Gave table task without .Destroy\n\n" .. debug.traceback())
    end

    return v2
end

function t1.GivePromise(p9, p10) -- line: 154
    if not p10:IsPending() then
        return p10
    end

    local v3 = p10.resolved(p10)
    local v4 = p9:GiveTask(v3)

    v3:Finally(function() -- line: 163
        -- upvalues: p9 (copy), v4 (copy)
        p9[v4] = nil
    end)

    return v3
end

function t1.DoCleaning(p11) -- line: 186
    local _tasks = p11._tasks

    for v5, v6 in pairs(_tasks) do
        if typeof(v6) == "RBXScriptConnection" then
            _tasks[v5] = nil
            v6:Disconnect()
        end
    end

    local v7, v8 = next(_tasks)

    while v8 ~= nil do
        _tasks[v7] = nil

        if type(v8) == "function" then
            v8()
        elseif type(v8) == "thread" then
            task.cancel(v8)
        elseif typeof(v8) == "RBXScriptConnection" then
            v8:Disconnect()
        elseif v8.Destroy then
            v8:Destroy()
        end

        v7, v8 = next(_tasks)
    end
end

t1.Destroy = t1.DoCleaning

return t1
