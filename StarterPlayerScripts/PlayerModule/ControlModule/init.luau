-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local Workspace = game:GetService("Workspace")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local VRService = game:GetService("VRService")
local Keyboard = require(script:WaitForChild("Keyboard"))
local Gamepad = require(script:WaitForChild("Gamepad"))
local DynamicThumbstick = require(script:WaitForChild("DynamicThumbstick"))

local function v1() -- line: 32
    return UserSettings():IsUserFeatureEnabled("UserHideControlsWhenMenuOpen")
end

local ok, result = pcall(v1)
local v2 = ok and result
local TouchThumbstick = require(script:WaitForChild("TouchThumbstick"))
local ClickToMoveController = require(script:WaitForChild("ClickToMoveController"))
local TouchJump = require(script:WaitForChild("TouchJump"))
local VehicleController = require(script:WaitForChild("VehicleController"))
local Value = Enum.ContextActionPriority.Default.Value
local t2 = {
    [Enum.TouchMovementMode.DPad] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.DPad] = DynamicThumbstick,
    [Enum.TouchMovementMode.Thumbpad] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.Thumbpad] = DynamicThumbstick,
    [Enum.TouchMovementMode.Thumbstick] = TouchThumbstick,
    [Enum.DevTouchMovementMode.Thumbstick] = TouchThumbstick,
    [Enum.TouchMovementMode.DynamicThumbstick] = DynamicThumbstick,
    [Enum.DevTouchMovementMode.DynamicThumbstick] = DynamicThumbstick,
    [Enum.TouchMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.DevTouchMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.TouchMovementMode.Default] = DynamicThumbstick,
    [Enum.ComputerMovementMode.Default] = Keyboard,
    [Enum.ComputerMovementMode.KeyboardMouse] = Keyboard,
    [Enum.DevComputerMovementMode.KeyboardMouse] = Keyboard,
    [Enum.DevComputerMovementMode.Scriptable] = nil,
    [Enum.ComputerMovementMode.ClickToMove] = ClickToMoveController,
    [Enum.DevComputerMovementMode.ClickToMove] = ClickToMoveController
}
local t3 = {
    [Enum.UserInputType.Keyboard] = Keyboard,
    [Enum.UserInputType.MouseButton1] = Keyboard,
    [Enum.UserInputType.MouseButton2] = Keyboard,
    [Enum.UserInputType.MouseButton3] = Keyboard,
    [Enum.UserInputType.MouseWheel] = Keyboard,
    [Enum.UserInputType.MouseMovement] = Keyboard,
    [Enum.UserInputType.Gamepad1] = Gamepad,
    [Enum.UserInputType.Gamepad2] = Gamepad,
    [Enum.UserInputType.Gamepad3] = Gamepad,
    [Enum.UserInputType.Gamepad4] = Gamepad
}
local v3 = nil

function t1.new() -- line: 89
    -- upvalues: t1 (copy), Players (copy), RunService (copy), UserInputService (copy), GuiService (copy), UserGameSettings (copy), v2 (copy), VehicleController (copy), Value (copy)
    local self = setmetatable({}, t1)

    self.controllers = {}
    self.activeControlModule = nil
    self.activeController = nil
    self.touchJumpController = nil
    self.moveFunction = Players.LocalPlayer.Move
    self.humanoid = nil
    self.lastInputType = Enum.UserInputType.None
    self.controlsEnabled = true
    self.humanoidSeatedConn = nil
    self.vehicleController = nil
    self.touchControlFrame = nil

    if v2 then
        GuiService.MenuOpened:Connect(function() -- line: 111
            -- upvalues: self (copy)
            if self.touchControlFrame and self.touchControlFrame.Visible then
                self.touchControlFrame.Visible = false
            end
        end)
        GuiService.MenuClosed:Connect(function() -- line: 117
            -- upvalues: self (copy)
            if self.touchControlFrame then
                self.touchControlFrame.Visible = true
            end
        end)
    end

    self.vehicleController = VehicleController.new(Value)
    Players.LocalPlayer.CharacterAdded:Connect(function(p1) -- line: 126
        -- upvalues: self (copy)
        self:OnCharacterAdded(p1)
    end)
    Players.LocalPlayer.CharacterRemoving:Connect(function(p2) -- line: 127
        -- upvalues: self (copy)
        self:OnCharacterRemoving(p2)
    end)

    if Players.LocalPlayer.Character then
        self:OnCharacterAdded(Players.LocalPlayer.Character)
    end

    RunService:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(p3) -- line: 132
        -- upvalues: self (copy)
        self:OnRenderStepped(p3)
    end)
    UserInputService.LastInputTypeChanged:Connect(function(p4) -- line: 136
        -- upvalues: self (copy)
        self:OnLastInputTypeChanged(p4)
    end)
    UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function() -- line: 141
        -- upvalues: self (copy)
        self:OnTouchMovementModeChange()
    end)
    Players.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function() -- line: 144
        -- upvalues: self (copy)
        self:OnTouchMovementModeChange()
    end)
    UserGameSettings:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function() -- line: 148
        -- upvalues: self (copy)
        self:OnComputerMovementModeChange()
    end)
    Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function() -- line: 151
        -- upvalues: self (copy)
        self:OnComputerMovementModeChange()
    end)
    self.playerGui = nil
    self.touchGui = nil
    self.playerGuiAddedConn = nil
    GuiService:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function() -- line: 160
        -- upvalues: self (copy)
        self:UpdateTouchGuiVisibility()
        self:UpdateActiveControlModuleEnabled()
    end)

    if UserInputService.TouchEnabled then
        self.playerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")

        if self.playerGui then
            self:CreateTouchGuiContainer()
            self:OnLastInputTypeChanged(UserInputService:GetLastInputType())
        else
            self.playerGuiAddedConn = Players.LocalPlayer.ChildAdded:Connect(function(p5) -- line: 171
                -- upvalues: self (copy), UserInputService (copy)
                if not p5:IsA("PlayerGui") then
                    return
                end

                self.playerGui = p5
                self:CreateTouchGuiContainer()
                self.playerGuiAddedConn:Disconnect()
                self.playerGuiAddedConn = nil
                self:OnLastInputTypeChanged(UserInputService:GetLastInputType())
            end)
        end
    else
        self:OnLastInputTypeChanged(UserInputService:GetLastInputType())
    end

    return self
