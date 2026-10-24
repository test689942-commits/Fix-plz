-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local New = _G.New
local t1 = {}

function t1.new(p1) -- line: 9
    -- upvalues: t1 (copy)
    p1 = p1 or {}

    local t2 = {
        _spring = nil,
        _connection = nil,
        _baseCFrame = nil,
        _isEnabled = false,
        MoveDistance = p1.MoveDistance or 0.15,
        PositionMultiplier = p1.PositionMultiplier or Vector3.new(0.2, 0.15, 0),
        RotationMultiplier = p1.RotationMultiplier or Vector3.new(0.02, 0.03, 0),
        SpringMass = p1.SpringMass or 5,
        SpringForce = p1.SpringForce or 50,
        SpringDamping = p1.SpringDamping or 4,
        SpringSpeed = p1.SpringSpeed or 6
    }

    setmetatable(t2, {
        __index = t1
    })

    return t2
end

function t1.Enable(p2, p3) -- line: 38
    -- upvalues: RunService (copy), New (copy)
    if p2._isEnabled then
        return
    end

    p2._isEnabled = true
    p2._baseCFrame = p3 or workspace.CurrentCamera.CFrame

    if not p2._spring then
        p2._spring = New("Utility.Spring")()
        p2._spring:changestats(p2.SpringMass, p2.SpringForce, p2.SpringDamping, p2.SpringSpeed)
    end

    p2._spring.Position = Vector3.new(0, 0, 0)
    p2._spring.Velocity = Vector3.new(0, 0, 0)
    p2._spring.Target = Vector3.new(0, 0, 0)
    p2._connection = RunService.RenderStepped:Connect(function(p4) -- line: 61
        -- upvalues: p2 (copy)
        p2:_update(p4)
    end)

    return p2
end

function t1.Disable(p5) -- line: 69
    if p5._isEnabled then
        p5._isEnabled = false

        if p5._connection then
            p5._connection:Disconnect()
            p5._connection = nil
        end

        if p5._spring then
            p5._spring.Position = Vector3.new(0, 0, 0)
            p5._spring.Velocity = Vector3.new(0, 0, 0)
            p5._spring.Target = Vector3.new(0, 0, 0)
        end

        p5._baseCFrame = nil

        return p5
    end
end

function t1.UpdateBaseCFrame(p6, p7) -- line: 93
    p6._baseCFrame = p7

    return p6
end

function t1.GetCurrentOffset(p8) -- line: 99
    if p8._spring then
        return p8._spring.Position
    end

    return (Vector3.new(0, 0, 0))
end

function t1.GetTargetOffset(p9) -- line: 105
    if p9._spring then
        return p9._spring.Target
    end

    return (Vector3.new(0, 0, 0))
end

function t1.Shove(p10, p11) -- line: 111
    if p10._spring then
        p10._spring:shove(p11)
    end

    return p10
end

function t1.IsEnabled(p12) -- line: 119
    return p12._isEnabled
end

function t1.Destroy(p13) -- line: 124
    p13:Disable()
    p13._spring = nil
    p13._baseCFrame = nil
end

function t1._update(p14, p15) -- line: 131
    -- upvalues: UserInputService (copy)
    if not (p14._isEnabled and p14._spring and p14._baseCFrame) then
        return
    end

    local CurrentCamera = workspace.CurrentCamera
    local ViewportSize = CurrentCamera.ViewportSize
    local MouseLocation = UserInputService:GetMouseLocation()
    local v3 = math.clamp(MouseLocation.X / ViewportSize.X, 0, 1)
    local v5 = math.clamp(MouseLocation.Y / ViewportSize.Y, 0, 1)
    local v6 = (v3 * 2 - 1) * p14.MoveDistance
    local v7 = (1 - v5) * 2 * p14.MoveDistance - p14.MoveDistance

    p14._spring.Target = Vector3.new(v6, v7, 0)
    p14._spring:update(p15)

    local _springPosition = p14._spring.Position
    local v8 = -_springPosition.Y * p14.RotationMultiplier.X
    local v9 = _springPosition.X * p14.RotationMultiplier.Y
    local v10 = _springPosition.X * p14.PositionMultiplier.X
    local v11 = _springPosition.Y * p14.PositionMultiplier.Y

    CurrentCamera.CFrame = p14._baseCFrame * CFrame.new(v10, v11, 0) * CFrame.Angles(v8, v9, 0)
end

t1.Presets = {
    IntroScene = {
        MoveDistance = 0.15,
        PositionMultiplier = Vector3.new(0.2, 0.15, 0),
        RotationMultiplier = Vector3.new(0.02, 0.03, 0),
        SpringMass = 5,
        SpringForce = 50,
        SpringDamping = 4,
        SpringSpeed = 6
    },
    Subtle = {
        MoveDistance = 0.08,
        PositionMultiplier = Vector3.new(0.1, 0.07, 0),
        RotationMultiplier = Vector3.new(0.01, 0.015, 0),
        SpringMass = 5,
        SpringForce = 45,
        SpringDamping = 4.5,
        SpringSpeed = 7
    },
    Strong = {
        MoveDistance = 0.25,
        PositionMultiplier = Vector3.new(0.3, 0.2, 0),
        RotationMultiplier = Vector3.new(0.03, 0.04, 0),
        SpringMass = 4,
        SpringForce = 60,
        SpringDamping = 3.5,
        SpringSpeed = 5
    },
    NoRotation = {
        MoveDistance = 0.15,
        PositionMultiplier = Vector3.new(0.2, 0.15, 0),
        RotationMultiplier = Vector3.new(0, 0, 0),
        SpringMass = 5,
        SpringForce = 50,
        SpringDamping = 4,
        SpringSpeed = 6
    }
}

function t1.Create(p16, p17) -- line: 220
    -- upvalues: t1 (copy)
    local v12 = t1.Presets[p16] or t1.Presets.IntroScene

    p17 = p17 or {}

    for v14, v15 in pairs(v12) do
        if p17[v14] == nil then
            p17[v14] = v15
        end
    end

    return t1.new(p17)
end

return t1
