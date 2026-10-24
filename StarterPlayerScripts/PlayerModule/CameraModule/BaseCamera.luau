-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

Vector2.new(0.2617993877991494, 0)
Vector2.new(0.7853981633974483, 0)
Vector2.new(0, 0)

local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local ZoomController = require(script.Parent:WaitForChild("ZoomController"))
local CameraToggleStateController = require(script.Parent:WaitForChild("CameraToggleStateController"))
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local CameraUI = require(script.Parent:WaitForChild("CameraUI"))
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

game:GetService("StarterGui")

local VRService = game:GetService("VRService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local LocalPlayer = Players.LocalPlayer
local t1 = {}

t1.__index = t1

function t1.new() -- line: 63
    -- upvalues: UserGameSettings (copy), LocalPlayer (copy), t1 (copy)
    local self = setmetatable({}, t1)

    self.FIRST_PERSON_DISTANCE_THRESHOLD = 1
    self.cameraType = nil
    self.cameraMovementMode = nil
    self.lastCameraTransform = nil
    self.lastUserPanCamera = tick()
    self.humanoidRootPart = nil
    self.humanoidCache = {}
    self.lastSubject = nil
    self.lastSubjectPosition = Vector3.new(0, 5, 0)
    self.lastSubjectCFrame = CFrame.new(self.lastSubjectPosition)
    self.defaultSubjectDistance = math.clamp(12.5, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance)
    self.currentSubjectDistance = math.clamp(12.5, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance)
    self.inFirstPerson = false
    self.inMouseLockedMode = true
    self.portraitMode = false
    self.isSmallTouchScreen = false
    self.resetCameraAngle = true
    self.enabled = false
    self.PlayerGui = nil
    self.cameraChangedConn = nil
    self.viewportSizeChangedConn = nil
    self.shouldUseVRRotation = false
    self.VRRotationIntensityAvailable = false
    self.lastVRRotationIntensityCheckTime = 0
    self.lastVRRotationTime = 0
    self.vrRotateKeyCooldown = {}
    self.cameraTranslationConstraints = Vector3.new(1, 1, 1)
    self.humanoidJumpOrigin = nil
    self.trackingHumanoid = nil
    self.cameraFrozen = false
    self.subjectStateChangedConn = nil
    self.gamepadZoomPressConnection = nil
    self.mouseLockOffset = Vector3.new(0, 0, 0)

    if LocalPlayer.Character then
        self:OnCharacterAdded(LocalPlayer.Character)
    end

    LocalPlayer.CharacterAdded:Connect(function(p1) -- line: 131
        -- upvalues: self (copy)
        self:OnCharacterAdded(p1)
    end)

    if self.cameraChangedConn then
        self.cameraChangedConn:Disconnect()
    end

    self.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- line: 136
        -- upvalues: self (copy)
        self:OnCurrentCameraChanged()
    end)
    self:OnCurrentCameraChanged()

    if self.playerCameraModeChangeConn then
        self.playerCameraModeChangeConn:Disconnect()
    end

    self.playerCameraModeChangeConn = LocalPlayer:GetPropertyChangedSignal("CameraMode"):Connect(function() -- line: 142
        -- upvalues: self (copy)
        self:OnPlayerCameraPropertyChange()
    end)

    if self.minDistanceChangeConn then
        self.minDistanceChangeConn:Disconnect()
    end

    self.minDistanceChangeConn = LocalPlayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function() -- line: 147
        -- upvalues: self (copy)
        self:OnPlayerCameraPropertyChange()
    end)

    if self.maxDistanceChangeConn then
        self.maxDistanceChangeConn:Disconnect()
    end

    self.maxDistanceChangeConn = LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function() -- line: 152
        -- upvalues: self (copy)
        self:OnPlayerCameraPropertyChange()
    end)

    if self.playerDevTouchMoveModeChangeConn then
        self.playerDevTouchMoveModeChangeConn:Disconnect()
    end

    self.playerDevTouchMoveModeChangeConn = LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() -- line: 157
        -- upvalues: self (copy)
        self:OnDevTouchMovementModeChanged()
    end)
    self:OnDevTouchMovementModeChanged()

    if self.gameSettingsTouchMoveMoveChangeConn then
        self.gameSettingsTouchMoveMoveChangeConn:Disconnect()
    end

    self.gameSettingsTouchMoveMoveChangeConn = UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() -- line: 163
        -- upvalues: self (copy)
        self:OnGameSettingsTouchMovementModeChanged()
    end)
    self:OnGameSettingsTouchMovementModeChanged()
    UserGameSettings:SetCameraYInvertVisible()
    UserGameSettings:SetGamepadCameraSensitivityVisible()
    self.hasGameLoaded = game:IsLoaded()

    if not self.hasGameLoaded then
        self.gameLoadedConn = game.Loaded:Connect(function() -- line: 173
            -- upvalues: self (copy)
            self.hasGameLoaded = true
            self.gameLoadedConn:Disconnect()
            self.gameLoadedConn = nil
        end)
    end

    self:OnPlayerCameraPropertyChange()

    return self