end

function t1:GetMoveVector() -- line: 191
    if self.activeController then
        return self.activeController:GetMoveVector()
    end

    return (Vector3.new(0, 0, 0))
end

function t1:GetActiveController() -- line: 198
    return self.activeController
end

function t1:UpdateActiveControlModuleEnabled() -- line: 203
    -- upvalues: Players (copy), UserInputService (copy), GuiService (copy), DynamicThumbstick (copy), TouchThumbstick (copy), ClickToMoveController (copy)
    local function v5() -- line: 213
        -- upvalues: self (copy), Players (copy), ClickToMoveController (copy)
        if self.activeControlModule == ClickToMoveController then
            self.activeController:Enable(true, Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice, self.touchJumpController)
        elseif self.touchControlFrame then
            self.activeController:Enable(true, self.touchControlFrame)
        else
            self.activeController:Enable(true)
        end
    end

    if self.activeController then
        if not self.controlsEnabled or not GuiService.TouchControlsEnabled and UserInputService.TouchEnabled and (self.activeControlModule == ClickToMoveController or self.activeControlModule == TouchThumbstick or self.activeControlModule == DynamicThumbstick) then
            self.activeController:Enable(false)

            if self.moveFunction then
                self.moveFunction(Players.LocalPlayer, Vector3.new(0, 0, 0), true)
            end
        else
            v5()
        end
    end
end

function t1:Enable(p10) -- line: 253
    if p10 ~= nil then
        self.controlsEnabled = p10
    else
        self.controlsEnabled = true
    end

    if self.activeController then
        self:UpdateActiveControlModuleEnabled()
    end
end

function t1:Disable() -- line: 267
    self.controlsEnabled = false
    self:UpdateActiveControlModuleEnabled()
end

function t1.SelectComputerMovementModule(_) -- line: 275
    -- upvalues: Players (copy), UserInputService (copy), UserGameSettings (copy), Keyboard (copy), ClickToMoveController (copy), t2 (copy), t3 (copy), v3 (ref)
    if not UserInputService.KeyboardEnabled and not UserInputService.GamepadEnabled then
        return nil, false
    end

    local DevComputerMovementMode = Players.LocalPlayer.DevComputerMovementMode
    local v6

    if DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice then
        v6 = t3[v3]

        if UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and v6 == Keyboard then
            v6 = ClickToMoveController
        end
    else
        v6 = t2[DevComputerMovementMode]

        if not v6 and DevComputerMovementMode ~= Enum.DevComputerMovementMode.Scriptable then
            warn("No character control module is associated with DevComputerMovementMode ", DevComputerMovementMode)
        end
    end

    if v6 then
        return v6, true
    end

    if DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable then
        return nil, true
    end

    return nil, false
end

