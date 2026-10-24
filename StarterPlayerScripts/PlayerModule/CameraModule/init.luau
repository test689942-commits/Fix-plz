-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

local t2 = {
    "CameraMinZoomDistance",
    "CameraMaxZoomDistance",
    "CameraMode",
    "DevCameraOcclusionMode",
    "DevComputerCameraMode",
    "DevTouchCameraMode",
    "DevComputerMovementMode",
    "DevTouchMovementMode",
    "DevEnableMouseLock"
}
local t3 = {
    "ComputerCameraMovementMode",
    "ComputerMovementMode",
    "ControlMode",
    "GamepadCameraSensitivity",
    "MouseSensitivity",
    "RotationType",
    "TouchCameraMovementMode",
    "TouchMovementMode"
}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local CameraUtils = require(script:WaitForChild("CameraUtils"))
local CameraInput = require(script:WaitForChild("CameraInput"))
local ClassicCamera = require(script:WaitForChild("ClassicCamera"))
local OrbitalCamera = require(script:WaitForChild("OrbitalCamera"))
local LegacyCamera = require(script:WaitForChild("LegacyCamera"))
local VehicleCamera = require(script:WaitForChild("VehicleCamera"))
local VRCamera = require(script:WaitForChild("VRCamera"))
local VRVehicleCamera = require(script:WaitForChild("VRVehicleCamera"))
local Invisicam = require(script:WaitForChild("Invisicam"))
local Poppercam = require(script:WaitForChild("Poppercam"))
local TransparencyController = require(script:WaitForChild("TransparencyController"))
local MouseLockController = require(script:WaitForChild("MouseLockController"))
local t4 = {}
local t5 = {}
local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts")

PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default)
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow)
PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic)
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default)
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow)
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic)
PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle)

function t1.new() -- line: 95
    -- upvalues: t1 (copy), t2 (copy), t3 (copy), Players (copy), RunService (copy), UserInputService (copy), UserGameSettings (copy), TransparencyController (copy), MouseLockController (copy)
    local self = setmetatable({}, t1)

    self.activeCameraController = nil
    self.activeOcclusionModule = nil
    self.activeTransparencyController = nil
    self.activeMouseLockController = nil
    self.currentComputerCameraMovementMode = nil
    self.cameraSubjectChangedConn = nil
    self.cameraTypeChangedConn = nil

    for _, player in pairs(Players:GetPlayers()) do
        self:OnPlayerAdded(player)
    end

    Players.PlayerAdded:Connect(function(p1) -- line: 116
        -- upvalues: self (copy)
        self:OnPlayerAdded(p1)
    end)
    self.activeTransparencyController = TransparencyController.new()
    self.activeTransparencyController:Enable(true)

    if not UserInputService.TouchEnabled then
        self.activeMouseLockController = MouseLockController.new()

        local BindableToggleEvent = self.activeMouseLockController:GetBindableToggleEvent()

        if BindableToggleEvent then
            BindableToggleEvent:Connect(function() -- line: 127
                -- upvalues: self (copy)
                self:OnMouseLockToggled()
            end)
        end
    end

    self:ActivateCameraController(self:GetCameraControlChoice())
    self:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode)
    self:OnCurrentCameraChanged()
    RunService:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(p2) -- line: 136
        -- upvalues: self (copy)
        self:Update(p2)
    end)

    for _, v2 in pairs(t2) do
        Players.LocalPlayer:GetPropertyChangedSignal(v2):Connect(function() -- line: 140
            -- upvalues: self (copy), v2 (copy)
            self:OnLocalPlayerCameraPropertyChanged(v2)
        end)
    end

    for _, v3 in pairs(t3) do
        UserGameSettings:GetPropertyChangedSignal(v3):Connect(function() -- line: 146
            -- upvalues: self (copy), v3 (copy)
            self:OnUserGameSettingsPropertyChanged(v3)
        end)
    end

    game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- line: 150
        -- upvalues: self (copy)
        self:OnCurrentCameraChanged()
    end)

    return self
end

