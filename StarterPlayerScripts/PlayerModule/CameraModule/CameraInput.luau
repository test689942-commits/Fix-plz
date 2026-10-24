-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local VRService = game:GetService("VRService")

game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Value = Enum.ContextActionPriority.Default.Value
local v1 = Vector2.new(1, 0.77) * 0.008726646259971648
local v2 = Vector2.new(1, 0.77) * 0.12217304763960307
local v3 = Vector2.new(1, 0.66) * 0.017453292519943295
local v4 = Vector2.new(1, 0.77) * 0.06981317007977318

local function v5() -- line: 29
    return UserSettings():IsUserFeatureEnabled("UserResetTouchStateOnMenuOpen")
end

local ok, result = pcall(v5)
local v6 = ok and result
local BindableEvent = Instance.new("BindableEvent")
local BindableEvent2 = Instance.new("BindableEvent")
local Event = BindableEvent.Event
local Event2 = BindableEvent2.Event

UserInputService.InputBegan:Connect(function(p1, p2) -- line: 43
    -- upvalues: BindableEvent (copy)
    if not p2 and p1.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent:Fire()
    end
end)
UserInputService.InputEnded:Connect(function(p3, _) -- line: 49
    -- upvalues: BindableEvent2 (copy)
    if p3.UserInputType == Enum.UserInputType.MouseButton2 then
        BindableEvent2:Fire()
    end
end)

local function thumbstickCurve(p5) -- line: 60
    local v8 = (math.exp((math.abs(p5) - 0.1) / 0.9 * 2) - 1) / 6.38905609893065

    return math.sign(p5) * math.clamp(v8, 0, 1)
end

local function adjustTouchPitchSensitivity(p6) -- line: 74
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return p6
    end

    local v9 = CurrentCamera.CFrame:ToEulerAnglesYXZ()

    if p6.Y * v9 >= 0 then
        return p6
    end

    local v10 = (1 - (math.abs(v9) * 2 / 3.141592653589793) ^ 0.75) * 0.75 + 0.25

    return Vector2.new(1, v10) * p6
end

local function isInDynamicThumbstickArea(p7) -- line: 100
    -- upvalues: LocalPlayer (copy)
    local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    local TouchGui = PlayerGui and PlayerGui:FindFirstChild("TouchGui")
    local TouchControlFrame = TouchGui and TouchGui:FindFirstChild("TouchControlFrame")
    local DynamicThumbstickFrame = TouchControlFrame and TouchControlFrame:FindFirstChild("DynamicThumbstickFrame")

    if not DynamicThumbstickFrame or not TouchGui.Enabled then
        return false
    end

    local AbsolutePosition = DynamicThumbstickFrame.AbsolutePosition
    local v11 = AbsolutePosition + DynamicThumbstickFrame.AbsoluteSize

    if p7.X >= AbsolutePosition.X and p7.Y >= AbsolutePosition.Y and p7.X <= v11.X then
        return p7.Y <= v11.Y
    end

    return false
end

local n1 = 0.016666666666666666

RunService.Stepped:Connect(function(_, p9) -- line: 125
    -- upvalues: n1 (ref)
    n1 = p9
end)

local t1 = {}
local t2 = {}
local n2 = 0

local function incPanInputCount() -- line: 135
    -- upvalues: n2 (ref)
    n2 = math.max(0, n2 + 1)
end

local function decPanInputCount() -- line: 139
    -- upvalues: n2 (ref)
    n2 = math.max(0, n2 - 1)
end

local function resetPanInputCount() -- line: 143
    -- upvalues: n2 (ref)
    n2 = 0
end

local t3 = {
    Thumbstick2 = Vector2.new()
}
local t4 = {
    Left = 0,
    Right = 0,
    I = 0,
    O = 0
}
local t5 = {
    Wheel = 0,
    Pinch = 0,
    Movement = Vector2.new(),
    Pan = Vector2.new()
}
local t6 = {
    Pinch = 0,
    Move = Vector2.new()
}
local BindableEvent3 = Instance.new("BindableEvent")

