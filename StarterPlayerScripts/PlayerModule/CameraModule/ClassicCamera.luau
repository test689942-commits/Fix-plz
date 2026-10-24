-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

Vector2.new(0, 0)

local n1 = 0
local v1 = CFrame.fromOrientation(-0.2617993877991494, 0, 0)
local Players = game:GetService("Players")
local VRService = game:GetService("VRService")
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local self = setmetatable({}, BaseCamera)

self.__index = self

function self.new() -- line: 34
    -- upvalues: CameraUtils (copy), BaseCamera (copy), self (copy)
    local v4 = setmetatable(BaseCamera.new(), self)

    v4.isFollowCamera = false
    v4.isCameraToggle = false
    v4.cameraOffset = Vector3.new()
    v4.lastUpdate = tick()
    v4.cameraToggleSpring = CameraUtils.Spring.new(5, 0)

    return v4
end

function self.GetCameraToggleOffset(p1, p2) -- line: 46
    -- upvalues: CameraInput (copy), CameraUtils (copy)
    if not p1.isCameraToggle then
        return (Vector3.new())
    end

    local currentSubjectDistance = p1.currentSubjectDistance

    if CameraInput.getTogglePan() then
        p1.cameraToggleSpring.goal = math.clamp(CameraUtils.map(currentSubjectDistance, 0.5, p1.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1), 0, 1)
    else
        p1.cameraToggleSpring.goal = 0
    end

    local v7 = math.clamp(CameraUtils.map(currentSubjectDistance, 0.5, 64, 0, 1), 0, 1) + 1

    return (Vector3.new(0, p1.cameraToggleSpring:step(p2) * v7, 0))
end

function self.SetCameraMovementMode(p3, p4) -- line: 64
    -- upvalues: BaseCamera (copy)
    BaseCamera.SetCameraMovementMode(p3, p4)
    p3.isFollowCamera = p4 == Enum.ComputerCameraMovementMode.Follow
    p3.isCameraToggle = p4 == Enum.ComputerCameraMovementMode.CameraToggle
end