function t1.GetCameraMovementModeFromSettings(_) -- line: 157
    -- upvalues: Players (copy), UserInputService (copy), UserGameSettings (copy), CameraUtils (copy)
    if Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
        return CameraUtils.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic)
    end

    local v4, v5

    if UserInputService.TouchEnabled then
        v4 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevTouchCameraMode)
        v5 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.TouchCameraMovementMode)
    else
        v4 = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevComputerCameraMode)
        v5 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.ComputerCameraMovementMode)
    end

    if v4 == Enum.DevComputerCameraMovementMode.UserChoice then
        return v5
    end

    return v4
end

function t1:ActivateOcclusionModule(p5) -- line: 182
    -- upvalues: Players (copy), Invisicam (copy), Poppercam (copy), t5 (copy)
    local v6

    if p5 == Enum.DevCameraOcclusionMode.Zoom then
        v6 = Poppercam
    else
        if p5 ~= Enum.DevCameraOcclusionMode.Invisicam then
            warn("CameraScript ActivateOcclusionModule called with unsupported mode")

            return
        end

        v6 = Invisicam
    end

    self.occlusionMode = p5

    if self.activeOcclusionModule and self.activeOcclusionModule:GetOcclusionMode() == p5 then
        if not self.activeOcclusionModule:GetEnabled() then
            self.activeOcclusionModule:Enable(true)
        end
    else
        local activeOcclusionModule = self.activeOcclusionModule

        self.activeOcclusionModule = t5[v6]

        if not self.activeOcclusionModule then
            self.activeOcclusionModule = v6.new()

            if self.activeOcclusionModule then
                t5[v6] = self.activeOcclusionModule
            end
        end

        if not self.activeOcclusionModule then
            return
        end

        if self.activeOcclusionModule:GetOcclusionMode() ~= p5 then
            warn("CameraScript ActivateOcclusionModule mismatch: ", self.activeOcclusionModule:GetOcclusionMode(), "~=", p5)
        end

        if activeOcclusionModule then
            if activeOcclusionModule == self.activeOcclusionModule then
                warn("CameraScript ActivateOcclusionModule failure to detect already running correct module")
            else
                activeOcclusionModule:Enable(false)
            end
        end

        if p5 == Enum.DevCameraOcclusionMode.Invisicam then
            if Players.LocalPlayer.Character then
                self.activeOcclusionModule:CharacterAdded(Players.LocalPlayer.Character, Players.LocalPlayer)
            end
        else
            for _, player in pairs(Players:GetPlayers()) do
                if player and player.Character then
                    self.activeOcclusionModule:CharacterAdded(player.Character, player)
                end
            end

            self.activeOcclusionModule:OnCameraSubjectChanged(game.Workspace.CurrentCamera.CameraSubject)
        end

        self.activeOcclusionModule:Enable(true)
    end
end

function t1:ShouldUseVehicleCamera() -- line: 261
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return false
    end

    local CameraType, CameraSubject = CurrentCamera.CameraType, CurrentCamera.CameraSubject
    local v7 = CameraType == Enum.CameraType.Custom or CameraType == Enum.CameraType.Follow
    local VehicleSeat = CameraSubject and CameraSubject:IsA("VehicleSeat") or false
    local v8 = self.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam

    return VehicleSeat and v7 and v8
end

