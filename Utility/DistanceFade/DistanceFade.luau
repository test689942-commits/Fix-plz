-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

local t2 = {
    DistanceOuter = 16,
    DistanceInner = 4,
    EffectRadius = 16,
    EffectRadiusMin = 0,
    EdgeDistanceCalculations = false,
    Texture = "rbxassetid://18838056070",
    TextureTransparency = 0,
    TextureTransparencyMin = 1,
    BackgroundTransparency = 1,
    BackgroundTransparencyMin = 1,
    TextureColor = Color3.fromRGB(255, 255, 255),
    BackgroundColor = Color3.fromRGB(255, 255, 255),
    TextureSize = Vector2.new(8, 8),
    TextureOffset = Vector2.new(0, 0),
    ZOffset = 0,
    AlwaysOnTop = false,
    Brightness = 1,
    LightInfluence = 0,
    MaxDistance = 1000,
    PixelsPerStud = 100,
    SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
}

local function SetUpFolders(p1) -- line: 53
    if p1.WorkspaceFolder ~= nil then
        return
    end

    local DistanceFade_SurfaceParts = game.Workspace:FindFirstChild("DistanceFade_SurfaceParts")

    if DistanceFade_SurfaceParts ~= nil then
        p1.WorkspaceFolder = DistanceFade_SurfaceParts
    else
        p1.WorkspaceFolder = Instance.new("Folder")
        p1.WorkspaceFolder.Name = "DistanceFade_SurfaceParts"
        p1.WorkspaceFolder.Parent = workspace
    end
end

function t1.new() -- line: 82
    -- upvalues: t1 (copy), t2 (copy)
    local t3 = {
        WorkspaceFolder = nil,
        Settings = {},
        FaceSettings = {},
        TargetParts = {}
    }

    setmetatable(t3, t1)
    t3.Settings = {}

    for v1, v2 in t2 do
        t3.Settings[v1] = v2
    end

    if t3.WorkspaceFolder == nil then
        local DistanceFade_SurfaceParts = game.Workspace:FindFirstChild("DistanceFade_SurfaceParts")

        if DistanceFade_SurfaceParts ~= nil then
            t3.WorkspaceFolder = DistanceFade_SurfaceParts

            return t3
        end

        t3.WorkspaceFolder = Instance.new("Folder")
        t3.WorkspaceFolder.Name = "DistanceFade_SurfaceParts"
        t3.WorkspaceFolder.Parent = workspace
    end

    return t3
end

function t1.UpdateSettings(p2, p3) -- line: 101
    -- upvalues: t2 (copy)
    if p2.Settings == nil then
        p2.Settings = {}
    end

    if p3 ~= nil then
        assert(type(p3) == "table", "Expected table as parameter")

        for v6, v7 in t2 do
            if p3[v6] ~= nil then
                p2.Settings[v6] = p3[v6]
            elseif p2.Settings[v6] == nil then
                p2.Settings[v6] = v7
            end
        end
    else
        for v3, v4 in t2 do
            p2.Settings[v3] = v4
        end
    end
end

function t1.UpdateFaceSettings(p4, p5, p6, p7) -- line: 124
    if p4.FaceSettings[p5] == nil then
        p4.FaceSettings[p5] = {}
    end

    if p4.FaceSettings[p5][p6] == nil then
        p4.FaceSettings[p5][p6] = {}
    end

    if p7 ~= nil then
        assert(type(p7) == "table", "Expected table as parameter")

        for v9, v10 in pairs(p7) do
            p4.FaceSettings[p5][p6][v9] = v10
        end
    else
        p4.FaceSettings[p5][p6] = nil
    end
end

local function GetNormalDirection(p8, p9) -- line: 147
    if p8 == Enum.NormalId.Front then
        return p9.CFrame.LookVector
    end

    if p8 == Enum.NormalId.Back then
        return -p9.CFrame.LookVector
    end

    if p8 == Enum.NormalId.Left then
        return -p9.CFrame.RightVector
    end

    if p8 == Enum.NormalId.Right then
        return p9.CFrame.RightVector
    end

    if p8 == Enum.NormalId.Top then
        return p9.CFrame.UpVector
    end

    return if p8 == Enum.NormalId.Bottom then -p9.CFrame.UpVector else nil
end

local function GetNormalOffset(p10, p11) -- line: 168
    local v11 = Vector3.new()
    local v12 = CFrame.new()

    if p10 == Enum.NormalId.Front then
        return p11.Size.Z / 2 * p11.CFrame.LookVector, (CFrame.Angles(0, 0, 0))
    end

    if p10 == Enum.NormalId.Back then
        return p11.Size.Z / 2 * -p11.CFrame.LookVector, (CFrame.Angles(0, 3.141592653589793, 0))
    end

    if p10 == Enum.NormalId.Left then
        return p11.Size.X / 2 * -p11.CFrame.RightVector, (CFrame.Angles(0, 1.5707963267948966, 0))
    end

    if p10 == Enum.NormalId.Right then
        return p11.Size.X / 2 * p11.CFrame.RightVector, (CFrame.Angles(0, -1.5707963267948966, 0))
    end

    if p10 == Enum.NormalId.Top then
        return p11.Size.Y / 2 * p11.CFrame.UpVector, (CFrame.Angles(1.5707963267948966, 0, 0))
    end

    if p10 == Enum.NormalId.Bottom then
        v11 = p11.Size.Y / 2 * -p11.CFrame.UpVector
        v12 = CFrame.Angles(-1.5707963267948966, 0, 0)
    end

    return v11, v12
end