function self.Update(p5) -- line: 71
    -- upvalues: n1 (ref), v1 (copy), Players (copy), VRService (copy), CameraInput (copy), CameraUtils (copy)
    local v9 = tick()
    local v10 = v9 - p5.lastUpdate
    local CurrentCamera = workspace.CurrentCamera
    local _CFrame, Focus = CurrentCamera.CFrame, CurrentCamera.Focus
    local lookVector

    if p5.resetCameraAngle then
        local HumanoidRootPart = p5:GetHumanoidRootPart()

        lookVector = if HumanoidRootPart then (HumanoidRootPart.CFrame * v1).lookVector else v1.lookVector
        p5.resetCameraAngle = false
    end

    local LocalPlayer = Players.LocalPlayer
    local Humanoid = p5:GetHumanoid()
    local CameraSubject = CurrentCamera.CameraSubject
    local v11, v12

    if CameraSubject then
        v11 = CameraSubject:IsA("VehicleSeat")
        v12 = CameraSubject:IsA("SkateboardPlatform")
    else
        v12 = CameraSubject
        v11 = CameraSubject
    end

    local v13 = Humanoid and Humanoid:GetState() == Enum.HumanoidStateType.Climbing

    if p5.lastUpdate == nil or v10 > 1 then
        p5.lastCameraTransform = nil
    end

    local v14 = CameraInput.getRotation()

    p5:StepZoom()

    local CameraHeight = p5:GetCameraHeight()

    if CameraInput.getRotation() ~= Vector2.new() then
        n1 = 0
        p5.lastUserPanCamera = tick()
    end

    local v15 = v9 - p5.lastUserPanCamera < 2
    local SubjectPosition = p5:GetSubjectPosition()
    local v16, v17

    if SubjectPosition and LocalPlayer and CurrentCamera then
        local CameraToSubjectDistance = p5:GetCameraToSubjectDistance()

        if CameraToSubjectDistance < 0.5 then
            CameraToSubjectDistance = 0.5
        end

        local v18, v19, v20

        if not p5:GetIsMouseLocked() or p5:IsInFirstPerson() then
            v20 = true
        else
            v18 = p5:CalculateNewLookCFrameFromArg(lookVector, v14)

            local CameraOffset = LocalPlayer:FindFirstChild("CameraOffset")

            v19 = CameraOffset and CameraOffset.Value
            v20 = false
        end

        local v21 = SubjectPosition
        local v22 = v14

        if v20 then
            if CameraInput.getRotation() ~= Vector2.new() then
            elseif p5.lastCameraTransform then
                local v23 = p5:IsInFirstPerson()

                if (v11 or v12 or p5.isFollowCamera and v13) and p5.lastUpdate and Humanoid and Humanoid.Torso then
                    if v23 then
                        if p5.lastSubjectCFrame and (v11 or v12) and CameraSubject:IsA("BasePart") then
                            local v24 = -CameraUtils.GetAngleBetweenXZVectors(p5.lastSubjectCFrame.lookVector, CameraSubject.CFrame.lookVector)

                            v22 = if CameraUtils.IsFinite(v24) then v14 + Vector2.new(v24, 0) else v14
                            n1 = 0
                        end
                    elseif not v15 then
                        local lookVector = Humanoid.Torso.CFrame.lookVector
                        local v26 = n1

                        n1 = math.clamp(v26 + 3.839724354387525 * v10, 0, 4.363323129985824)

                        local v28 = math.clamp(n1 * v10, 0, 1)

                        if p5:IsInFirstPerson() and (not p5.isFollowCamera or not p5.isClimbing) then
                            v28 = 1
                        end

                        local v29 = CameraUtils.GetAngleBetweenXZVectors(lookVector, p5:GetCameraLookVector())

                        if CameraUtils.IsFinite(v29) and math.abs(v29) > 1E-04 then
                            v22 = v14 + Vector2.new(v29 * v28, 0)
                        end
                    end
                elseif p5.isFollowCamera and not v23 and not v15 and not VRService.VREnabled then
                    local v30 = -(p5.lastCameraTransform.p - SubjectPosition)
                    local v31 = CameraUtils.GetAngleBetweenXZVectors(v30, p5:GetCameraLookVector())

                    if CameraUtils.IsFinite(v31) and math.abs(v31) > 1E-04 and math.abs(v31) > 0.4 * v10 then
                        v22 = v14 + Vector2.new(v31, 0)
                    end
                end
            end
        else
            local v32 = v19 or Vector3.new(1.75, 0, 0)
            local v33 = v32.X * v18.RightVector + v32.Y * v18.UpVector + v32.Z * v18.LookVector

            if CameraUtils.IsFiniteVector3(v33) then
                v21 = SubjectPosition + v33
            end
        end

        local v34, v35

        if p5.isFollowCamera then
            local v36 = p5:CalculateNewLookVectorFromArg(lookVector, v22)

            v34 = if VRService.VREnabled then p5:GetVRFocus(v21, v10) else CFrame.new(v21)
            v35 = CFrame.new(v34.p - CameraToSubjectDistance * v36, v34.p) + Vector3.new(0, CameraHeight, 0)
        else
            local VREnabled = VRService.VREnabled
            local v37 = if VREnabled then p5:GetVRFocus(v21, v10) else CFrame.new(v21)
            local p = v37.p

            if not VREnabled or p5:IsInFirstPerson() then
                v34 = v37

                local v38 = p5:CalculateNewLookVectorFromArg(lookVector, v22)

                v35 = CFrame.new(p - CameraToSubjectDistance * v38, p)
            else
                local magnitude = (v21 - CurrentCamera.CFrame.p).magnitude
                local v39, lookVector, v40

                if CameraToSubjectDistance < magnitude then
                    local v41 = math.min(magnitude, CameraToSubjectDistance)
                    local v42 = p5:CalculateNewLookVectorFromArg(nil, v22) * v41

                    v39 = p - v42
                    lookVector = CurrentCamera.CFrame.lookVector

                    if v22.x ~= 0 then
                        lookVector = v42
                    end

                    v40 = false
                elseif v22.x == 0 then
                    v35 = _CFrame
                    v34 = v37
                    v40 = true
                else
                    local v43 = math.min(magnitude, CameraToSubjectDistance)
                    local v44 = p5:CalculateNewLookVectorFromArg(nil, v22) * v43

                    v39 = p - v44
                    lookVector = CurrentCamera.CFrame.lookVector

                    if v22.x ~= 0 then
                        lookVector = v44
                    end

                    v40 = false
                end

                if not v40 then
                    v34 = v37

                    local v47 = Vector3.new(v39.x + lookVector.x, v39.y, v39.z + lookVector.z)

                    v35 = CFrame.new(v39, v47) + Vector3.new(0, CameraHeight, 0)
                end
            end
        end

        local CameraToggleOffset = p5:GetCameraToggleOffset(v10)

        v16 = v34 + CameraToggleOffset
        v17 = v35 + CameraToggleOffset
        p5.lastCameraTransform = v17
        p5.lastCameraFocus = v16

        if (v11 or v12) and CameraSubject:IsA("BasePart") then
            p5.lastSubjectCFrame = CameraSubject.CFrame
        else
            p5.lastSubjectCFrame = nil
        end
    else
        v16 = Focus
        v17 = _CFrame
    end

    p5.lastUpdate = v9

    return v17, v16
end

function self.EnterFirstPerson(p6) -- line: 250
    p6.inFirstPerson = true
    p6:UpdateMouseBehavior()
end

function self.LeaveFirstPerson(p7) -- line: 255
    p7.inFirstPerson = false
    p7:UpdateMouseBehavior()
end

return self