end

function t1.GetModuleName(_) -- line: 185
    return "BaseCamera"
end

function t1:OnCharacterAdded(p4) -- line: 189
    -- upvalues: UserInputService (copy), LocalPlayer (copy)
    self.resetCameraAngle = self.resetCameraAngle or self:GetEnabled()
    self.humanoidRootPart = nil

    if UserInputService.TouchEnabled then
        self.PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

        for _, child in ipairs(p4:GetChildren()) do
            if child:IsA("Tool") then
                self.isAToolEquipped = true
            end
        end

        p4.ChildAdded:Connect(function(p5) -- line: 199
            -- upvalues: self (copy)
            if p5:IsA("Tool") then
                self.isAToolEquipped = true
            end
        end)
        p4.ChildRemoved:Connect(function(p6) -- line: 204
            -- upvalues: self (copy)
            if p6:IsA("Tool") then
                self.isAToolEquipped = false
            end
        end)
    end
end

function t1:GetHumanoidRootPart() -- line: 212
    -- upvalues: LocalPlayer (copy)
    if not self.humanoidRootPart and LocalPlayer.Character then
        local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

        if Humanoid then
            self.humanoidRootPart = Humanoid.RootPart
        end
    end

    return self.humanoidRootPart
end

function t1.GetBodyPartToFollow(_, p9, _) -- line: 224
    if p9:GetState() == Enum.HumanoidStateType.Dead then
        local Parent = p9.Parent
        local v2

        if Parent and Parent:IsA("Model") then
            v2 = Parent:FindFirstChild("Head") or p9.RootPart

            return v2
        end
    end

    return p9.RootPart
end

function t1:GetSubjectCFrame() -- line: 236
    local lastSubjectCFrame = self.lastSubjectCFrame
    local CurrentCamera = workspace.CurrentCamera
    local v3 = CurrentCamera and CurrentCamera.CameraSubject

    if not v3 then
        return lastSubjectCFrame
    end

    local v4 = lastSubjectCFrame

    if v3:IsA("Humanoid") then
        local v5 = v3:GetState() == Enum.HumanoidStateType.Dead
        local RootPart = v3.RootPart

        if v5 then
            RootPart = v3.Parent and v3.Parent:IsA("Model") and v3.Parent:FindFirstChild("Head") or RootPart
        end

        if RootPart and RootPart:IsA("BasePart") then
            local v6

            if v3.RigType == Enum.HumanoidRigType.R15 then
                if v3.AutomaticScalingEnabled then
                    local RootPart2 = v3.RootPart

                    v6 = if RootPart == RootPart2 then Vector3.new(0, 1.5, 0) + Vector3.new(0, (RootPart2.Size.Y - 2) / 2, 0) else Vector3.new(0, 1.5, 0)
                else
                    v6 = Vector3.new(0, 2, 0)
                end
            else
                v6 = Vector3.new(0, 1.5, 0)
            end

            if v5 then
                v6 = Vector3.new(0, 0, 0)
            end

            v4 = RootPart.CFrame * CFrame.new(v6 + v3.CameraOffset)
        end
    elseif v3:IsA("BasePart") then
        v4 = v3.CFrame
    elseif v3:IsA("Model") then
        v4 = if v3.PrimaryPart then v3:GetPrimaryPartCFrame() else CFrame.new()
    end

    if v4 then
        self.lastSubjectCFrame = v4
    end

    return v4
