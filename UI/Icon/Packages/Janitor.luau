-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local RunService = game:GetService("RunService")
local Heartbeat = RunService.Heartbeat

local function getPromiseReference() -- line: 25
    -- upvalues: RunService (copy)
    if RunService:IsRunning() then
        return require(game:GetService("ReplicatedStorage").Framework).modules.Promise
    end
end

local v1 = newproxy(true)

getmetatable(v1).__tostring = function() -- line: 33
    return "IndicesReference"
end

local v2 = newproxy(true)

getmetatable(v2).__tostring = function() -- line: 38
    return "LinkToInstanceIndex"
end

local t1 = {
    IGNORE_MEMORY_DEBUG = true,
    ClassName = "Janitor",
    __index = {
        CurrentlyCleaning = true,
        [v1] = nil
    }
}
local t3 = {
    ["function"] = true,
    Promise = "cancel",
    RBXScriptConnection = "Disconnect"
}

function t1.new() -- line: 64
    -- upvalues: v1 (copy), t1 (copy)
    return (setmetatable({
        CurrentlyCleaning = false,
        [v1] = nil
    }, t1))
end

function t1.Is(p1) -- line: 76
    -- upvalues: t1 (copy)
    if type(p1) == "table" then
        return getmetatable(p1) == t1
    end

    return false
end

t1.is = t1.Is

function t1.__index.Add(p2, p3, p4, p5) -- line: 89
    -- upvalues: v1 (copy), t3 (copy)
    if p5 then
        p2:Remove(p5)

        local v3 = p2[v1]

        if not v3 then
            v3 = {}
            p2[v1] = v3
        end

        v3[p5] = p3
    end

    local v4 = typeof(p3)

    if v4 == "table" and string.match(tostring(p3), "Promise") then
        v4 = "Promise"
    end

    p4 = p4 or t3[v4] or "Destroy"

    if type(p3) ~= "function" and not p3[p4] then
        warn(string.format("Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s", tostring(p3), tostring(p4), debug.traceback(nil, 2)))
    end

    p2[p3] = {
        p4,
        (debug.traceback(""))
    }

    return p3
end

t1.__index.Give = t1.__index.Add

function t1.__index.AddPromise(p6, p7) -- line: 126
    -- upvalues: RunService (copy)
    local Promise = if RunService:IsRunning() then require(game:GetService("ReplicatedStorage").Framework).modules.Promise else nil

    if not Promise then
        return p7
    end

    if not Promise.is(p7) then
        error(string.format("Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %s (%s))", typeof(p7), (tostring(p7))))
    end

    if p7:getStatus() ~= Promise.Status.Started then
        return p7
    end

    local v6 = newproxy(false)
    local v7 = p6:Add(Promise.new(function(p8, _, p10) -- line: 134
        -- upvalues: p7 (copy)
        if not p10(function() -- line: 135
            -- upvalues: p7 (copy)
            p7:cancel()
        end) then
            p8(p7)
        end
    end), "cancel", v6)

    v7:finallyCall(p6.Remove, p6, v6)

    return v7
end

t1.__index.GivePromise = t1.__index.AddPromise

function t1.__index.AddObject(p11, p12) -- line: 156
    -- upvalues: RunService (copy)
    local v8 = newproxy(false)
    local Promise = if RunService:IsRunning() then require(game:GetService("ReplicatedStorage").Framework).modules.Promise else nil

    if Promise and Promise.is(p12) then
        if p12:getStatus() ~= Promise.Status.Started then
            return p12
        end

        local v9 = p11:Add(Promise.resolve(p12), "cancel", v8)

        v9:finallyCall(p11.Remove, p11, v8)

        return v9, v8
    end

    return p11:Add(p12, false, v8), v8
end

t1.__index.GiveObject = t1.__index.AddObject

function t1.__index.Remove(p13, p14) -- line: 179
    -- upvalues: v1 (copy)
    local v10 = p13[v1]
    local v11, v12

    if v10 then
        v11 = v10[p14]

        if v11 then
            local v13 = p13[v11]

            v12 = v13 and v13[1]

            if v12 then
                if v12 == true then
                    v11()
                else
                    local v14 = v11[v12]

                    if v14 then
                        v14(v11)
                    end
                end

                p13[v11] = nil
            end

            v10[p14] = nil
        end
    end

    return p13
end

function t1.__index.Get(p15, p16) -- line: 213
    -- upvalues: v1 (copy)
    local v15 = p15[v1]

    if v15 then
        return v15[p16]
    end
end