t1.gamepadZoomPress = BindableEvent3.Event

local BindableEvent4 = VRService.VREnabled and Instance.new("BindableEvent") or nil

if VRService.VREnabled then
    t1.gamepadReset = BindableEvent4.Event
end

function t1.getRotationActivated() -- line: 176
    -- upvalues: n2 (ref), t3 (copy)
    if n2 > 0 then
        return true
    end

    return t3.Thumbstick2.Magnitude > 0
end

function t1.getRotation(p10) -- line: 180
    -- upvalues: UserGameSettings (copy), v1 (copy), v2 (copy), v3 (copy), v4 (copy), adjustTouchPitchSensitivity (copy), n1 (ref), t3 (copy), t4 (copy), t5 (copy), t6 (copy)
    local v14 = Vector2.new(1, UserGameSettings:GetCameraYInvertValue())
    local v15 = Vector2.new(t4.Right - t4.Left, 0) * n1
    local Thumbstick2 = t3.Thumbstick2
    local Movement, Pan = t5.Movement, t5.Pan
    local v16 = adjustTouchPitchSensitivity(t6.Move)

    if p10 then
        v15 = Vector2.new()
    end

    return (v15 * 2.0943951023931953 + Thumbstick2 * v4 + Movement * v1 + Pan * v2 + v16 * v3) * v14
end

function t1.getZoomDelta() -- line: 204
    -- upvalues: t4 (copy), t5 (copy), t6 (copy)
    local v17 = t4.O - t4.I
    local v18 = -t5.Wheel + t5.Pinch
    local v19 = -t6.Pinch

    return v17 * 0.1 + v18 * 1 + v19 * 0.04
end

local function thumbstick(_, _, p13) -- line: 212
    -- upvalues: thumbstickCurve (copy), t3 (copy)
    local Position = p13.Position

    t3[p13.KeyCode.Name] = Vector2.new(thumbstickCurve(Position.X), -thumbstickCurve(Position.Y))

    return Enum.ContextActionResult.Pass
end

local function mouseMovement(p14) -- line: 218
    -- upvalues: t5 (copy)
    local Delta = p14.Delta

    t5.Movement = Vector2.new(Delta.X, Delta.Y)
end

local function mouseWheel(_, _, p17) -- line: 223
    -- upvalues: t5 (copy)
    t5.Wheel = p17.Position.Z

    return Enum.ContextActionResult.Pass
end

local function keypress(_, p19, p20) -- line: 228
    -- upvalues: t4 (copy)
    t4[p20.KeyCode.Name] = p19 == Enum.UserInputState.Begin and 1 or 0
end

local function gamepadZoomPress(_, p22, _) -- line: 232
    -- upvalues: BindableEvent3 (copy)
    if p22 == Enum.UserInputState.Begin then
        BindableEvent3:Fire()
    end
end

local function gamepadReset(_, p25, _) -- line: 238
    -- upvalues: BindableEvent4 (copy)
    if p25 == Enum.UserInputState.Begin then
        BindableEvent4:Fire()
    end
end

local function resetInputDevices() -- line: 244
    -- upvalues: t3 (copy), t4 (copy), t5 (copy), t6 (copy)
    for _, v20 in pairs({ t3, t4, t5, t6 }) do
        for v21, v22 in pairs(v20) do
            if type(v22) == "boolean" then
                v20[v21] = false
            else
                v20[v21] *= 0
            end
        end
    end
end

local t7 = {}
local v23, Magnitude

local function touchBegan(p27, p28) -- line: 268
    -- upvalues: isInDynamicThumbstickArea (copy), n2 (ref), t7 (ref), v23 (ref)
    assert(p27.UserInputType == Enum.UserInputType.Touch)
    assert(p27.UserInputState == Enum.UserInputState.Begin)

    if v23 == nil and isInDynamicThumbstickArea(p27.Position) and not p28 then
        v23 = p27
    else
        if not p28 then
            n2 = math.max(0, n2 + 1)
        end

        local t8 = t7

        t8[p27] = p28
    end