function t1:ActivateCameraController(p8, p9) -- line: 279
    -- upvalues: VRService (copy), ClassicCamera (copy), OrbitalCamera (copy), LegacyCamera (copy), VehicleCamera (copy), VRCamera (copy), VRVehicleCamera (copy), t4 (copy)
    local v9, v10

    if p9 ~= nil then
        if p9 == Enum.CameraType.Scriptable then
            if self.activeCameraController then
                self.activeCameraController:Enable(false)
                self.activeCameraController = nil
            end

            return
        end

        if p9 == Enum.CameraType.Custom then
            v10 = self:GetCameraMovementModeFromSettings()
            v9 = nil
        elseif p9 == Enum.CameraType.Track then
            v10 = Enum.ComputerCameraMovementMode.Classic
            v9 = nil
        elseif p9 == Enum.CameraType.Follow then
            v10 = Enum.ComputerCameraMovementMode.Follow
            v9 = nil
        elseif p9 == Enum.CameraType.Orbital then
            v10 = Enum.ComputerCameraMovementMode.Orbital
            v9 = nil
        else
            if p9 ~= Enum.CameraType.Attach and p9 ~= Enum.CameraType.Watch and p9 ~= Enum.CameraType.Fixed then
                v9 = nil
                warn("CameraScript encountered an unhandled Camera.CameraType value: ", p9)
            else
                v9 = LegacyCamera
            end

            v10 = p8
        end
    else
        v10 = p8
    end

    if not v9 then
        if VRService.VREnabled then
            v9 = VRCamera
        elseif v10 ~= Enum.ComputerCameraMovementMode.Classic and v10 ~= Enum.ComputerCameraMovementMode.Follow and v10 ~= Enum.ComputerCameraMovementMode.Default and v10 ~= Enum.ComputerCameraMovementMode.CameraToggle then
            if v10 ~= Enum.ComputerCameraMovementMode.Orbital then
                warn("ActivateCameraController did not select a module.")

                return
            end

            v9 = OrbitalCamera
        else
            v9 = ClassicCamera
        end
    end

    if self:ShouldUseVehicleCamera() then
        v9 = if VRService.VREnabled then VRVehicleCamera else VehicleCamera
    end

    local v11

    if t4[v9] then
        v11 = t4[v9]

        if v11.Reset then
            v11:Reset()
        end
    else
        v11 = v9.new()
        t4[v9] = v11
    end

    if self.activeCameraController then
        if self.activeCameraController == v11 then
            if not self.activeCameraController:GetEnabled() then
                self.activeCameraController:Enable(true)
            end
        else
            self.activeCameraController:Enable(false)
            self.activeCameraController = v11
            self.activeCameraController:Enable(true)
        end
    elseif v11 ~= nil then
        self.activeCameraController = v11
        self.activeCameraController:Enable(true)
    end

    if self.activeCameraController then
        if v10 ~= nil then
            self.activeCameraController:SetCameraMovementMode(v10)
        elseif p9 ~= nil then
            self.activeCameraController:SetCameraType(p9)
        end
    end
end

function t1:OnCameraSubjectChanged() -- line: 384
    local CurrentCamera = workspace.CurrentCamera
    local v12 = CurrentCamera and CurrentCamera.CameraSubject

    if self.activeTransparencyController then
        self.activeTransparencyController:SetSubject(v12)
    end

    if self.activeOcclusionModule then
        self.activeOcclusionModule:OnCameraSubjectChanged(v12)
    end

    self:ActivateCameraController(nil, CurrentCamera.CameraType)
end

function t1.OnCameraTypeChanged(p11, p12) -- line: 399
    -- upvalues: UserInputService (copy), CameraUtils (copy)
    if p12 == Enum.CameraType.Scriptable and UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
        CameraUtils.restoreMouseBehavior()
    end

    p11:ActivateCameraController(nil, p12)
end

function t1:OnCurrentCameraChanged() -- line: 411
    local CurrentCamera = game.Workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    if self.cameraSubjectChangedConn then
        self.cameraSubjectChangedConn:Disconnect()
    end

    if self.cameraTypeChangedConn then
        self.cameraTypeChangedConn:Disconnect()
    end

    self.cameraSubjectChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- line: 423
        -- upvalues: self (copy), CurrentCamera (copy)
        self:OnCameraSubjectChanged(CurrentCamera.CameraSubject)
    end)
    self.cameraTypeChangedConn = CurrentCamera:GetPropertyChangedSignal("CameraType"):Connect(function() -- line: 427
        -- upvalues: self (copy), CurrentCamera (copy)
        self:OnCameraTypeChanged(CurrentCamera.CameraType)
    end)
    self:OnCameraSubjectChanged(CurrentCamera.CameraSubject)
    self:OnCameraTypeChanged(CurrentCamera.CameraType)
end