function t1.SelectTouchModule(_) -- line: 313
    -- upvalues: Players (copy), UserInputService (copy), UserGameSettings (copy), t2 (copy)
    if not UserInputService.TouchEnabled then
        return nil, false
    end

    local DevTouchMovementMode = Players.LocalPlayer.DevTouchMovementMode
    local v7

    if DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
        v7 = t2[UserGameSettings.TouchMovementMode]
    else
        if DevTouchMovementMode == Enum.DevTouchMovementMode.Scriptable then
            return nil, true
        end

        v7 = t2[DevTouchMovementMode]
    end

    return v7, true
end

local function calculateRawMoveVector(p14, p15) -- line: 329
    -- upvalues: Workspace (copy), VRService (copy)
    local CurrentCamera = Workspace.CurrentCamera

    if not CurrentCamera then
        return p15
    end

    if p14:GetState() == Enum.HumanoidStateType.Swimming then
        return CurrentCamera.CFrame:VectorToWorldSpace(p15)
    end

    local CFrame = CurrentCamera.CFrame

    if VRService.VREnabled and p14.RootPart and (p14.RootPart.CFrame.Position - CFrame.Position).Magnitude < 3 then
        CFrame *= VRService:GetUserCFrame(Enum.UserCFrame.Head)
    end

    local _, _, _, Components, Components2, Components3, _, _, Components4, _, _, Components5 = CFrame:GetComponents()

    if not (Components4 < 1 and Components4 > -1) then
        Components3 = -Components2 * math.sign(Components4)
    else
        Components = Components5
    end

    local v9 = math.sqrt(Components * Components + Components3 * Components3)

    return (Vector3.new((Components * p15.X + Components3 * p15.Z) / v9, 0, (Components * p15.Z - Components3 * p15.X) / v9))
end

local v12 = Vector3.new()
local v13 = Vector3.new()
local n1 = 0
local n2 = 0
local n3 = 0

function lerp(p16, p17, p18) -- line: 382
    return p16 + (p17 - p16) * p18
end

function t1:OnRenderStepped(p20) -- line: 386
    -- upvalues: Players (copy), Gamepad (copy), calculateRawMoveVector (copy), v12 (ref), v13 (ref), n1 (ref), n2 (ref), n3 (ref)
    if not (self.activeController and self.activeController.enabled and self.humanoid) then
        return
    end

    self.activeController:OnRenderStepped(p20)

    local MoveVector = self.activeController:GetMoveVector()
    local v14 = self.activeController:IsMoveVectorCameraRelative()
    local ClickToMoveController = self:GetClickToMoveController()

    if self.activeController ~= ClickToMoveController then
        if MoveVector.magnitude > 0 then
            ClickToMoveController:CleanupPath()
        else
            ClickToMoveController:OnRenderStepped(p20)
            MoveVector = ClickToMoveController:GetMoveVector()
            v14 = ClickToMoveController:IsMoveVectorCameraRelative()
        end
    end

    local v15 = if self.vehicleController then self.vehicleController:Update(MoveVector, v14, self.activeControlModule == Gamepad) else MoveVector

    if v14 then
        v15 = calculateRawMoveVector(self.humanoid, v15)
    end

    local IsJumping = self.activeController:GetIsJumping() or self.touchJumpController and self.touchJumpController:GetIsJumping()

    v12 = v15
    v13 = lerp(v13, v12, (math.clamp(p20 * 4.873, 0, 1)))

    local X, Y, Z = v13.X, v13.Y, v13.Z
    local v19, v20

    if X < n1 and X > 0 and X < 0.55 then
        v20 = false
    elseif n1 < X and X < 0 and X > -0.55 then
        v20 = false
    else
        v19 = X
        v20 = true
    end

    if not v20 then
        v19 = 0
    end

    local v22, v23

    if Y < n2 and Y > 0 and Y < 0.55 then
        v23 = false
    elseif n2 < Y and Y < 0 and Y > -0.55 then
        v23 = false
    else
        v22 = Y
        v23 = true
    end

    if not v23 then
        v22 = 0
    end

    local v25, v26

    if Z < n3 and Z > 0 and Z < 0.55 then
        v26 = false
    elseif n3 < Z and Z < 0 and Z > -0.55 then
        v26 = false
    else
        v25 = Z
        v26 = true
    end

    if not v26 then
        v25 = 0
    end

    v13 = Vector3.new(v19, v22, v25)
    n1 = v19
    n2 = v22
    n3 = v25
    self.moveFunction(Players.LocalPlayer, v13, false)
    self.humanoid.Jump = IsJumping
end

function t1:OnHumanoidSeated(p22, p23) -- line: 458
    -- upvalues: Value (copy)
    if p22 then
        if p23 and p23:IsA("VehicleSeat") then
            if not self.vehicleController then
                self.vehicleController = self.vehicleController.new(Value)
            end

            self.vehicleController:Enable(true, p23)
        end
    elseif self.vehicleController then
        self.vehicleController:Enable(false, p23)
    end
