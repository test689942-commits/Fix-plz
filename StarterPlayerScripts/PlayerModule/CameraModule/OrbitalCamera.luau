-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {
    InitialDistance = 25,
    MinDistance = 10,
    MaxDistance = 100,
    InitialElevation = 35,
    MinElevation = 35,
    MaxElevation = 35,
    ReferenceAzimuth = -45,
    CWAzimuthTravel = 90,
    CCWAzimuthTravel = 90,
    UseAzimuthLimits = false
}
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local Players = game:GetService("Players")
local VRService = game:GetService("VRService")
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local self = setmetatable({}, BaseCamera)

self.__index = self

function self.new() -- line: 43
    -- upvalues: BaseCamera (copy), self (copy)
    local v3 = setmetatable(BaseCamera.new(), self)

    v3.lastUpdate = tick()
    v3.changedSignalConnections = {}
    v3.refAzimuthRad = nil
    v3.curAzimuthRad = nil
    v3.minAzimuthAbsoluteRad = nil
    v3.maxAzimuthAbsoluteRad = nil
    v3.useAzimuthLimits = nil
    v3.curElevationRad = nil
    v3.minElevationRad = nil
    v3.maxElevationRad = nil
    v3.curDistance = nil
    v3.minDistance = nil
    v3.maxDistance = nil
    v3.gamepadDollySpeedMultiplier = 1
    v3.lastUserPanCamera = tick()
    v3.externalProperties = {}
    v3.externalProperties.InitialDistance = 25
    v3.externalProperties.MinDistance = 10
    v3.externalProperties.MaxDistance = 100
    v3.externalProperties.InitialElevation = 35
    v3.externalProperties.MinElevation = 35
    v3.externalProperties.MaxElevation = 35
    v3.externalProperties.ReferenceAzimuth = -45
    v3.externalProperties.CWAzimuthTravel = 90
    v3.externalProperties.CCWAzimuthTravel = 90
    v3.externalProperties.UseAzimuthLimits = false
    v3:LoadNumberValueParameters()

    return v3
end

function self.LoadOrCreateNumberValueParameter(p1, p2, p3, p4) -- line: 82
    local v4 = script:FindFirstChild(p2)

    if not (v4 and v4:isA(p3)) then
        if p1.externalProperties[p2] == nil then
            return
        end

        v4 = Instance.new(p3)
        v4.Name = p2
        v4.Parent = script
        v4.Value = p1.externalProperties[p2]
    else
        p1.externalProperties[p2] = v4.Value
    end

    if not p4 then
        return
    end

    if p1.changedSignalConnections[p2] then
        p1.changedSignalConnections[p2]:Disconnect()
    end

    p1.changedSignalConnections[p2] = v4.Changed:Connect(function(p5) -- line: 102
        -- upvalues: p1 (copy), p2 (copy), p4 (copy)
        p1.externalProperties[p2] = p5
        p4(p1)
    end)
end

function self.SetAndBoundsCheckAzimuthValues(p6) -- line: 109
    p6.minAzimuthAbsoluteRad = math.rad(p6.externalProperties.ReferenceAzimuth) - math.abs((math.rad(p6.externalProperties.CWAzimuthTravel)))
    p6.maxAzimuthAbsoluteRad = math.rad(p6.externalProperties.ReferenceAzimuth) + math.abs((math.rad(p6.externalProperties.CCWAzimuthTravel)))
    p6.useAzimuthLimits = p6.externalProperties.UseAzimuthLimits

    if p6.useAzimuthLimits then
        p6.curAzimuthRad = math.max(p6.curAzimuthRad, p6.minAzimuthAbsoluteRad)
        p6.curAzimuthRad = math.min(p6.curAzimuthRad, p6.maxAzimuthAbsoluteRad)
    end
end

function self.SetAndBoundsCheckElevationValues(p7) -- line: 119
    local v9 = math.max(p7.externalProperties.MinElevation, -80)
    local v10 = math.min(p7.externalProperties.MaxElevation, 80)

    p7.minElevationRad = math.rad((math.min(v9, v10)))
    p7.maxElevationRad = math.rad((math.max(v9, v10)))
    p7.curElevationRad = math.max(p7.curElevationRad, p7.minElevationRad)
    p7.curElevationRad = math.min(p7.curElevationRad, p7.maxElevationRad)