function t1.__index.Cleanup(p17) -- line: 224
    -- upvalues: v1 (copy)
    if p17.CurrentlyCleaning then
        return
    end

    p17.CurrentlyCleaning = nil

    for v16, v17 in next, p17 do
        if v16 ~= v1 then
            local v18 = type(v16)

            if v18 ~= "string" and v18 ~= "number" then
                local v19 = v17[1]
                local v20 = v17[2]

                local function warnUser(p18) -- line: 241
                    -- upvalues: v20 (copy)
                    local v21 = debug.traceback("", 3)

                    warn("-------- Janitor Error --------" .. "\n" .. tostring(p18) .. "\n" .. v21 .. "" .. v20)
                end

                if v19 == true then
                    local ok, result = pcall(v16)

                    if not ok then
                        local v22 = debug.traceback("", 3)

                        warn("-------- Janitor Error --------" .. "\n" .. tostring(result) .. "\n" .. v22 .. "" .. v20)
                    end
                else
                    local v23 = v16[v19]

                    if v23 then
                        local ok, result = pcall(v23, v16)
                        local v24 = typeof(v16) == "Instance" and v23 == "Destroy"

                        if not ok and not v24 then
                            local v25 = debug.traceback("", 3)

                            warn("-------- Janitor Error --------" .. "\n" .. tostring(result) .. "\n" .. v25 .. "" .. v20)
                        end
                    end
                end
            end

            p17[v16] = nil
        end
    end

    local v26 = p17[v1]

    if v26 then
        for v27 in next, v26 do
            v26[v27] = nil
        end

        p17[v1] = {}
    end

    p17.CurrentlyCleaning = false
end

t1.__index.Clean = t1.__index.Cleanup

function t1.__index.Destroy(p19) -- line: 284
    p19:Cleanup()
end

t1.__call = t1.__index.Cleanup

local t5 = {
    Connected = true
}

t5.__index = t5

function t5.Disconnect(p20) -- line: 298
    if p20.Connected then
        p20.Connected = false
        p20.Connection:Disconnect()
    end
end

function t5.__tostring(p21) -- line: 305
    return "Disconnect<" .. tostring(p21.Connected) .. ">"
end

function t1.__index.LinkToInstance(p22, p23, p24) -- line: 315
    -- upvalues: Heartbeat (copy), v2 (copy), t5 (copy)
    local connection
    local v28 = p24 and newproxy(false) or v2
    local v29 = p23.Parent == nil
    local self = setmetatable({}, t5)

    local function ChangedFunction(_, p26) -- line: 321
        -- upvalues: p22 (copy), connection (ref), v29 (ref), self (copy), Heartbeat (copy)
        if self.Connected then
            v29 = p26 == nil

            if v29 then
                coroutine.wrap(function() -- line: 327
                    -- upvalues: p22 (copy), connection (ref), v29 (ref), self (copy), Heartbeat (copy)
                    Heartbeat:Wait()

                    if self.Connected then
                        if connection.Connected then
                            while v29 and connection.Connected and self.Connected do
                                Heartbeat:Wait()
                            end

                            if self.Connected and v29 then
                                p22:Cleanup()
                            end
                        else
                            p22:Cleanup()
                        end
                    end
                end)()
            end
        end
    end

    connection = p23.AncestryChanged:Connect(ChangedFunction)
    self.Connection = connection

    if v29 then
        local Parent = p23.Parent

        if self.Connected then
            v29 = Parent == nil

            if v29 then
                coroutine.wrap(function() -- line: 327
                    -- upvalues: p22 (copy), connection (ref), v29 (ref), self (copy), Heartbeat (copy)
                    Heartbeat:Wait()

                    if self.Connected then
                        if connection.Connected then
                            while v29 and connection.Connected and self.Connected do
                                Heartbeat:Wait()
                            end

                            if self.Connected and v29 then
                                p22:Cleanup()
                            end
                        else
                            p22:Cleanup()
                        end
                    end
                end)()
            end
        end
    end

    return p22:Add(self, "Disconnect", v28)
end

function t1.__index.LinkToInstances(p27, ...) -- line: 363
    -- upvalues: t1 (copy)
    local v31 = t1.new()

    for _, v32 in ipairs({ ... }) do
        v31:Add(p27:LinkToInstance(v32, true), "Disconnect")
    end

    return v31
end

for v33, v34 in next, t1.__index do
    local v36 = string.sub(string.lower(v33), 1, 1) .. string.sub(v33, 2)

    t1.__index[v36] = v34
end

return t1
