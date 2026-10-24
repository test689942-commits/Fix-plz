-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Players = game:GetService("Players")

require(script.Parent.TargetSelector)

local t1 = {}

t1.__index = t1

local v1 = Color3.fromRGB(0, 0, 255)
local v2 = Color3.fromRGB(255, 0, 0)

local function angleToCircleSize(p1) -- line: 13
    local CurrentCamera = workspace.CurrentCamera

    if not CurrentCamera then
        return 0
    end

    local v3 = math.rad(CurrentCamera.FieldOfView)
    local ViewportSize = CurrentCamera.ViewportSize
    local v5 = math.tan(v3 / 2) * 2
    local v8 = math.tan((math.rad(p1 / 2))) / v5

    return ViewportSize.Y * v8 * 2
end

function t1._createTargetDot(p2, p3) -- line: 32
    local Part = Instance.new("Part")

    Part.Material = Enum.Material.Plastic
    Part.Shape = Enum.PartType.Ball
    Part.Transparency = 1
    Part.Anchored = true
    Part.CanCollide = false
    Part.CanQuery = false
    Part.CanTouch = false
    Part.Parent = p2.dotsFolder

    local Highlight = Instance.new("Highlight")

    Highlight.Adornee = Part
    Highlight.Parent = Part
    Highlight.OutlineTransparency = 1
    Highlight.FillTransparency = 0.5
    p2.activeDots[p3] = {
        dot = Part
    }
end

function t1._ensureTargetDotsCreated(p4, p5) -- line: 57
    while #p4.activeDots < p5 do
        p4:_createTargetDot(#p4.activeDots + 1)
    end
end

function t1.clearTargetDots(p6) -- line: 64
    p6.dotsFolder:ClearAllChildren()
    p6.activeDots = {}
end

function t1.updateTargetDots(p7, p8, p9) -- line: 69
    -- upvalues: v1 (copy), v2 (copy)
    if workspace.CurrentCamera then
        local n1 = 0

        for _, v9 in p8 do
            if v9.instance then
                local v10 = n1

                for v11, v12 in v9.points do
                    v10 += 1
                    n1 = v10
                    p7:_ensureTargetDotsCreated(v10)

                    local v13 = p7.activeDots[v10]

                    v13.dot.Position = v12
                    v13.dot.Transparency = 0

                    local v14 = if p9 and v9.instance == p9.instance then p9.weights[v11] else 0

                    if v14 > 0 then
                        local v15 = v1:Lerp(v2, v14)

                        v13.dot.Size = Vector3.new(2, 2, 2)
                        v13.dot.Highlight.FillColor = v15
                        v13.dot.Color = v15
                    else
                        v13.dot.Size = Vector3.new(1.5, 1.5, 1.5)
                        v13.dot.Color = v1
                        v13.dot.Highlight.FillColor = v1
                    end
                end
            end
        end

        for i = n1 + 1, #p7.activeDots do
            p7.activeDots[i].dot.Transparency = 1
        end
    end
end

local function createCircleGui(p10) -- line: 117
    local Frame = Instance.new("Frame")

    Frame.Name = "AimAssistRangeCircle"
    Frame.BackgroundTransparency = 1
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.fromScale(0.5, 0.5)
    Frame.Size = UDim2.fromOffset(0, 0)
    Frame.Parent = p10

    local UIStroke = Instance.new("UIStroke")

    UIStroke.Color = Color3.new(1, 0, 0)
    UIStroke.Thickness = 1
    UIStroke.Transparency = 0.3
    UIStroke.Parent = Frame

    local UICorner = Instance.new("UICorner")

    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame

    return Frame
end

function t1.createVisualElements(p11) -- line: 144
    -- upvalues: Players (copy), createCircleGui (copy)
    local LocalPlayer = Players.LocalPlayer

    if not LocalPlayer then
        return
    end

    local ScreenGui = Instance.new("ScreenGui")

    ScreenGui.Name = "AimAssistDebugGui"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.Parent = LocalPlayer.PlayerGui

    local v16 = createCircleGui(ScreenGui)
    local TextLabel = Instance.new("TextLabel")

    TextLabel.Name = "RangeLabel"
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.5, 0, 1, 10)
    TextLabel.Size = UDim2.fromOffset(200, 20)
    TextLabel.AnchorPoint = Vector2.new(0.5, 0)
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextColor3 = Color3.new(1, 1, 1)
    TextLabel.TextSize = 16
    TextLabel.TextStrokeTransparency = 0.5
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    TextLabel.Text = "Aim Assist Disabled"
    TextLabel.Parent = v16

    local Folder = Instance.new("Folder")

    Folder.Parent = workspace
    Folder.Name = "TargetDotsFolder"
    p11.screenGui = ScreenGui
    p11.circle = v16
    p11.rangeLabel = TextLabel
    p11.dotsFolder = Folder
    p11.activeDots = {}
end

function t1.update(p12, p13, p14, p15) -- line: 188
    if not (p12.screenGui and p12.dotsFolder) then
        return
    end

    if p13 then
        local v17 = Color3.new(1, 0, 0)
        local v18 = Color3.new(0, 0, 1)

        p12.circle.UIStroke.Color = v17:Lerp(v18, p13.normalizedAngle)
        p12.rangeLabel.Text = string.format("Aim Assist Angle: %.1f°\nAim Assist Depth: %.1f", p13.angle, p13.distance)
    else
        p12.circle.UIStroke.Color = Color3.new(1, 1, 1)
        p12.rangeLabel.Text = "Aim Assist Disabled"
    end

    local CurrentCamera = workspace.CurrentCamera
    local v19 = 0

    if CurrentCamera then
        local v20 = math.rad(CurrentCamera.FieldOfView)
        local ViewportSize = CurrentCamera.ViewportSize
        local v22 = math.tan(v20 / 2) * 2
        local v25 = math.tan((math.rad(p14 / 2))) / v22

        v19 = ViewportSize.Y * v25 * 2
    end

    p12.circle.Size = UDim2.fromOffset(v19, v19)
    p12:updateTargetDots(p15, p13)
end

function t1.destroy(p16) -- line: 217
    local screenGui = p16.screenGui

    p16.screenGui = nil

    if screenGui then
        screenGui:Destroy()
    end

    local dotsFolder = p16.dotsFolder

    p16.dotsFolder = nil

    if dotsFolder then
        dotsFolder:Destroy()
    end
end

function t1.new() -- line: 231
    -- upvalues: t1 (copy)
    local t2 = {
        screenGui = nil,
        dotsFolder = nil
    }

    setmetatable(t2, t1)

    return t2
end

return t1