end

function t1.GetSubjectVelocity(_) -- line: 302
    local CurrentCamera = workspace.CurrentCamera
    local v8 = CurrentCamera and CurrentCamera.CameraSubject

    if v8 then
        if v8:IsA("BasePart") then
            return v8.Velocity
        end

        if v8:IsA("Humanoid") then
            local RootPart = v8.RootPart

            if RootPart then
                return RootPart.Velocity
            end
        elseif v8:IsA("Model") then
            local PrimaryPart = v8.PrimaryPart

            if PrimaryPart then
                return PrimaryPart.Velocity
            end
        end
    end

    return (Vector3.new(0, 0, 0))
end

function t1.GetSubjectRotVelocity(_) -- line: 331
    local CurrentCamera = workspace.CurrentCamera
    local v9 = CurrentCamera and CurrentCamera.CameraSubject

    if v9 then
        if v9:IsA("BasePart") then
            return v9.RotVelocity
        end

        if v9:IsA("Humanoid") then
            local RootPart = v9.RootPart

            if RootPart then
                return RootPart.RotVelocity
            end
        elseif v9:IsA("Model") then
            local PrimaryPart = v9.PrimaryPart

            if PrimaryPart then
                return PrimaryPart.RotVelocity
            end
        end
    end

    return (Vector3.new(0, 0, 0))
end

function t1:StepZoom() -- line: 360
    -- upvalues: ZoomController (copy), CameraInput (copy)
    local currentSubjectDistance = self.currentSubjectDistance
    local v10 = CameraInput.getZoomDelta()

    if math.abs(v10) > 0 then
        local v11 = if v10 > 0 then math.max(currentSubjectDistance + v10 * (currentSubjectDistance * 0.5 + 1), self.FIRST_PERSON_DISTANCE_THRESHOLD) else math.max((currentSubjectDistance + v10) / (1 - v10 * 0.5), 0.5)

        if v11 < self.FIRST_PERSON_DISTANCE_THRESHOLD then
            v11 = 0.5
        end

        self:SetCameraToSubjectDistance(v11)
    end

    return ZoomController.GetZoomRadius()
end

function t1:GetSubjectPosition() -- line: 385
    local lastSubjectPosition = self.lastSubjectPosition
    local CurrentCamera = game.Workspace.CurrentCamera
    local v14 = CurrentCamera and CurrentCamera.CameraSubject

    if not v14 then
        return nil
    end

    local v15 = lastSubjectPosition

    if v14:IsA("Humanoid") then
        local v16 = v14:GetState() == Enum.HumanoidStateType.Dead
        local RootPart = v14.RootPart

        if v16 then
            RootPart = v14.Parent and v14.Parent:IsA("Model") and v14.Parent:FindFirstChild("Head") or RootPart
        end

        if RootPart and RootPart:IsA("BasePart") then
            local v17 = if v14.RigType ~= Enum.HumanoidRigType.R15 then Vector3.new(0, 1.5, 0)
                elseif not v14.AutomaticScalingEnabled then Vector3.new(0, 2, 0)
                elseif RootPart == v14.RootPart then Vector3.new(0, 1.5, 0) + Vector3.new(0, v14.RootPart.Size.Y / 2 - 1, 0)
                else Vector3.new(0, 1.5, 0)

            if v16 then
                v17 = Vector3.new(0, 0, 0)
            end

            v15 = RootPart.CFrame.p + RootPart.CFrame:vectorToWorldSpace(v17 + v14.CameraOffset)
        end
    elseif v14:IsA("VehicleSeat") then
        v15 = v14.CFrame.p + v14.CFrame:vectorToWorldSpace((Vector3.new(0, 5, 0)))
    elseif v14:IsA("SkateboardPlatform") then
        v15 = v14.CFrame.p + Vector3.new(0, 5, 0)
    elseif v14:IsA("BasePart") then
        v15 = v14.CFrame.p
    elseif v14:IsA("Model") then
        v15 = if v14.PrimaryPart then v14:GetPrimaryPartCFrame().p else v14:GetModelCFrame().p
    end

    self.lastSubject = v14
    self.lastSubjectPosition = v15

    return v15
