-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local RunService = game:GetService("RunService")
local GameMgr, _ = _G.GameMgr, _G.PoolMgr

game:GetService("TweenService")

local t2 = {
    PercentHumidity = 60,
    WindDirection = Vector3.new(0, 0, 1),
    WindForce = 0
}

local function CalculateBulletTrajectory(p1, p2) -- line: 14
    local v1 = (p2 + 0) * 196.2

    return Vector3.new(0, p1 * 196.2 - math.clamp(v1, 0, v1), 0) + Vector3.new(0, 0, 0)
end

function t1.Show(p3, p4, p5, p6, p7, p8, p9) -- line: 26
    -- upvalues: RunService (copy), GameMgr (copy), t2 (copy)
    local Part = Instance.new("Part")

    Part.Name = "Bullet"
    Part.CanCollide = false
    Part.Transparency = 1
    Part.FrontSurface = Enum.SurfaceType.Smooth
    Part.Size = Vector3.new(1, 1, 1)

    local BodyForce = Instance.new("BodyForce")
    local Mass = Part:GetMass()
    local v3 = (0 + (60 - t2.PercentHumidity) / 400) * 196.2

    BodyForce.Force = Vector3.new(0, Mass * 196.2 - math.clamp(v3, 0, v3), 0) + t2.WindDirection * t2.WindForce
    BodyForce.Parent = Part
    Part.Parent = workspace.FX
    Part.CFrame = CFrame.lookAlong(p4, p5) + p5
    Part.AssemblyLinearVelocity = p5 * p6

    local BillboardGui = Instance.new("BillboardGui", Part)

    BillboardGui.Adornee = Part
    BillboardGui.Enabled = false

    local v5 = math.random(275, 375) / 10

    BillboardGui.Size = UDim2.new(v5, 0, v5, 0)
    BillboardGui.LightInfluence = 0

    local ImageLabel = Instance.new("ImageLabel", BillboardGui)

    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel.Position = UDim2.new(0, 0, 0, 0)
    ImageLabel.ImageColor3 = p7
    ImageLabel.ImageTransparency = math.random(2, 5) / 15
    task.delay(0.2, function() -- line: 54
        -- upvalues: Part (copy)
        if Part:FindFirstChild("BillboardGui") ~= nil then
            Part.BillboardGui.Enabled = true
        end
    end)

    local LineHandleAdornment = Instance.new("LineHandleAdornment")

    LineHandleAdornment.Parent = Part
    LineHandleAdornment.Adornee = Part
    LineHandleAdornment.Color3 = p7
    LineHandleAdornment.Length = 11
    LineHandleAdornment.Thickness = 4
    LineHandleAdornment.ZIndex = -5
    LineHandleAdornment.Transparency = 0
    LineHandleAdornment.SizeRelativeOffset = Vector3.new(0, -0.05, -4)
    LineHandleAdornment.AdornCullingMode = Enum.AdornCullingMode.Automatic
    LineHandleAdornment.AlwaysOnTop = false
    LineHandleAdornment.Visible = true

    local LineHandleAdornment2 = Instance.new("LineHandleAdornment")

    LineHandleAdornment2.Parent = Part
    LineHandleAdornment2.Adornee = Part
    LineHandleAdornment2.Color3 = p7
    LineHandleAdornment2.Length = 17
    LineHandleAdornment2.Thickness = 3
    LineHandleAdornment2.Transparency = 0.6
    LineHandleAdornment2.SizeRelativeOffset = Vector3.new(0, -0.05, -4)
    LineHandleAdornment2.AdornCullingMode = Enum.AdornCullingMode.Automatic
    LineHandleAdornment2.AlwaysOnTop = true

    local PointLight = Instance.new("PointLight")

    PointLight.Parent = Part
    PointLight.Brightness = 5
    PointLight.Color = p7
    PointLight.Range = 10
    PointLight.Shadows = true
    game.Debris:AddItem(Part, 5)
    task.spawn(function() -- line: 93
        -- upvalues: p3 (copy), p8 (copy), p9 (copy), Part (copy), RunService (copy), GameMgr (copy)
        local PartPosition, _ = Part.Position, Part.Position
        local v6 = RaycastParams.new()

        v6.FilterType = Enum.RaycastFilterType.Exclude
        v6.FilterDescendantsInstances = p9

        local n1 = 0

        while true do
            if Part.Parent then
                RunService.Heartbeat:wait()

                local PartPosition2 = Part.Position

                n1 += (PartPosition2 - PartPosition).magnitude

                local v7 = workspace:Raycast(PartPosition, PartPosition2 - PartPosition, v6)

                if p8 < n1 then
                    break
                end

                if v7 then
                    Part:Destroy()
                    task.spawn(function() -- line: 116
                        -- upvalues: v7 (copy), GameMgr (copy)
                        GameMgr:ShowEffect("HitEffect", v7.Position, v7.Instance, v7.Normal)
                    end)

                    if p3.onHit then
                        p3.onHit(v7, n1)
                    end
                end

                PartPosition = PartPosition2
                continue
            end

            return
        end

        Part:Destroy()
    end)
    p3.obj = Part
end

return t1
