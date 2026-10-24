-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local ContextActionService = game:GetService("ContextActionService")
local t1 = {}

t1.__index = t1

function t1.new(p1) -- line: 27
    -- upvalues: t1 (copy)
    local self = setmetatable({}, t1)

    self.CONTROL_ACTION_PRIORITY = p1
    self.enabled = false
    self.vehicleSeat = nil
    self.throttle = 0
    self.steer = 0
    self.acceleration = 0
    self.decceleration = 0
    self.turningRight = 0
    self.turningLeft = 0
    self.vehicleMoveVector = Vector3.new(0, 0, 0)
    self.autoPilot = {}
    self.autoPilot.MaxSpeed = 0
    self.autoPilot.MaxSteeringAngle = 0

    return self
end

function t1:BindContextActions() -- line: 51
    -- upvalues: ContextActionService (copy)
    ContextActionService:BindActionAtPriority("throttleAccel", function(p3, p4, p5) -- line: 53
        -- upvalues: self (copy)
        self:OnThrottleAccel(p3, p4, p5)

        return Enum.ContextActionResult.Pass
    end, false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonR2)
    ContextActionService:BindActionAtPriority("throttleDeccel", function(p6, p7, p8) -- line: 57
        -- upvalues: self (copy)
        self:OnThrottleDeccel(p6, p7, p8)

        return Enum.ContextActionResult.Pass
    end, false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonL2)
    ContextActionService:BindActionAtPriority("arrowSteerRight", function(p9, p10, p11) -- line: 62
        -- upvalues: self (copy)
        self:OnSteerRight(p9, p10, p11)

        return Enum.ContextActionResult.Pass
    end, false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Right)
    ContextActionService:BindActionAtPriority("arrowSteerLeft", function(p12, p13, p14) -- line: 66
        -- upvalues: self (copy)
        self:OnSteerLeft(p12, p13, p14)

        return Enum.ContextActionResult.Pass
    end, false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Left)
end

function t1:Enable(p16, p17) -- line: 72
    -- upvalues: ContextActionService (copy)
    if p16 == self.enabled and p17 == self.vehicleSeat then
        return
    end

    self.enabled = p16
    self.vehicleMoveVector = Vector3.new(0, 0, 0)

    if not p16 then
        ContextActionService:UnbindAction("throttleAccel")
        ContextActionService:UnbindAction("throttleDeccel")
        ContextActionService:UnbindAction("arrowSteerRight")
        ContextActionService:UnbindAction("arrowSteerLeft")
        self.vehicleSeat = nil
    end

    if (not p16 or p17) and p16 then
        self.vehicleSeat = p17
        self:SetupAutoPilot()
        self:BindContextActions()
    end
end

function t1:OnThrottleAccel(_, p20, _) -- line: 98
    if p20 == Enum.UserInputState.End or p20 == Enum.UserInputState.Cancel then
        self.acceleration = 0
    else
        self.acceleration = -1
    end

    self.throttle = self.acceleration + self.decceleration
end

function t1:OnThrottleDeccel(_, p24, _) -- line: 107
    if p24 == Enum.UserInputState.End or p24 == Enum.UserInputState.Cancel then
        self.decceleration = 0
    else
        self.decceleration = 1
    end

    self.throttle = self.acceleration + self.decceleration
end

function t1:OnSteerRight(_, p28, _) -- line: 116
    if p28 == Enum.UserInputState.End or p28 == Enum.UserInputState.Cancel then
        self.turningRight = 0
    else
        self.turningRight = 1
    end

    self.steer = self.turningRight + self.turningLeft
end

function t1:OnSteerLeft(_, p32, _) -- line: 125
    if p32 == Enum.UserInputState.End or p32 == Enum.UserInputState.Cancel then
        self.turningLeft = 0
    else
        self.turningLeft = -1
    end

    self.steer = self.turningRight + self.turningLeft
end

function t1:Update(p35, p36, _) -- line: 135
    if not self.vehicleSeat then
        return p35, false
    end

    if p36 then
        local v2 = p35 + Vector3.new(self.steer, 0, self.throttle)

        self.vehicleSeat.ThrottleFloat = -v2.Z
        self.vehicleSeat.SteerFloat = v2.X

        return v2, true
    end

    local v3 = self.vehicleSeat.Occupant.RootPart.CFrame:VectorToObjectSpace(p35)

    self.vehicleSeat.ThrottleFloat = self:ComputeThrottle(v3)
    self.vehicleSeat.SteerFloat = self:ComputeSteer(v3)

    return Vector3.new(0, 0, 0), true
end

function t1.ComputeThrottle(_, p39) -- line: 161
    if p39 == Vector3.new(0, 0, 0) then
        return 0
    end

    return -p39.Z
end

function t1:ComputeSteer(p41) -- line: 170
    if p41 == Vector3.new(0, 0, 0) then
        return 0
    end

    return -math.atan2(-p41.x, -p41.z) * 57.29577951308232 / self.autoPilot.MaxSteeringAngle
end

function t1:SetupAutoPilot() -- line: 179
    self.autoPilot.MaxSpeed = self.vehicleSeat.MaxSpeed
    self.autoPilot.MaxSteeringAngle = 35
end

return t1
