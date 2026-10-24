-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local ZoomController = require(script.Parent:WaitForChild("ZoomController"))
local VehicleCameraCore = require(script:WaitForChild("VehicleCameraCore"))
local VehicleCameraConfig = require(script:WaitForChild("VehicleCameraConfig"))
local LocalPlayer = Players.LocalPlayer
local _, Spring, mapClamp, sanitizeAngle = CameraUtils.map, CameraUtils.Spring, CameraUtils.mapClamp, CameraUtils.sanitizeAngle

local function pitchVelocity(p1, p2) -- line: 26
    return (math.abs((p2.XVector:Dot(p1))))
end

local function yawVelocity(p3, p4) -- line: 31
    return (math.abs((p4.YVector:Dot(p3))))
end

local n1 = 0.016666666666666666

RunService.Stepped:Connect(function(_, p6) -- line: 37
    -- upvalues: n1 (ref)
    n1 = p6
end)

local self = setmetatable({}, BaseCamera)

self.__index = self

function self.new() -- line: 44
    -- upvalues: BaseCamera (copy), self (copy)
    local v5 = setmetatable(BaseCamera.new(), self)

    v5:Reset()

    return v5
end

function self.Reset(p7) -- line: 50
    -- upvalues: CameraUtils (copy), VehicleCameraCore (copy), VehicleCameraConfig (copy), Spring (copy)
    p7.vehicleCameraCore = VehicleCameraCore.new(p7:GetSubjectCFrame())
    p7.pitchSpring = Spring.new(0, -math.rad(VehicleCameraConfig.pitchBaseAngle))
    p7.yawSpring = Spring.new(0, 0)
    p7.lastPanTick = 0

    local CurrentCamera = workspace.CurrentCamera
    local v6 = CurrentCamera and CurrentCamera.CameraSubject

    assert(CurrentCamera)
    assert(v6)
    assert(v6:IsA("VehicleSeat"))

    local ConnectedParts = v6:GetConnectedParts(true)
    local v7, v8 = CameraUtils.getLooseBoundingSphere(ConnectedParts)

    p7.assemblyRadius = math.max(v8, 0.001)
    p7.assemblyOffset = v6.CFrame:Inverse() * v7
    p7:_StepInitialZoom()
end

function self._StepInitialZoom(p8) -- line: 74
    -- upvalues: ZoomController (copy), VehicleCameraConfig (copy)
    p8:SetCameraToSubjectDistance((math.max(ZoomController.GetZoomRadius(), p8.assemblyRadius * VehicleCameraConfig.initialZoomRadiusMul)))
end

function self._StepRotation(p9, p10, p11) -- line: 81
    -- upvalues: CameraInput (copy), VehicleCameraConfig (copy), mapClamp (copy), sanitizeAngle (copy)
    local yawSpring, pitchSpring = p9.yawSpring, p9.pitchSpring
    local v11 = CameraInput.getRotation(true)
    local v12 = -v11.X
    local v13 = -v11.Y

    yawSpring.pos = sanitizeAngle(yawSpring.pos + v12)
    pitchSpring.pos = sanitizeAngle((math.clamp(pitchSpring.pos + v13, -1.3962634015954636, 1.3962634015954636)))

    if CameraInput.getRotationActivated() then
        p9.lastPanTick = os.clock()
    end

    local v15 = -math.rad(VehicleCameraConfig.pitchBaseAngle)
    local v16 = math.rad(VehicleCameraConfig.pitchDeadzoneAngle)

    if os.clock() - p9.lastPanTick > VehicleCameraConfig.autocorrectDelay then
        local v17 = mapClamp(p11, VehicleCameraConfig.autocorrectMinCarSpeed, VehicleCameraConfig.autocorrectMaxCarSpeed, 0, VehicleCameraConfig.autocorrectResponse)

        yawSpring.freq = v17
        pitchSpring.freq = v17

        if yawSpring.freq < 0.001 then
            yawSpring.vel = 0
        end

        if pitchSpring.freq < 0.001 then
            pitchSpring.vel = 0
        end

        if math.abs((sanitizeAngle(v15 - pitchSpring.pos))) <= v16 then
            pitchSpring.goal = pitchSpring.pos
        else
            pitchSpring.goal = v15
        end
    else
        yawSpring.freq = 0
        yawSpring.vel = 0
        pitchSpring.freq = 0
        pitchSpring.vel = 0
        pitchSpring.goal = v15
    end

    return CFrame.fromEulerAnglesYXZ(pitchSpring:step(p10), yawSpring:step(p10), 0)
end

function self._GetThirdPersonLocalOffset(p12) -- line: 144
    -- upvalues: VehicleCameraConfig (copy)
    return p12.assemblyOffset + Vector3.new(0, p12.assemblyRadius * VehicleCameraConfig.verticalCenterOffset, 0)
end

function self._GetFirstPersonLocalOffset(p13, p14) -- line: 148
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character

    if Character and Character.Parent then
        local Head = Character:FindFirstChild("Head")

        if Head and Head:IsA("BasePart") then
            return p14:Inverse() * Head.Position
        end
    end

    return p13:_GetThirdPersonLocalOffset()
end

function self.Update(p15) -- line: 162
    -- upvalues: mapClamp (copy), n1 (ref)
    local CurrentCamera = workspace.CurrentCamera
    local v20 = CurrentCamera and CurrentCamera.CameraSubject
    local vehicleCameraCore = p15.vehicleCameraCore

    assert(CurrentCamera)
    assert(v20)
    assert(v20:IsA("VehicleSeat"))

    local v21 = n1

    n1 = 0

    local SubjectCFrame = p15:GetSubjectCFrame()
    local SubjectVelocity = p15:GetSubjectVelocity()
    local SubjectRotVelocity = p15:GetSubjectRotVelocity()
    local v23 = math.abs((SubjectVelocity:Dot(SubjectCFrame.ZVector)))
    local v25 = math.abs((SubjectCFrame.YVector:Dot(SubjectRotVelocity)))
    local v27 = math.abs((SubjectCFrame.XVector:Dot(SubjectRotVelocity)))
    local v28 = p15:StepZoom()
    local v29 = p15:_StepRotation(v21, v23)
    local v30 = mapClamp(v28, 0.5, p15.assemblyRadius, 1, 0)
    local v31 = p15:_GetThirdPersonLocalOffset():Lerp(p15:_GetFirstPersonLocalOffset(SubjectCFrame), v30)

    vehicleCameraCore:setTransform(SubjectCFrame)

    local v32 = vehicleCameraCore:step(v21, v27, v25, v30)
    local v33 = CFrame.new(SubjectCFrame * v31) * v32 * v29

    return v33 * CFrame.new(0, 0, v28), v33
end

function self.ApplyVRTransform(_) -- line: 207
end

function self.EnterFirstPerson(p17) -- line: 211
    p17.inFirstPerson = true
    p17:UpdateMouseBehavior()
end

function self.LeaveFirstPerson(p18) -- line: 216
    p18.inFirstPerson = false
    p18:UpdateMouseBehavior()
end

return self
