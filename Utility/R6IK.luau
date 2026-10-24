-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local function SolveArmIK(p1, p2, p3, p4, p5, p6) -- line: 1
    local v1 = if p6 == "Left" then p1 * CFrame.new(0, 0, p5.X) elseif p6 == "Right" then p1 * CFrame.new(0, 0, -p5.X) else nil
    local v2 = v1:pointToObjectSpace(p2)
    local unit, magnitude = v2.unit, v2.magnitude
    local v3 = (Vector3.new(0, 0, -1)):Cross(unit)
    local v5 = math.acos(-unit.Z)
    local v6 = v1 * CFrame.fromAxisAngle(v3, v5)

    if magnitude < math.max(p4, p3) - math.min(p4, p3) then
        return v6 * CFrame.new(0, 0, math.max(p4, p3) - math.min(p4, p3) - magnitude), -1.5707963267948966, 3.141592653589793
    end

    if p3 + p4 < magnitude then
        return v6, 1.5707963267948966, 0, magnitude
    end

    local v8 = -math.acos((-(p4 * p4) + p3 * p3 + magnitude * magnitude) / (2 * p3 * magnitude))
    local v10 = math.acos((p4 * p4 - p3 * p3 + magnitude * magnitude) / (2 * p4 * magnitude))

    return v6, v8 + 1.5707963267948966, v10 - v8
end

local function SolveLegIK(p7, p8, p9, p10, p11) -- line: 38
    local v11 = p7 * CFrame.new(-p11.X, 0, 0)
    local v12 = v11:pointToObjectSpace(p8)
    local unit, magnitude = v12.unit, v12.magnitude
    local v13 = (Vector3.new(0, 0, -1)):Cross(-unit)
    local v15 = math.acos(-unit.Z)
    local v16 = v11 * CFrame.fromAxisAngle(v13, v15):Inverse()

    if magnitude < math.max(p10, p9) - math.min(p10, p9) then
        return v16 * CFrame.new(0, 0, math.max(p10, p9) - math.min(p10, p9) - magnitude), -1.5707963267948966, 3.141592653589793
    end

    if p9 + p10 < magnitude then
        return v16, 1.5707963267948966, 0, magnitude
    end

    local v18 = -math.acos((-(p10 * p10) + p9 * p9 + magnitude * magnitude) / (2 * p9 * magnitude))
    local v20 = math.acos((p10 * p10 - p9 * p9 + magnitude * magnitude) / (2 * p10 * magnitude))

    return v16, 1.5707963267948966 - v18, -(v20 - v18)
end

local function SolveLesIK(p12, p13, p14, p15) -- line: 70
    local v21 = p12:pointToObjectSpace(p13)
    local Unit, Magnitude = v21.Unit, v21.Magnitude
    local v22 = (Vector3.new(0, 0, -1)):Cross(-Unit)
    local v24 = math.acos(-Unit.Z)
    local v25 = p12 * CFrame.fromAxisAngle(v22, v24):Inverse()

    if Magnitude < math.max(p15, p14) - math.min(p15, p14) then
        return v25 * CFrame.new(0, 0, math.max(p15, p14) - math.min(p15, p14) - Magnitude), -1.5707963267948966, 3.141592653589793
    end

    if p14 + p15 < Magnitude then
        return v25, 1.5707963267948966, 0
    end

    local v27 = -math.acos((-(p15 * p15) + p14 * p14 + Magnitude * Magnitude) / (2 * p14 * Magnitude))
    local v29 = math.acos((p15 * p15 - p14 * p14 + Magnitude * Magnitude) / (2 * p15 * Magnitude))

    return v25, 1.5707963267948966 - v27, -(v29 - v27)
end

local function WorldCFrameToC0ObjectSpace(p16, p17) -- line: 108
    local _ = p16.Part1.CFrame
    local Part0, C1, _ = p16.Part0, p16.C1, p16.C0

    return Part0.CFrame:inverse() * p17 * C1
end

local t1 = {}

t1.__index = t1

