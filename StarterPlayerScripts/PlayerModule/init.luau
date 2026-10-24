-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

function t1.new() -- line: 12
    -- upvalues: t1 (copy)
    local self = setmetatable({}, t1)

    self.cameras = require(script:WaitForChild("CameraModule"))
    self.controls = require(script:WaitForChild("ControlModule"))

    return self
end

function t1:GetCameras() -- line: 19
    return self.cameras
end

function t1:GetControls() -- line: 23
    return self.controls
end

function t1:GetClickToMoveController() -- line: 27
    return self.controls:GetClickToMoveController()
end

return t1.new()