end

function t1:UpdateDefaultSubjectDistance() -- line: 455
    -- upvalues: LocalPlayer (copy)
    if self.portraitMode then
        self.defaultSubjectDistance = math.clamp(25, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance)
    else
        self.defaultSubjectDistance = math.clamp(12.5, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance)
    end
end

function t1:OnViewportSizeChanged() -- line: 463
    -- upvalues: UserInputService (copy)
    local ViewportSize = game.Workspace.CurrentCamera.ViewportSize

    self.portraitMode = ViewportSize.X < ViewportSize.Y

    local TouchEnabled = UserInputService.TouchEnabled and (ViewportSize.Y < 500 or ViewportSize.X < 700)

    self.isSmallTouchScreen = TouchEnabled
    self:UpdateDefaultSubjectDistance()
end

function t1:OnCurrentCameraChanged() -- line: 473
    -- upvalues: UserInputService (copy)
    if UserInputService.TouchEnabled then
        if self.viewportSizeChangedConn then
            self.viewportSizeChangedConn:Disconnect()
            self.viewportSizeChangedConn = nil
        end

        local CurrentCamera = game.Workspace.CurrentCamera

        if CurrentCamera then
            self:OnViewportSizeChanged()
            self.viewportSizeChangedConn = CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- line: 484
                -- upvalues: self (copy)
                self:OnViewportSizeChanged()
            end)
        end
    end

    if self.cameraSubjectChangedConn then
        self.cameraSubjectChangedConn:Disconnect()
        self.cameraSubjectChangedConn = nil
    end

    local CurrentCamera = game.Workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    self.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- line: 498
        -- upvalues: self (copy)
        self:OnNewCameraSubject()
    end)
    self:OnNewCameraSubject()
end

function t1:OnDynamicThumbstickEnabled() -- line: 505
    -- upvalues: UserInputService (copy)
    if UserInputService.TouchEnabled then
        self.isDynamicThumbstickEnabled = true
    end
end

function t1:OnDynamicThumbstickDisabled() -- line: 511
    self.isDynamicThumbstickEnabled = false
end

function t1.OnGameSettingsTouchMovementModeChanged(p21) -- line: 515
    -- upvalues: UserGameSettings (copy), LocalPlayer (copy)
    if LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        if UserGameSettings.TouchMovementMode == Enum.TouchMovementMode.DynamicThumbstick or UserGameSettings.TouchMovementMode == Enum.TouchMovementMode.Default then
            p21:OnDynamicThumbstickEnabled()
        else
            p21:OnDynamicThumbstickDisabled()
        end
    end
end

function t1.OnDevTouchMovementModeChanged(p22) -- line: 526
    -- upvalues: LocalPlayer (copy)
    if LocalPlayer.DevTouchMovementMode == Enum.DevTouchMovementMode.DynamicThumbstick then
        p22:OnDynamicThumbstickEnabled()
    else
        p22:OnGameSettingsTouchMovementModeChanged()
    end
end

function t1:OnPlayerCameraPropertyChange() -- line: 534
    self:SetCameraToSubjectDistance(self.currentSubjectDistance)
end

function t1.InputTranslationToCameraAngleChange(_, p25, p26) -- line: 539
    return p25 * p26
end