end

local function touchEnded(p29, _) -- line: 288
    -- upvalues: n2 (ref), t7 (ref), v23 (ref), Magnitude (ref)
    assert(p29.UserInputType == Enum.UserInputType.Touch)
    assert(p29.UserInputState == Enum.UserInputState.End)

    if p29 == v23 then
        v23 = nil
    end

    if t7[p29] == false then
        Magnitude = nil
        n2 = math.max(0, n2 - 1)
    end

    local t9 = t7

    t9[p29] = nil
end

local function touchChanged(p31, p32) -- line: 307
    -- upvalues: t6 (copy), t7 (ref), v23 (ref), Magnitude (ref)
    assert(p31.UserInputType == Enum.UserInputType.Touch)
    assert(p31.UserInputState == Enum.UserInputState.Change)

    if p31 == v23 then
        return
    end

    if t7[p31] == nil then
        local t10 = t7

        t10[p31] = p32
    end

    local t11 = {}

    for v32, v33 in pairs(t7) do
        if not v33 then
            table.insert(t11, v32)
        end
    end

    if #t11 == 1 and t7[p31] == false then
        local Delta = p31.Delta

        t6.Move += Vector2.new(Delta.X, Delta.Y)
    end

    if #t11 ~= 2 then
        Magnitude = nil

        return
    end

    local Magnitude2 = (t11[1].Position - t11[2].Position).Magnitude

    if Magnitude then
        t6.Pinch += Magnitude2 - Magnitude
    end

    Magnitude = Magnitude2
end

local function resetTouchState() -- line: 351
    -- upvalues: v6 (copy), n2 (ref), t7 (ref), v23 (ref), Magnitude (ref)
    t7 = {}
    v23 = nil
    Magnitude = nil

    if v6 then
        n2 = 0
    end
end

local function pointerAction(p33, p34, p35, p36) -- line: 361
    -- upvalues: t5 (copy)
    if p36 then
        return
    end

    t5.Wheel = p33
    t5.Pan = p34
    t5.Pinch = -p35
end

local function inputBegan(p37, p38) -- line: 369
    -- upvalues: n2 (ref), touchBegan (copy)
    if p37.UserInputType == Enum.UserInputType.Touch then
        touchBegan(p37, p38)
    elseif p37.UserInputType == Enum.UserInputType.MouseButton2 and not p38 then
        n2 = math.max(0, n2 + 1)
    end
end

local function inputChanged(p39, p40) -- line: 378
    -- upvalues: t5 (copy), touchChanged (copy)
    if p39.UserInputType == Enum.UserInputType.Touch then
        touchChanged(p39, p40)
    elseif p39.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = p39.Delta

        t5.Movement = Vector2.new(Delta.X, Delta.Y)
    end
end

local function inputEnded(p41, p42) -- line: 387
    -- upvalues: n2 (ref), touchEnded (copy)
    if p41.UserInputType == Enum.UserInputType.Touch then
        touchEnded(p41, p42)
    elseif p41.UserInputType == Enum.UserInputType.MouseButton2 then
        n2 = math.max(0, n2 - 1)
    end
end

local v36 = false

