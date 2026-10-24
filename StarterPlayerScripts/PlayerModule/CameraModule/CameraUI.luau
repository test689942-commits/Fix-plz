-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local function v1() -- line: 8
    return UserSettings():IsUserFeatureEnabled("UserEnableCameraToggleNotification")
end

local ok, result = pcall(v1)
local v2 = ok and result
local LocalPlayer = Players.LocalPlayer

if not LocalPlayer then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    LocalPlayer = Players.LocalPlayer
end

local PlayerGui = (function(p1, p2) -- waitForChildOfClass | line: 20
    local v3 = p1:FindFirstChildOfClass(p2)

    while true do
        if not v3 then
            v3 = p1.ChildAdded:Wait()
            continue
        end

        if v3.ClassName == p2 then
            break
        end

        v3 = p1.ChildAdded:Wait()
    end

    return v3
end)(LocalPlayer, "PlayerGui")
local v4 = UDim2.new(0, 326, 0, 58)
local v5 = UDim2.new(0, 80, 0, 58)
local v6 = Color3.fromRGB(32, 32, 32)
local v7 = Color3.fromRGB(200, 200, 200)

local function create(p3) -- line: 38
    return function(p4) -- line: 39
        -- upvalues: p3 (copy)
        local v8 = Instance.new(p3)
        local Parent = p4.Parent

        p4.Parent = nil

        for v9, v10 in pairs(p4) do
            if type(v9) == "string" then
                v8[v9] = v10
            else
                v10.Parent = v8
            end
        end

        v8.Parent = Parent

        return v8
    end
end

local v11 = false
local v12, Toast, Icon, Upper, Lower