function t1:GamepadZoomPress() -- line: 543
    local CameraToSubjectDistance = self:GetCameraToSubjectDistance()

    if CameraToSubjectDistance > 15 then
        self:SetCameraToSubjectDistance(10)
    elseif CameraToSubjectDistance > 5 then
        self:SetCameraToSubjectDistance(0)
    else
        self:SetCameraToSubjectDistance(20)
    end
end

function t1:Enable(p29) -- line: 555
    -- upvalues: CameraInput (copy), LocalPlayer (copy)
    if self.enabled == p29 then
        return
    end

    self.enabled = p29

    if self.enabled then
        CameraInput.setInputEnabled(true)
        self.gamepadZoomPressConnection = CameraInput.gamepadZoomPress:Connect(function() -- line: 561
            -- upvalues: self (copy)
            self:GamepadZoomPress()
        end)

        if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
            self.currentSubjectDistance = 0.5

            if not self.inFirstPerson then
                self:EnterFirstPerson()
            end
        end
    else
        CameraInput.setInputEnabled(false)

        if self.gamepadZoomPressConnection then
            self.gamepadZoomPressConnection:Disconnect()
            self.gamepadZoomPressConnection = nil
        end

        self:Cleanup()
    end

    self:OnEnable(p29)
end

function t1.OnEnable(_, _) -- line: 586
end

function t1:GetEnabled() -- line: 590
    return self.enabled
end

function t1:Cleanup() -- line: 594
    -- upvalues: CameraUtils (copy)
    if self.subjectStateChangedConn then
        self.subjectStateChangedConn:Disconnect()
        self.subjectStateChangedConn = nil
    end

    if self.viewportSizeChangedConn then
        self.viewportSizeChangedConn:Disconnect()
        self.viewportSizeChangedConn = nil
    end

    self.lastCameraTransform = nil
    self.lastSubjectCFrame = nil
    CameraUtils.restoreMouseBehavior()
end

function t1:UpdateMouseBehavior() -- line: 611
    -- upvalues: CameraUtils (copy), CameraToggleStateController (copy), CameraInput (copy), CameraUI (copy), UserGameSettings (copy)
    local v19 = UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove

    if not self.isCameraToggle or v19 ~= false then
        CameraUI.setCameraModeToastEnabled(false)
        CameraInput.disableCameraToggleInput()

        if not self.inFirstPerson then
            if self.inMouseLockedMode then
                return
            end

            CameraUtils.restoreRotationType()
            CameraUtils.restoreMouseBehavior()
        end
    else
        CameraUI.setCameraModeToastEnabled(true)
        CameraInput.enableCameraToggleInput()
        CameraToggleStateController(self.inFirstPerson)
    end
end

function t1:UpdateForDistancePropertyChange() -- line: 633
    self:SetCameraToSubjectDistance(self.currentSubjectDistance)
end

function t1:SetCameraToSubjectDistance(p37) -- line: 639
    -- upvalues: ZoomController (copy), LocalPlayer (copy)
    local currentSubjectDistance = self.currentSubjectDistance

    if LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        self.currentSubjectDistance = 0.5

        if not self.inFirstPerson then
            self:EnterFirstPerson()
        end
    else
        local v20 = math.clamp(p37, LocalPlayer.CameraMinZoomDistance, LocalPlayer.CameraMaxZoomDistance)

        if v20 < 1 then
            self.currentSubjectDistance = 0.5

            if not self.inFirstPerson then
                self:EnterFirstPerson()
            end
        else
            self.currentSubjectDistance = v20

            if self.inFirstPerson then
                self:LeaveFirstPerson()
            end
        end
    end

    ZoomController.SetZoomParameters(self.currentSubjectDistance, (math.sign(p37 - currentSubjectDistance)))

    return self.currentSubjectDistance
end

function t1:SetCameraType(p39) -- line: 673
    self.cameraType = p39
end

function t1:GetCameraType() -- line: 678
    return self.cameraType
end