end

function t1:OnCharacterAdded(p25) -- line: 473
    self.humanoid = p25:FindFirstChildOfClass("Humanoid")

    while not self.humanoid do
        p25.ChildAdded:wait()
        self.humanoid = p25:FindFirstChildOfClass("Humanoid")
    end

    self:UpdateTouchGuiVisibility()

    if self.humanoidSeatedConn then
        self.humanoidSeatedConn:Disconnect()
        self.humanoidSeatedConn = nil
    end

    self.humanoidSeatedConn = self.humanoid.Seated:Connect(function(p26, p27) -- line: 486
        -- upvalues: self (copy)
        self:OnHumanoidSeated(p26, p27)
    end)
end

function t1:OnCharacterRemoving(_) -- line: 491
    self.humanoid = nil
    self:UpdateTouchGuiVisibility()
end

function t1:UpdateTouchGuiVisibility() -- line: 497
    -- upvalues: GuiService (copy)
    if self.touchGui then
        local v28 = self.humanoid and GuiService.TouchControlsEnabled

        self.touchGui.Enabled = not not v28
    end
end

function t1:SwitchToController(p32) -- line: 511
    -- upvalues: DynamicThumbstick (copy), TouchThumbstick (copy), ClickToMoveController (copy), TouchJump (copy), Value (copy)
    if p32 then
        if not self.controllers[p32] then
            self.controllers[p32] = p32.new(Value)
        end

        if self.activeController ~= self.controllers[p32] then
            if self.activeController then
                self.activeController:Enable(false)
            end

            self.activeController = self.controllers[p32]
            self.activeControlModule = p32

            if self.touchControlFrame and (self.activeControlModule == ClickToMoveController or self.activeControlModule == TouchThumbstick or self.activeControlModule == DynamicThumbstick) then
                if not self.controllers[TouchJump] then
                    self.controllers[TouchJump] = TouchJump.new()
                end

                self.touchJumpController = self.controllers[TouchJump]
                self.touchJumpController:Enable(true, self.touchControlFrame)
            elseif self.touchJumpController then
                self.touchJumpController:Enable(false)
            end

            self:UpdateActiveControlModuleEnabled()
        end
    else
        if self.activeController then
            self.activeController:Enable(false)
        end

        self.activeController = nil
        self.activeControlModule = nil
    end
end

function t1:OnLastInputTypeChanged(p34) -- line: 553
    -- upvalues: t3 (copy), v3 (ref)
    if v3 == p34 then
        warn("LastInputType Change listener called with current type.")
    end

    v3 = p34

    if v3 == Enum.UserInputType.Touch then
        local v30, v31 = self:SelectTouchModule()

        if v31 then
            while not self.touchControlFrame do
                wait()
            end

            self:SwitchToController(v30)
        end
    elseif t3[v3] ~= nil then
        local v32 = self:SelectComputerMovementModule()

        if v32 then
            self:SwitchToController(v32)
        end
    end

    self:UpdateTouchGuiVisibility()
end

function t1:OnComputerMovementModeChange() -- line: 580
    local v33, v34 = self:SelectComputerMovementModule()

    if v34 then
        self:SwitchToController(v33)
    end
end

function t1:OnTouchMovementModeChange() -- line: 587
    local v35, v36 = self:SelectTouchModule()

    if v36 then
        while not self.touchControlFrame do
            wait()
        end

        self:SwitchToController(v35)
    end
end

function t1:CreateTouchGuiContainer() -- line: 597
    if self.touchGui then
        self.touchGui:Destroy()
    end

    self.touchGui = Instance.new("ScreenGui")
    self.touchGui.Name = "TouchGui"
    self.touchGui.ResetOnSpawn = false
    self.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self:UpdateTouchGuiVisibility()
    self.touchControlFrame = Instance.new("Frame")
    self.touchControlFrame.Name = "TouchControlFrame"
    self.touchControlFrame.Size = UDim2.new(1, 0, 1, 0)
    self.touchControlFrame.BackgroundTransparency = 1
    self.touchControlFrame.Parent = self.touchGui
    self.touchGui.Parent = self.playerGui
end

function t1:GetClickToMoveController() -- line: 616
    -- upvalues: ClickToMoveController (copy), Value (copy)
    if not self.controllers[ClickToMoveController] then
        self.controllers[ClickToMoveController] = ClickToMoveController.new(Value)
    end

    return self.controllers[ClickToMoveController]
end

return t1.new()