function t1:OnLocalPlayerCameraPropertyChanged(p15) -- line: 435
    -- upvalues: Players (copy), CameraUtils (copy)
    if p15 == "CameraMode" then
        if Players.LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson then
            if Players.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
                local CameraMovementModeFromSettings = self:GetCameraMovementModeFromSettings()

                self:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(CameraMovementModeFromSettings))
            else
                warn("Unhandled value for property player.CameraMode: ", Players.LocalPlayer.CameraMode)
            end
        else
            if not self.activeCameraController or self.activeCameraController:GetModuleName() ~= "ClassicCamera" then
                self:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(Enum.DevComputerCameraMovementMode.Classic))
            end

            if self.activeCameraController then
                self.activeCameraController:UpdateForDistancePropertyChange()
            end
        end
    elseif p15 == "DevComputerCameraMode" or p15 == "DevTouchCameraMode" then
        local CameraMovementModeFromSettings = self:GetCameraMovementModeFromSettings()

        self:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(CameraMovementModeFromSettings))
    elseif p15 == "DevCameraOcclusionMode" then
        self:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode)
    elseif (p15 == "CameraMinZoomDistance" or p15 == "CameraMaxZoomDistance") and self.activeCameraController then
        self.activeCameraController:UpdateForDistancePropertyChange()
    end
end

function t1:OnUserGameSettingsPropertyChanged(p17) -- line: 479
    -- upvalues: CameraUtils (copy)
    if p17 == "ComputerCameraMovementMode" then
        local CameraMovementModeFromSettings = self:GetCameraMovementModeFromSettings()

        self:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(CameraMovementModeFromSettings))
    end
end

function t1:Update(p19) -- line: 492
    -- upvalues: CameraInput (copy)
    if self.activeCameraController then
        self.activeCameraController:UpdateMouseBehavior()

        local v13, v14 = self.activeCameraController:Update(p19)

        if self.activeOcclusionModule then
            v13, v14 = self.activeOcclusionModule:Update(p19, v13, v14)
        end

        local CurrentCamera = game.Workspace.CurrentCamera

        CurrentCamera.CFrame = v13
        CurrentCamera.Focus = v14

        if self.activeTransparencyController then
            self.activeTransparencyController:Update(p19)
        end

        if CameraInput.getInputEnabled() then
            CameraInput.resetInputForFrameEnd()
        end
    end
end

function t1.GetCameraControlChoice(_) -- line: 520
    -- upvalues: Players (copy), UserInputService (copy), UserGameSettings (copy), CameraUtils (copy)
    local LocalPlayer = Players.LocalPlayer

    if not LocalPlayer then
        return
    end

    if UserInputService:GetLastInputType() == Enum.UserInputType.Touch or UserInputService.TouchEnabled then
        if LocalPlayer.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice then
            return CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.TouchCameraMovementMode)
        end

        return CameraUtils.ConvertCameraModeEnumToStandard(LocalPlayer.DevTouchCameraMode)
    end

    if LocalPlayer.DevComputerCameraMode ~= Enum.DevComputerCameraMovementMode.UserChoice then
        return CameraUtils.ConvertCameraModeEnumToStandard(LocalPlayer.DevComputerCameraMode)
    end

    local v15 = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.ComputerCameraMovementMode)

    return CameraUtils.ConvertCameraModeEnumToStandard(v15)
end

function t1:OnCharacterAdded(p22, p23) -- line: 543
    if self.activeOcclusionModule then
        self.activeOcclusionModule:CharacterAdded(p22, p23)
    end
end

function t1:OnCharacterRemoving(p25, p26) -- line: 549
    if self.activeOcclusionModule then
        self.activeOcclusionModule:CharacterRemoving(p25, p26)
    end
end

function t1.OnPlayerAdded(p27, p28) -- line: 555
    p28.CharacterAdded:Connect(function(p29) -- line: 556
        -- upvalues: p27 (copy), p28 (copy)
        p27:OnCharacterAdded(p29, p28)
    end)
    p28.CharacterRemoving:Connect(function(p30) -- line: 559
        -- upvalues: p27 (copy), p28 (copy)
        p27:OnCharacterRemoving(p30, p28)
    end)
end

function t1:OnMouseLockToggled() -- line: 564
    if self.activeMouseLockController then
        local IsMouseLocked = self.activeMouseLockController:GetIsMouseLocked()
        local MouseLockOffset = self.activeMouseLockController:GetMouseLockOffset()

        if self.activeCameraController then
            self.activeCameraController:SetIsMouseLocked(IsMouseLocked)
            self.activeCameraController:SetMouseLockOffset(MouseLockOffset)
        end
    end
end

t1.new()

return {}
