-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local v1 = "rbxasset://textures/ui/traildot.png"
local v2 = "rbxasset://textures/ui/waypoint.png"
local v3 = false
local v4 = UDim2.new(0, 42, 0, 50)
local v5 = Vector2.new(0, 0.5)
local v6 = Vector2.new(0, 1)
local v7 = Vector2.new(0, 0.5)
local v8 = Vector2.new(0.1, 0.5)
local v9 = Vector2.new(-0.1, 0.5)
local v10 = Vector2.new(1.5, 1.5)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local function CreateWaypointTemplates() -- line: 44
    -- upvalues: v1 (ref), v2 (ref), v3 (ref), v4 (copy), v5 (copy), v7 (copy), v10 (ref)
    local Part = Instance.new("Part")

    Part.Size = Vector3.new(1, 1, 1)
    Part.Anchored = true
    Part.CanCollide = false
    Part.Name = "TrailDot"
    Part.Transparency = 1

    local ImageHandleAdornment = Instance.new("ImageHandleAdornment")

    ImageHandleAdornment.Name = "TrailDotImage"
    ImageHandleAdornment.Size = v10
    ImageHandleAdornment.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
    ImageHandleAdornment.AlwaysOnTop = v3
    ImageHandleAdornment.Image = v1
    ImageHandleAdornment.Adornee = Part
    ImageHandleAdornment.Parent = Part

    local Part2 = Instance.new("Part")

    Part2.Size = Vector3.new(2, 2, 2)
    Part2.Anchored = true
    Part2.CanCollide = false
    Part2.Name = "EndWaypoint"
    Part2.Transparency = 1

    local ImageHandleAdornment2 = Instance.new("ImageHandleAdornment")

    ImageHandleAdornment2.Name = "TrailDotImage"
    ImageHandleAdornment2.Size = v10
    ImageHandleAdornment2.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
    ImageHandleAdornment2.AlwaysOnTop = v3
    ImageHandleAdornment2.Image = v1
    ImageHandleAdornment2.Adornee = Part2
    ImageHandleAdornment2.Parent = Part2

    local BillboardGui = Instance.new("BillboardGui")

    BillboardGui.Name = "EndWaypointBillboard"
    BillboardGui.Size = v4
    BillboardGui.LightInfluence = 0
    BillboardGui.SizeOffset = v5
    BillboardGui.AlwaysOnTop = true
    BillboardGui.Adornee = Part2
    BillboardGui.Parent = Part2

    local ImageLabel = Instance.new("ImageLabel")

    ImageLabel.Image = v2
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Size = UDim2.new(1, 0, 1, 0)
    ImageLabel.Parent = BillboardGui

    local Part3 = Instance.new("Part")

    Part3.Size = Vector3.new(2, 2, 2)
    Part3.Anchored = true
    Part3.CanCollide = false
    Part3.Name = "FailureWaypoint"
    Part3.Transparency = 1

    local ImageHandleAdornment3 = Instance.new("ImageHandleAdornment")

    ImageHandleAdornment3.Name = "TrailDotImage"
    ImageHandleAdornment3.Size = v10
    ImageHandleAdornment3.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
    ImageHandleAdornment3.AlwaysOnTop = v3
    ImageHandleAdornment3.Image = v1
    ImageHandleAdornment3.Adornee = Part3
    ImageHandleAdornment3.Parent = Part3

    local BillboardGui2 = Instance.new("BillboardGui")

    BillboardGui2.Name = "FailureWaypointBillboard"
    BillboardGui2.Size = v4
    BillboardGui2.LightInfluence = 0
    BillboardGui2.SizeOffset = v7
    BillboardGui2.AlwaysOnTop = true
    BillboardGui2.Adornee = Part3
    BillboardGui2.Parent = Part3

    local Frame = Instance.new("Frame")

    Frame.BackgroundTransparency = 1
    Frame.Size = UDim2.new(0, 0, 0, 0)
    Frame.Position = UDim2.new(0.5, 0, 1, 0)
    Frame.Parent = BillboardGui2

    local ImageLabel2 = Instance.new("ImageLabel")

    ImageLabel2.Image = v2
    ImageLabel2.BackgroundTransparency = 1
    ImageLabel2.Position = UDim2.new(0, -v4.X.Offset / 2, 0, -v4.Y.Offset)
    ImageLabel2.Size = v4
    ImageLabel2.Parent = Frame

    return Part, Part2, Part3
