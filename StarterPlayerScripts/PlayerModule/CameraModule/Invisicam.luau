-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Players = game:GetService("Players")
local t1 = {
    LIMBS = 2,
    MOVEMENT = 3,
    CORNERS = 4,
    CIRCLE1 = 5,
    CIRCLE2 = 6,
    LIMBMOVE = 7,
    SMART_CIRCLE = 8,
    CHAR_OUTLINE = 9
}
local t2 = {
    Head = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true,
    LeftLowerArm = true,
    RightLowerArm = true,
    LeftUpperLeg = true,
    RightUpperLeg = true
}
local t3 = {
    (Vector3.new(1, 1, -1)),
    (Vector3.new(1, -1, -1)),
    (Vector3.new(-1, -1, -1)),
    (Vector3.new(-1, 1, -1))
}

local function AssertTypes(p1, ...) -- line: 59
    local t4 = {}
    local v1 = ""

    for _, v2 in pairs({ ... }) do
        t4[v2] = true
        v1 ..= (if v1 == "" then "" else " or ") .. v2
    end

    local v3 = type(p1)

    assert(t4[v3], v1 .. " type expected, got: " .. v3)
end

local function Det3x3(p2, p3, p4, p5, p6, p7, p8, p9, p10) -- line: 71
    return p2 * (p6 * p10 - p7 * p9) - p3 * (p5 * p10 - p7 * p8) + p4 * (p5 * p9 - p6 * p8)
end

local function RayIntersection(p11, p12, p13, p14) -- line: 79
    local v6 = p12:Cross(p14)
    local v7 = p13.X - p11.X
    local v8 = p13.Y - p11.Y
    local v9 = p13.Z - p11.Z
    local X = p12.X
    local v10 = -p14.X
    local X2 = v6.X
    local Y = p12.Y
    local v11 = -p14.Y
    local Y2 = v6.Y
    local Z = p12.Z
    local v12 = -p14.Z
    local Z2 = v6.Z
    local v13 = X * (v11 * Z2 - Y2 * v12) - v10 * (Y * Z2 - Y2 * Z) + X2 * (Y * v12 - v11 * Z)

    if v13 ~= 0 then
        local v14 = -p14.X
        local X = v6.X
        local v15 = -p14.Y
        local Y = v6.Y
        local v16 = -p14.Z
        local Z = v6.Z
        local v17 = (v7 * (v15 * Z - Y * v16) - v14 * (v8 * Z - Y * v9) + X * (v8 * v16 - v15 * v9)) / v13
        local X2 = p12.X
        local X3 = v6.X
        local Y2 = p12.Y
        local Y3 = v6.Y
        local Z2 = p12.Z
        local Z3 = v6.Z
        local v18 = (X2 * (v8 * Z3 - Y3 * v9) - v7 * (Y2 * Z3 - Y3 * Z2) + X3 * (Y2 * v9 - v8 * Z2)) / v13
        local v19 = p11 + v17 * p12
        local v20 = p13 + v18 * p14
        local v21 = v19 + (v20 - v19) * 0.5

        if (v20 - v19).Magnitude < 0.25 then
            return v21
        end
    end

    return (Vector3.new(0, 0, 0))
end

local BaseOcclusion = require(script.Parent:WaitForChild("BaseOcclusion"))
local self = setmetatable({}, BaseOcclusion)

self.__index = self

function self.new() -- line: 112
    -- upvalues: t1 (copy), BaseOcclusion (copy), self (copy)
    local v24 = setmetatable(BaseOcclusion.new(), self)

    v24.char = nil
    v24.humanoidRootPart = nil
    v24.torsoPart = nil
    v24.headPart = nil
    v24.childAddedConn = nil
    v24.childRemovedConn = nil
    v24.behaviors = {}
    v24.behaviors[t1.LIMBS] = v24.LimbBehavior
    v24.behaviors[t1.MOVEMENT] = v24.MoveBehavior
    v24.behaviors[t1.CORNERS] = v24.CornerBehavior
    v24.behaviors[t1.CIRCLE1] = v24.CircleBehavior
    v24.behaviors[t1.CIRCLE2] = v24.CircleBehavior
    v24.behaviors[t1.LIMBMOVE] = v24.LimbMoveBehavior
    v24.behaviors[t1.SMART_CIRCLE] = v24.SmartCircleBehavior
    v24.behaviors[t1.CHAR_OUTLINE] = v24.CharacterOutlineBehavior
    v24.mode = t1.SMART_CIRCLE
    v24.behaviorFunction = v24.SmartCircleBehavior
    v24.savedHits = {}
    v24.trackedLimbs = {}
    v24.camera = game.Workspace.CurrentCamera
    v24.enabled = false

    return v24
