-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"))

require(script.Parent:WaitForChild("CameraInput"))

local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local ZoomController = require(script.Parent:WaitForChild("ZoomController"))

require(script.Parent:WaitForChild("VehicleCamera"))

local VehicleCameraCore = require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraCore"))
local VehicleCameraConfig = require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraConfig"))
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

game:GetService("VRService")

local LocalPlayer = Players.LocalPlayer
local Spring, mapClamp, _ = CameraUtils.Spring, CameraUtils.mapClamp, CameraUtils.sanitizeAngle

local function pitchVelocity(p1, p2) -- line: 35
    return (math.abs((p2.XVector:Dot(p1))))
end

local function yawVelocity(p3, p4) -- line: 40
    return (math.abs((p4.YVector:Dot(p3))))
end

local n1 = 0.016666666666666666
local self = setmetatable({}, VRBaseCamera)

self.__index = self

function self.new() -- line: 48
    -- upvalues: VRBaseCamera (copy), RunService (copy), n1 (ref), self (copy)
    local v5 = setmetatable(VRBaseCamera.new(), self)

    v5:Reset()
    RunService.Stepped:Connect(function(_, p6) -- line: 53
        -- upvalues: n1 (ref)
        n1 = p6
    end)

    return v5
end

function self.Reset(p7) -- line: 60
    -- upvalues: CameraUtils (copy), VehicleCameraCore (copy), VehicleCameraConfig (copy), Spring (copy)
    p7.vehicleCameraCore = VehicleCameraCore.new(p7:GetSubjectCFrame())
    p7.pitchSpring = Spring.new(0, -math.rad(VehicleCameraConfig.pitchBaseAngle))
    p7.yawSpring = Spring.new(0, 0)

    local CurrentCamera = workspace.CurrentCamera
    local v6 = CurrentCamera and CurrentCamera.CameraSubject

    assert(CurrentCamera, "VRVehicleCamera initialization error")
    assert(v6)
    assert(v6:IsA("VehicleSeat"))

    local ConnectedParts = v6:GetConnectedParts(true)
    local v7, v8 = CameraUtils.getLooseBoundingSphere(ConnectedParts)

    p7.assemblyRadius = math.max(v8, 0.001)
    p7.assemblyOffset = v6.CFrame:Inverse() * v7
    p7.lastCameraFocus = nil
    p7:_StepInitialZoom()
end

function self._StepInitialZoom(p8) -- line: 85
    -- upvalues: ZoomController (copy), VehicleCameraConfig (copy)
    p8:SetCameraToSubjectDistance((math.max(ZoomController.GetZoomRadius(), p8.assemblyRadius * VehicleCameraConfig.initialZoomRadiusMul)))
end

function self._GetThirdPersonLocalOffset(p9) -- line: 92
    -- upvalues: VehicleCameraConfig (copy)
    return p9.assemblyOffset + Vector3.new(0, p9.assemblyRadius * VehicleCameraConfig.verticalCenterOffset, 0)
end

function self._GetFirstPersonLocalOffset(p10, p11) -- line: 96
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character

    if Character and Character.Parent then
        local Head = Character:FindFirstChild("Head")

        if Head and Head:IsA("BasePart") then
            return p11:Inverse() * Head.Position
        end
    end

    return p10:_GetThirdPersonLocalOffset()
end

function self.Update(p12) -- line: 110
    -- upvalues: LocalPlayer (copy), mapClamp (copy), n1 (ref)
    local CurrentCamera = workspace.CurrentCamera
    local v12 = CurrentCamera and CurrentCamera.CameraSubject
    local vehicleCameraCore = p12.vehicleCameraCore

    assert(CurrentCamera)
    assert(v12)
    assert(v12:IsA("VehicleSeat"))

    local v13 = n1

    n1 = 0

    local SubjectCFrame = p12:GetSubjectCFrame()
    local SubjectVelocity = p12:GetSubjectVelocity()
    local SubjectRotVelocity = p12:GetSubjectRotVelocity()

    math.abs((SubjectVelocity:Dot(SubjectCFrame.ZVector)))

    local v16 = math.abs((SubjectCFrame.YVector:Dot(SubjectRotVelocity)))
    local v18 = math.abs((SubjectCFrame.XVector:Dot(SubjectRotVelocity)))
    local v19 = p12:StepZoom()
    local v20 = mapClamp(v19, 0.5, p12.assemblyRadius, 1, 0)
    local v21 = p12:_GetThirdPersonLocalOffset():Lerp(p12:_GetFirstPersonLocalOffset(SubjectCFrame), v20)

    vehicleCameraCore:setTransform(SubjectCFrame)

    local v22 = vehicleCameraCore:step(v13, v18, v16, v20)

    p12:UpdateFadeFromBlack(v13)

    if p12:IsInFirstPerson() then
        local Unit = Vector3.new(v22.LookVector.X, 0, v22.LookVector.Z).Unit
        local v23 = CFrame.new(v22.Position, Unit)
        local v24 = CFrame.new(SubjectCFrame * v21) * v23
        local v25 = v24 * CFrame.new(0, 0, v19)

        p12:StartVREdgeBlur(LocalPlayer)

        return v25, v24
    end

    local v26 = CFrame.new(SubjectCFrame * v21) * v22
    local v27 = v26 * CFrame.new(0, 0, v19)

    if not p12.lastCameraFocus then
        p12.lastCameraFocus = v26
        p12.needsReset = true
    end

    local v28 = v26.Position - CurrentCamera.CFrame.Position
    local magnitude = v28.magnitude

    if v28.Unit:Dot(CurrentCamera.CFrame.LookVector) > 0.56 and magnitude < 200 and not p12.needsReset then
        v26 = p12.lastCameraFocus

        local p = v26.p
        local CameraLookVector = p12:GetCameraLookVector()
        local v29 = p12:CalculateNewLookVectorFromArg(Vector3.new(CameraLookVector.X, 0, CameraLookVector.Z).Unit, Vector2.new(0, 0))

        v27 = CFrame.new(p - v19 * v29, p)
    else
        p12.currentSubjectDistance = 16
        p12.lastCameraFocus = p12:GetVRFocus(SubjectCFrame.Position, v13)
        p12.needsReset = false
        p12:StartFadeFromBlack()
        p12:ResetZoom()
    end

    p12:UpdateEdgeBlur(LocalPlayer, v13)

    return v27, v26
end

function self.EnterFirstPerson(p13) -- line: 203
    p13.inFirstPerson = true
    p13:UpdateMouseBehavior()
end

function self.LeaveFirstPerson(p14) -- line: 208
    p14.inFirstPerson = false
    p14:UpdateMouseBehavior()
end

return self