end

local v11, v12, v13 = CreateWaypointTemplates()

local function getTrailDotParent() -- line: 130
    -- upvalues: Workspace (copy)
    local CurrentCamera = Workspace.CurrentCamera
    local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay")

    if not ClickToMoveDisplay then
        ClickToMoveDisplay = Instance.new("Model")
        ClickToMoveDisplay.Name = "ClickToMoveDisplay"
        ClickToMoveDisplay.Parent = CurrentCamera
    end

    return ClickToMoveDisplay
end

local function placePathWaypoint(p1, p2) -- line: 141
    -- upvalues: Workspace (copy), LocalPlayer (copy)
    local v15, v16, v17 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(p2 + Vector3.new(0, 2.5, 0), (Vector3.new(0, -10, 0))), {
        Workspace.CurrentCamera,
        LocalPlayer.Character
    })

    if not v15 then
        return
    end

    p1.CFrame = CFrame.new(v16, v16 + v17)

    local CurrentCamera = Workspace.CurrentCamera
    local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay")

    if not ClickToMoveDisplay then
        ClickToMoveDisplay = Instance.new("Model")
        ClickToMoveDisplay.Name = "ClickToMoveDisplay"
        ClickToMoveDisplay.Parent = CurrentCamera
    end

    p1.Parent = ClickToMoveDisplay
end

local t2 = {}

t2.__index = t2

function t2:Destroy() -- line: 156
    self.DisplayModel:Destroy()
end

function t2.NewDisplayModel(_, p5) -- line: 160
    -- upvalues: v11 (ref), placePathWaypoint (copy)
    local clone = v11:Clone()

    placePathWaypoint(clone, p5)

    return clone
end

function t2.new(p6, p7) -- line: 166
    -- upvalues: t2 (copy)
    local self = setmetatable({}, t2)

    self.DisplayModel = self:NewDisplayModel(p6)
    self.ClosestWayPoint = p7

    return self
end

local t4 = {}

t4.__index = t4

function t4:Destroy() -- line: 178
    self.Destroyed = true
    self.Tween:Cancel()
    self.DisplayModel:Destroy()
end

function t4.NewDisplayModel(_, p10) -- line: 184
    -- upvalues: v12 (ref), placePathWaypoint (copy)
    local clone = v12:Clone()

    placePathWaypoint(clone, p10)

    return clone
end

function t4:CreateTween() -- line: 190
    -- upvalues: v6 (copy), TweenService (copy)
    local v19 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true)
    local tween = TweenService:Create(self.DisplayModel.EndWaypointBillboard, v19, {
        SizeOffset = v6
    })

    tween:Play()

    return tween
end

function t4:TweenInFrom(p13) -- line: 201
    -- upvalues: TweenService (copy)
    local v20 = p13 - self.DisplayModel.Position

    self.DisplayModel.EndWaypointBillboard.StudsOffset = Vector3.new(0, v20.Y, 0)

    local v21 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local tween = TweenService:Create(self.DisplayModel.EndWaypointBillboard, v21, {
        StudsOffset = Vector3.new(0, 0, 0)
    })

    tween:Play()

    return tween
end

function t4.new(p14, p15, p16) -- line: 215
    -- upvalues: t4 (copy)
    local self = setmetatable({}, t4)

    self.DisplayModel = self:NewDisplayModel(p14)
    self.Destroyed = false

    if not (p16 and (p16 - p14).Magnitude > 5) then
        self.Tween = self:CreateTween()
    else
        self.Tween = self:TweenInFrom(p16)
        coroutine.wrap(function() -- line: 222
            -- upvalues: self (copy)
            self.Tween.Completed:Wait()

            if not self.Destroyed then
                self.Tween = self:CreateTween()
            end
        end)()
    end

    self.ClosestWayPoint = p15

    return self
end

local t6 = {}

t6.__index = t6

function t6:Hide() -- line: 239
    self.DisplayModel.Parent = nil
end

function t6:Destroy() -- line: 243
    self.DisplayModel:Destroy()
end

