-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local t1 = {}

local function round(p1) -- line: 12
    return (math.floor(p1 + 0.5))
end

local t2 = {}

t2.__index = t2

function t2.new(p2, p3) -- line: 21
    -- upvalues: t2 (copy)
    return (setmetatable({
        vel = 0,
        freq = p2,
        goal = p3,
        pos = p3
    }, t2))
end

function t2.step(p4, p5) -- line: 31
    local v2 = p4.freq * 2 * 3.141592653589793
    local goal, pos, vel = p4.goal, p4.pos, p4.vel
    local v3 = pos - goal
    local v5 = math.exp(-v2 * p5)
    local v6 = (v3 * (v2 * p5 + 1) + vel * p5) * v5 + goal
    local v7 = (vel * (1 - v2 * p5) - v3 * (v2 * v2 * p5)) * v5

    p4.pos = v6
    p4.vel = v7

    return v6
end

t1.Spring = t2

function t1.map(p6, p7, p8, p9, p10) -- line: 53
    return (p6 - p7) * (p10 - p9) / (p8 - p7) + p9
end

function t1.mapClamp(p11, p12, p13, p14, p15) -- line: 58
    return (math.clamp((p11 - p12) * (p15 - p14) / (p13 - p12) + p14, math.min(p14, p15), (math.max(p14, p15))))
end

