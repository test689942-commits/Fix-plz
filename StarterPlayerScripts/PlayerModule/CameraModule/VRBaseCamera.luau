-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local VRService = game:GetService("VRService")
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local ZoomController = require(script.Parent:WaitForChild("ZoomController"))
local LocalPlayer = game:GetService("Players").LocalPlayer
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local function v1() -- line: 29
    return UserSettings():IsUserFeatureEnabled("UserVRApplyHeadScaleToHandPositions")
end

local ok, result = pcall(v1)
local v2 = ok and result
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local self = setmetatable({}, BaseCamera)

self.__index = self

function self.new() -- line: 40
    -- upvalues: LocalPlayer (copy), BaseCamera (copy), self (copy)
    local v5 = setmetatable(BaseCamera.new(), self)

    v5.defaultDistance = 7
    v5.defaultSubjectDistance = math.clamp(v5.defaultDistance, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance)
    v5.currentSubjectDistance = math.clamp(v5.defaultDistance, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance)
    v5.VRFadeResetTimer = 0
    v5.VREdgeBlurTimer = 0
    v5.gamepadResetConnection = nil
    v5.needsReset = true

    return v5
end

function self.GetModuleName(_) -- line: 59
    return "VRBaseCamera"
end

function self.GamepadZoomPress(p2) -- line: 63
    if p2:GetCameraToSubjectDistance() > 3.5 then
        p2:SetCameraToSubjectDistance(0)
        p2.currentSubjectDistance = 0
    else
        p2:SetCameraToSubjectDistance(7)
        p2.currentSubjectDistance = 7
    end

    p2:GamepadReset()
    p2:ResetZoom()
end

function self.GamepadReset(p3) -- line: 78
    p3.needsReset = true
end

function self.ResetZoom(p4) -- line: 82
    -- upvalues: ZoomController (copy)
    ZoomController.SetZoomParameters(p4.currentSubjectDistance, 0)
    ZoomController.ReleaseSpring()
end

function self.OnEnable(p5, p6) -- line: 87
    -- upvalues: CameraInput (copy), LocalPlayer (copy), Lighting (copy)
    if p6 then
        p5.gamepadResetConnection = CameraInput.gamepadReset:Connect(function() -- line: 89
            -- upvalues: p5 (copy)
            p5:GamepadReset()
        end)
    else
        if p5.inFirstPerson then
            p5:GamepadZoomPress()
        end

        if p5.gamepadResetConnection then
            p5.gamepadResetConnection:Disconnect()
            p5.gamepadResetConnection = nil
        end

        p5.VREdgeBlurTimer = 0
        p5:UpdateEdgeBlur(LocalPlayer, 1)

        local VRFade = Lighting:FindFirstChild("VRFade")

        if VRFade then
            VRFade.Brightness = 0
        end
    end
end

function self.UpdateDefaultSubjectDistance(p7) -- line: 113
    -- upvalues: LocalPlayer (copy)
    p7.defaultSubjectDistance = math.clamp(7, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance)
end

function self.GetCameraToSubjectDistance(p8) -- line: 118
    return p8.currentSubjectDistance
end

function self.SetCameraToSubjectDistance(p9, p10) -- line: 123
    -- upvalues: ZoomController (copy), LocalPlayer (copy)
    local currentSubjectDistance = p9.currentSubjectDistance
    local v6 = math.clamp(p10, 0, LocalPlayer.CameraMaxZoomDistance)

    if v6 < 1 then
        p9.currentSubjectDistance = 0.5

        if not p9.inFirstPerson then
            p9:EnterFirstPerson()
        end
    else
        p9.currentSubjectDistance = v6

        if p9.inFirstPerson then
            p9:LeaveFirstPerson()
        end
    end

    ZoomController.SetZoomParameters(p9.currentSubjectDistance, (math.sign(p10 - currentSubjectDistance)))

    return p9.currentSubjectDistance
end

function self.GetVRFocus(p11, p12, p13) -- line: 147
    local v8 = p11.lastCameraFocus or p12

    p11.cameraTranslationConstraints = Vector3.new(p11.cameraTranslationConstraints.x, math.min(1, p11.cameraTranslationConstraints.y + p13), p11.cameraTranslationConstraints.z)

    local v11 = Vector3.new(0, p11:GetCameraHeight(), 0)

    return (CFrame.new(Vector3.new(p12.x, v8.y, p12.z):Lerp(p12 + v11, p11.cameraTranslationConstraints.y)))
end

function self.StartFadeFromBlack(p14) -- line: 163
    -- upvalues: Lighting (copy), UserGameSettings (copy)
    if UserGameSettings.VignetteEnabled == false then
        return
    end

    local VRFade = Lighting:FindFirstChild("VRFade")

    if not VRFade then
        VRFade = Instance.new("ColorCorrectionEffect")
        VRFade.Name = "VRFade"
        VRFade.Parent = Lighting
    end

    VRFade.Brightness = -1
    p14.VRFadeResetTimer = 0.1
end

function self.UpdateFadeFromBlack(p15, p16) -- line: 178
    -- upvalues: Lighting (copy)
    local VRFade = Lighting:FindFirstChild("VRFade")

    if p15.VRFadeResetTimer > 0 then
        p15.VRFadeResetTimer = math.max(p15.VRFadeResetTimer - p16, 0)

        local VRFade = Lighting:FindFirstChild("VRFade")

        if VRFade and VRFade.Brightness < 0 then
            VRFade.Brightness = math.min(VRFade.Brightness + p16 * 10, 0)
        end
    elseif VRFade then
        VRFade.Brightness = 0
    end
end