function t1.setInputEnabled(p43) -- line: 398
    -- upvalues: ContextActionService (copy), UserInputService (copy), VRService (copy), Value (copy), v6 (copy), t2 (ref), thumbstick (copy), keypress (copy), gamepadZoomPress (copy), gamepadReset (copy), resetInputDevices (copy), resetTouchState (copy), pointerAction (copy), inputBegan (copy), inputChanged (copy), inputEnded (copy), v36 (ref)
    if v36 == p43 then
        return
    end

    v36 = p43
    resetInputDevices()
    resetTouchState()

    if v36 then
        ContextActionService:BindActionAtPriority("RbxCameraThumbstick", thumbstick, false, Value, Enum.KeyCode.Thumbstick2)
        ContextActionService:BindActionAtPriority("RbxCameraKeypress", keypress, false, Value, Enum.KeyCode.Left, Enum.KeyCode.Right, Enum.KeyCode.I, Enum.KeyCode.O)

        if VRService.VREnabled then
            ContextActionService:BindAction("RbxCameraGamepadReset", gamepadReset, false, Enum.KeyCode.ButtonL3)
        end

        ContextActionService:BindAction("RbxCameraGamepadZoom", gamepadZoomPress, false, Enum.KeyCode.ButtonR3)

        local t12 = t2

        table.insert(t12, UserInputService.InputBegan:Connect(inputBegan))

        local t13 = t2

        table.insert(t13, UserInputService.InputChanged:Connect(inputChanged))

        local t14 = t2

        table.insert(t14, UserInputService.InputEnded:Connect(inputEnded))

        local t15 = t2

        table.insert(t15, UserInputService.PointerAction:Connect(pointerAction))

        if v6 then
            local GuiService = game:GetService("GuiService")
            local t16 = t2

            table.insert(t16, GuiService.MenuOpened:connect(resetTouchState))
        end
    else
        ContextActionService:UnbindAction("RbxCameraThumbstick")
        ContextActionService:UnbindAction("RbxCameraMouseMove")
        ContextActionService:UnbindAction("RbxCameraMouseWheel")
        ContextActionService:UnbindAction("RbxCameraKeypress")
        ContextActionService:UnbindAction("RbxCameraGamepadZoom")

        if VRService.VREnabled then
            ContextActionService:UnbindAction("RbxCameraGamepadReset")
        end

        for _, v37 in pairs(t2) do
            v37:Disconnect()
        end

        t2 = {}
    end
end

function t1.getInputEnabled() -- line: 470
    -- upvalues: v36 (ref)
    return v36
end

function t1.resetInputForFrameEnd() -- line: 474
    -- upvalues: t5 (copy), t6 (copy)
    t5.Movement = Vector2.new()
    t6.Move = Vector2.new()
    t6.Pinch = 0
    t5.Wheel = 0
    t5.Pan = Vector2.new()
    t5.Pinch = 0
end

UserInputService.WindowFocused:Connect(resetInputDevices)
UserInputService.WindowFocusReleased:Connect(resetInputDevices)

local v38 = false
local v39 = false
local n3 = 0

function t1.getHoldPan() -- line: 495
    -- upvalues: v38 (ref)
    return v38
end

function t1.getTogglePan() -- line: 499
    -- upvalues: v39 (ref)
    return v39
end

function t1.getPanning() -- line: 503
    -- upvalues: v38 (ref), v39 (ref)
    return v39 or v38
end

function t1.setTogglePan(p44) -- line: 507
    -- upvalues: v39 (ref)
    v39 = p44
end

local v40 = false
local connection, connection2

function t1.enableCameraToggleInput() -- line: 515
    -- upvalues: UserInputService (copy), Event (copy), Event2 (copy), v38 (ref), v39 (ref), n3 (ref), v40 (ref), connection (ref), connection2 (ref)
    if v40 then
        return
    end

    v40 = true
    v38 = false
    v39 = false

    if connection then
        connection:Disconnect()
    end

    if connection2 then
        connection2:Disconnect()
    end

    connection = Event:Connect(function() -- line: 532
        -- upvalues: v38 (ref), n3 (ref)
        v38 = true
        n3 = tick()
    end)
    connection2 = Event2:Connect(function() -- line: 537
        -- upvalues: UserInputService (copy), v38 (ref), v39 (ref), n3 (ref)
        v38 = false

        if tick() - n3 < 0.3 and (v39 or UserInputService:GetMouseDelta().Magnitude < 2) then
            v39 = not v39
        end
    end)
end

function t1.disableCameraToggleInput() -- line: 545
    -- upvalues: v40 (ref), connection (ref), connection2 (ref)
    if not v40 then
        return
    end

    v40 = false

    if connection then
        connection:Disconnect()
        connection = nil
    end

    if connection2 then
        connection2:Disconnect()
        connection2 = nil
    end
end

return t1
