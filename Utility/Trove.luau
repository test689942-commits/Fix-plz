-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local v1 = newproxy()
local v2 = newproxy()
local RunService = game:GetService("RunService")

local function GetObjectCleanupFunction(p1, p2) -- line: 12
    -- upvalues: v1 (copy), v2 (copy)
    local v3 = typeof(p1)

    if v3 == "function" then
        return v1
    end

    if v3 == "thread" then
        return v2
    end

    if p2 then
        return p2
    end

    if v3 == "Instance" then
        return "Destroy"
    end

    if v3 == "RBXScriptConnection" then
        return "Disconnect"
    end

    if v3 == "table" then
        if typeof(p1.Destroy) == "function" then
            return "Destroy"
        end

        if typeof(p1.Disconnect) == "function" then
            return "Disconnect"
        end
    end

    error("Failed to get cleanup function for object " .. v3 .. ": " .. tostring(p1), 3)
end

local function AssertPromiseLike(p3) -- line: 37
    if type(p3) ~= "table" or type(p3.getStatus) ~= "function" or type(p3.finally) ~= "function" or type(p3.cancel) ~= "function" then
        error("Did not receive a Promise as an argument", 3)
    end
end

local t1 = {}

t1.__index = t1

function t1.new(p4) -- line: 46
    p4._objects = {}
end

function t1.Extend(p5) -- line: 50
    -- upvalues: t1 (copy)
    return p5:Construct(t1)
end

function t1.Clone(p6, p7) -- line: 54
    return p6:Add(p7:Clone())
end

function t1.Construct(p8, p9, ...) -- line: 58
    local v5 = type(p9)
    local v6 = if v5 == "table" then p9.new(...) elseif v5 == "function" then p9(...) else nil

    return p8:Add(v6)
end

function t1.Connect(p10, p11, p12) -- line: 69
    return p10:Add(p11:Connect(p12))
end

function t1.BindToRenderStep(p13, p14, p15, p16) -- line: 73
    -- upvalues: RunService (copy)
    RunService:BindToRenderStep(p14, p15, p16)
    p13:Add(function() -- line: 75
        -- upvalues: p14 (copy), RunService (copy)
        RunService:UnbindFromRenderStep(p14)
    end)
end

function t1.AddPromise(p17, p18) -- line: 80
    if type(p18) ~= "table" or type(p18.getStatus) ~= "function" or type(p18.finally) ~= "function" or type(p18.cancel) ~= "function" then
        error("Did not receive a Promise as an argument", 3)
    end

    if p18:getStatus() == "Started" then
        p18:finally(function() -- line: 83
            -- upvalues: p17 (copy), p18 (copy)
            return p17:_findAndRemoveFromObjects(p18, false)
        end)
        p17:Add(p18, "cancel")
    end

    return p18
end

function t1.Add(p19, p20, p21) -- line: 92
    -- upvalues: GetObjectCleanupFunction (copy)
    if p20 == nil then
        return
    end

    local v8 = GetObjectCleanupFunction(p20, p21)

    table.insert(p19._objects, {
        p20,
        v8
    })

    return p20
end

function t1.Remove(p22, p23) -- line: 112
    return p22:_findAndRemoveFromObjects(p23, true)
end

function t1.Clean(p24) -- line: 122
    for _, v9 in ipairs(p24._objects) do
        p24:_cleanupObject(v9[1], v9[2])
    end

    table.clear(p24._objects)
end

function t1._findAndRemoveFromObjects(p25, p26, p27) -- line: 130
    local _objects = p25._objects

    for v10, v11 in ipairs(_objects) do
        if v11[1] == p26 then
            local v12 = #_objects

            _objects[v10] = _objects[v12]
            _objects[v12] = nil

            if p27 then
                p25:_cleanupObject(v11[1], v11[2])
            end

            return true
        end
    end

    return false
end

function t1._cleanupObject(_, p29, p30) -- line: 147
    -- upvalues: v1 (copy), v2 (copy)
    if p30 == v1 then
        p29()
    elseif p30 == v2 then
        if coroutine.status(p29) == "suspended" then
            coroutine.close(p29)
        else
            task.spawn(function() -- line: 154
                -- upvalues: p29 (copy)
                task.wait()
                coroutine.close(p29)
            end)
        end
    elseif p29[p30] then
        p29[p30](p29)
    end
end

function t1.AttachToInstance(p31, p32) -- line: 166
    assert(p32:IsDescendantOf(game), "Instance is not a descendant of the game hierarchy")

    return p31:Connect(p32.Destroying, function() -- line: 168
        -- upvalues: p31 (copy)
        p31:Destroy()
    end)
end

function t1.Destroy(p33) -- line: 173
    p33:Clean()
end

return t1