end

function self.SetAndBoundsCheckDistanceValues(p8) -- line: 135
    p8.minDistance = p8.externalProperties.MinDistance
    p8.maxDistance = p8.externalProperties.MaxDistance
    p8.curDistance = math.max(p8.curDistance, p8.minDistance)
    p8.curDistance = math.min(p8.curDistance, p8.maxDistance)
end

function self.LoadNumberValueParameters(p9) -- line: 143
    p9:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil)
    p9:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil)
    p9:LoadOrCreateNumberValueParameter("ReferenceAzimuth", "NumberValue", p9.SetAndBoundsCheckAzimuthValue)
    p9:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", p9.SetAndBoundsCheckAzimuthValues)
    p9:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", p9.SetAndBoundsCheckAzimuthValues)
    p9:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", p9.SetAndBoundsCheckElevationValues)
    p9:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", p9.SetAndBoundsCheckElevationValues)
    p9:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", p9.SetAndBoundsCheckDistanceValues)
    p9:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", p9.SetAndBoundsCheckDistanceValues)
    p9:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", p9.SetAndBoundsCheckAzimuthValues)
    p9.curAzimuthRad = math.rad(p9.externalProperties.ReferenceAzimuth)
    p9.curElevationRad = math.rad(p9.externalProperties.InitialElevation)
    p9.curDistance = p9.externalProperties.InitialDistance
    p9:SetAndBoundsCheckAzimuthValues()
    p9:SetAndBoundsCheckElevationValues()
    p9:SetAndBoundsCheckDistanceValues()
end

function self.GetModuleName(_) -- line: 168
    return "OrbitalCamera"
end

function self.SetInitialOrientation(p11, p12) -- line: 172
    -- upvalues: CameraUtils (copy)
    if not p12 or not p12.RootPart then
        warn("OrbitalCamera could not set initial orientation due to missing humanoid")

        return
    end

    assert(p12.RootPart, "")

    local Unit = (p12.RootPart.CFrame.LookVector - Vector3.new(0, 0.23, 0)).Unit
    local v13 = CameraUtils.GetAngleBetweenXZVectors(Unit, p11:GetCameraLookVector())
    local v15 = math.asin(p11:GetCameraLookVector().Y) - math.asin(Unit.Y)

    if CameraUtils.IsFinite(v13) then
    end

    if CameraUtils.IsFinite(v15) then
    end
end

function self.GetCameraToSubjectDistance(p13) -- line: 190
    return p13.curDistance
end

function self.SetCameraToSubjectDistance(p14, p15) -- line: 194
    -- upvalues: Players (copy)
    if Players.LocalPlayer then
        p14.currentSubjectDistance = math.clamp(p15, p14.minDistance, p14.maxDistance)
        p14.currentSubjectDistance = math.max(p14.currentSubjectDistance, p14.FIRST_PERSON_DISTANCE_THRESHOLD)
    end

    p14.inFirstPerson = false
    p14:UpdateMouseBehavior()

    return p14.currentSubjectDistance
end

function self.CalculateNewLookVector(p16, p17, p18) -- line: 207
    p17 = p17 or p16:GetCameraLookVector()

    local v17 = math.asin(p17.Y)
    local v20 = math.clamp(p18.Y, v17 - 1.3962634015954636, v17 - -1.3962634015954636)
    local v21 = Vector2.new(p18.X, v20)
    local v22 = CFrame.new(Vector3.new(0, 0, 0), p17)

    return (CFrame.Angles(0, -v21.X, 0) * v22 * CFrame.Angles(-v21.Y, 0, 0)).LookVector
end