local function initializeUI() -- line: 64
    -- upvalues: PlayerGui (copy), v5 (copy), v6 (copy), v7 (copy), v11 (ref), v12 (ref), Toast (ref), Icon (ref), Upper (ref), Lower (ref)
    assert(not v11, "initializeUI called when already initialized")

    local v14 = "ScreenGui"
    local v19 = "ImageLabel"
    local v28 = "Frame"
    local v35 = "ImageLabel"
    local v41 = "Frame"
    local v48 = "TextLabel"
    local v54 = "TextLabel"

    v12 = (function(p5) -- line: 39
        -- upvalues: v14 (copy)
        local v16 = Instance.new(v14)
        local Parent = p5.Parent

        p5.Parent = nil

        for v17, v18 in pairs(p5) do
            if type(v17) == "string" then
                v16[v17] = v18
            else
                v18.Parent = v16
            end
        end

        v16.Parent = Parent

        return v16
    end)({
        Name = "RbxCameraUI",
        AutoLocalize = false,
        Enabled = true,
        DisplayOrder = -1,
        IgnoreGuiInset = false,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        (function(p6) -- line: 39
            -- upvalues: v19 (copy)
            local v21 = Instance.new(v19)
            local Parent = p6.Parent

            p6.Parent = nil

            for v22, v23 in pairs(p6) do
                if type(v22) == "string" then
                    v21[v22] = v23
                else
                    v23.Parent = v21
                end
            end

            v21.Parent = Parent

            return v21
        end)({
            Name = "Toast",
            Visible = false,
            AnchorPoint = (Vector2.new(0.5, 0)),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = (UDim2.new(0.5, 0, 0, 8)),
            Size = v5,
            Image = "rbxasset://textures/ui/Camera/CameraToast9Slice.png",
            ImageColor3 = v6,
            ImageRectSize = (Vector2.new(6, 6)),
            ImageTransparency = 1,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = (Rect.new(3, 3, 3, 3)),
            ClipsDescendants = true,
            ((function(p7) -- line: 39
                -- upvalues: v28 (copy)
                local v30 = Instance.new(v28)
                local Parent = p7.Parent

                p7.Parent = nil

                for v31, v32 in pairs(p7) do
                    if type(v31) == "string" then
                        v30[v31] = v32
                    else
                        v32.Parent = v30
                    end
                end

                v30.Parent = Parent

                return v30
            end)({
                Name = "IconBuffer",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = (UDim2.new(0, 0, 0, 0)),
                Size = (UDim2.new(0, 80, 1, 0)),
                (function(p8) -- line: 39
                    -- upvalues: v35 (copy)
                    local v37 = Instance.new(v35)
                    local Parent = p8.Parent

                    p8.Parent = nil

                    for v38, v39 in pairs(p8) do
                        if type(v38) == "string" then
                            v37[v38] = v39
                        else
                            v39.Parent = v37
                        end
                    end

                    v37.Parent = Parent

                    return v37
                end)({
                    Name = "Icon",
                    BackgroundTransparency = 1,
                    ZIndex = 2,
                    Image = "rbxasset://textures/ui/Camera/CameraToastIcon.png",
                    ImageTransparency = 1,
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    Position = UDim2.new(0.5, 0, 0.5, 0),
                    Size = UDim2.new(0, 48, 0, 48),
                    ImageColor3 = v7
                })
            })),
            (function(p9) -- line: 39
                -- upvalues: v41 (copy)
                local v43 = Instance.new(v41)
                local Parent = p9.Parent

                p9.Parent = nil

                for v44, v45 in pairs(p9) do
                    if type(v44) == "string" then
                        v43[v44] = v45
                    else
                        v45.Parent = v43
                    end
                end

                v43.Parent = Parent

                return v43
            end)({
                Name = "TextBuffer",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = (UDim2.new(0, 80, 0, 0)),
                Size = (UDim2.new(1, -80, 1, 0)),
                ClipsDescendants = true,
                ((function(p10) -- line: 39
                    -- upvalues: v48 (copy)
                    local v50 = Instance.new(v48)
                    local Parent = p10.Parent

                    p10.Parent = nil

                    for v51, v52 in pairs(p10) do
                        if type(v51) == "string" then
                            v50[v51] = v52
                        else
                            v52.Parent = v50
                        end
                    end

                    v50.Parent = Parent

                    return v50
                end)({
                    Name = "Upper",
                    BackgroundTransparency = 1,
                    Text = "Camera control enabled",
                    TextTransparency = 1,
                    TextSize = 19,
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 0.5, 0),
                    Size = UDim2.new(1, 0, 0, 19),
                    Font = Enum.Font.GothamMedium,
                    TextColor3 = v7,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center
                })),
                (function(p11) -- line: 39
                    -- upvalues: v54 (copy)
                    local v56 = Instance.new(v54)
                    local Parent = p11.Parent

                    p11.Parent = nil

                    for v57, v58 in pairs(p11) do
                        if type(v57) == "string" then
                            v56[v57] = v58
                        else
                            v58.Parent = v56
                        end
                    end

                    v56.Parent = Parent

                    return v56
                end)({
                    Name = "Lower",
                    BackgroundTransparency = 1,
                    Text = "Right mouse button to toggle",
                    TextTransparency = 1,
                    TextSize = 15,
                    AnchorPoint = Vector2.new(0, 0),
                    Position = UDim2.new(0, 0, 0.5, 3),
                    Size = UDim2.new(1, 0, 0, 15),
                    Font = Enum.Font.Gotham,
                    TextColor3 = v7,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Center
                })
            })
        }),
        Parent = PlayerGui
    })
    Toast = v12.Toast
    Icon = Toast.IconBuffer.Icon
    Upper = Toast.TextBuffer.Upper
    Lower = Toast.TextBuffer.Lower
    v11 = true
end

local t2 = {}

function t2.setCameraModeToastEnabled(p12) -- line: 167
    -- upvalues: v2 (copy), v11 (ref), Toast (ref), initializeUI (copy), t2 (copy)
    if not (p12 or v11) then
        return
    end

    if not v11 then
        if v2 then
            v11 = true
        else
            initializeUI()
        end
    end

    if not v2 then
        Toast.Visible = p12
    end

    if not p12 then
        t2.setCameraModeToastOpen(false)
    end
end

local v59 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

function t2.setCameraModeToastOpen(p13) -- line: 192
    -- upvalues: TweenService (copy), StarterGui (copy), v2 (copy), v4 (copy), v5 (copy), v11 (ref), Toast (ref), Icon (ref), Upper (ref), Lower (ref), v59 (copy)
    assert(v11)

    if v2 then
        if p13 then
            StarterGui:SetCore("SendNotification", {
                Title = "Camera Control Enabled",
                Text = "Right click to toggle",
                Duration = 3
            })
        end
    else
        TweenService:Create(Toast, v59, {
            Size = p13 and v4 or v5,
            ImageTransparency = p13 and 0.4 or 1
        }):Play()
        TweenService:Create(Icon, v59, {
            ImageTransparency = p13 and 0 or 1
        }):Play()
        TweenService:Create(Upper, v59, {
            TextTransparency = p13 and 0 or 1
        }):Play()
        TweenService:Create(Lower, v59, {
            TextTransparency = p13 and 0 or 1
        }):Play()
    end
end

return t2