function t6.NewDisplayModel(_, p20) -- line: 247
    -- upvalues: Workspace (copy), LocalPlayer (copy), v13 (ref), placePathWaypoint (copy)
    local clone = v13:Clone()

    placePathWaypoint(clone, p20)

    local v24, v25, v26 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(p20 + Vector3.new(0, 2.5, 0), (Vector3.new(0, -10, 0))), {
        Workspace.CurrentCamera,
        LocalPlayer.Character
    })

    if v24 then
        clone.CFrame = CFrame.new(v25, v25 + v26)

        local CurrentCamera = Workspace.CurrentCamera
        local ClickToMoveDisplay = CurrentCamera:FindFirstChild("ClickToMoveDisplay")

        if not ClickToMoveDisplay then
            ClickToMoveDisplay = Instance.new("Model")
            ClickToMoveDisplay.Name = "ClickToMoveDisplay"
            ClickToMoveDisplay.Parent = CurrentCamera
        end

        clone.Parent = ClickToMoveDisplay
    end

    return clone
end

function t6:RunFailureTween() -- line: 261
    -- upvalues: v7 (copy), v8 (copy), v9 (copy), TweenService (copy)
    wait(0.125)

    local v27 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local tween = TweenService:Create(self.DisplayModel.FailureWaypointBillboard, v27, {
        SizeOffset = v8
    })

    tween:Play()
    TweenService:Create(self.DisplayModel.FailureWaypointBillboard.Frame, v27, {
        Rotation = 10
    }):Play()
    tween.Completed:wait()

    local v28 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true)
    local tween2 = TweenService:Create(self.DisplayModel.FailureWaypointBillboard, v28, {
        SizeOffset = v9
    })

    tween2:Play()

    local v29 = TweenInfo.new(0.125, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 3, true)

    TweenService:Create(self.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel, v29, {
        ImageColor3 = Color3.new(0.75, 0.75, 0.75)
    }):Play()
    TweenService:Create(self.DisplayModel.FailureWaypointBillboard.Frame, v29, {
        Rotation = -10
    }):Play()
    tween2.Completed:wait()

    local v30 = TweenInfo.new(0.0625, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local tween3 = TweenService:Create(self.DisplayModel.FailureWaypointBillboard, v30, {
        SizeOffset = v7
    })

    tween3:Play()
    TweenService:Create(self.DisplayModel.FailureWaypointBillboard.Frame, v30, {
        Rotation = 0
    }):Play()
    tween3.Completed:wait()
    wait(0.125)
end

function t6.new(p22) -- line: 310
    -- upvalues: t6 (copy)
    local self = setmetatable({}, t6)

    self.DisplayModel = self:NewDisplayModel(p22)

    return self
end

local Animation = Instance.new("Animation")

Animation.AnimationId = "rbxassetid://2874840706"

local track

local function getFailureAnimationTrack(p23) -- line: 324
    -- upvalues: Animation (copy), track (ref)
    if p23 == nil then
        return track
    end

    track = p23:LoadAnimation(Animation)
    assert(track, "")

    local track3 = track

    track3.Priority = Enum.AnimationPriority.Action
    track.Looped = false

    return track
end

local function findPlayerHumanoid() -- line: 335
    -- upvalues: LocalPlayer (copy)
    local Character = LocalPlayer.Character

    if Character then
        return Character:FindFirstChildOfClass("Humanoid")
    end
end

local function createTrailDots(p24, p25) -- line: 342
    -- upvalues: t2 (copy), t4 (copy)
    local t8 = {}
    local v32 = #p24 - 1
    local n1 = 1

    for i = 1, v32 do
        local v33 = (p24[i].Position - p24[#p24].Position).Magnitude < 3

        if i % 2 == 0 and not v33 then
            t8[n1] = t2.new(p24[i].Position, i)
            n1 += 1
        end
    end

    table.insert(t8, (t4.new(p24[#p24].Position, #p24, p25)))

    local t9 = {}
    local v35 = #t8
    local n2 = 1

    for i = v35, 1, -1 do
        t9[n2] = t8[i]
        n2 += 1
    end

    return t9
end

local function getTrailDotScale(p26, p27) -- line: 367
    return p27 * (math.clamp(p26 - 10, 0, 90) / 90 * 1.5 + 1)
end

local n3 = 0

function t1.CreatePathDisplay(p28, p29) -- line: 376
    -- upvalues: v10 (ref), RunService (copy), Workspace (copy), createTrailDots (copy), n3 (ref)
    n3 += 1

    local v37 = createTrailDots(p28, p29)

    local function removePathBeforePoint(p30) -- line: 380
        -- upvalues: v37 (copy)
        for i = #v37, 1, -1 do
            local v38 = v37[i]

            if not (v38.ClosestWayPoint <= p30) then
                break
            end

            v38:Destroy()
            v37[i] = nil
        end
    end

    local v39 = "ClickToMoveResizeTrail" .. n3

    local function resizeTrailDots() -- line: 394
        -- upvalues: v37 (copy), v39 (copy), v10 (ref), RunService (copy), Workspace (copy)
        if #v37 == 0 then
            RunService:UnbindFromRenderStep(v39)
        else
            local p = Workspace.CurrentCamera.CFrame.p

            for i = 1, #v37 do
                local TrailDotImage = v37[i].DisplayModel:FindFirstChild("TrailDotImage")

                if TrailDotImage then
                    local Magnitude = (v37[i].DisplayModel.Position - p).Magnitude

                    TrailDotImage.Size = v10 * (math.clamp(Magnitude - 10, 0, 90) / 90 * 1.5 + 1)
                end
            end
        end
    end

    RunService:BindToRenderStep(v39, Enum.RenderPriority.Camera.Value - 1, resizeTrailDots)

    return function() -- removePath | line: 410
        -- upvalues: p28 (copy), removePathBeforePoint (copy)
        removePathBeforePoint(#p28)
    end, removePathBeforePoint
end

local v42

function t1.DisplayFailureWaypoint(p31) -- line: 418
    -- upvalues: t6 (copy), v42 (ref)
    if v42 then
        v42:Hide()
    end

    local v43 = t6.new(p31)

    v42 = v43
    coroutine.wrap(function() -- line: 424
        -- upvalues: v43 (ref)
        v43:RunFailureTween()
        v43:Destroy()
        v43 = nil
    end)()
end

function t1.CreateEndWaypoint(p32) -- line: 431
    -- upvalues: t4 (copy)
    return t4.new(p32)
end

function t1.PlayFailureAnimation() -- line: 435
    -- upvalues: LocalPlayer (copy), Animation (copy), track (ref)
    local Character = LocalPlayer.Character
    local Humanoid = if Character then Character:FindFirstChildOfClass("Humanoid") else nil

    if not Humanoid then
        return
    end

    if Humanoid ~= nil then
        track = Humanoid:LoadAnimation(Animation)
        assert(track, "")
        track.Priority = Enum.AnimationPriority.Action
        track.Looped = false
    end

    track:Play()
end

function t1.CancelFailureAnimation() -- line: 443
    -- upvalues: track (ref)
    if track ~= nil and track.IsPlaying then
        track:Stop()
    end
end

function t1.SetWaypointTexture(p33) -- line: 449
    -- upvalues: v1 (ref), CreateWaypointTemplates (copy), v11 (ref), v12 (ref), v13 (ref)
    v1 = p33
    v11, v12, v13 = CreateWaypointTemplates()
end

function t1.GetWaypointTexture() -- line: 454
    -- upvalues: v1 (ref)
    return v1
end

function t1.SetWaypointRadius(p34) -- line: 458
    -- upvalues: v10 (ref), CreateWaypointTemplates (copy), v11 (ref), v12 (ref), v13 (ref)
    v10 = Vector2.new(p34, p34)
    v11, v12, v13 = CreateWaypointTemplates()
end

function t1.GetWaypointRadius() -- line: 463
    -- upvalues: v10 (ref)
    return v10.X
end

function t1.SetEndWaypointTexture(p35) -- line: 467
    -- upvalues: v2 (ref), CreateWaypointTemplates (copy), v11 (ref), v12 (ref), v13 (ref)
    v2 = p35
    v11, v12, v13 = CreateWaypointTemplates()
end

function t1.GetEndWaypointTexture() -- line: 472
    -- upvalues: v2 (ref)
    return v2
end

function t1.SetWaypointsAlwaysOnTop(p36) -- line: 476
    -- upvalues: v3 (ref), CreateWaypointTemplates (copy), v11 (ref), v12 (ref), v13 (ref)
    v3 = p36
    v11, v12, v13 = CreateWaypointTemplates()
end

function t1.GetWaypointsAlwaysOnTop() -- line: 481
    -- upvalues: v3 (ref)
    return v3
end

return t1
