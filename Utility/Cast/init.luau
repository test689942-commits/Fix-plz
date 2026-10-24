-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {
    DebugLogging = false,
    VisualizeCasts = false
}

t1.__index = t1
t1.__type = "FastCast"
t1.HighFidelityBehavior = {
    Default = 1,
    Always = 3
}

local ActiveCast = require(script.ActiveCast)
local Signal = require(script.Signal)

require(script.Table)
require(script.TypeDefinitions)
ActiveCast.SetStaticFastCastReference(t1)

function t1.new() -- line: 107
    -- upvalues: t1 (copy), Signal (copy)
    return (setmetatable({
        LengthChanged = Signal.new("LengthChanged"),
        RayHit = Signal.new("RayHit"),
        RayPierced = Signal.new("RayPierced"),
        CastTerminating = Signal.new("CastTerminating"),
        WorldRoot = workspace
    }, t1))
end

function t1.newBehavior() -- line: 119
    -- upvalues: t1 (copy)
    return {
        RaycastParams = nil,
        MaxDistance = 1000,
        CanPierceFunction = nil,
        HighFidelitySegmentSize = 0.5,
        CosmeticBulletTemplate = nil,
        CosmeticBulletProvider = nil,
        CosmeticBulletContainer = nil,
        AutoIgnoreContainer = true,
        Acceleration = Vector3.new(),
        HighFidelityBehavior = t1.HighFidelityBehavior.Default
    }
end

local v1 = t1.newBehavior()

function t1.Fire(p1, p2, p3, p4, p5) -- line: 136
    -- upvalues: ActiveCast (copy), v1 (copy)
    local v2 = if p5 == nil then v1 else p5
    local v3 = ActiveCast.new(p1, p2, p3, p4, v2)

    v3.RayInfo.WorldRoot = p1.WorldRoot

    return v3
end

return t1
