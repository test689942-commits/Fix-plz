-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local CameraUtils = require(script.Parent.Parent.CameraUtils)
local VehicleCameraConfig = require(script.Parent.VehicleCameraConfig)
local map, mapClamp, sanitizeAngle = CameraUtils.map, CameraUtils.mapClamp, CameraUtils.sanitizeAngle

local function getYaw(p1) -- line: 10
    -- upvalues: sanitizeAngle (copy)
    local _, v1 = p1:toEulerAnglesYXZ()

    return sanitizeAngle(v1)
end

local function getPitch(p2) -- line: 16
    -- upvalues: sanitizeAngle (copy)
    return sanitizeAngle((p2:toEulerAnglesYXZ()))
end

local function stepSpringAxis(p3, p4, p5, p6, p7) -- line: 22
    -- upvalues: sanitizeAngle (copy)
    local v3 = sanitizeAngle(p6 - p5)
    local v5 = math.exp(-p4 * p3)

    return sanitizeAngle((v3 * (1 + p4 * p3) + p7 * p3) * v5 + p5), (p7 * (1 - p4 * p3) - v3 * (p4 * p4 * p3)) * v5
end

local t1 = {}

t1.__index = t1

function t1.new(p8, p9, p10) -- line: 36
    -- upvalues: t1 (copy)
    return (setmetatable({
        fRising = p8,
        fFalling = p9,
        g = p10,
        p = p10,
        v = p10 * 0
    }, t1))
end

function t1.step(p11, p12) -- line: 46
    local fRising, fFalling, g, p = p11.fRising, p11.fFalling, p11.g, p11.p
    local v = p11.v

    if v > 0 and fRising then
        fFalling = fRising
    end

    local v6 = 6.283185307179586 * fFalling
    local v7 = p - g
    local v9 = math.exp(-v6 * p12)
    local v10 = (v7 * (1 + v6 * p12) + v * p12) * v9 + g
    local v11 = (v * (1 - v6 * p12) - v7 * (v6 * v6 * p12)) * v9

    p11.p = v10
    p11.v = v11

    return v10
end

local t3 = {}

t3.__index = t3

function t3.new(p13) -- line: 72
    -- upvalues: VehicleCameraConfig (copy), sanitizeAngle (copy), t1 (copy), t3 (copy)
    assert(typeof(p13) == "CFrame")

    local t4 = {
        yawV = 0,
        pitchV = 0
    }
    local _, v13 = p13:toEulerAnglesYXZ()

    t4.yawG = sanitizeAngle(v13)

    local _, v14 = p13:toEulerAnglesYXZ()

    t4.yawP = sanitizeAngle(v14)
    t4.pitchG = sanitizeAngle((p13:toEulerAnglesYXZ()))
    t4.pitchP = sanitizeAngle((p13:toEulerAnglesYXZ()))
    t4.fSpringYaw = t1.new(VehicleCameraConfig.yawReponseDampingRising, VehicleCameraConfig.yawResponseDampingFalling, 0)
    t4.fSpringPitch = t1.new(VehicleCameraConfig.pitchReponseDampingRising, VehicleCameraConfig.pitchResponseDampingFalling, 0)

    return (setmetatable(t4, t3))
end

function t3.setGoal(p14, p15) -- line: 99
    -- upvalues: sanitizeAngle (copy)
    assert(typeof(p15) == "CFrame")

    local _, v18 = p15:toEulerAnglesYXZ()

    p14.yawG = sanitizeAngle(v18)
    p14.pitchG = sanitizeAngle((p15:toEulerAnglesYXZ()))
end

function t3.getCFrame(p16) -- line: 106
    return CFrame.fromEulerAnglesYXZ(p16.pitchP, p16.yawP, 0)
end

function t3.step(p17, p18, p19, p20, p21) -- line: 110
    -- upvalues: VehicleCameraConfig (copy), map (copy), mapClamp (copy), sanitizeAngle (copy)
    assert(typeof(p18) == "number")
    assert(typeof(p20) == "number")
    assert(typeof(p19) == "number")
    assert(typeof(p21) == "number")

    local fSpringYaw, fSpringPitch = p17.fSpringYaw, p17.fSpringPitch

    fSpringYaw.g = mapClamp(map(p21, 0, 1, p20, 0), math.rad(VehicleCameraConfig.cutoffMinAngularVelYaw), math.rad(VehicleCameraConfig.cutoffMaxAngularVelYaw), 1, 0)
    fSpringPitch.g = mapClamp(map(p21, 0, 1, p19, 0), math.rad(VehicleCameraConfig.cutoffMinAngularVelPitch), math.rad(VehicleCameraConfig.cutoffMaxAngularVelPitch), 1, 0)

    local v28 = 6.283185307179586 * VehicleCameraConfig.yawStiffness * fSpringYaw:step(p18)
    local v29 = 6.283185307179586 * VehicleCameraConfig.pitchStiffness * fSpringPitch:step(p18) * map(p21, 0, 1, 1, VehicleCameraConfig.firstPersonResponseMul)
    local v30 = v28 * map(p21, 0, 1, 1, VehicleCameraConfig.firstPersonResponseMul)
    local yawG, yawP, yawV = p17.yawG, p17.yawP, p17.yawV
    local v31 = sanitizeAngle(yawP - yawG)
    local v33 = math.exp(-v30 * p18)
    local v34 = sanitizeAngle((v31 * (1 + v30 * p18) + yawV * p18) * v33 + yawG)
    local v35 = (yawV * (1 - v30 * p18) - v31 * (v30 * v30 * p18)) * v33

    p17.yawP = v34
    p17.yawV = v35

    local pitchG, pitchP, pitchV = p17.pitchG, p17.pitchP, p17.pitchV
    local v36 = sanitizeAngle(pitchP - pitchG)
    local v38 = math.exp(-v29 * p18)
    local v39 = sanitizeAngle((v36 * (1 + v29 * p18) + pitchV * p18) * v38 + pitchG)
    local v40 = (pitchV * (1 - v29 * p18) - v36 * (v29 * v29 * p18)) * v38

    p17.pitchP = v39
    p17.pitchV = v40

    return p17:getCFrame()
end

local t5 = {}

t5.__index = t5

function t5.new(p22) -- line: 167
    -- upvalues: t3 (copy), t5 (copy)
    return (setmetatable({
        vrs = t3.new(p22)
    }, t5))
end

function t5.step(p23, p24, p25, p26, p27) -- line: 173
    return p23.vrs:step(p24, p25, p26, p27)
end

function t5.setTransform(p28, p29) -- line: 177
    p28.vrs:setGoal(p29)
end

return t5
