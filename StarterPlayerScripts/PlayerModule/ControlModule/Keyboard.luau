-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"))
local self = setmetatable({}, BaseCharacterController)

self.__index = self

function self.new(p1) -- line: 20
    -- upvalues: BaseCharacterController (copy), self (copy)
    local v3 = setmetatable(BaseCharacterController.new(), self)

    v3.CONTROL_ACTION_PRIORITY = p1
    v3.textFocusReleasedConn = nil
    v3.textFocusGainedConn = nil
    v3.windowFocusReleasedConn = nil
    v3.forwardValue = 0
    v3.backwardValue = 0
    v3.leftValue = 0
    v3.rightValue = 0
    v3.jumpEnabled = true

    return v3
end

function self.Enable(p2, p3) -- line: 39
    -- upvalues: UserInputService (copy)
    if not UserInputService.KeyboardEnabled then
        return false
    end

    if p3 ~= p2.enabled then
        p2.forwardValue = 0
        p2.backwardValue = 0
        p2.leftValue = 0
        p2.rightValue = 0
        p2.moveVector = Vector3.new(0, 0, 0)
        p2.jumpRequested = false
        p2:UpdateJump()

        if p3 then
            p2:BindContextActions()
            p2:ConnectFocusEventListeners()
        else
            p2:UnbindContextActions()
            p2:DisconnectFocusEventListeners()
        end

        p2.enabled = p3
    end

    return true
end

function self.UpdateMovement(p4, p5) -- line: 71
    if p5 == Enum.UserInputState.Cancel then
        p4.moveVector = Vector3.new(0, 0, 0)
    else
        p4.moveVector = Vector3.new(p4.leftValue + p4.rightValue, 0, p4.forwardValue + p4.backwardValue)
    end
end

function self.UpdateJump(p6) -- line: 79
    p6.isJumping = p6.jumpRequested
end

function self.BindContextActions(p7) -- line: 83
    -- upvalues: ContextActionService (copy)
    local function v6(_, p9, _) -- line: 89
        -- upvalues: p7 (copy)
        p7.forwardValue = p9 == Enum.UserInputState.Begin and -1 or 0
        p7:UpdateMovement(p9)

        return Enum.ContextActionResult.Pass
    end

    local function v7(_, p12, _) -- line: 95
        -- upvalues: p7 (copy)
        p7.backwardValue = p12 == Enum.UserInputState.Begin and 1 or 0
        p7:UpdateMovement(p12)

        return Enum.ContextActionResult.Pass
    end

    local function v8(_, p15, _) -- line: 101
        -- upvalues: p7 (copy)
        p7.leftValue = p15 == Enum.UserInputState.Begin and -1 or 0
        p7:UpdateMovement(p15)

        return Enum.ContextActionResult.Pass
    end

    local function v9(_, p18, _) -- line: 107
        -- upvalues: p7 (copy)
        p7.rightValue = p18 == Enum.UserInputState.Begin and 1 or 0
        p7:UpdateMovement(p18)

        return Enum.ContextActionResult.Pass
    end

    local function v10(_, p21, _) -- line: 113
        -- upvalues: p7 (copy)
        p7.jumpRequested = p7.jumpEnabled and p21 == Enum.UserInputState.Begin
        p7:UpdateJump()

        return Enum.ContextActionResult.Pass
    end

    ContextActionService:BindActionAtPriority("moveForwardAction", v6, false, p7.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterForward)
    ContextActionService:BindActionAtPriority("moveBackwardAction", v7, false, p7.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterBackward)
    ContextActionService:BindActionAtPriority("moveLeftAction", v8, false, p7.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterLeft)
    ContextActionService:BindActionAtPriority("moveRightAction", v9, false, p7.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterRight)
    ContextActionService:BindActionAtPriority("jumpAction", v10, false, p7.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterJump)
end

function self.UnbindContextActions(_) -- line: 133
    -- upvalues: ContextActionService (copy)
    ContextActionService:UnbindAction("moveForwardAction")
    ContextActionService:UnbindAction("moveBackwardAction")
    ContextActionService:UnbindAction("moveLeftAction")
    ContextActionService:UnbindAction("moveRightAction")
    ContextActionService:UnbindAction("jumpAction")
end

function self.ConnectFocusEventListeners(p24) -- line: 141
    -- upvalues: UserInputService (copy)
    local function onFocusReleased() -- line: 142
        -- upvalues: p24 (copy)
        p24.moveVector = Vector3.new(0, 0, 0)
        p24.forwardValue = 0
        p24.backwardValue = 0
        p24.leftValue = 0
        p24.rightValue = 0
        p24.jumpRequested = false
        p24:UpdateJump()
    end

    local function onTextFocusGained(_) -- line: 152
        -- upvalues: p24 (copy)
        p24.jumpRequested = false
        p24:UpdateJump()
    end

    p24.textFocusReleasedConn = UserInputService.TextBoxFocusReleased:Connect(onFocusReleased)
    p24.textFocusGainedConn = UserInputService.TextBoxFocused:Connect(onTextFocusGained)
    p24.windowFocusReleasedConn = UserInputService.WindowFocused:Connect(onFocusReleased)
end

function self.DisconnectFocusEventListeners(p26) -- line: 162
    if p26.textFocusReleasedConn then
        p26.textFocusReleasedConn:Disconnect()
        p26.textFocusReleasedConn = nil
    end

    if p26.textFocusGainedConn then
        p26.textFocusGainedConn:Disconnect()
        p26.textFocusGainedConn = nil
    end

    if p26.windowFocusReleasedConn then
        p26.windowFocusReleasedConn:Disconnect()
        p26.windowFocusReleasedConn = nil
    end
end

return self