function t1:SetCameraMovementMode(p42) -- line: 683
    self.cameraMovementMode = p42
end

function t1:GetCameraMovementMode() -- line: 687
    return self.cameraMovementMode
end

function t1:SetIsMouseLocked(p45) -- line: 691
    self.inMouseLockedMode = p45
end

function t1:GetIsMouseLocked() -- line: 695
    return self.inMouseLockedMode
end

function t1:SetMouseLockOffset(p48) -- line: 699
    self.mouseLockOffset = p48
end

function t1:GetMouseLockOffset() -- line: 703
    return self.mouseLockOffset
end

function t1:InFirstPerson() -- line: 707
    return self.inFirstPerson
end

function t1.EnterFirstPerson(_) -- line: 711
end

function t1.LeaveFirstPerson(_) -- line: 715
end

function t1:GetCameraToSubjectDistance() -- line: 720
    return self.currentSubjectDistance
end

function t1.GetMeasuredDistanceToFocus(_) -- line: 727
    local CurrentCamera = game.Workspace.CurrentCamera

    return if CurrentCamera then (CurrentCamera.CoordinateFrame.p - CurrentCamera.Focus.p).magnitude else nil
end

function t1.GetCameraLookVector(_) -- line: 735
    return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or Vector3.new(0, 0, 1)
end

function t1:CalculateNewLookCFrameFromArg(p57, p58) -- line: 739
    p57 = p57 or self:GetCameraLookVector()

    local v23 = math.asin(p57.Y)
    local v26 = math.clamp(p58.Y, v23 + -1.3962634015954636, v23 + 1.3962634015954636)
    local v27 = Vector2.new(p58.X, v26)
    local v28 = CFrame.new(Vector3.new(0, 0, 0), p57)

    return CFrame.Angles(0, -v27.X, 0) * v28 * CFrame.Angles(-v27.Y, 0, 0)
end

function t1:CalculateNewLookVectorFromArg(p60, p61) -- line: 749
    return self:CalculateNewLookCFrameFromArg(p60, p61).LookVector
end

function t1:CalculateNewLookVectorVRFromArg(p63) -- line: 754
    local unit = ((self:GetSubjectPosition() - game.Workspace.CurrentCamera.CFrame.p) * Vector3.new(1, 0, 1)).unit
    local v29 = Vector2.new(p63.X, 0)
    local v30 = CFrame.new(Vector3.new(0, 0, 0), unit)

    return ((CFrame.Angles(0, -v29.X, 0) * v30 * CFrame.Angles(-v29.Y, 0, 0)).LookVector * Vector3.new(1, 0, 1)).unit
end

function t1:GetHumanoid() -- line: 764
    -- upvalues: LocalPlayer (copy)
    local v31 = LocalPlayer and LocalPlayer.Character

    if not v31 then
        return nil
    end

    local v32 = self.humanoidCache[LocalPlayer]

    if v32 and v32.Parent == v31 then
        return v32
    end

    self.humanoidCache[LocalPlayer] = nil

    local Humanoid = v31:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        self.humanoidCache[LocalPlayer] = Humanoid
    end

    return Humanoid
end

function t1.GetHumanoidPartToFollow(_, p66, p67) -- line: 782
    if p67 ~= Enum.HumanoidStateType.Dead then
        return p66.Torso
    end

    local Parent = p66.Parent

    return Parent and Parent:FindFirstChild("Head") or p66.Torso
end

function t1:OnNewCameraSubject() -- line: 796
    if self.subjectStateChangedConn then
        self.subjectStateChangedConn:Disconnect()
        self.subjectStateChangedConn = nil
    end
end

function t1:IsInFirstPerson() -- line: 803
    return self.inFirstPerson
end

function t1.Update(_, _) -- line: 807
    error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2)
end

function t1:GetCameraHeight() -- line: 811
    -- upvalues: VRService (copy)
    if not VRService.VREnabled or self.inFirstPerson then
        return 0
    end

    return 0.25881904510252074 * self.currentSubjectDistance
end

return t1
