-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

function t1.new() -- line: 14
    -- upvalues: t1 (copy)
    local self = setmetatable({}, t1)

    self.enabled = false
    self.moveVector = Vector3.new(0, 0, 0)
    self.moveVectorIsCameraRelative = true
    self.isJumping = false

    return self
end

function t1.OnRenderStepped(_, _) -- line: 23
end

function t1:GetMoveVector() -- line: 27
    return self.moveVector
end

function t1:IsMoveVectorCameraRelative() -- line: 31
    return self.moveVectorIsCameraRelative
end

function t1:GetIsJumping() -- line: 35
    return self.isJumping
end

function t1.Enable(_, _) -- line: 41
    error("BaseCharacterController:Enable must be overridden in derived classes and should not be called.")

    return false
end

return t1
