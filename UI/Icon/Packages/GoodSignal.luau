-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local v1

local function acquireRunnerThreadAndCallEventHandler(p1, ...) -- line: 34
    -- upvalues: v1 (ref)
    local v2 = v1

    v1 = nil
    p1(...)
    v1 = v2
end

local function runEventHandlerInFreeThread() -- line: 45
    -- upvalues: acquireRunnerThreadAndCallEventHandler (copy)
    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield())
    end
end

local t1 = {}

t1.__index = t1

function t1.new(p2, p3) -- line: 60
    -- upvalues: t1 (copy)
    return (setmetatable({
        _connected = true,
        _next = false,
        _signal = p2,
        _fn = p3
    }, t1))
end

function t1.Disconnect(p4) -- line: 69
    p4._connected = false

    if p4._signal._handlerListHead == p4 then
        p4._signal._handlerListHead = p4._next
    else
        local v3 = p4._signal._handlerListHead

        while v3 and v3._next ~= p4 do
            v3 = v3._next
        end

        if v3 then
            v3._next = p4._next
        end
    end
end

t1.Destroy = t1.Disconnect
setmetatable(t1, {
    __index = function(_, p6) -- __index | line: 92
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p6))), 2)
    end,
    __newindex = function(_, p8, _) -- __newindex | line: 95
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p8))), 2)
    end
})

local t4 = {}

t4.__index = t4

function t4.new() -- line: 104
    -- upvalues: t4 (copy)
    return (setmetatable({
        _handlerListHead = false
    }, t4))
end

function t4.Connect(p10, p11) -- line: 110
    -- upvalues: t1 (copy)
    local v4 = t1.new(p10, p11)

    if p10._handlerListHead then
        v4._next = p10._handlerListHead
    end

    p10._handlerListHead = v4

    return v4
end

function t4.DisconnectAll(p12) -- line: 123
    p12._handlerListHead = false
end

t4.Destroy = t4.DisconnectAll

function t4.Fire(p13, ...) -- line: 132
    -- upvalues: v1 (ref), runEventHandlerInFreeThread (copy)
    local v5 = p13._handlerListHead

    while v5 do
        if v5._connected then
            if not v1 then
                v1 = coroutine.create(runEventHandlerInFreeThread)
                coroutine.resume(v1)
            end

            task.spawn(v1, v5._fn, ...)
        end

        v5 = v5._next
    end
end

function t4.Wait(p14) -- line: 149
    local thread = coroutine.running()
    local connection

    connection = p14:Connect(function(...) -- line: 152
        -- upvalues: thread (copy), connection (ref)
        connection:Disconnect()
        task.spawn(thread, ...)
    end)

    return coroutine.yield()
end

function t4.Once(p15, p16) -- line: 161
    local connection

    connection = p15:Connect(function(...) -- line: 163
        -- upvalues: p16 (copy), connection (ref)
        if connection._connected then
            connection:Disconnect()
        end

        p16(...)
    end)

    return connection
end

setmetatable(t4, {
    __index = function(_, p18) -- __index | line: 174
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p18))), 2)
    end,
    __newindex = function(_, p20, _) -- __newindex | line: 177
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p20))), 2)
    end
})

return t4