function self.StartVREdgeBlur(p17, p18) -- line: 194
    -- upvalues: VRService (copy), RunService (copy), UserGameSettings (copy), v2 (copy)
    if UserGameSettings.VignetteEnabled == false then
        return
    end

    local VRBlurPart = workspace.CurrentCamera:FindFirstChild("VRBlurPart")

    if not VRBlurPart then
        VRBlurPart = Instance.new("Part")
        VRBlurPart.Name = "VRBlurPart"
        VRBlurPart.Parent = workspace.CurrentCamera
        VRBlurPart.CanTouch = false
        VRBlurPart.CanCollide = false
        VRBlurPart.CanQuery = false
        VRBlurPart.Anchored = true
        VRBlurPart.Size = Vector3.new(0.44, 0.47, 1)
        VRBlurPart.Transparency = 1
        VRBlurPart.CastShadow = false
        RunService.RenderStepped:Connect(function(_) -- line: 214
            -- upvalues: VRBlurPart (ref), VRService (copy), v2 (copy)
            local UserCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head)

            if v2 then
                local v14 = workspace.CurrentCamera.CFrame * (CFrame.new(UserCFrame.p * workspace.CurrentCamera.HeadScale) * (UserCFrame - UserCFrame.p))
                local VRBlurPart2 = VRBlurPart

                VRBlurPart2.CFrame = v14 * CFrame.Angles(0, 3.141592653589793, 0) + v14.LookVector * (1.05 * workspace.CurrentCamera.HeadScale)
                VRBlurPart2.Size = Vector3.new(0.44, 0.47, 1) * workspace.CurrentCamera.HeadScale
            else
                local v15 = workspace.Camera.CFrame * UserCFrame

                VRBlurPart.CFrame = v15 * CFrame.Angles(0, 3.141592653589793, 0) + v15.LookVector * 1.05
            end
        end)
    end

    local VRBlurScreen = p18.PlayerGui:FindFirstChild("VRBlurScreen")
    local VRBlur = if VRBlurScreen then VRBlurScreen:FindFirstChild("VRBlur") else nil
    local ImageLabel

    if VRBlur then
        ImageLabel = VRBlur
    else
        local v16 = VRBlurScreen or Instance.new("SurfaceGui") or Instance.new("ScreenGui")

        v16.Name = "VRBlurScreen"
        v16.Parent = p18.PlayerGui
        v16.Adornee = VRBlurPart
        ImageLabel = Instance.new("ImageLabel")
        ImageLabel.Name = "VRBlur"
        ImageLabel.Parent = v16
        ImageLabel.Image = "rbxasset://textures/ui/VR/edgeBlur.png"
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)

        local v17 = workspace.CurrentCamera.ViewportSize.X * 2.3 / 512
        local v18 = workspace.CurrentCamera.ViewportSize.Y * 2.3 / 512

        ImageLabel.Size = UDim2.fromScale(v17, v18)
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Active = true
        ImageLabel.ScaleType = Enum.ScaleType.Stretch
    end

    ImageLabel.Visible = true
    ImageLabel.ImageTransparency = 0
    p17.VREdgeBlurTimer = 0.14
end

function self.UpdateEdgeBlur(p20, p21, p22) -- line: 268
    local VRBlurScreen = p21.PlayerGui:FindFirstChild("VRBlurScreen")
    local VRBlur = if VRBlurScreen then VRBlurScreen:FindFirstChild("VRBlur") else nil

    if VRBlur then
        if p20.VREdgeBlurTimer > 0 then
            p20.VREdgeBlurTimer -= p22

            local VRBlurScreen = p21.PlayerGui:FindFirstChild("VRBlurScreen")

            if VRBlurScreen then
                local VRBlur = VRBlurScreen:FindFirstChild("VRBlur")

                if VRBlur then
                    VRBlur.ImageTransparency = 1 - math.clamp(p20.VREdgeBlurTimer, 0.01, 0.14) * 7.142857142857142
                end
            end
        else
            VRBlur.Visible = false
        end
    end
end

function self.GetCameraHeight(p23) -- line: 293
    if p23.inFirstPerson then
        return 0
    end

    return 0.25881904510252074 * p23.currentSubjectDistance
end

function self.GetSubjectCFrame(p24) -- line: 300
    -- upvalues: BaseCamera (copy)
    local v19 = BaseCamera.GetSubjectCFrame(p24)
    local CurrentCamera = workspace.CurrentCamera
    local v20 = CurrentCamera and CurrentCamera.CameraSubject

    if not v20 then
        return v19
    end

    local v21 = if v20:IsA("Humanoid") and v20:GetState() == Enum.HumanoidStateType.Dead and v20 == p24.lastSubject then p24.lastSubjectCFrame else v19

    if v21 then
        p24.lastSubjectCFrame = v21
    end

    return v21
end

function self.GetSubjectPosition(p25) -- line: 326
    -- upvalues: BaseCamera (copy)
    local v22 = BaseCamera.GetSubjectPosition(p25)
    local CurrentCamera = game.Workspace.CurrentCamera
    local v23 = CurrentCamera and CurrentCamera.CameraSubject

    if not v23 then
        return nil
    end

    if v23:IsA("Humanoid") then
        if v23:GetState() == Enum.HumanoidStateType.Dead and v23 == p25.lastSubject then
            v22 = p25.lastSubjectPosition
        end
    elseif v23:IsA("VehicleSeat") then
        v22 = v23.CFrame.p + v23.CFrame:vectorToWorldSpace((Vector3.new(0, 4, 0)))
    end

    p25.lastSubjectPosition = v22

    return v22
end

return self
