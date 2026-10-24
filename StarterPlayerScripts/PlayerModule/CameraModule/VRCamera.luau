-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Players = game:GetService("Players")
local VRService = game:GetService("VRService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))

require(script.Parent:WaitForChild("CameraUtils"))

local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"))
local self = setmetatable({}, VRBaseCamera)

self.__index = self

local function v2() -- line: 26
    return UserSettings():IsUserFeatureEnabled("UserFlagEnableVRUpdate3")
end

local ok, result = pcall(v2)
local v3 = ok and result

function self.new() -- line: 32
    -- upvalues: VRBaseCamera (copy), self (copy)
    local v5 = setmetatable(VRBaseCamera.new(), self)

    v5.lastUpdate = tick()
    v5:Reset()

    return v5
end

function self.Reset(p1) -- line: 41
    p1.needsReset = true
    p1.needsBlackout = true
    p1.motionDetTime = 0
    p1.blackOutTimer = 0
    p1.lastCameraResetPosition = nil
    p1.stepRotateTimeout = 0
    p1.cameraOffsetRotation = 0
    p1.cameraOffsetRotationDiscrete = 0
end

function self.Update(p2, p3) -- line: 52
    -- upvalues: Players (copy)
    local CurrentCamera = workspace.CurrentCamera
    local CFrame, Focus = CurrentCamera.CFrame, CurrentCamera.Focus
    local LocalPlayer = Players.LocalPlayer

    p2:GetHumanoid()

    local _ = CurrentCamera.CameraSubject

    if p2.lastUpdate == nil or p3 > 1 then
        p2.lastCameraTransform = nil
    end

    p2:StepZoom()
    p2:UpdateFadeFromBlack(p3)
    p2:UpdateEdgeBlur(LocalPlayer, p3)

    local lastSubjectPosition = p2.lastSubjectPosition
    local SubjectPosition = p2:GetSubjectPosition()

    if p2.needsBlackout then
        p2:StartFadeFromBlack()

        local v6 = math.clamp(p3, 1E-04, 0.1)

        p2.blackOutTimer += v6

        if p2.blackOutTimer > 0.1 and game:IsLoaded() then
            p2.needsBlackout = false
            p2.needsReset = true
        end
    end

    local v7, v8

    if SubjectPosition and LocalPlayer and CurrentCamera then
        local VRFocus = p2:GetVRFocus(SubjectPosition, p3)
        local v9, v10

        if p2:IsInFirstPerson() then
            v9, v10 = p2:UpdateFirstPersonTransform(p3, CFrame, VRFocus, lastSubjectPosition, SubjectPosition)
        else
            v9, v10 = p2:UpdateThirdPersonTransform(p3, CFrame, VRFocus, lastSubjectPosition, SubjectPosition)
        end

        v8 = v10
        p2.lastCameraTransform = v9
        p2.lastCameraFocus = v10
        v7 = v9
    else
        v8 = Focus
        v7 = CFrame
    end

    p2.lastUpdate = tick()

    return v7, v8
end

function self.UpdateFirstPersonTransform(p4, p5, _, p7, p8, p9) -- line: 105
    -- upvalues: Players (copy), UserGameSettings (copy), CameraInput (copy), v3 (copy)
    if p4.needsReset then
        p4:StartFadeFromBlack()
        p4.needsReset = false
        p4.stepRotateTimeout = 0.25
        p4.VRCameraFocusFrozen = true
        p4.cameraOffsetRotation = 0
        p4.cameraOffsetRotationDiscrete = 0
    end

    local LocalPlayer = Players.LocalPlayer

    if (p8 - p9).magnitude > 0.01 then
        p4:StartVREdgeBlur(LocalPlayer)
    end

    local p = p7.p
    local CameraLookVector = p4:GetCameraLookVector()
    local Unit = Vector3.new(CameraLookVector.X, 0, CameraLookVector.Z).Unit

    if p4.stepRotateTimeout > 0 then
        p4.stepRotateTimeout -= p5
    end

    local v11 = CameraInput.getRotation()
    local v12

    if not (v3 and UserGameSettings.VRSmoothRotationEnabled) then
        if p4.stepRotateTimeout <= 0 then
            local v13

            if math.abs(v11.X) > 0.03 then
                v13 = if v11.X < 0 then -0.5 else 0.5
                v12 = v13
                p4.needsReset = true
            else
                v12 = 0
            end
        else
            v12 = 0
        end
    else
        v12 = v11.X
    end

    local v14 = p4:CalculateNewLookVectorFromArg(Unit, Vector2.new(v12, 0))

    return CFrame.new(p - 0.5 * v14, p), p7
end

function self.UpdateThirdPersonTransform(p10, p11, p12, p13, p14, p15) -- line: 151
    -- upvalues: Players (copy), VRService (copy), UserGameSettings (copy), CameraInput (copy), v3 (copy)
    local CameraToSubjectDistance = p10:GetCameraToSubjectDistance()

    if CameraToSubjectDistance < 0.5 then
        CameraToSubjectDistance = 0.5
    end

    local v15

    if p14 == nil or p10.lastCameraFocus == nil then
        v15 = p12
    else
        local LocalPlayer = Players.LocalPlayer
        local v16 = p14 - p15
        local MoveVector = require(LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule")):GetMoveVector()
        local v17 = v16.magnitude > 0.01 or MoveVector.magnitude > 0.01

        if v17 then
            p10.motionDetTime = 0.1
        end

        p10.motionDetTime -= p11

        if p10.motionDetTime > 0 then
            v17 = true
        end

        if v17 and not p10.needsReset then
            local lastCameraFocus = p10.lastCameraFocus

            p10.VRCameraFocusFrozen = true

            return p12, lastCameraFocus
        end

        local v18 = p10.lastCameraResetPosition == nil or (p15 - p10.lastCameraResetPosition).Magnitude > 1
        local v19 = CameraInput.getRotation()
        local v20, v21
        local v22 = p12

        if not v3 or v19 == Vector2.new() or v19.X == 0 then
            v21 = false
        else
            v20 = p10.cameraOffsetRotation + v19.X

            if v20 < -3.141592653589793 then
                v20 = 3.141592653589793 - (v20 + 3.141592653589793)
            elseif v20 > 3.141592653589793 then
                v20 = -3.141592653589793 + (v20 - 3.141592653589793)
            end

            p10.cameraOffsetRotation = math.clamp(v20, -3.141592653589793, 3.141592653589793)

            if UserGameSettings.VRSmoothRotationEnabled then
                p10.cameraOffsetRotationDiscrete = p10.cameraOffsetRotation

                local Humanoid = p10:GetHumanoid()
                local v23 = Humanoid.Torso and Humanoid.Torso.CFrame.lookVector or Vector3.new(1, 0, 0)
                local v24 = Vector3.new(v23.X, 0, v23.Z)
                local v25 = p13.Position - v24 * CameraToSubjectDistance
                local v26 = Vector3.new(p13.Position.X, v25.Y, p13.Position.Z)
                local v27 = v26 - (CFrame.new(v25, v26) * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), p10.cameraOffsetRotationDiscrete)).LookVector * (v26 - v25).Magnitude

                v22 = CFrame.new(v27, v26)
                v21 = false
            else
                local v29 = math.floor(p10.cameraOffsetRotation * 12 / 12)

                if v29 == p10.cameraOffsetRotationDiscrete then
                    v21 = false
                else
                    v21 = true
                    p10.cameraOffsetRotationDiscrete = v29
                end
            end
        end

        if p10.VRCameraFocusFrozen and v18 or p10.needsReset or v21 then
            if not v21 then
                p10.cameraOffsetRotationDiscrete = 0
                p10.cameraOffsetRotation = 0
            end

            VRService:RecenterUserHeadCFrame()
            p10.VRCameraFocusFrozen = false
            p10.needsReset = false
            p10.lastCameraResetPosition = p15
            p10:ResetZoom()
            p10:StartFadeFromBlack()

            local Humanoid = p10:GetHumanoid()
            local lookVector = Humanoid.Torso and Humanoid.Torso.CFrame.lookVector or Vector3.new(1, 0, 0)
            local v30 = Vector3.new(lookVector.X, 0, lookVector.Z)
            local v31 = p13.Position - v30 * CameraToSubjectDistance
            local v32 = Vector3.new(p13.Position.X, v31.Y, p13.Position.Z)

            if v3 and p10.cameraOffsetRotation ~= 0 then
                v31 = v32 - (CFrame.new(v31, v32) * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), p10.cameraOffsetRotationDiscrete)).LookVector * (v32 - v31).Magnitude
            end

            v15 = CFrame.new(v31, v32)
        else
            v15 = v22
        end
    end

    return v15, p13
end

function self.EnterFirstPerson(p16) -- line: 264
    p16.inFirstPerson = true
    p16:UpdateMouseBehavior()
end

function self.LeaveFirstPerson(p17) -- line: 269
    p17.inFirstPerson = false
    p17.needsReset = true
    p17:UpdateMouseBehavior()

    if p17.VRBlur then
        p17.VRBlur.Visible = false
    end
end

return self
