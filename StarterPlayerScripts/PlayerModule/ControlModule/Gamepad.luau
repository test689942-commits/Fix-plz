-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local None = Enum.UserInputType.None
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"))
local self = setmetatable({}, BaseCharacterController)

self.__index = self

function self.new(p1) -- line: 21
    -- upvalues: None (copy), BaseCharacterController (copy), self (copy)
    local v3 = setmetatable(BaseCharacterController.new(), self)

    v3.CONTROL_ACTION_PRIORITY = p1
    v3.forwardValue = 0
    v3.backwardValue = 0
    v3.leftValue = 0
    v3.rightValue = 0
    v3.activeGamepad = None
    v3.gamepadConnectedConn = nil
    v3.gamepadDisconnectedConn = nil

    return v3
end

function self.Enable(p2, p3) -- line: 37
    -- upvalues: UserInputService (copy), None (copy)
    if not UserInputService.GamepadEnabled then
        return false
    end

    if p3 ~= p2.enabled then
        p2.forwardValue = 0
        p2.backwardValue = 0
        p2.leftValue = 0
        p2.rightValue = 0
        p2.moveVector = Vector3.new(0, 0, 0)
        p2.isJumping = false

        if p3 then
            p2.activeGamepad = p2:GetHighestPriorityGamepad()

            if p2.activeGamepad == None then
                return false
            end

            p2:BindContextActions()
            p2:ConnectGamepadConnectionListeners()
        else
            p2:UnbindContextActions()
            p2:DisconnectGamepadConnectionListeners()
            p2.activeGamepad = None
        end

        p2.enabled = p3
    end

    return true
end

function self.GetHighestPriorityGamepad(_) -- line: 77
    -- upvalues: UserInputService (copy), None (copy)
    local ConnectedGamepads = UserInputService:GetConnectedGamepads()
    local v4 = None

    for _, v5 in pairs(ConnectedGamepads) do
        if v5.Value < v4.Value then
            v4 = v5
        end
    end

    return v4
end

function self.BindContextActions(p5) -- line: 88
    -- upvalues: ContextActionService (copy), None (copy)
    if p5.activeGamepad == None then
        return false
    end

    local function v6(_, p7, _) -- line: 95
        -- upvalues: p5 (copy)
        p5.isJumping = p7 == Enum.UserInputState.Begin

        return Enum.ContextActionResult.Sink
    end

    local function v7(_, p10, p11) -- line: 100
        -- upvalues: p5 (copy)
        if p10 == Enum.UserInputState.Cancel then
            p5.moveVector = Vector3.new(0, 0, 0)

            return Enum.ContextActionResult.Sink
        end

        if p5.activeGamepad ~= p11.UserInputType then
            return Enum.ContextActionResult.Pass
        end

        if p11.KeyCode == Enum.KeyCode.Thumbstick1 then
            if p11.Position.magnitude > 0.2 then
                p5.moveVector = Vector3.new(p11.Position.X, 0, -p11.Position.Y)
            else
                p5.moveVector = Vector3.new(0, 0, 0)
            end

            return Enum.ContextActionResult.Sink
        end
    end

    ContextActionService:BindActivate(p5.activeGamepad, Enum.KeyCode.ButtonR2)
    ContextActionService:BindActionAtPriority("jumpAction", v6, false, p5.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA)
    ContextActionService:BindActionAtPriority("moveThumbstick", v7, false, p5.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1)

    return true
end

function self.UnbindContextActions(p12) -- line: 129
    -- upvalues: ContextActionService (copy), None (copy)
    if p12.activeGamepad ~= None then
        ContextActionService:UnbindActivate(p12.activeGamepad, Enum.KeyCode.ButtonR2)
    end

    ContextActionService:UnbindAction("moveThumbstick")
    ContextActionService:UnbindAction("jumpAction")
end

function self.OnNewGamepadConnected(p13) -- line: 137
    -- upvalues: None (copy)
    local HighestPriorityGamepad = p13:GetHighestPriorityGamepad()

    if HighestPriorityGamepad ~= p13.activeGamepad then
        if HighestPriorityGamepad == None then
            warn("Gamepad:OnNewGamepadConnected found no connected gamepads")
            p13:UnbindContextActions()
        else
            if p13.activeGamepad ~= None then
                p13:UnbindContextActions()
            end

            p13.activeGamepad = HighestPriorityGamepad
            p13:BindContextActions()
        end
    end
end

function self.OnCurrentGamepadDisconnected(p14) -- line: 164
    -- upvalues: ContextActionService (copy), None (copy)
    if p14.activeGamepad ~= None then
        ContextActionService:UnbindActivate(p14.activeGamepad, Enum.KeyCode.ButtonR2)
    end

    local HighestPriorityGamepad = p14:GetHighestPriorityGamepad()

    if p14.activeGamepad ~= None and HighestPriorityGamepad == p14.activeGamepad then
        warn("Gamepad:OnCurrentGamepadDisconnected found the supposedly disconnected gamepad in connectedGamepads.")
        p14:UnbindContextActions()
        p14.activeGamepad = None
    elseif HighestPriorityGamepad == None then
        p14:UnbindContextActions()
        p14.activeGamepad = None
    else
        p14.activeGamepad = HighestPriorityGamepad
        ContextActionService:BindActivate(p14.activeGamepad, Enum.KeyCode.ButtonR2)
    end
end

function self.ConnectGamepadConnectionListeners(p15) -- line: 189
    -- upvalues: UserInputService (copy)
    p15.gamepadConnectedConn = UserInputService.GamepadConnected:Connect(function(_) -- line: 190
        -- upvalues: p15 (copy)
        p15:OnNewGamepadConnected()
    end)
    p15.gamepadDisconnectedConn = UserInputService.GamepadDisconnected:Connect(function(p17) -- line: 194
        -- upvalues: p15 (copy)
        if p15.activeGamepad == p17 then
            p15:OnCurrentGamepadDisconnected()
        end
    end)
end

function self.DisconnectGamepadConnectionListeners(p18) -- line: 202
    if p18.gamepadConnectedConn then
        p18.gamepadConnectedConn:Disconnect()
        p18.gamepadConnectedConn = nil
    end

    if p18.gamepadDisconnectedConn then
        p18.gamepadDisconnectedConn:Disconnect()
        p18.gamepadDisconnectedConn = nil
    end
end

return self
