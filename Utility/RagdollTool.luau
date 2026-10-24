-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local New = _G.New

local function NewHingePart() -- line: 4
    local Part = Instance.new("Part")

    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Part.Shape = "Ball"
    Part.Size = Vector3.new(1, 1, 1)
    Part.Transparency = 1
    Part.CanCollide = true

    return Part
end

local function CreateJoint(p1, p2, p3, p4, p5) -- line: 14
    local v1 = Instance.new(p1)

    v1.Part0 = p2
    v1.part1 = p3

    if p4 ~= nil then
        v1.C0 = p4
    end

    if p5 ~= nil then
        v1.C1 = p5
    end

    v1.Parent = p2
end

local t2 = {
    ["Right Shoulder"] = {
        "Right Arm",
        CFrame.new(0, 0.5, 0),
        CFrame.new(1.5, 0.5, 0),
        CFrame.new(1.5, 0, 0)
    },
    ["Left Shoulder"] = {
        "Left Arm",
        CFrame.new(0, 0.5, 0),
        CFrame.new(-1.5, 0.5, 0),
        CFrame.new(-1.5, 0, 0)
    },
    ["Right Hip"] = {
        "Right Leg",
        CFrame.new(0, 0.5, 0),
        CFrame.new(0.5, -1.5, 0),
        CFrame.new(0.5, -2, 0)
    },
    ["Left Hip"] = {
        "Left Leg",
        CFrame.new(0, 0.5, 0),
        CFrame.new(-0.5, -1.5, 0),
        CFrame.new(-0.5, -2, 0)
    }
}

function t1.new(p6, p7) -- line: 30
    -- upvalues: New (copy), t2 (copy)
    p6.character = p7
    p6.joints = {}
    p6.humanoid = p6.character:FindFirstChild("Humanoid")
    p6.humanoid.BreakJointsOnDeath = false
    p6.humanoid.RequiresNeck = false
    p6.trove = New("Utility.Trove")()

    local Torso = p7:FindFirstChild("Torso")

    for v2, v3 in pairs(t2) do
        local v4 = p7:FindFirstChild(v3[1])

        if v4 ~= nil then
            local Attachment = Instance.new("Attachment")

            Attachment.Name = v2
            Attachment.CFrame = v3[2]
            Attachment.Parent = v4

            local Attachment2 = Instance.new("Attachment")

            Attachment2.Name = v2
            Attachment2.CFrame = v3[3]
            Attachment2.Parent = Torso

            local BallSocketConstraint = Instance.new("BallSocketConstraint")

            BallSocketConstraint.Name = v2 .. "_SOCKET"
            BallSocketConstraint.Radius = 0
            BallSocketConstraint.MaxFrictionTorque = 10
            BallSocketConstraint.Parent = Torso
            BallSocketConstraint.Enabled = false
            BallSocketConstraint.Attachment1 = Attachment
            BallSocketConstraint.Attachment0 = Attachment2

            local Part = Instance.new("Part")

            Part.TopSurface = Enum.SurfaceType.Smooth
            Part.BottomSurface = Enum.SurfaceType.Smooth
            Part.Shape = "Ball"
            Part.Size = Vector3.new(1, 1, 1)
            Part.Transparency = 1
            Part.CanCollide = true

            local Weld = Instance.new("Weld")

            Weld.C0 = CFrame.new(0, -0.25, 0)
            Weld.Part0 = v4
            Weld.Part1 = Part
            Weld.Parent = Part
            Part.Parent = p7
            Part.CanCollide = false
            table.insert(p6.joints, {
                v4,
                Part,
                Torso:FindFirstChild(v2),
                BallSocketConstraint
            })
        end
    end
end

function t1.Ragdoll(p8) -- line: 77
    p8.humanoid.PlatformStand = true
    p8.trove:Add(p8.humanoid:GetPropertyChangedSignal("PlatformStand"):Connect(function() -- line: 79
        -- upvalues: p8 (copy)
        if not p8.humanoid.PlatformStand then
            p8.humanoid.PlatformStand = true
        end
    end))

    for _, v5 in ipairs(p8.joints) do
        v5[1].CanCollide = false
        v5[1].Massless = true
        v5[2].Massless = true
        v5[2].CanCollide = true
        v5[3].Enabled = false
        v5[4].Enabled = true
    end
end

function t1.UnRagdoll(p9) -- line: 94
    p9.humanoid.PlatformStand = false
    p9.trove:Clean()

    for _, v6 in ipairs(p9.joints) do
        v6[1].CanCollide = true
        v6[1].Massless = false
        v6[2].Massless = false
        v6[2].CanCollide = false
        v6[3].Enabled = true
        v6[4].Enabled = false
    end
end

function t1.Destroy(p10) -- line: 107
    for _, v7 in ipairs(p10.joints) do
        v7[2]:Destroy()
        v7[4]:Destroy()
    end
end

return t1
