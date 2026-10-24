-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

game:GetService("ReplicatedStorage")

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local AimAssistEnum = require(script.AimAssistEnum)
local TargetSelector = require(script.TargetSelector)
local AimAdjuster = require(script.AimAdjuster)
local DebugVisualizer = require(script.DebugVisualizer)
local t1 = {}

t1.__index = t1
t1.AimAssistEnum = AimAssistEnum
t1.Constants = {
    AIM_ASSIST_RANGE_ATTRIBUTE = "aimAssistRange",
    AIM_ASSIST_FOV_ATTRIBUTE = "aimAssistFov",
    AIM_ASSIST_FRICTION_STRENGTH_ATTRIBUTE = "aimAssistFrictionStrength",
    AIM_ASSIST_TRACKING_STRENGTH_ATTRIBUTE = "aimAssistTrackingStrength",
    AIM_ASSIST_CENTERING_STRENGTH_ATTRIBUTE = "aimAssistCenteringStrength",
    AIM_ASSIST_BIND_NAME_START = "AimAssistStart",
    AIM_ASSIST_BIND_NAME_APPLY = "AimAssistApply",
    AIM_ASSIST_TARGET_TAG = "Target",
    AIM_ASSIST_DEADZONE = 0.1,
    AIM_ASSIST_INACTIVITY = 0.1,
    AIM_ASSIST_MIN_RANGE = 10
}

function t1.enable(p1) -- line: 33
    -- upvalues: RunService (copy), t1 (copy)
    p1.enabled = true
    RunService:BindToRenderStep(t1.Constants.AIM_ASSIST_BIND_NAME_START, Enum.RenderPriority.Camera.Value - 1, function() -- line: 36
        -- upvalues: p1 (copy)
        p1:startAimAssist()
    end)
    RunService:BindToRenderStep(t1.Constants.AIM_ASSIST_BIND_NAME_APPLY, Enum.RenderPriority.Camera.Value + 1, function(p2) -- line: 43
        -- upvalues: p1 (copy)
        p1:applyAimAssist(p2)
    end)
end

function t1.disable(p3) -- line: 49
    -- upvalues: RunService (copy), t1 (copy)
    p3.enabled = false
    RunService:UnbindFromRenderStep(t1.Constants.AIM_ASSIST_BIND_NAME_START)
    RunService:UnbindFromRenderStep(t1.Constants.AIM_ASSIST_BIND_NAME_APPLY)
end

function t1.getGamepadEligibility(p4) -- line: 56
    -- upvalues: UserInputService (copy), t1 (copy)
    if UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad or not p4.thumbstickStates then
        return false
    end

    for _, v3 in p4.thumbstickStates do
        if t1.Constants.AIM_ASSIST_DEADZONE < v3 then
            return true
        end
    end

    return false
end

function t1.updateGamepadEligibility(p5, p6, p7) -- line: 70
    p5.thumbstickStates[p6] = Vector2.new(p7.X, p7.Y).Magnitude
end

function t1.getTouchEligibility(p8) -- line: 74
    -- upvalues: UserInputService (copy), t1 (copy)
    if UserInputService.PreferredInput ~= Enum.PreferredInput.Touch or not p8.lastActiveTouch then
        return false
    end

    return p8.lastActiveTouch - os.clock() < t1.Constants.AIM_ASSIST_INACTIVITY
end

function t1.updateTouchEligibility(p9) -- line: 82
    p9.lastActiveTouch = os.clock()
end

function t1.setDebug(p10, p11) -- line: 87
    if p10.debug ~= p11 then
        p10.debug = p11

        if p10.debug then
            p10.debugVisualizer:createVisualElements()
        elseif p10.debugVisualizer then
            p10.debugVisualizer:destroy()
        end
    end
end

function t1.setSubject(p12, p13) -- line: 101
    p12.subject = p13
    p12:startAimAssist()
end

function t1.setType(p14, p15) -- line: 107
    p14.aimAdjuster:setType(p15)
end

function t1.setRange(p16, p17) -- line: 111
    p16.targetSelector:setRange(p17)
end

function t1.setFieldOfView(p18, p19) -- line: 115
    p18.targetSelector:setFieldOfView(p19)
end

function t1.setSortingBehavior(p20, p21) -- line: 120
    p20.targetSelector:setSortingBehavior(p21)
end

function t1.setIgnoreLineOfSight(p22, p23) -- line: 124
    p22.targetSelector:setIgnoreLineOfSight(p23)
end

function t1.addTargetTag(p24, p25, p26) -- line: 130
    p24.targetSelector:addTargetTag(p25, p26)
end

function t1.removeTargetTag(p27, p28) -- line: 134
    p27.targetSelector:removeTargetTag(p28)
end

function t1.addPlayerTargets(p29, p30, p31, p32) -- line: 139
    p29.targetSelector:addPlayerTargets(p30, p31, p32)
end

function t1.removePlayerTargets(p33) -- line: 143
    p33.targetSelector:removePlayerTargets()
end

function t1.setMethodStrength(p34, p35, p36) -- line: 149
    p34.aimAdjuster:setMethodStrength(p35, p36)
end

function t1.setEasingFunc(p37, p38, p39) -- line: 154
    p37.easingFuncs[p38] = p39
end

function t1.startAimAssist(p40) -- line: 160
    if p40.subject then
        p40.startingSubjectCFrame = p40.subject:GetPivot()
    end
end

function t1.applyAimAssist(p41, p42) -- line: 169
    if p41.subject then
        local Pivot = p41.subject:GetPivot()
        local v4 = if p41:getGamepadEligibility() or p41:getTouchEligibility() then p41.targetSelector:selectTarget(p41.subject) else nil

        if p41.debug then
            local v5 = p41.targetSelector:getAllTargetPoints()

            p41.debugVisualizer:update(v4, p41.targetSelector.fieldOfView, v5)
        end

        local n1 = 1

        if v4 then
            for v6, v7 in p41.easingFuncs do
                n1 *= v7(v4[v6])
            end
        end

        local t2 = {
            subjectCFrame = Pivot,
            startingCFrame = p41.startingSubjectCFrame,
            adjustmentStrength = n1,
            targetResult = v4,
            deltaTime = p42
        }
        local v8 = p41.aimAdjuster:adjustAim(t2)

        p41.startingSubjectCFrame = v8
        p41.subject:PivotTo(v8)
    end
end

function t1.new() -- line: 207
    -- upvalues: TargetSelector (copy), AimAdjuster (copy), DebugVisualizer (copy), t1 (copy)
    local t3 = {
        enabled = false,
        subject = nil,
        debug = false,
        thumbstickStates = {}
    }

    t3.targetSelector = TargetSelector.new()
    t3.aimAdjuster = AimAdjuster.new()
    t3.debugVisualizer = DebugVisualizer.new()
    t3.easingFuncs = {}
    t3.startingSubjectCFrame = nil
    setmetatable(t3, t1)

    return t3
end

function t1.Destroy(p43) -- line: 227
    if p43.debugVisualizer then
        p43.debugVisualizer:destroy()
    end
end

return t1
