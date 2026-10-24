-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local ZoomController = require(script.Parent:WaitForChild("ZoomController"))
local t1 = {}

t1.__index = t1

local v1 = CFrame.new()

local function cframeToAxis(p1) -- line: 13
    local v2, v3 = p1:ToAxisAngle()

    return v2 * v3
end

local function axisToCFrame(p2) -- line: 18
    -- upvalues: v1 (copy)
    local Magnitude = p2.Magnitude

    if Magnitude > 1E-05 then
        return CFrame.fromAxisAngle(p2, Magnitude)
    end

    return v1
end

local function extractRotation(p3) -- line: 26
    local _, _, _, Components, Components2, Components3, Components4, Components5, Components6, Components7, Components8, Components9 = p3:GetComponents()

    return CFrame.new(0, 0, 0, Components, Components2, Components3, Components4, Components5, Components6, Components7, Components8, Components9)
end

function t1.new() -- line: 31
    -- upvalues: t1 (copy)
    return (setmetatable({
        lastCFrame = nil
    }, t1))
end

function t1.Step(p4, p5, p6) -- line: 37
    -- upvalues: v1 (copy)
    local v4 = p4.lastCFrame or p6

    p4.lastCFrame = p6

    local Position = p6.Position
    local _, _, _, Components, Components2, Components3, Components4, Components5, Components6, Components7, Components8, Components9 = p6:GetComponents()
    local v5 = CFrame.new(0, 0, 0, Components, Components2, Components3, Components4, Components5, Components6, Components7, Components8, Components9)
    local p = v4.p
    local _, _, _, Components10, Components11, Components12, Components13, Components14, Components15, Components16, Components17, Components18 = v4:GetComponents()
    local v6 = CFrame.new(0, 0, 0, Components10, Components11, Components12, Components13, Components14, Components15, Components16, Components17, Components18)
    local v7 = (Position - p) / p5
    local v8, v9 = (v5 * v6:inverse()):ToAxisAngle()
    local v10 = v8 * v9 / p5

    return {
        extrapolate = function(p7) -- extrapolate | line: 52
            -- upvalues: Position (copy), v5 (copy), v7 (copy), v10 (copy), v1 (copy)
            local v11 = v7 * p7 + Position
            local v12 = v10 * p7
            local Magnitude = v12.Magnitude

            return (if Magnitude > 1E-05 then CFrame.fromAxisAngle(v12, Magnitude) else v1) * v5 + v11
        end,
        posVelocity = v7,
        rotVelocity = v10
    }
end

function t1.Reset(p8) -- line: 65
    p8.lastCFrame = nil
end

local BaseOcclusion = require(script.Parent:WaitForChild("BaseOcclusion"))
local self = setmetatable({}, BaseOcclusion)

self.__index = self

function self.new() -- line: 75
    -- upvalues: t1 (copy), BaseOcclusion (copy), self (copy)
    local v15 = setmetatable(BaseOcclusion.new(), self)

    v15.focusExtrapolator = t1.new()

    return v15
end

function self.GetOcclusionMode(_) -- line: 81
    return Enum.DevCameraOcclusionMode.Zoom
end

function self.Enable(p10, _) -- line: 85
    p10.focusExtrapolator:Reset()
end

function self.Update(p12, p13, p14, p15, _) -- line: 89
    -- upvalues: ZoomController (copy)
    local v16 = CFrame.new(p15.p, p14.p) * CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, -1)
    local v17 = p12.focusExtrapolator:Step(p13, v16)
    local v18 = ZoomController.Update(p13, v16, v17)

    return v16 * CFrame.new(0, 0, v18), p15
end

function self.CharacterAdded(_, _, _) -- line: 102
end

function self.CharacterRemoving(_, _, _) -- line: 106
end

function self.OnCameraSubjectChanged(_, _) -- line: 109
end

return self