end

function self.Enable(p15, p16) -- line: 145
    p15.enabled = p16

    if not p16 then
        p15:Cleanup()
    end
end

function self.GetOcclusionMode(_) -- line: 153
    return Enum.DevCameraOcclusionMode.Invisicam
end

function self.LimbBehavior(p18, p19) -- line: 158
    for v25, _ in pairs(p18.trackedLimbs) do
        p19[#p19 + 1] = v25.Position
    end
end

function self.MoveBehavior(p20, p21) -- line: 164
    for i = 1, 3 do
        local humanoidRootPartPosition, Velocity = p20.humanoidRootPart.Position, p20.humanoidRootPart.Velocity
        local v26 = Vector3.new(Velocity.X, 0, Velocity.Z).Magnitude / 2
        local v27 = (i - 1) * p20.humanoidRootPart.CFrame.lookVector * v26

        p21[#p21 + 1] = humanoidRootPartPosition + v27
    end
end

function self.CornerBehavior(p22, p23) -- line: 173
    -- upvalues: t3 (copy)
    local CFrame = p22.humanoidRootPart.CFrame
    local CFramePosition = CFrame.Position
    local v28 = CFrame - CFramePosition
    local v29 = p22.char:GetExtentsSize() / 2

    p23[#p23 + 1] = CFramePosition

    for i = 1, #t3 do
        p23[#p23 + 1] = CFramePosition + v28 * (v29 * t3[i])
    end
end

function self.CircleBehavior(p24, p25) -- line: 184
    -- upvalues: t1 (copy)
    local v30

    if p24.mode == t1.CIRCLE1 then
        v30 = p24.humanoidRootPart.CFrame
    else
        local CoordinateFrame = p24.camera.CoordinateFrame

        v30 = CoordinateFrame - CoordinateFrame.Position + p24.humanoidRootPart.Position
    end

    p25[#p25 + 1] = v30.Position

    for i = 0, 9 do
        local v31 = 0.6283185307179586 * i
        local v34 = Vector3.new(math.cos(v31), math.sin(v31), 0) * 3

        p25[#p25 + 1] = v30 * v34
    end
end

function self.LimbMoveBehavior(p26, p27) -- line: 200
    p26:LimbBehavior(p27)
    p26:MoveBehavior(p27)
end

function self.CharacterOutlineBehavior(p28, p29) -- line: 205
    local unit = p28.torsoPart.CFrame.upVector.unit
    local unit2 = p28.torsoPart.CFrame.rightVector.unit

    p29[#p29 + 1] = p28.torsoPart.CFrame.p
    p29[#p29 + 1] = p28.torsoPart.CFrame.p + unit
    p29[#p29 + 1] = p28.torsoPart.CFrame.p - unit
    p29[#p29 + 1] = p28.torsoPart.CFrame.p + unit2
    p29[#p29 + 1] = p28.torsoPart.CFrame.p - unit2

    if p28.headPart then
        p29[#p29 + 1] = p28.headPart.CFrame.p
    end

    local v35 = CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(p28.camera.CoordinateFrame.lookVector.X, 0, p28.camera.CoordinateFrame.lookVector.Z)))
    local Position = p28.torsoPart and p28.torsoPart.Position or p28.humanoidRootPart.Position
    local t6 = {
        p28.torsoPart
    }

    if p28.headPart then
        t6[#t6 + 1] = p28.headPart
    end

    for i = 1, 24 do
        local v36 = 6.283185307179586 * i / 24
        local v39 = v35 * (Vector3.new(math.cos(v36), math.sin(v36), 0) * 3)
        local v41 = Vector3.new(v39.X, math.max(v39.Y, -2.25), v39.Z)
        local v42 = Ray.new(Position + v41, -3 * v41)
        local v43, v44 = game.Workspace:FindPartOnRayWithWhitelist(v42, t6, false)

        if v43 then
            p29[#p29 + 1] = v44 + 0.2 * (Position - v44).unit
        end
    end
end

function self.SmartCircleBehavior(p30, p31) -- line: 244
    -- upvalues: RayIntersection (copy)
    local unit = p30.torsoPart.CFrame.upVector.unit
    local unit2 = p30.torsoPart.CFrame.rightVector.unit

    p31[#p31 + 1] = p30.torsoPart.CFrame.p
    p31[#p31 + 1] = p30.torsoPart.CFrame.p + unit
    p31[#p31 + 1] = p30.torsoPart.CFrame.p - unit
    p31[#p31 + 1] = p30.torsoPart.CFrame.p + unit2
    p31[#p31 + 1] = p30.torsoPart.CFrame.p - unit2

    if p30.headPart then
        p31[#p31 + 1] = p30.headPart.CFrame.p
    end

    local v45 = p30.camera.CFrame - p30.camera.CFrame.p
    local v46 = Vector3.new(0, 0.5, 0) + (p30.torsoPart and p30.torsoPart.Position or p30.humanoidRootPart.Position)

    for i = 1, 24 do
        local v47 = 0.2617993877991494 * i - 1.5707963267948966
        local v50 = v46 + v45 * (Vector3.new(math.cos(v47), math.sin(v47), 0) * 2.5)
        local v51 = v50 - p30.camera.CFrame.p
        local v52 = Ray.new(v46, v50 - v46)
        local v53, v54, v55 = game.Workspace:FindPartOnRayWithIgnoreList(v52, { p30.char }, false, false)
        local v56

        if v53 then
            local v57 = v54 + 0.1 * v55.unit
            local v58 = v57 - v46
            local unit = v58:Cross(v51).unit:Cross(v55).unit
            local unit2 = (v57 - p30.camera.CFrame.p).unit
            local v59 = v57

            if v58.unit:Dot(-unit) < v58.unit:Dot(unit2) then
                v59 = RayIntersection(v57, unit, v50, v51)

                if v59.Magnitude > 0 then
                    local v60 = Ray.new(v57, v59 - v57)
                    local v61, v62, v63 = game.Workspace:FindPartOnRayWithIgnoreList(v60, { p30.char }, false, false)

                    if v61 then
                        v59 = v62 + 0.1 * v63.unit
                    end
                else
                    v59 = v57
                end
            end

            local v64 = Ray.new(v46, v59 - v46)
            local v65, v66 = game.Workspace:FindPartOnRayWithIgnoreList(v64, { p30.char }, false, false)

            v56 = if v65 then v66 - 0.1 * (v59 - v46).unit else v59
        else
            v56 = v50
        end

        p31[#p31 + 1] = v56
    end
end

function self.CheckTorsoReference(p32) -- line: 329
    if p32.char then
        p32.torsoPart = p32.char:FindFirstChild("Torso")

        if not p32.torsoPart then
            p32.torsoPart = p32.char:FindFirstChild("UpperTorso")

            if not p32.torsoPart then
                p32.torsoPart = p32.char:FindFirstChild("HumanoidRootPart")
            end
        end

        p32.headPart = p32.char:FindFirstChild("Head")
    end
end

function self.CharacterAdded(p33, p34, p35) -- line: 343
    -- upvalues: Players (copy), t2 (copy)
    if p35 ~= Players.LocalPlayer then
        return
    end

    if p33.childAddedConn then
        p33.childAddedConn:Disconnect()
        p33.childAddedConn = nil
    end

    if p33.childRemovedConn then
        p33.childRemovedConn:Disconnect()
        p33.childRemovedConn = nil
    end

    p33.char = p34
    p33.trackedLimbs = {}

    local function childAdded(p36) -- line: 359
        -- upvalues: p33 (copy), t2 (copy)
        if not p36:IsA("BasePart") then
            return
        end

        if t2[p36.Name] then
            p33.trackedLimbs[p36] = true
        end

        if p36.Name == "Torso" or p36.Name == "UpperTorso" then
            p33.torsoPart = p36
        end

        if p36.Name == "Head" then
            p33.headPart = p36
        end
    end

    local function childRemoved(p37) -- line: 375
        -- upvalues: p33 (copy)
        p33.trackedLimbs[p37] = nil
        p33:CheckTorsoReference()
    end

    p33.childAddedConn = p34.ChildAdded:Connect(childAdded)
    p33.childRemovedConn = p34.ChildRemoved:Connect(childRemoved)

    for _, child in pairs(p33.char:GetChildren()) do
        if child:IsA("BasePart") then
            if t2[child.Name] then
                p33.trackedLimbs[child] = true
            end

            if child.Name == "Torso" or child.Name == "UpperTorso" then
                p33.torsoPart = child
            end

            if child.Name == "Head" then
                p33.headPart = child
            end
        end
    end
end

function self.SetMode(p38, p39) -- line: 389
    -- upvalues: t1 (copy), AssertTypes (copy)
    AssertTypes(p39, "number")

    for _, v67 in pairs(t1) do
        if v67 == p39 then
            p38.mode = p39
            p38.behaviorFunction = p38.behaviors[p38.mode]

            return
        end
    end

    error("Invalid mode number")
end

function self.GetObscuredParts(p40) -- line: 401
    return p40.savedHits
end

function self.Cleanup(p41) -- line: 406
    for v68, v69 in pairs(p41.savedHits) do
        v68.LocalTransparencyModifier = v69
    end
end

function self.Update(p42, _, p44, p45) -- line: 412
    if not p42.enabled or not p42.char then
        return p44, p45
    end

    p42.camera = game.Workspace.CurrentCamera

    if not p42.humanoidRootPart then
        local Humanoid = p42.char:FindFirstChildOfClass("Humanoid")

        if not (Humanoid and Humanoid.RootPart) then
            p42.humanoidRootPart = p42.char:FindFirstChild("HumanoidRootPart")

            if not p42.humanoidRootPart then
                return p44, p45
            end
        else
            p42.humanoidRootPart = Humanoid.RootPart
        end

        local connection

        connection = p42.humanoidRootPart.AncestryChanged:Connect(function(p46, p47) -- line: 437
            -- upvalues: p42 (copy), connection (ref)
            if p46 == p42.humanoidRootPart and not p47 then
                p42.humanoidRootPart = nil

                if connection and connection.Connected then
                    connection:Disconnect()
                    connection = nil
                end
            end
        end)
    end

    if not p42.torsoPart then
        p42:CheckTorsoReference()

        if not p42.torsoPart then
            return p44, p45
        end
    end

    local t7 = {}

    p42.behaviorFunction(p42, t7)

    local t8 = {}
    local t9 = {
        p42.char
    }

    local function add(p48) -- line: 463
        -- upvalues: p42 (copy), t8 (copy)
        t8[p48] = true

        if not p42.savedHits[p48] then
            p42.savedHits[p48] = p48.LocalTransparencyModifier
        end
    end

    local t10 = {}
    local p = p42.headPart and p42.headPart.CFrame.p or t7[1]
    local p2 = p42.torsoPart and p42.torsoPart.CFrame.p or t7[2]
    local PartsObscuringTarget = p42.camera:GetPartsObscuringTarget({ p, p2 }, t9)
    local n1 = 0

    for i = 1, #PartsObscuringTarget do
        local v71 = PartsObscuringTarget[i]

        n1 += 1
        t10[v71] = true

        for _, child in pairs(v71:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
                n1 += 1
                break
            end
        end
    end

    local v72, v73

    if n1 > 0 then
        v72 = math.pow(0.375 / n1 + 0.375, 1 / n1)
        v73 = math.pow(0.25 / n1 + 0.25, 1 / n1)
    else
        v72 = 0.75
        v73 = 0.75
    end

    local PartsObscuringTarget2 = p42.camera:GetPartsObscuringTarget(t7, t9)
    local t11 = {}

    for i = 1, #PartsObscuringTarget2 do
        local v78 = PartsObscuringTarget2[i]

        if not t10[v78] or not v72 then
            t11[v78] = v73
        else
            t11[v78] = v72
        end

        if v78.Transparency < t11[v78] then
            t8[v78] = true

            if not p42.savedHits[v78] then
                p42.savedHits[v78] = v78.LocalTransparencyModifier
            end
        end

        for _, child in pairs(v78:GetChildren()) do
            if (child:IsA("Decal") or child:IsA("Texture")) and child.Transparency < t11[v78] then
                t11[child] = t11[v78]
                t8[child] = true

                if not p42.savedHits[child] then
                    p42.savedHits[child] = child.LocalTransparencyModifier
                end
            end
        end
    end

    for v79, v80 in pairs(p42.savedHits) do
        if t8[v79] then
            v79.LocalTransparencyModifier = v79.Transparency < 1 and (t11[v79] - v79.Transparency) / (1 - v79.Transparency) or 0
        else
            v79.LocalTransparencyModifier = v80
            p42.savedHits[v79] = nil
        end
    end

    return p44, p45
end

return self