local function GetSidePositionsOfPartAlongNormal(p12, p13, p14, p15) -- line: 196
    local UpVector, v13, v14, v15, v16

    if p14 == Enum.NormalId.Front or p14 == Enum.NormalId.Back then
        local v17 = p15.X / 2
        local v18 = p15.Y / 2
        local v19 = p15.Z / 2

        v14 = p14 == Enum.NormalId.Front and p13.RightVector or -p13.RightVector
        UpVector = p13.UpVector
        v13 = p14 == Enum.NormalId.Front and p13.LookVector * v19 or -p13.LookVector * v19
        v15 = v17
        v16 = v18
    elseif p14 == Enum.NormalId.Left or p14 == Enum.NormalId.Right then
        local v21 = p15.Z / 2
        local v22 = p15.Y / 2
        local v23 = p15.X / 2

        v14 = p14 == Enum.NormalId.Left and p13.LookVector or -p13.LookVector
        UpVector = p13.UpVector
        v13 = p14 == Enum.NormalId.Left and -p13.RightVector * v23 or p13.RightVector * v23
        v15 = v21
        v16 = v22
    elseif p14 == Enum.NormalId.Top or p14 == Enum.NormalId.Bottom then
        local v25 = p15.X / 2
        local v26 = p15.Z / 2
        local v27 = p15.Y / 2
        local RightVector = p13.RightVector

        UpVector = p14 == Enum.NormalId.Top and -p13.LookVector or p13.LookVector

        local v28 = p14 == Enum.NormalId.Top
        local v29 = if v28 then p13.UpVector * v27 else nil

        v13 = if not v28 or not v29 then -p13.UpVector * v27 else v29
        v15 = v25
        v16 = v26
        v14 = RightVector
    end

    local v30 = p12 + v13

    return {
        Left = v30 - v14 * v15,
        Right = v30 + v14 * v15,
        Top = v30 + UpVector * v16,
        Bottom = v30 - UpVector * v16
    }
end

local function ToNormalSpace(p16, p17, p18) -- line: 242
    local v31 = p16:PointToObjectSpace(p17)

    if p18 == Enum.NormalId.Front then
        return v31
    end

    if p18 == Enum.NormalId.Back then
        return (Vector3.new(-v31.X, v31.Y, v31.Z))
    end

    if p18 == Enum.NormalId.Left then
        return (Vector3.new(-v31.Z, v31.Y, v31.X))
    end

    if p18 == Enum.NormalId.Right then
        return (Vector3.new(v31.Z, v31.Y, v31.X))
    end

    if p18 == Enum.NormalId.Top then
        return (Vector3.new(v31.X, v31.Z, v31.Y))
    end

    return (Vector3.new(v31.X, -v31.Z, v31.Y))
end

local function NewTile() -- line: 267
    local Frame = Instance.new("Frame")

    Frame.BackgroundTransparency = 1

    local Frame2 = Instance.new("Frame")

    Frame2.BackgroundTransparency = 1
    Frame2.ClipsDescendants = true
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame2.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame2.Size = UDim2.new(1, 0, 1, 0)
    Frame2.Name = "ScaleFrame"
    Frame2.Parent = Frame

    local ImageLabel = Instance.new("ImageLabel")

    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Parent = Frame2
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Size = UDim2.new(9, 0, 9, 0)
    ImageLabel.ScaleType = Enum.ScaleType.Tile
    ImageLabel.TileSize = UDim2.new(0.111, 0, 0.111, 0)

    return Frame
end

