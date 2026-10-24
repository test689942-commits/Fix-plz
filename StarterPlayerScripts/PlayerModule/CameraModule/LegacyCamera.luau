-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

Vector2.new()
require(script.Parent:WaitForChild("CameraUtils"))

local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local Players = game:GetService("Players")
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local self = setmetatable({}, BaseCamera)

self.__index = self

function self.new() -- line: 21
    -- upvalues: BaseCamera (copy), self (copy)
    local v3 = setmetatable(BaseCamera.new(), self)

    v3.cameraType = Enum.CameraType.Fixed
    v3.lastUpdate = tick()
    v3.lastDistanceToSubject = nil

    return v3
end

function self.GetModuleName(_) -- line: 31
    return "LegacyCamera"
end

function self.SetCameraToSubjectDistance(p2, p3) -- line: 36
    -- upvalues: BaseCamera (copy)
    return BaseCamera.SetCameraToSubjectDistance(p2, p3)
end

function self.Update(p4, _) -- line: 40
    -- upvalues: CameraInput (copy), Players (copy)
    if not p4.cameraType then
        return nil, nil
    end

    local v4 = tick()
    local v5 = v4 - p4.lastUpdate
    local CurrentCamera = workspace.CurrentCamera
    local _CFrame, Focus = CurrentCamera.CFrame, CurrentCamera.Focus
    local LocalPlayer = Players.LocalPlayer

    if p4.lastUpdate == nil or v5 > 1 then
        p4.lastDistanceToSubject = nil
    end

    local SubjectPosition = p4:GetSubjectPosition()

    if p4.cameraType == Enum.CameraType.Fixed then
        if SubjectPosition and LocalPlayer and CurrentCamera then
            local CameraToSubjectDistance = p4:GetCameraToSubjectDistance()
            local v6 = p4:CalculateNewLookVectorFromArg(nil, CameraInput.getRotation())

            Focus = CurrentCamera.Focus
            _CFrame = CFrame.new(CurrentCamera.CFrame.p, CurrentCamera.CFrame.p + CameraToSubjectDistance * v6)
        end
    elseif p4.cameraType == Enum.CameraType.Attach then
        local SubjectCFrame = p4:GetSubjectCFrame()
        local v7 = CurrentCamera.CFrame:ToEulerAnglesYXZ()
        local _, v8 = SubjectCFrame:ToEulerAnglesYXZ()
        local v10 = math.clamp(v7 - CameraInput.getRotation().Y, -1.3962634015954636, 1.3962634015954636)

        Focus = CFrame.new(SubjectCFrame.p) * CFrame.fromEulerAnglesYXZ(v10, v8, 0)
        _CFrame = Focus * CFrame.new(0, 0, p4:StepZoom())
    else
        if p4.cameraType ~= Enum.CameraType.Watch then
            return CurrentCamera.CFrame, CurrentCamera.Focus
        end

        if SubjectPosition and LocalPlayer and CurrentCamera then
            if SubjectPosition == CurrentCamera.CFrame.p then
                warn("Camera cannot watch subject in same position as itself")

                return CurrentCamera.CFrame, CurrentCamera.Focus
            end

            local Humanoid = p4:GetHumanoid()
            local unit

            if Humanoid and Humanoid.RootPart then
                local v11 = SubjectPosition - CurrentCamera.CFrame.p

                unit = v11.unit

                if p4.lastDistanceToSubject and p4.lastDistanceToSubject == p4:GetCameraToSubjectDistance() then
                    p4:SetCameraToSubjectDistance(v11.magnitude)
                end
            end

            local CameraToSubjectDistance = p4:GetCameraToSubjectDistance()
            local v12 = p4:CalculateNewLookVectorFromArg(unit, CameraInput.getRotation())

            Focus = CFrame.new(SubjectPosition)
            _CFrame = CFrame.new(SubjectPosition - CameraToSubjectDistance * v12, SubjectPosition)
            p4.lastDistanceToSubject = CameraToSubjectDistance
        end
    end

    p4.lastUpdate = v4

    return _CFrame, Focus
end

return self
