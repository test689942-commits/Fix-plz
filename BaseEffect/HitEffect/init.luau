-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local GameMgr = _G.GameMgr
local Debris = game:GetService("Debris")
local Holes = script.Holes
local t2 = {
    "Head",
    "UpperTorso",
    "LowerTorso",
    "LeftFoot",
    "LeftLowerLeg",
    "LeftUpperLeg",
    "RightFoot",
    "RightLowerLeg",
    "RightUpperLeg",
    "LeftHand",
    "LeftLowerArm",
    "LeftUpperArm",
    "RightHand",
    "RightLowerArm",
    "RightUpperArm",
    "HumanoidRootPart",
    "Torso",
    "Left Arm",
    "Right Arm",
    "Left Leg",
    "Right Leg",
    "Leg"
}

local function rlist(p1) -- line: 30
    return p1[math.random(1, #p1)]
end

local function randf(p2, p3) -- line: 34
    return p2 + math.random() * (p3 - p2)
end

local function colorseq(p4, p5, p6) -- line: 39
    return ColorSequence.new(Color3.new(p4, p5, p6))
end

function t1.Show(p7, p8, p9, p10) -- line: 44
    -- upvalues: GameMgr (copy), Debris (copy), Holes (copy), t2 (copy)
    task.spawn(function() -- line: 45
        -- upvalues: p7 (copy), p8 (copy), p9 (copy), p10 (copy), GameMgr (copy), Debris (copy), Holes (copy), t2 (copy)
        local Attachment = Instance.new("Attachment")

        Attachment.CFrame = CFrame.new(p8, p8 + p10)
        Attachment.Parent = workspace.Terrain

        local v3 = (if table.find(t2, p9.Name) then Holes.Human else Holes:FindFirstChild((string.sub(tostring(p9.Material), 15)))) or Holes.Default

        if v3.Holes then
            local Part = Instance.new("Part")

            Part.FrontSurface = Enum.SurfaceType.Smooth
            Part.TopSurface = 0
            Part.BottomSurface = 0
            Part.Transparency = 1
            Part.CanCollide = false
            Part.Name = "BulletHole"

            local HoleSize = v3.HoleSize
            local MinValue, MaxValue = HoleSize.MinValue, HoleSize.MaxValue
            local v4 = MinValue + math.random() * (MaxValue - MinValue)

            Part.Size = Vector3.new(v4, 0, v4)
            Part.CFrame = CFrame.new(p8, p8 - p10) * CFrame.Angles(1.5707963267948966, (0 + math.random() * 2) * 3.141592653589793, 0)

            local Children = v3.Holes:GetChildren()
            local clone = Children[math.random(1, #Children)]:Clone()

            clone.Face = "Top"

            if not v3:FindFirstChild("DontRecolor") then
                clone.Color3 = p9.Color
            end

            clone.Parent = Part

            local WeldConstraint = Instance.new("WeldConstraint")

            WeldConstraint.Parent = Part
            WeldConstraint.Part0 = Part
            WeldConstraint.Part1 = p9
            Part.Parent = workspace.FX
            Debris:AddItem(Part, 15)
        end

        local Children = v3.Particles.Used:GetChildren()

        for _, v5 in pairs(Children) do
            local clone = v5:Clone()

            clone.Parent = Attachment
            p7:Emit(clone)
            Debris:AddItem(clone, clone.Lifetime.Max)
        end

        if v3:FindFirstChild("Flash") then
            local clone = v3.Flash:Clone()

            clone.Shadows = true
            clone.Range *= 0.7407407407407407 + math.random() * 0.6092592592592594
            clone.Enabled = true
            clone.Parent = Attachment

            if v3.Flash:FindFirstChild("Duration") then
                Debris:AddItem(clone, v3.Flash.Duration.Value)
            else
                Debris:AddItem(clone, 0.05)
            end
        end

        if v3:FindFirstChild("FlashDecals") then
            local BillboardGui = Instance.new("BillboardGui")

            BillboardGui.Adornee = Attachment
            BillboardGui.Parent = Attachment

            local Children = v3.FlashDecals:GetChildren()
            local clone = Children[math.random(1, #Children)]:Clone()
            local Size = clone:FindFirstChild("Size")
            local v6

            if Size then
                local MinValue, MaxValue = Size.MinValue, Size.MaxValue

                v6 = MinValue + math.random() * (MaxValue - MinValue)
            else
                v6 = 0.8 + math.random() * 0.44999999999999996
            end

            BillboardGui.Size = UDim2.new(v6, 0, v6, 0)

            local Trans = clone:FindFirstChild("Trans")

            if Trans then
                local MinValue, MaxValue = Trans.MinValue, Trans.MaxValue

                clone.ImageTransparency = MinValue + math.random() * (MaxValue - MinValue)
            end

            clone.Visible = true
            clone.Rotation = math.random(0, 360)
            clone.Size = UDim2.new(0.05, 0, 0.05, 0)

            local v7 = if clone:FindFirstChild("Duration") then clone.Duration.Value else 0.07

            clone.Parent = BillboardGui
            clone:TweenSize(UDim2.new(1, 0, 1, 0), "Out", "Quad", v7 * 2)
            Debris:AddItem(BillboardGui, v7)
        end

        local Children2 = v3.Sounds:GetChildren()
        local clone = Children2[math.random(1, #Children2)]:Clone()

        clone.PlaybackSpeed = 0.8 + math.random() * 0.44999999999999996
        clone.Parent = Attachment
        clone.Volume = GameMgr.SoundVolume
        clone:Play()
        Debris:AddItem(clone, clone.TimeLength / clone.PlaybackSpeed)

        repeat
            wait()
        until #Attachment:GetChildren() == 0

        Attachment:Destroy()
    end)
end

return t1