local function CreateGrid(_, p20) -- line: 290
    -- upvalues: NewTile (copy)
    local t4 = {}

    for i = 1, 4 do
        for j = 1, 4 do
            local v35 = NewTile()

            v35.Parent = p20.ScaleFrame
            v35.Size = UDim2.new(0.25, 0, 0.25, 0)
            v35.Position = UDim2.new((j - 1) * 0.25, 0, (i - 1) * 0.25, 0)
            v35.BorderSizePixel = 0
            table.insert(t4, v35)
            v35.Name = tostring(#t4)
        end
    end

    return t4
end

local function ApplyCircularGradient(p21) -- line: 309
    local t5 = {
        [1] = 45,
        [4] = 135,
        [13] = -45,
        [16] = -135
    }
    local t6 = {
        [2] = 75,
        [3] = 105,
        [5] = 15,
        [8] = 165,
        [9] = -15,
        [12] = -165,
        [14] = -75,
        [15] = -105
    }

    for i = 1, #p21 do
        local v37 = p21[i]
        local v38 = false

        for v39, v40 in t5 do
            if v39 == i then
                local UIGradient = Instance.new("UIGradient")

                UIGradient.Parent = v37.ScaleFrame.ImageLabel
                v38 = true
                UIGradient.Rotation = v40
                break
            end
        end

        if not v38 then
            for v41, v42 in t6 do
                if v41 == i then
                    local UIGradient = Instance.new("UIGradient")

                    UIGradient.Parent = v37.ScaleFrame.ImageLabel
                    UIGradient.Rotation = v42
                    break
                end
            end
        end
    end
end

local function SetUpSurface(p22, p23, p24) -- line: 352
    -- upvalues: GetNormalOffset (copy), CreateGrid (copy), ApplyCircularGradient (copy)
    local Part = Instance.new("Part")

    Part.Transparency = 1
    Part.Parent = p24.WorkspaceFolder
    Part.Size = Vector3.new(0, 0, 0)
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanTouch = false
    Part.CanQuery = false
    Part.Locked = true

    local v43, v44 = GetNormalOffset(p23, p22)

    Part.CFrame = p22.CFrame * CFrame.new(v43) * v44

    local SurfaceGui = Instance.new("SurfaceGui")

    SurfaceGui.ResetOnSpawn = false
    SurfaceGui.ClipsDescendants = true
    SurfaceGui.Parent = game.Players.LocalPlayer.PlayerGui
    SurfaceGui.Adornee = Part
    SurfaceGui.Face = Enum.NormalId.Front
    SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
    SurfaceGui.PixelsPerStud = 1000

    local Frame = Instance.new("Frame")

    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame.BackgroundTransparency = 1
    Frame.Name = "ScaleFrame"
    Frame.Parent = SurfaceGui
    SurfaceGui.Enabled = false

    local EffectResolution = p24.Settings.EffectResolution

    ApplyCircularGradient(CreateGrid(EffectResolution, SurfaceGui), EffectResolution)

    return Part, SurfaceGui
end

function t1.AddFace(p25, p26, p27) -- line: 389
    -- upvalues: SetUpSurface (copy)
    local v46 = if p27 == nil then Enum.NormalId.Front else p27
    local v47, v48 = SetUpSurface(p26, v46, p25)
    local t7 = {
        SurfaceNormal = v46,
        SurfacePart = v47,
        SurfaceGui = v48
    }

    if p25.TargetParts[p26] == nil then
        p25.TargetParts[p26] = {}
    end

    p25.TargetParts[p26][v46] = t7
end

function t1.RemoveFace(p28, p29, p30) -- line: 406
    local v49 = if p30 == nil then Enum.NormalId.Front else p30

    if p28.TargetParts[p29] ~= nil then
        local v50 = p28.TargetParts[p29][v49]

        if v50 ~= nil then
            v50.SurfacePart:Destroy()
            v50.SurfaceGui:Destroy()
            p28.TargetParts[p29][v49] = nil

            if next(p28.TargetParts[p29]) == nil then
                p28.TargetParts[p29] = nil

                if p28.WorkspaceFolder ~= nil and #p28.WorkspaceFolder:GetChildren() == 0 then
                    p28.WorkspaceFolder:Destroy()
                    p28.WorkspaceFolder = nil
                end
            end
        end
    end
end

function t1.Clear(p31) -- line: 432
    for _, v51 in p31.TargetParts do
        for _, v52 in v51 do
            v52.SurfacePart:Destroy()
            v52.SurfaceGui:Destroy()
        end
    end

    if p31.WorkspaceFolder ~= nil and #p31.WorkspaceFolder:GetChildren() == 0 then
        p31.WorkspaceFolder:Destroy()
        p31.WorkspaceFolder = nil
    end

    table.clear(p31.TargetParts)
end

local t8 = {
    {
        OffsetX = 3,
        OffsetY = 3
    },
    {
        OffsetX = 2,
        OffsetY = 3
    },
    {
        OffsetX = 1,
        OffsetY = 3
    },
    {
        OffsetX = 0,
        OffsetY = 3
    },
    {
        OffsetX = 3,
        OffsetY = 2
    },
    {
        OffsetX = 2,
        OffsetY = 2
    },
    {
        OffsetX = 1,
        OffsetY = 2
    },
    {
        OffsetX = 0,
        OffsetY = 2
    },
    {
        OffsetX = 3,
        OffsetY = 1
    },
    {
        OffsetX = 2,
        OffsetY = 1
    },
    {
        OffsetX = 1,
        OffsetY = 1
    },
    {
        OffsetX = 0,
        OffsetY = 1
    },
    {
        OffsetX = 3,
        OffsetY = 0
    },
    {
        OffsetX = 2,
        OffsetY = 0
    },
    {
        OffsetX = 1,
        OffsetY = 0
    },
    {
        OffsetX = 0,
        OffsetY = 0
    }
}

local function UpdateTextureOffset(p32, p33, p34, p35) -- line: 524
    local function ConvertToRange(p36, p37) -- line: 525
        local v53 = math.abs(p36) / p37 % 1

        if p36 < 0 then
            return -v53
        end

        return v53
    end

    local v54 = math.abs(p32) / p34 % 1

    if p32 < 0 then
        v54 = -v54
    end

    local v55 = math.abs(p33) / p35 % 1

    if p33 < 0 then
        v55 = -v55
    end

    return UDim2.new(0.5 + v54 * p34, 0, 0.5 + v55 * p35, 0)
end

local function AdjustGradientOffset(p38, p39) -- line: 539
    local v56 = math.rad(p38.Rotation)
    local v57 = math.cos(v56)
    local v58 = math.sin(v56)
    local v59 = p39.X * v57 - p39.Y * v58
    local v60 = p39.X * v58 + p39.Y * v57

    return Vector2.new(v59, v60)
end

function UpdateSideGradient(p40) -- line: 550
    local UIGradient = p40.ScaleFrame.ImageLabel.UIGradient
    local _ = p40.ScaleFrame.Size
    local ImageLabelPosition = p40.ScaleFrame.ImageLabel.Position
    local v61 = -(ImageLabelPosition.X.Scale + 0.5) / 200
    local v62 = if p40.Name == "2" or p40.Name == "3" or p40.Name == "14" or p40.Name == "15" then 0 else v61
    local v63 = -(ImageLabelPosition.Y.Scale + 0.5) / 200
    local v64 = if p40.Name == "5" or p40.Name == "8" or p40.Name == "9" or p40.Name == "12" then 0 else v63

    if p40.Name == "5" or p40.Name == "9" then
        v62 += 0.01
    end

    if p40.Name == "2" or p40.Name == "3" then
        v64 += 0.01
    end

    local v65 = (ImageLabelPosition.X.Scale - 0.5) / 9 + v62
    local v66 = (ImageLabelPosition.Y.Scale - 0.5) / 9 + v64
    local v67 = if p40.Name ~= "12" and p40.Name ~= "9" and p40.Name ~= "2" and p40.Name ~= "3" then v66 else -v66
    local v68 = if p40.Name ~= "5" and p40.Name ~= "9" and p40.Name ~= "15" and p40.Name ~= "3" then v65 else -v65
    local v69, v70

    if p40.Name == "2" or p40.Name == "3" or p40.Name == "14" or p40.Name == "15" then
        v69 = v67
        v70 = v68
    else
        v69 = v68
        v70 = v67
    end

    local t9 = {
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.444, 1),
        NumberSequenceKeypoint.new(0.466, 1),
        NumberSequenceKeypoint.new(0.555, 0),
        NumberSequenceKeypoint.new(1, 0)
    }
    local t10 = {}

    for i = 1, #t9 do
        local v71 = t9[i]
        local v72 = v71.Time + v69

        t10[i] = NumberSequenceKeypoint.new(math.clamp(v72, 0, 1), v71.Value)
    end

    if t10[1].Time > 0 then
        table.insert(t10, 1, NumberSequenceKeypoint.new(0, t10[1].Value))
    end

    if t10[#t10].Time < 1 then
        table.insert(t10, NumberSequenceKeypoint.new(1, t10[#t10].Value))
    end

    for _, v73 in t10 do
        if v73.Time < 0 then
            v73.Time = 0
        elseif v73.Time > 1 then
            v73.Time = 1
        end
    end

    UIGradient.Transparency = NumberSequence.new(t10)

    local v74 = Vector2.new(-v70 / 4, 0)
    local v75 = math.rad(UIGradient.Rotation)
    local v76 = math.cos(v75)
    local v77 = math.sin(v75)
    local v78 = v74.X * v76 - v74.Y * v77
    local v79 = v74.X * v77 + v74.Y * v76

    UIGradient.Offset = Vector2.new(v78, v79)
end

function UpdateCornerGradient(p41) -- line: 617
    local UIGradient = p41.ScaleFrame.ImageLabel.UIGradient
    local _ = p41.ScaleFrame.Size
    local ImageLabelPosition = p41.ScaleFrame.ImageLabel.Position
    local v80 = -(ImageLabelPosition.X.Scale + 0.5) / 75
    local v81 = -(ImageLabelPosition.Y.Scale + 0.5) / 75
    local v82 = (ImageLabelPosition.X.Scale - 0.5) / 9 + v80
    local v83 = (ImageLabelPosition.Y.Scale - 0.5) / 9 + v81

    if p41.Name == "13" or p41.Name == "1" then
        v82 = -v82
    end

    if p41.Name == "1" or p41.Name == "4" then
        v83 = -v83
    end

    local v84 = if p41.Name == "1" then -0.015
        elseif p41.Name == "4" then 0.0025
        elseif p41.Name == "16" then 0.02
        elseif p41.Name == "13" then 0.0025
        else 0
    local v85 = (v82 + v83) / 1.4142135623730951 + v84
    local v86 = (v82 + v83) / 1.4142135623730951 + v84
    local t11 = {
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.444, 1),
        NumberSequenceKeypoint.new(0.51, 1),
        NumberSequenceKeypoint.new(0.555, 0.2),
        NumberSequenceKeypoint.new(1, 0.2)
    }
    local t12 = {}

    for i = 1, #t11 do
        local v87 = t11[i]
        local v88 = v87.Time + v85

        t12[i] = NumberSequenceKeypoint.new(math.clamp(v88, 0, 1), v87.Value)
    end

    if t12[1].Time > 0 then
        table.insert(t12, 1, NumberSequenceKeypoint.new(0, t12[1].Value))
    end

    if t12[#t12].Time < 1 then
        table.insert(t12, NumberSequenceKeypoint.new(1, t12[#t12].Value))
    end

    if p41.Name == "1" or p41.Name == "4" then
        local t13 = {}

        for v89, v90 in t12 do
            if v90.Time == 1 then
                for j = 1, v89 do
                    table.insert(t13, t12[j])
                end

                t12 = t13
                break
            end
        end
    end

    for _, v92 in t12 do
        if v92.Time < 0 then
            v92.Time = 0
        elseif v92.Time > 1 then
            v92.Time = 1
        end
    end

    UIGradient.Transparency = NumberSequence.new(t12)

    local v93 = Vector2.new(-v86 / 4, 0)
    local v94 = math.rad(UIGradient.Rotation)
    local v95 = math.cos(v94)
    local v96 = math.sin(v94)
    local v97 = v93.X * v95 - v93.Y * v96
    local v98 = v93.X * v96 + v93.Y * v95

    UIGradient.Offset = Vector2.new(v97, v98)
end

function t1.Step(p42, p43) -- line: 697
    -- upvalues: GetNormalDirection (copy), GetNormalOffset (copy), GetSidePositionsOfPartAlongNormal (copy), ToNormalSpace (copy), t8 (copy), UpdateTextureOffset (copy)
    local Settings

    if p42.WorkspaceFolder == nil then
        Settings = game.Workspace:FindFirstChild("DistanceFade_SurfaceParts")

        if Settings ~= nil then
            p42.WorkspaceFolder = Settings
        else
            p42.WorkspaceFolder = Instance.new("Folder")
            p42.WorkspaceFolder.Name = "DistanceFade_SurfaceParts"
            p42.WorkspaceFolder.Parent = workspace
        end
    end

    Settings = p42.Settings

    if Settings.EffectRadiusMin > Settings.EffectRadius then
        Settings.EffectRadiusMin = Settings.EffectRadius
    end

    if Settings.DistanceInner > Settings.DistanceOuter then
        Settings.DistanceInner = Settings.DistanceOuter
    end

    local v99

    if p43 ~= nil then
        v99 = p43
    else
        local WorkspaceFolder = game.Players.LocalPlayer.Character

        if WorkspaceFolder == nil then
            return
        end

        v99 = WorkspaceFolder.HumanoidRootPart.Position
    end

    for v100, v101 in p42.TargetParts do
        for v102, v103 in v101 do
            local v104 = {}

            if p42.FaceSettings[v100] ~= nil and p42.FaceSettings[v100][v102] ~= nil then
                for v105, v106 in Settings do
                    v104[v105] = v106

                    if p42.FaceSettings[v100][v102][v105] ~= nil then
                        v104[v105] = p42.FaceSettings[v100][v102][v105]
                    end
                end
            end

            if next(v104) == nil then
                v104 = Settings
            end

            local SurfacePart, SurfaceGui = v103.SurfacePart, v103.SurfaceGui

            SurfaceGui.ZOffset = v104.ZOffset
            SurfaceGui.AlwaysOnTop = v104.AlwaysOnTop
            SurfaceGui.Brightness = v104.Brightness
            SurfaceGui.LightInfluence = v104.LightInfluence
            SurfaceGui.MaxDistance = v104.MaxDistance
            SurfaceGui.PixelsPerStud = v104.PixelsPerStud
            SurfaceGui.SizingMode = v104.SizingMode

            local v107 = v100.CFrame
            local Magnitude, v108 = GetNormalOffset(v103.SurfaceNormal, v100)
            local v109 = GetNormalDirection(v103.SurfaceNormal, v100)
            local v110 = v99 - (v100.Position + Magnitude)
            local v111 = v110 - v109 * v110:Dot(v109)

            v110 = v100.Position + v111 + Magnitude
            v111 = v100.CFrame * CFrame.new(Magnitude) * v108
            SurfacePart.CFrame = CFrame.new(v110) * CFrame.fromMatrix(Vector3.new(), v111.RightVector, v111.UpVector)
            v111 = (v99 - SurfacePart.Position).Magnitude

            local v112 = GetSidePositionsOfPartAlongNormal(v100.Position, v100.CFrame, v103.SurfaceNormal, v100.Size)
            local v113, v114, v115, v116

            Magnitude = v111

            if v104.EdgeDistanceCalculations then
                v113 = ToNormalSpace(CFrame.new(v112.Top) * (v100.CFrame - v100.CFrame.Position), v99, v103.SurfaceNormal)
                v115 = v113.Y
                v116 = v113.Z

                local Magnitude2 = Vector3.new(0, v115, v116).Magnitude

                if not (Magnitude2 < 1e999) then
                    Magnitude2 = 1e999
                end

                v113 = ToNormalSpace(CFrame.new(v112.Bottom) * (v100.CFrame - v100.CFrame.Position), v99, v103.SurfaceNormal)
                v115 = v113.Y
                v116 = v113.Z
                Magnitude = Vector3.new(0, v115, v116).Magnitude

                if not (Magnitude < Magnitude2) then
                    Magnitude = Magnitude2
                end

                v113 = ToNormalSpace(CFrame.new(v112.Left) * (v100.CFrame - v100.CFrame.Position), v99, v103.SurfaceNormal)
                v114 = v113.X
                v116 = v113.Z
                Magnitude2 = Vector3.new(v114, 0, v116).Magnitude

                if not (Magnitude2 < Magnitude) then
                    Magnitude2 = Magnitude
                end

                v113 = ToNormalSpace(CFrame.new(v112.Right) * (v100.CFrame - v100.CFrame.Position), v99, v103.SurfaceNormal)
                v114 = v113.X
                v116 = v113.Z
                Magnitude = Vector3.new(v114, 0, v116).Magnitude

                if not (Magnitude < Magnitude2) then
                    Magnitude = Magnitude2
                end

                if not (Magnitude < v111) then
                    Magnitude = v111
                end
            end

            v113 = 1 / (v104.TextureSize.X * 2 / v104.EffectRadius)

            if Magnitude < v104.DistanceInner then
                SurfaceGui.Enabled = true
                v114 = v113
                v111 = v104.EffectRadius / v113
                v115 = v104.TextureSize.X * 2 / v104.EffectRadius
                v116 = (v104.EffectRadiusMin + (v104.EffectRadius - v104.EffectRadiusMin) * v113 * v115) * 2

                local v117 = SurfacePart.Size.Z

                SurfacePart.Size = Vector3.new(v116, v116, v117)
                v116 = GetSidePositionsOfPartAlongNormal(SurfacePart.Position, SurfacePart.CFrame, Enum.NormalId.Front, SurfacePart.Size)
                v115 = {}
                v115.Left = ToNormalSpace(v100.CFrame, v112.Left, v103.SurfaceNormal)
                v115.Right = ToNormalSpace(v100.CFrame, v112.Right, v103.SurfaceNormal)
                v115.Top = ToNormalSpace(v100.CFrame, v112.Top, v103.SurfaceNormal)
                v115.Bottom = ToNormalSpace(v100.CFrame, v112.Bottom, v103.SurfaceNormal)
                v110 = {}
                v110.Left = ToNormalSpace(v100.CFrame, v116.Left, v103.SurfaceNormal)
                v110.Right = ToNormalSpace(v100.CFrame, v116.Right, v103.SurfaceNormal)
                v110.Top = ToNormalSpace(v100.CFrame, v116.Top, v103.SurfaceNormal)
                v110.Bottom = ToNormalSpace(v100.CFrame, v116.Bottom, v103.SurfaceNormal)
                v116 = if v110.Left.X < v115.Left.X then 1 - (v115.Left.X - v110.Left.X) / SurfacePart.Size.X else 1

                local v118 = if v110.Right.X > v115.Right.X then 1 - (v110.Right.X - v115.Right.X) / SurfacePart.Size.X else 1
                local v119 = if v110.Bottom.Y < v115.Bottom.Y then 1 - (v115.Bottom.Y - v110.Bottom.Y) / SurfacePart.Size.Y else 1
                local v120 = if v110.Top.Y > v115.Top.Y then 1 - (v110.Top.Y - v115.Top.Y) / SurfacePart.Size.Y else 1

                if v120 < 0 or v119 < 0 or v116 < 0 or v118 < 0 then
                    SurfaceGui.Enabled = false
                else
                    v117 = 1 - (1 - v116 + (1 - v118))

                    local v121 = 1 - (1 - v120 + (1 - v119))
                    local v122 = if v116 <= v118 then 1 else -1
                    local v123 = if v119 <= v120 then 1 else -1
                    local v124 = SurfacePart.Size * Vector3.new(v117, v121, 1)
                    local v125, v126, v127, v128, v129

                    if v118 < 1 and v116 < 1 then
                        v127 = (v118 - v116) * 2
                        v128 = (SurfacePart.Size.X - v124.X) / 2 * v127
                        v129 = (v110.Right.X + v110.Left.X) / 2
                        v125 = (v115.Right.X + v115.Left.X) / 2
                        v126 = math.abs(v115.Right.X - v115.Left.X)
                        v128 -= v129 + v128 + v124.X - (v125 + v126)
                        v122 = v127 / ((1 - (v118 + v116 - 1)) * 2)
                    else
                        v128 = (SurfacePart.Size.X - v124.X) / 2 * v122
                    end

                    if v120 < 1 and v119 < 1 then
                        v118 = (v120 - v119) * 2
                        v127 = (SurfacePart.Size.Y - v124.Y) / 2 * v118
                        v116 = (v110.Top.Y + v110.Bottom.Y) / 2
                        v129 = (v115.Top.Y + v115.Bottom.Y) / 2
                        v126 = v115.Top.Y - v115.Bottom.Y
                        v125 = math.abs(v126)
                        v127 -= v116 + v127 + v124.Y - (v129 + v125)
                        v123 = v118 / ((1 - (v120 + v119 - 1)) * 2)
                    else
                        v127 = (SurfacePart.Size.Y - v124.Y) / 2 * v123
                    end

                    SurfacePart.CFrame *= CFrame.new(v128, v127, 0)
                    SurfacePart.Size = v124
                    SurfaceGui.ScaleFrame.Size = UDim2.new(1 / v117, 0, 1 / v121, 0)
                    SurfaceGui.ScaleFrame.Position = UDim2.new(0.5 - (1 - 1 / v117) / 2 * v122, 0, 0.5 - (1 - 1 / v121) / 2 * v123, 0)
                    v127 = if v113 > 1 then v113 else 1
                    v128 = math.min((1 - (v113 + (1 - v113))) / (0.8 - (1 - v113)), 1) * v127

                    if v128 < 0 then
                        v128 = 1
                    end

                    v127 = v104.TextureTransparency + (v104.TextureTransparencyMin - v104.TextureTransparency) * v128
                    v124 = v104.BackgroundTransparency + (v104.BackgroundTransparencyMin - v104.BackgroundTransparency) * v128
                    v128 = 1 / (v113 + (v113 - v113) * (v104.EffectRadiusMin / v104.EffectRadius))
                    v119 = SurfacePart.Position
                    v120 = v119 - v109 * v119:Dot(v109)
                    v129 = ToNormalSpace(v100.CFrame, v120, v103.SurfaceNormal)
                    v120 = (1 / v128 - 1) * 3 * v128
                    v115 = -(1 - v117) / 0.5 * v122
                    v122 = -(1 - v121) / 0.5 * v123
                    v123 = -v104.TextureOffset.X / v104.TextureSize.X * v128
                    v121 = v104.TextureSize.Y / v104.TextureSize.X
                    v117 = v121 - 1
                    v113 = -v104.TextureOffset.Y / v104.TextureSize.X * v128

                    for _, child in SurfaceGui.ScaleFrame:GetChildren() do
                        v109 = child.ScaleFrame.ImageLabel
                        v109.Image = v104.Texture
                        v109.ImageTransparency = v127
                        v109.ImageColor3 = v104.TextureColor
                        v109.BackgroundTransparency = v124
                        v109.BackgroundColor3 = v104.BackgroundColor
                        v107 = t8[tonumber(child.Name)]
                        SurfacePart = (1 / v128 - 1) * v128 * v107.OffsetX

                        local v130 = (1 / v128 - 1) * v128 * v107.OffsetY

                        v107 = v123 + SurfacePart + v115 + v120 + v129.X / (v111 / 2) * v128
                        SurfacePart = v113 + v130 + v122 + v120 + v129.Y / (v111 / 2) * v128

                        local v131 = UDim2.new
                        local v132 = 0.111 * v128

                        v109.TileSize = v131(math.max(v132, 0.001), 0, math.max(0.111 * v128 * v121, 0.001), 0)

                        if child.Name == "1" or child.Name == "2" or child.Name == "3" or child.Name == "4" then
                            SurfacePart -= v117 * v128
                        elseif child.Name == "9" or child.Name == "10" or child.Name == "11" or child.Name == "12" then
                            SurfacePart += v117 * v128
                        elseif child.Name == "13" or child.Name == "14" or child.Name == "15" or child.Name == "16" then
                            SurfacePart += v117 * v128 * 2
                        end

                        v130 = UpdateTextureOffset(v107, SurfacePart, v128, v128 * v121)
                        v107 = if v130.X.Scale > 4.5 then v130.X.Scale - 4.5 elseif v130.X.Scale < -3.5 then v130.X.Scale + 3.5 else 0
                        SurfacePart = if v130.Y.Scale > 4.5 then v130.Y.Scale - 4.5 elseif v130.Y.Scale < -3.5 then v130.Y.Scale + 3.5 else 0
                        v131 = Vector2.new(-v107, -SurfacePart)

                        if SurfacePart < 0 then
                            v131 = if v114 < 0.125 then Vector2.new(v131.X, -SurfacePart) else Vector2.new(v131.X, 1 * v128)
                        end

                        if v107 < 0 then
                            v131 = if v114 < 0.125 then Vector2.new(-v107, v131.Y) else Vector2.new(1 * v128, v131.Y)
                        end

                        v109.Position = UDim2.new(v130.X.Scale + v131.X, 0, v130.Y.Scale + v131.Y, 0)
                        v131 = {
                            2, 3, 5, 9, 8, 12, 14, 15
                        }
                        v130 = {
                            1, 4, 13, 16
                        }

                        local new = table.find
                        local v133 = child.Name

                        new = new(v131, (tonumber(v133)))

                        if new then
                            v132 = function() -- line: 972
                                -- upvalues: child (copy)
                                UpdateSideGradient(child)
                            end

                            pcall(v132)
                        else
                            new = table.find
                            v133 = child.Name

                            if new(v130, (tonumber(v133))) then
                                v132 = function() -- line: 976
                                    -- upvalues: child (copy)
                                    UpdateCornerGradient(child)
                                end

                                pcall(v132)
                            end
                        end
                    end
                end
            elseif Magnitude < v104.DistanceOuter then
                SurfaceGui.Enabled = true
                v116 = (Magnitude - v104.DistanceInner) / (v104.DistanceOuter - v104.DistanceInner)
                v114 = v113 - math.clamp(v116, 0, 1)
                v111 = v104.EffectRadius / v113
                v115 = v104.TextureSize.X * 2 / v104.EffectRadius
                v116 = (v104.EffectRadiusMin + (v104.EffectRadius - v104.EffectRadiusMin) * v114 * v115) * 2

                local v134 = SurfacePart.Size.Z

                SurfacePart.Size = Vector3.new(v116, v116, v134)
                v116 = GetSidePositionsOfPartAlongNormal(SurfacePart.Position, SurfacePart.CFrame, Enum.NormalId.Front, SurfacePart.Size)
                v115 = {}
                v115.Left = ToNormalSpace(v100.CFrame, v112.Left, v103.SurfaceNormal)
                v115.Right = ToNormalSpace(v100.CFrame, v112.Right, v103.SurfaceNormal)
                v115.Top = ToNormalSpace(v100.CFrame, v112.Top, v103.SurfaceNormal)
                v115.Bottom = ToNormalSpace(v100.CFrame, v112.Bottom, v103.SurfaceNormal)
                v110 = {}
                v110.Left = ToNormalSpace(v100.CFrame, v116.Left, v103.SurfaceNormal)
                v110.Right = ToNormalSpace(v100.CFrame, v116.Right, v103.SurfaceNormal)
                v110.Top = ToNormalSpace(v100.CFrame, v116.Top, v103.SurfaceNormal)
                v110.Bottom = ToNormalSpace(v100.CFrame, v116.Bottom, v103.SurfaceNormal)
                v116 = if v110.Left.X < v115.Left.X then 1 - (v115.Left.X - v110.Left.X) / SurfacePart.Size.X else 1

                local v135 = if v110.Right.X > v115.Right.X then 1 - (v110.Right.X - v115.Right.X) / SurfacePart.Size.X else 1
                local v136 = if v110.Bottom.Y < v115.Bottom.Y then 1 - (v115.Bottom.Y - v110.Bottom.Y) / SurfacePart.Size.Y else 1
                local v137 = if v110.Top.Y > v115.Top.Y then 1 - (v110.Top.Y - v115.Top.Y) / SurfacePart.Size.Y else 1

                if v137 < 0 or v136 < 0 or v116 < 0 or v135 < 0 then
                    SurfaceGui.Enabled = false
                else
                    v134 = 1 - (1 - v116 + (1 - v135))

                    local v138 = 1 - (1 - v137 + (1 - v136))
                    local v139 = if v116 <= v135 then 1 else -1
                    local v140 = if v136 <= v137 then 1 else -1
                    local v141 = SurfacePart.Size * Vector3.new(v134, v138, 1)
                    local v142, v143, v144, v145, v146

                    if v135 < 1 and v116 < 1 then
                        v144 = (v135 - v116) * 2
                        v145 = (SurfacePart.Size.X - v141.X) / 2 * v144
                        v146 = (v110.Right.X + v110.Left.X) / 2
                        v142 = (v115.Right.X + v115.Left.X) / 2
                        v143 = math.abs(v115.Right.X - v115.Left.X)
                        v145 -= v146 + v145 + v141.X - (v142 + v143)
                        v139 = v144 / ((1 - (v135 + v116 - 1)) * 2)
                    else
                        v145 = (SurfacePart.Size.X - v141.X) / 2 * v139
                    end

                    if v137 < 1 and v136 < 1 then
                        v135 = (v137 - v136) * 2
                        v144 = (SurfacePart.Size.Y - v141.Y) / 2 * v135
                        v116 = (v110.Top.Y + v110.Bottom.Y) / 2
                        v146 = (v115.Top.Y + v115.Bottom.Y) / 2
                        v143 = v115.Top.Y - v115.Bottom.Y
                        v142 = math.abs(v143)
                        v144 -= v116 + v144 + v141.Y - (v146 + v142)
                        v140 = v135 / ((1 - (v137 + v136 - 1)) * 2)
                    else
                        v144 = (SurfacePart.Size.Y - v141.Y) / 2 * v140
                    end

                    SurfacePart.CFrame *= CFrame.new(v145, v144, 0)
                    SurfacePart.Size = v141
                    SurfaceGui.ScaleFrame.Size = UDim2.new(1 / v134, 0, 1 / v138, 0)
                    SurfaceGui.ScaleFrame.Position = UDim2.new(0.5 - (1 - 1 / v134) / 2 * v139, 0, 0.5 - (1 - 1 / v138) / 2 * v140, 0)
                    v144 = if v113 > 1 then v113 else 1
                    v145 = math.min((1 - (v114 + (1 - v113))) / (0.8 - (1 - v113)), 1) * v144

                    if v145 < 0 then
                        v145 = 1
                    end

                    v144 = v104.TextureTransparency + (v104.TextureTransparencyMin - v104.TextureTransparency) * v145
                    v141 = v104.BackgroundTransparency + (v104.BackgroundTransparencyMin - v104.BackgroundTransparency) * v145
                    v145 = 1 / (v114 + (v113 - v114) * (v104.EffectRadiusMin / v104.EffectRadius))
                    v136 = SurfacePart.Position
                    v137 = v136 - v109 * v136:Dot(v109)
                    v146 = ToNormalSpace(v100.CFrame, v137, v103.SurfaceNormal)
                    v137 = (1 / v145 - 1) * 3 * v145
                    v115 = -(1 - v134) / 0.5 * v139
                    v139 = -(1 - v138) / 0.5 * v140
                    v140 = -v104.TextureOffset.X / v104.TextureSize.X * v145
                    v138 = v104.TextureSize.Y / v104.TextureSize.X
                    v134 = v138 - 1
                    v113 = -v104.TextureOffset.Y / v104.TextureSize.X * v145

                    for _, child in SurfaceGui.ScaleFrame:GetChildren() do
                        v109 = child.ScaleFrame.ImageLabel
                        v109.Image = v104.Texture
                        v109.ImageTransparency = v144
                        v109.ImageColor3 = v104.TextureColor
                        v109.BackgroundTransparency = v141
                        v109.BackgroundColor3 = v104.BackgroundColor
                        v107 = t8[tonumber(child.Name)]
                        SurfacePart = (1 / v145 - 1) * v145 * v107.OffsetX

                        local v147 = (1 / v145 - 1) * v145 * v107.OffsetY

                        v107 = v140 + SurfacePart + v115 + v137 + v146.X / (v111 / 2) * v145
                        SurfacePart = v113 + v147 + v139 + v137 + v146.Y / (v111 / 2) * v145

                        local v148 = UDim2.new
                        local v149 = 0.111 * v145

                        v109.TileSize = v148(math.max(v149, 0.001), 0, math.max(0.111 * v145 * v138, 0.001), 0)

                        if child.Name == "1" or child.Name == "2" or child.Name == "3" or child.Name == "4" then
                            SurfacePart -= v134 * v145
                        elseif child.Name == "9" or child.Name == "10" or child.Name == "11" or child.Name == "12" then
                            SurfacePart += v134 * v145
                        elseif child.Name == "13" or child.Name == "14" or child.Name == "15" or child.Name == "16" then
                            SurfacePart += v134 * v145 * 2
                        end

                        v147 = UpdateTextureOffset(v107, SurfacePart, v145, v145 * v138)
                        v107 = if v147.X.Scale > 4.5 then v147.X.Scale - 4.5 elseif v147.X.Scale < -3.5 then v147.X.Scale + 3.5 else 0
                        SurfacePart = if v147.Y.Scale > 4.5 then v147.Y.Scale - 4.5 elseif v147.Y.Scale < -3.5 then v147.Y.Scale + 3.5 else 0
                        v148 = Vector2.new(-v107, -SurfacePart)

                        if SurfacePart < 0 then
                            v148 = if v114 < 0.125 then Vector2.new(v148.X, -SurfacePart) else Vector2.new(v148.X, 1 * v145)
                        end

                        if v107 < 0 then
                            v148 = if v114 < 0.125 then Vector2.new(-v107, v148.Y) else Vector2.new(1 * v145, v148.Y)
                        end

                        v109.Position = UDim2.new(v147.X.Scale + v148.X, 0, v147.Y.Scale + v148.Y, 0)
                        v148 = {
                            2, 3, 5, 9, 8, 12, 14, 15
                        }
                        v147 = {
                            1, 4, 13, 16
                        }

                        local new = table.find
                        local v150 = child.Name

                        new = new(v148, (tonumber(v150)))

                        if new then
                            v149 = function() -- line: 972
                                -- upvalues: child (copy)
                                UpdateSideGradient(child)
                            end

                            pcall(v149)
                        else
                            new = table.find
                            v150 = child.Name

                            if new(v147, (tonumber(v150))) then
                                v149 = function() -- line: 976
                                    -- upvalues: child (copy)
                                    UpdateCornerGradient(child)
                                end

                                pcall(v149)
                            end
                        end
                    end
                end
            else
                SurfaceGui.Enabled = false
            end
        end
    end
end

return t1
