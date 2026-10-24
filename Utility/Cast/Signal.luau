-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

require(script.Parent.TypeDefinitions)

local TestService = game:GetService("TestService")
local Table = require(script.Parent.Table)
local t1 = {}

t1.__index = t1
t1.__type = "Signal"

local t2 = {}

t2.__index = t2
t2.__type = "SignalConnection"

function t1.new(p1) -- line: 44
    -- upvalues: t1 (copy)
    return (setmetatable({
        Name = p1,
        Connections = {},
        YieldingThreads = {}
    }, t1))
end

local function NewConnection(p2, p3) -- line: 53
    -- upvalues: t2 (copy)
    return (setmetatable({
        Index = -1,
        Signal = p2,
        Delegate = p3
    }, t2))
end

local function ThreadAndReportError(p4, p5, p6) -- line: 62
    -- upvalues: TestService (copy)
    local v1 = coroutine.create(function() -- line: 63
        -- upvalues: p4 (copy), p5 (copy)
        p4(unpack(p5))
    end)
    local v2, v3 = coroutine.resume(v1)

    if not v2 then
        TestService:Error(string.format("Exception thrown in your %s event handler: %s", p6, v3))
        TestService:Checkpoint(debug.traceback(v1))
    end
end

function t1.Connect(p7, p8) -- line: 75
    -- upvalues: Table (copy), t1 (copy), t2 (copy)
    assert(getmetatable(p7) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Connect", "Signal.new()"))

    local v5 = setmetatable({
        Index = -1,
        Signal = p7,
        Delegate = p8
    }, t2)

    v5.Index = #p7.Connections + 1
    Table.insert(p7.Connections, v5.Index, v5)

    return v5
end

function t1.Fire(p9, ...) -- line: 83
    -- upvalues: Table (copy), t1 (copy), ThreadAndReportError (copy)
    assert(getmetatable(p9) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Fire", "Signal.new()"))

    local v7 = Table.pack(...)
    local Connections, YieldingThreads = p9.Connections, p9.YieldingThreads

    for i = 1, #Connections do
        local v8 = Connections[i]

        if v8.Delegate ~= nil then
            ThreadAndReportError(v8.Delegate, v7, v8.Signal.Name)
        end
    end

    for i = 1, #YieldingThreads do
        local v9 = YieldingThreads[i]

        if v9 ~= nil then
            coroutine.resume(v9, ...)
        end
    end
end

function t1.FireSync(p10, ...) -- line: 103
    -- upvalues: Table (copy), t1 (copy)
    assert(getmetatable(p10) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("FireSync", "Signal.new()"))

    local v11 = Table.pack(...)
    local Connections, YieldingThreads = p10.Connections, p10.YieldingThreads

    for i = 1, #Connections do
        local v12 = Connections[i]

        if v12.Delegate ~= nil then
            v12.Delegate(unpack(v11))
        end
    end

    for i = 1, #YieldingThreads do
        local v13 = YieldingThreads[i]

        if v13 ~= nil then
            coroutine.resume(v13, ...)
        end
    end
end

function t1.Wait(p11) -- line: 123
    -- upvalues: Table (copy), t1 (copy)
    assert(getmetatable(p11) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Wait", "Signal.new()"))

    local thread = coroutine.running()

    Table.insert(p11.YieldingThreads, thread)

    local t6 = { coroutine.yield() }

    Table.removeObject(p11.YieldingThreads, thread)

    return unpack(t6)
end

function t1.Dispose(p12) -- line: 133
    -- upvalues: t1 (copy)
    assert(getmetatable(p12) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Dispose", "Signal.new()"))

    local Connections = p12.Connections

    for i = 1, #Connections do
        Connections[i]:Disconnect()
    end

    p12.Connections = {}
    setmetatable(p12, nil)
end

function t2.Disconnect(p13) -- line: 143
    -- upvalues: Table (copy), t2 (copy)
    assert(getmetatable(p13) == t2, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Disconnect", "private function NewConnection()"))
    Table.remove(p13.Signal.Connections, p13.Index)
    p13.SignalStatic = nil
    p13.Delegate = nil
    p13.YieldingThreads = {}
    p13.Index = -1
    setmetatable(p13, nil)
end

return t1