function t1.getLooseBoundingSphere(p16) -- line: 67
    local v11 = table.create(#p16)

    for v12, v13 in pairs(p16) do
        v11[v12] = v13.Position
    end

    local v14 = v11[1]
    local v15 = v14
    local n1 = 0

    for _, v16 in ipairs(v11) do
        local Magnitude = (v16 - v14).Magnitude

        if n1 < Magnitude then
            n1 = Magnitude
            v15 = v16
        end
    end

    local n2 = 0
    local v17 = v15

    for _, v18 in ipairs(v11) do
        local Magnitude = (v18 - v15).Magnitude

        if n2 < Magnitude then
            v17 = v18
            n2 = Magnitude
        end
    end

    local v19 = (v15 + v17) * 0.5
    local v20 = (v15 - v17).Magnitude * 0.5

    for _, v21 in ipairs(v11) do
        local Magnitude = (v21 - v19).Magnitude

        if v20 < Magnitude then
            v19 += (Magnitude - v20) * 0.5 * (v21 - v19).Unit
            v20 = (Magnitude + v20) * 0.5
        end
    end

    return v19, v20
end

function t1.sanitizeAngle(p17) -- line: 123
    return (p17 + 3.141592653589793) % 6.283185307179586 - 3.141592653589793
end

function t1.Round(p18, p19) -- line: 128
    local v22 = 10 ^ p19

    return math.floor(p18 * v22 + 0.5) / v22
end

function t1.IsFinite(p20) -- line: 133
    if p20 ~= p20 or p20 == 1e999 then
        return false
    end

    return p20 ~= (-1e999)
end

function t1.IsFiniteVector3(p21) -- line: 137
    -- upvalues: t1 (copy)
    return t1.IsFinite(p21.X) and t1.IsFinite(p21.Y) and t1.IsFinite(p21.Z)
end

function t1.GetAngleBetweenXZVectors(p22, p23) -- line: 142
    return (math.atan2(p23.X * p22.Z - p23.Z * p22.X, p23.X * p22.X + p23.Z * p22.Z))
end

function t1.RotateVectorByAngleAndRound(p24, p25, p26) -- line: 146
    if p24.Magnitude > 0 then
        local Unit = p24.Unit
        local v26 = math.atan2(Unit.Z, Unit.X)

        return math.floor((math.atan2(Unit.Z, Unit.X) + p25) / p26 + 0.5) * p26 - v26
    end

    return 0
end

local function SCurveTranform(p27) -- line: 160
    local v28 = math.clamp(p27, -1, 1)

    if v28 >= 0 then
        return v28 * 0.35 / (0.35 - v28 + 1)
    end

    return -(-v28 * 0.8 / (v28 + 0.8 + 1))
end

local function toSCurveSpace(p28) -- line: 169
    return (math.abs(p28) * 2 - 1) * 1.1 - 0.1
end

local function fromSCurveSpace(p29) -- line: 173
    return p29 / 2 + 0.5
end

function t1.GamepadLinearToCurve(p30) -- line: 177
    local function onAxis(p31) -- line: 178
        local v29 = if p31 < 0 then -1 else 1
        local v32 = math.clamp((math.abs((math.abs(p31))) * 2 - 1) * 1.1 - 0.1, -1, 1)

        return (math.clamp(((if v32 >= 0 then v32 * 0.35 / (0.35 - v32 + 1) else -(-v32 * 0.8 / (v32 + 0.8 + 1))) / 2 + 0.5) * v29, -1, 1))
    end

    local new = Vector2.new
    local X = p30.X
    local v34 = if X < 0 then -1 else 1
    local v37 = math.clamp((math.abs((math.abs(X))) * 2 - 1) * 1.1 - 0.1, -1, 1)
    local v39 = math.clamp(((if v37 >= 0 then v37 * 0.35 / (0.35 - v37 + 1) else -(-v37 * 0.8 / (v37 + 0.8 + 1))) / 2 + 0.5) * v34, -1, 1)
    local Y = p30.Y
    local v40 = if Y < 0 then -1 else 1
    local v43 = math.clamp((math.abs((math.abs(Y))) * 2 - 1) * 1.1 - 0.1, -1, 1)

    return new(v39, (math.clamp(((if v43 >= 0 then v43 * 0.35 / (0.35 - v43 + 1) else -(-v43 * 0.8 / (v43 + 0.8 + 1))) / 2 + 0.5) * v40, -1, 1)))
end

function t1.ConvertCameraModeEnumToStandard(p32) -- line: 191
    if p32 == Enum.TouchCameraMovementMode.Default then
        return Enum.ComputerCameraMovementMode.Follow
    end

    if p32 == Enum.ComputerCameraMovementMode.Default or p32 == Enum.TouchCameraMovementMode.Classic or p32 == Enum.DevTouchCameraMovementMode.Classic or p32 == Enum.DevComputerCameraMovementMode.Classic or p32 == Enum.ComputerCameraMovementMode.Classic then
        return Enum.ComputerCameraMovementMode.Classic
    end

    if p32 == Enum.TouchCameraMovementMode.Follow or p32 == Enum.DevTouchCameraMovementMode.Follow or p32 == Enum.DevComputerCameraMovementMode.Follow or p32 == Enum.ComputerCameraMovementMode.Follow then
        return Enum.ComputerCameraMovementMode.Follow
    end

    if p32 == Enum.TouchCameraMovementMode.Orbital or p32 == Enum.DevTouchCameraMovementMode.Orbital or p32 == Enum.DevComputerCameraMovementMode.Orbital or p32 == Enum.ComputerCameraMovementMode.Orbital then
        return Enum.ComputerCameraMovementMode.Orbital
    end

    if p32 == Enum.ComputerCameraMovementMode.CameraToggle or p32 == Enum.DevComputerCameraMovementMode.CameraToggle then
        return Enum.ComputerCameraMovementMode.CameraToggle
    end

    if p32 == Enum.DevTouchCameraMovementMode.UserChoice or p32 == Enum.DevComputerCameraMovementMode.UserChoice then
        return Enum.DevComputerCameraMovementMode.UserChoice
    end

    return Enum.ComputerCameraMovementMode.Classic
end

local function getMouse() -- line: 240
    -- upvalues: Players (copy)
    local LocalPlayer = Players.LocalPlayer

    if not LocalPlayer then
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        LocalPlayer = Players.LocalPlayer
    end

    assert(LocalPlayer)

    return LocalPlayer:GetMouse()
end

local v45 = ""
local v46

function t1.setMouseIconOverride(p33) -- line: 252
    -- upvalues: Players (copy), v45 (ref), v46 (ref)
    local LocalPlayer = Players.LocalPlayer

    if not LocalPlayer then
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        LocalPlayer = Players.LocalPlayer
    end

    assert(LocalPlayer)

    local Mouse = LocalPlayer:GetMouse()

    if Mouse.Icon ~= v46 then
        v45 = Mouse.Icon
    end

    Mouse.Icon = p33
    v46 = p33
end

function t1.restoreMouseIcon() -- line: 263
    -- upvalues: Players (copy), v45 (ref), v46 (ref)
    local LocalPlayer = Players.LocalPlayer

    if not LocalPlayer then
        Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
        LocalPlayer = Players.LocalPlayer
    end

    assert(LocalPlayer)

    local Mouse = LocalPlayer:GetMouse()

    if Mouse.Icon == v46 then
        Mouse.Icon = v45
    end

    v46 = nil
end

local v47 = Enum.MouseBehavior.Default
local v48

function t1.setMouseBehaviorOverride(p34) -- line: 274
    -- upvalues: UserInputService (copy), v47 (ref), v48 (ref)
    if UserInputService.MouseBehavior ~= v48 then
        v47 = UserInputService.MouseBehavior
    end

    UserInputService.MouseBehavior = p34
    v48 = p34
end

function t1.restoreMouseBehavior() -- line: 283
    -- upvalues: UserInputService (copy), v47 (ref), v48 (ref)
    if UserInputService.MouseBehavior == v48 then
        UserInputService.MouseBehavior = v47
    end

    v48 = nil
end

local v49 = Enum.RotationType.MovementRelative
local v50

function t1.setRotationTypeOverride(p35) -- line: 292
    -- upvalues: UserGameSettings (copy), v49 (ref), v50 (ref)
    if UserGameSettings.RotationType ~= v50 then
        v49 = UserGameSettings.RotationType
    end

    UserGameSettings.RotationType = p35
    v50 = p35
end

function t1.restoreRotationType() -- line: 301
    -- upvalues: UserGameSettings (copy), v49 (ref), v50 (ref)
    if UserGameSettings.RotationType == v50 then
        UserGameSettings.RotationType = v49
    end

    v50 = nil
end

return t1