function t1.new(p18, p19) -- line: 123
    p18.Torso = p19.Torso
    p18.HumanoidRootPart = p19.HumanoidRootPart
    p18.LeftArm = p19["Left Arm"]
    p18.RightArm = p19["Right Arm"]
    p18.LeftLeg = p19["Left Leg"]
    p18.RightLeg = p19["Right Leg"]
    p18.Motor6Ds = {
        ["Left Shoulder"] = p18.Torso["Left Shoulder"],
        ["Right Shoulder"] = p18.Torso["Right Shoulder"],
        ["Left Hip"] = p18.Torso["Left Hip"],
        ["Right Hip"] = p18.Torso["Right Hip"],
        RootJoint = p18.HumanoidRootPart.RootJoint
    }
    p18.C0s = {
        ["Left Shoulder"] = p18.Motor6Ds["Left Shoulder"].C0,
        ["Right Shoulder"] = p18.Motor6Ds["Right Shoulder"].C0,
        ["Left Hip"] = p18.Motor6Ds["Left Hip"].C0,
        ["Right Hip"] = p18.Motor6Ds["Right Hip"].C0,
        RootJoint = p18.Motor6Ds.RootJoint.C0
    }
    p18.C1s = {
        ["Left Shoulder"] = p18.Motor6Ds["Left Shoulder"].C1,
        ["Right Shoulder"] = p18.Motor6Ds["Right Shoulder"].C1,
        ["Left Hip"] = p18.Motor6Ds["Left Hip"].C1,
        ["Right Hip"] = p18.Motor6Ds["Right Hip"].C1,
        RootJoint = p18.Motor6Ds.RootJoint.C1
    }
    p18.Part0s = {
        ["Left Shoulder"] = p18.Motor6Ds["Left Shoulder"].Part0,
        ["Right Shoulder"] = p18.Motor6Ds["Right Shoulder"].Part0,
        ["Left Hip"] = p18.Motor6Ds["Left Hip"].Part0,
        ["Right Hip"] = p18.Motor6Ds["Right Hip"].Part0,
        RootJoint = p18.Motor6Ds.RootJoint.Part0
    }
    p18.Part1s = {
        ["Left Shoulder"] = p18.Motor6Ds["Left Shoulder"].Part1,
        ["Right Shoulder"] = p18.Motor6Ds["Right Shoulder"].Part1,
        ["Left Hip"] = p18.Motor6Ds["Left Hip"].Part1,
        ["Right Hip"] = p18.Motor6Ds["Right Hip"].Part1,
        RootJoint = p18.Motor6Ds.RootJoint.Part1
    }
    p18.LeftUpperArmLength = 1
    p18.LeftLowerArmLength = 1
    p18.RightUpperArmLength = 1
    p18.RightLowerArmLength = 1
    p18.LeftUpperLegLength = 1
    p18.LeftLowerLegLength = 1
    p18.RightUpperLegLength = 1
    p18.RightLowerLegLength = 1
    p18.TorsoIK = false
end