function self.Update(p19, _) -- line: 218
    -- upvalues: CameraInput (copy), Players (copy), VRService (copy)
    local v23 = tick()
    local v24 = v23 - p19.lastUpdate
    local v25 = CameraInput.getRotation() ~= Vector2.new()
    local CurrentCamera = workspace.CurrentCamera
    local _CFrame, Focus = CurrentCamera.CFrame, CurrentCamera.Focus
    local LocalPlayer = Players.LocalPlayer
    local v26 = CurrentCamera and CurrentCamera.CameraSubject
    local v27, v28

    if v26 then
        v27 = v26:IsA("VehicleSeat")
        v28 = v26:IsA("SkateboardPlatform")
    else
        v28 = v26
        v27 = v26
    end

    if p19.lastUpdate == nil or v24 > 1 then
        p19.lastCameraTransform = nil
    end

    if v25 then
        p19.lastUserPanCamera = tick()
    end

    local SubjectPosition = p19:GetSubjectPosition()
    local v29, v30

    if SubjectPosition and LocalPlayer and CurrentCamera then
        if p19.gamepadDollySpeedMultiplier ~= 1 then
            p19:SetCameraToSubjectDistance(p19.currentSubjectDistance * p19.gamepadDollySpeedMultiplier)
        end

        local VREnabled = VRService.VREnabled
        local VRFocus = if VREnabled then p19:GetVRFocus(SubjectPosition, v24) else nil

        v29 = if not VREnabled or not VRFocus then CFrame.new(SubjectPosition) else VRFocus

        local v31 = CameraInput.getRotation()
        local p = v29.p
        local v32 = true

        if not VREnabled or p19:IsInFirstPerson() then
            p19.curAzimuthRad -= v31.X

            if p19.useAzimuthLimits then
                p19.curAzimuthRad = math.clamp(p19.curAzimuthRad, p19.minAzimuthAbsoluteRad, p19.maxAzimuthAbsoluteRad)
            elseif p19.curAzimuthRad == 0 then
                p19.curAzimuthRad = 0
            else
                p19.curAzimuthRad = math.sign(p19.curAzimuthRad) * (math.abs(p19.curAzimuthRad) % 6.283185307179586) or 0
            end

            v32 = false
        end

        local v35

        if v32 then
            local CameraHeight = p19:GetCameraHeight()
            local v36 = SubjectPosition - CurrentCamera.CFrame.p
            local Magnitude = v36.Magnitude
            local v37, LookVector, v38

            if p19.currentSubjectDistance < Magnitude then
                local v39 = math.min(Magnitude, p19.currentSubjectDistance)
                local v40 = p19:CalculateNewLookVector(v36.Unit * Vector3.new(1, 0, 1), Vector2.new(v31.X, 0)) * v39

                v37 = p - v40
                LookVector = CurrentCamera.CFrame.LookVector

                if v31.X ~= 0 then
                    LookVector = v40
                end

                v38 = false
            elseif v31.X == 0 then
                v35 = _CFrame
                v38 = true
            else
                local v41 = math.min(Magnitude, p19.currentSubjectDistance)
                local v42 = p19:CalculateNewLookVector(v36.Unit * Vector3.new(1, 0, 1), Vector2.new(v31.X, 0)) * v41

                v37 = p - v42
                LookVector = CurrentCamera.CFrame.LookVector

                if v31.X ~= 0 then
                    LookVector = v42
                end

                v38 = false
            end

            if not v38 then
                local v45 = Vector3.new(v37.X + LookVector.X, v37.Y, v37.Z + LookVector.Z)

                v35 = CFrame.new(v37, v45) + Vector3.new(0, CameraHeight, 0)
            end
        else
            p19.curElevationRad = math.clamp(p19.curElevationRad + v31.Y, p19.minElevationRad, p19.maxElevationRad)

            local v47 = SubjectPosition + p19.currentSubjectDistance * (CFrame.fromEulerAnglesYXZ(-p19.curElevationRad, p19.curAzimuthRad, 0) * Vector3.new(0, 0, 1))

            v35 = CFrame.new(v47, SubjectPosition)
        end

        v30 = v35
        p19.lastCameraTransform = v35
        p19.lastCameraFocus = v29

        if (v27 or v28) and v26:IsA("BasePart") then
            p19.lastSubjectCFrame = v26.CFrame
        else
            p19.lastSubjectCFrame = nil
        end
    else
        v29 = Focus
        v30 = _CFrame
    end

    p19.lastUpdate = v23

    return v30, v29
end

return self
