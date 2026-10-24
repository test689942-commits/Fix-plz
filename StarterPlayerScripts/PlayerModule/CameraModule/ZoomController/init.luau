-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Popper = require(script:WaitForChild("Popper"))
local clamp, exp, min, max = math.clamp, math.exp, math.min, math.max
local CameraMinZoomDistance, CameraMaxZoomDistance
local LocalPlayer = game:GetService("Players").LocalPlayer

assert(LocalPlayer)

local function updateBounds() -- line: 23
    -- upvalues: CameraMinZoomDistance (ref), CameraMaxZoomDistance (ref), LocalPlayer (copy)
    CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance
    CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance
end

CameraMinZoomDistance = LocalPlayer.CameraMinZoomDistance
CameraMaxZoomDistance = LocalPlayer.CameraMaxZoomDistance
LocalPlayer:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(updateBounds)
LocalPlayer:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(updateBounds)

local t1 = {}

t1.__index = t1

function t1.new(p1, p2, p3, p4) -- line: 37
    -- upvalues: clamp (copy), t1 (copy)
    local v1 = clamp(p2, p3, p4)

    return (setmetatable({
        v = 0,
        freq = p1,
        x = v1,
        minValue = p3,
        maxValue = p4,
        goal = v1
    }, t1))
end

function t1.Step(p5, p6) -- line: 49
    -- upvalues: exp (copy)
    local v2 = p5.freq * 2 * 3.141592653589793
    local x, v, minValue, maxValue = p5.x, p5.v, p5.minValue, p5.maxValue
    local goal = p5.goal
    local v3 = goal - x
    local v4 = v2 * p6
    local v6 = exp(-v4)
    local v7 = goal + (v * p6 - v3 * (v4 + 1)) * v6
    local v8 = ((v3 * v2 - v) * v4 + v) * v6

    if v7 < minValue then
        v8 = 0
    elseif maxValue < v7 then
        minValue = maxValue
        v8 = 0
    else
        minValue = v7
    end

    p5.x = minValue
    p5.v = v8

    return minValue
end

local v9 = t1.new(4.5, 12.5, 0.5, CameraMaxZoomDistance)

local function stepTargetZoom(p7, p8, p9, p10) -- line: 87
    -- upvalues: clamp (copy)
    local v11 = clamp(p7 + p8 * (p7 * 0.0375 + 1), p9, p10)

    if v11 < 1 then
        return p8 <= 0 and p9 or 1
    end

    return v11
end

local n1 = 0

return {
    Update = function(p11, p12, p13) -- Update | line: 98
        -- upvalues: Popper (copy), clamp (copy), min (copy), max (copy), CameraMinZoomDistance (ref), CameraMaxZoomDistance (ref), v9 (copy), n1 (ref)
        local v12 = 1e999

        if v9.goal > 1 then
            local x, goal = v9.x, v9.goal
            local v13 = n1
            local CameraMinZoomDistance2 = CameraMinZoomDistance
            local CameraMaxZoomDistance2 = CameraMaxZoomDistance
            local v15 = clamp(goal + v13 * (goal * 0.0375 + 1), CameraMinZoomDistance2, CameraMaxZoomDistance2)

            if v15 < 1 then
                v15 = v13 <= 0 and CameraMinZoomDistance2 or 1
            end

            local v16 = max(x, v15)

            v12 = Popper(p12 * CFrame.new(0, 0, 0.5), v16 - 0.5, p13) + 0.5
        end

        v9.minValue = 0.5
        v9.maxValue = min(CameraMaxZoomDistance, v12)

        return v9:Step(p11)
    end,
    GetZoomRadius = function() -- GetZoomRadius | line: 122
        -- upvalues: v9 (copy)
        return v9.x
    end,
    SetZoomParameters = function(p14, p15) -- SetZoomParameters | line: 126
        -- upvalues: v9 (copy), n1 (ref)
        v9.goal = p14
        n1 = p15
    end,
    ReleaseSpring = function() -- ReleaseSpring | line: 131
        -- upvalues: v9 (copy)
        v9.x = v9.goal
        v9.v = 0
    end
}