function t1.ArmIK(p20, p21, p22) -- line: 187
    -- upvalues: SolveArmIK (copy)
    if p21 == "Left" then
        local v30 = p20.Torso.CFrame * p20.C0s["Left Shoulder"]
        local v31 = p20.C1s["Left Shoulder"]
        local v32, v33, v34 = SolveArmIK(v30, p22, p20.LeftUpperArmLength, p20.LeftLowerArmLength, v31, p21)
        local v35 = CFrame.Angles(v33, 0, 0)
        local v36 = CFrame.Angles(v34, 0, 0)
        local v37 = v32 * v35 * CFrame.new(0, -p20.LeftUpperArmLength * 0.5, 0) * CFrame.new(0, -p20.LeftUpperArmLength * 0.5, 0) * v36 * CFrame.new(0, -p20.LeftLowerArmLength * 0.5, 0) * CFrame.new(0, (p20.LeftArm.Size.Y - p20.LeftLowerArmLength) * 0.5, 0)
        local v38, v39 = p20.Motor6Ds["Left Shoulder"], p20.Motor6Ds["Left Shoulder"]
        local _ = v39.Part1.CFrame
        local Part0, C1, _ = v39.Part0, v39.C1, v39.C0

        v38.C0 = Part0.CFrame:inverse() * v37 * C1
    elseif p21 == "Right" then
        local v40 = p20.Torso.CFrame * p20.C0s["Right Shoulder"]
        local v41 = p20.C1s["Right Shoulder"]
        local v42, v43, v44 = SolveArmIK(v40, p22, p20.RightUpperArmLength, p20.RightLowerArmLength, v41, p21)
        local v45 = CFrame.Angles(v43, 0, 0)
        local v46 = CFrame.Angles(v44, 0, 0)
        local v47 = v42 * v45 * CFrame.new(0, -p20.RightUpperArmLength * 0.5, 0) * CFrame.new(0, -p20.RightUpperArmLength * 0.5, 0) * v46 * CFrame.new(0, -p20.RightLowerArmLength * 0.5, 0) * CFrame.new(0, (p20.RightArm.Size.Y - p20.RightLowerArmLength) * 0.5, 0)
        local v48, v49 = p20.Motor6Ds["Right Shoulder"], p20.Motor6Ds["Right Shoulder"]
        local _ = v49.Part1.CFrame
        local Part0, C1, _ = v49.Part0, v49.C1, v49.C0

        v48.C0 = Part0.CFrame:inverse() * v47 * C1
    end
end

function t1.LegIK(p23, p24, p25) -- line: 213
    -- upvalues: SolveLegIK (copy)
    if p24 == "Left" then
        local v50 = p23.Torso.CFrame * p23.C0s["Left Hip"]
        local v51 = p23.C1s["Left Hip"]
        local v52, v53, v54 = SolveLegIK(v50 * CFrame.Angles(0, 1.5707963267948966, 0), p25, p23.LeftUpperLegLength, p23.LeftLowerLegLength, v51)
        local v55 = CFrame.Angles(v53, 0, 0)
        local v56 = CFrame.Angles(v54, 0, 0)
        local v57 = v52 * v55 * CFrame.new(0, -p23.LeftUpperLegLength * 0.5, 0) * CFrame.new(0, -p23.LeftUpperLegLength * 0.5, 0) * v56 * CFrame.new(0, -p23.LeftLowerLegLength * 0.5, 0) * CFrame.new(0, (p23.LeftLeg.Size.Y - p23.LeftLowerLegLength) * 0.5, 0)
        local v58, v59 = p23.Motor6Ds["Left Hip"], p23.Motor6Ds["Left Hip"]
        local _ = v59.Part1.CFrame
        local Part0, C1, _ = v59.Part0, v59.C1, v59.C0

        v58.C0 = Part0.CFrame:inverse() * v57 * C1
    elseif p24 == "Right" then
        local v60 = p23.Torso.CFrame * p23.C0s["Right Hip"]
        local v61 = p23.C1s["Right Hip"]
        local v62, v63, v64 = SolveLegIK(v60 * CFrame.Angles(0, -1.5707963267948966, 0), p25, p23.RightUpperLegLength, p23.RightLowerLegLength, v61)
        local v65 = CFrame.Angles(v63, 0, 0)
        local v66 = CFrame.Angles(v64, 0, 0)
        local v67 = v62 * v65 * CFrame.new(0, -p23.RightUpperLegLength * 0.5, 0) * CFrame.new(0, -p23.RightUpperLegLength * 0.5, 0) * v66 * CFrame.new(0, -p23.RightLowerLegLength * 0.5, 0) * CFrame.new(0, (p23.RightLeg.Size.Y - p23.RightLowerLegLength) * 0.5, 0)
        local v68, v69 = p23.Motor6Ds["Right Hip"], p23.Motor6Ds["Right Hip"]
        local _ = v69.Part1.CFrame
        local Part0, C1, _ = v69.Part0, v69.C1, v69.C0

        v68.C0 = Part0.CFrame:inverse() * v67 * C1
    end
end

return t1
