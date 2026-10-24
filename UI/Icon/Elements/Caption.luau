-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return function(p1) -- line: 1
    local ClickRegion = p1:getInstance("ClickRegion")
    local CanvasGroup = Instance.new("CanvasGroup")

    CanvasGroup.Name = "Caption"
    CanvasGroup.AnchorPoint = Vector2.new(0.5, 0)
    CanvasGroup.BackgroundTransparency = 1
    CanvasGroup.BorderSizePixel = 0
    CanvasGroup.GroupTransparency = 1
    CanvasGroup.Position = UDim2.fromOffset(0, 0)
    CanvasGroup.Visible = true
    CanvasGroup.ZIndex = 30
    CanvasGroup.Parent = ClickRegion

    local Frame = Instance.new("Frame")

    Frame.Name = "Box"
    Frame.AutomaticSize = Enum.AutomaticSize.XY
    Frame.BackgroundColor3 = Color3.fromRGB(101, 102, 104)
    Frame.Position = UDim2.fromOffset(4, 7)
    Frame.ZIndex = 12
    Frame.Parent = CanvasGroup

    local TextLabel = Instance.new("TextLabel")

    TextLabel.Name = "Header"
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    TextLabel.Text = "Caption"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 14
    TextLabel.TextTruncate = Enum.TextTruncate.None
    TextLabel.TextWrapped = false
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.BackgroundTransparency = 1
    TextLabel.LayoutOrder = 1
    TextLabel.Size = UDim2.fromOffset(0, 16)
    TextLabel.ZIndex = 18
    TextLabel.Parent = Frame

    local UIListLayout = Instance.new("UIListLayout")

    UIListLayout.Name = "Layout"
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = Frame

    local UICorner = Instance.new("UICorner")

    UICorner.Name = "CaptionCorner"
    UICorner.Parent = Frame

    local UIPadding = Instance.new("UIPadding")

    UIPadding.Name = "Padding"
    UIPadding.PaddingBottom = UDim.new(0, 12)
    UIPadding.PaddingLeft = UDim.new(0, 12)
    UIPadding.PaddingRight = UDim.new(0, 12)
    UIPadding.PaddingTop = UDim.new(0, 12)
    UIPadding.Parent = Frame

    local Frame2 = Instance.new("Frame")

    Frame2.Name = "Hotkeys"
    Frame2.AutomaticSize = Enum.AutomaticSize.Y
    Frame2.BackgroundTransparency = 1
    Frame2.LayoutOrder = 3
    Frame2.Size = UDim2.fromScale(1, 0)
    Frame2.Visible = false
    Frame2.Parent = Frame

    local UIListLayout2 = Instance.new("UIListLayout")

    UIListLayout2.Name = "Layout1"
    UIListLayout2.Padding = UDim.new(0, 6)
    UIListLayout2.FillDirection = Enum.FillDirection.Vertical
    UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout2.HorizontalFlex = Enum.UIFlexAlignment.None
    UIListLayout2.ItemLineAlignment = Enum.ItemLineAlignment.Automatic
    UIListLayout2.VerticalFlex = Enum.UIFlexAlignment.None
    UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout2.Parent = Frame2

    local ImageLabel = Instance.new("ImageLabel")

    ImageLabel.Name = "Key1"
    ImageLabel.Image = "rbxasset://textures/ui/Controls/key_single.png"
    ImageLabel.ImageTransparency = 0.7
    ImageLabel.ScaleType = Enum.ScaleType.Slice
    ImageLabel.SliceCenter = Rect.new(5, 5, 23, 24)
    ImageLabel.AutomaticSize = Enum.AutomaticSize.X
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.LayoutOrder = 1
    ImageLabel.Size = UDim2.fromOffset(0, 30)
    ImageLabel.ZIndex = 15
    ImageLabel.Parent = Frame2

    local UIPadding2 = Instance.new("UIPadding")

    UIPadding2.Name = "Inset"
    UIPadding2.PaddingLeft = UDim.new(0, 8)
    UIPadding2.PaddingRight = UDim.new(0, 8)
    UIPadding2.Parent = ImageLabel

    local TextLabel2 = Instance.new("TextLabel")

    TextLabel2.AutoLocalize = false
    TextLabel2.Name = "LabelContent"
    TextLabel2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
    TextLabel2.Text = ""
    TextLabel2.TextColor3 = Color3.fromRGB(189, 190, 190)
    TextLabel2.TextSize = 14
    TextLabel2.AutomaticSize = Enum.AutomaticSize.X
    TextLabel2.BackgroundTransparency = 1
    TextLabel2.Position = UDim2.fromOffset(0, -1)
    TextLabel2.Size = UDim2.fromScale(1, 1)
    TextLabel2.ZIndex = 16
    TextLabel2.Parent = ImageLabel

    local ImageLabel2 = Instance.new("ImageLabel")

    ImageLabel2.Name = "Caret"
    ImageLabel2.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png"
    ImageLabel2.ImageColor3 = Color3.fromRGB(101, 102, 104)
    ImageLabel2.ImageRectOffset = Vector2.new(260, 440)
    ImageLabel2.ImageRectSize = Vector2.new(16, 8)
    ImageLabel2.AnchorPoint = Vector2.new(0, 0.5)
    ImageLabel2.BackgroundTransparency = 1
    ImageLabel2.Position = UDim2.new(0, 0, 0, 4)
    ImageLabel2.Rotation = 180
    ImageLabel2.Size = UDim2.fromOffset(16, 8)
    ImageLabel2.ZIndex = 12
    ImageLabel2.Parent = CanvasGroup

    local ImageLabel3 = Instance.new("ImageLabel")

    ImageLabel3.Name = "DropShadow"
    ImageLabel3.Image = "rbxasset://LuaPackages/Packages/_Index/UIBlox/UIBlox/AppImageAtlas/img_set_1x_1.png"
    ImageLabel3.ImageColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel3.ImageRectOffset = Vector2.new(217, 486)
    ImageLabel3.ImageRectSize = Vector2.new(25, 25)
    ImageLabel3.ImageTransparency = 0.45
    ImageLabel3.ScaleType = Enum.ScaleType.Slice
    ImageLabel3.SliceCenter = Rect.new(12, 12, 13, 13)
    ImageLabel3.BackgroundTransparency = 1
    ImageLabel3.Position = UDim2.fromOffset(0, 5)
    ImageLabel3.Size = UDim2.new(1, 0, 0, 48)
    ImageLabel3.Parent = CanvasGroup
    Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 147
        -- upvalues: Frame (copy), ImageLabel3 (copy)
        ImageLabel3.Size = UDim2.new(1, 0, 0, Frame.AbsoluteSize.Y + 8)
    end)

    local captionJanitor = p1.captionJanitor
    local _, v1 = p1:clipOutside(CanvasGroup)

    v1.AutomaticSize = Enum.AutomaticSize.None

    local function matchSize() -- line: 157
        -- upvalues: CanvasGroup (copy), v1 (copy)
        local AbsoluteSize = CanvasGroup.AbsoluteSize

        v1.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
    end

    captionJanitor:add(CanvasGroup:GetPropertyChangedSignal("AbsoluteSize"):Connect(matchSize))

    local AbsoluteSize = CanvasGroup.AbsoluteSize

    v1.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)

    local v2 = false
    local Header = CanvasGroup.Box.Header
    local UserInputService = game:GetService("UserInputService")

    local function updateHotkey(p2) -- line: 170
        -- upvalues: p1 (copy), CanvasGroup (copy), Frame2 (copy), TextLabel2 (copy), Header (copy), UserInputService (copy)
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local v3 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v4 = v3 == "_hotkey_"

        if not KeyboardEnabled and v4 then
            p1:setCaption()

            return
        end

        Header.Text = v3
        Header.Visible = not v4

        if p2 then
            TextLabel2.Text = p2.Name
            Frame2.Visible = true
        end

        if not KeyboardEnabled then
            Frame2.Visible = false
        end
    end

    CanvasGroup:GetAttributeChangedSignal("CaptionText"):Connect(updateHotkey)

    local Quad = Enum.EasingStyle.Quad
    local v5 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.In)
    local v6 = TweenInfo.new(0.2, Quad, Enum.EasingDirection.Out)
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")

    local function getCaptionPosition(p3) -- line: 196
        -- upvalues: v2 (ref)
        local v7 = if if p3 == nil then v2 else p3 then 10 else 2

        return UDim2.new(0.5, 0, 1, v7)
    end

    local function updatePosition(p4) -- line: 203
        -- upvalues: ClickRegion (copy), CanvasGroup (copy), ImageLabel2 (copy), v1 (copy), v2 (ref), v5 (copy), v6 (copy), TweenService (copy), RunService (copy)
        if not v2 then
            return
        end

        local v8 = if p4 == nil then v2 else p4
        local v9 = not v8

        if v9 == nil then
            v9 = v2
        end

        local v10 = if v9 then 10 else 2
        local v11 = UDim2.new(0.5, 0, 1, v10)
        local v12 = if if v8 == nil then v2 else v8 then 10 else 2
        local v13 = UDim2.new(0.5, 0, 1, v12)

        if v8 then
            local Offset = ImageLabel2.Position.Y.Offset

            ImageLabel2.Position = UDim2.fromOffset(0, Offset)
            CanvasGroup.AutomaticSize = Enum.AutomaticSize.XY
            CanvasGroup.Size = UDim2.fromOffset(32, 53)
        else
            local AbsoluteSize = CanvasGroup.AbsoluteSize

            CanvasGroup.AutomaticSize = Enum.AutomaticSize.Y
            CanvasGroup.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
        end

        local v14

        local function updateCaret() -- line: 232
            -- upvalues: v14 (ref), ClickRegion (copy), CanvasGroup (copy), ImageLabel2 (copy)
            local v15 = ClickRegion.AbsolutePosition.X - CanvasGroup.AbsolutePosition.X + ClickRegion.AbsoluteSize.X / 2 - ImageLabel2.AbsoluteSize.X / 2
            local Offset = ImageLabel2.Position.Y.Offset
            local v16 = UDim2.fromOffset(v15, Offset)

            if v14 ~= v15 then
                v14 = v15
                ImageLabel2.Position = UDim2.fromOffset(0, Offset)
                task.wait()
            end

            ImageLabel2.Position = v16
        end

        v1.Position = v11
        updateCaret()

        local tween = TweenService:Create(v1, v8 and v5 or v6, {
            Position = v13
        })
        local connection = RunService.Heartbeat:Connect(updateCaret)

        tween:Play()
        tween.Completed:Once(function() -- line: 255
            -- upvalues: connection (copy)
            connection:Disconnect()
        end)
    end

    captionJanitor:add(ClickRegion:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 260
        -- upvalues: updatePosition (copy)
        updatePosition()
    end))
    updatePosition(false)
    captionJanitor:add(p1.toggleKeyAdded:Connect(updateHotkey))

    for v18, _ in pairs(p1.bindedToggleKeys) do
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local v19 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v20 = v19 == "_hotkey_"
        local v21 = false

        if KeyboardEnabled then
            Header.Text = v19
            Header.Visible = not v20

            if v18 then
                TextLabel2.Text = v18.Name
                Frame2.Visible = true
            end
        elseif v20 then
            v21 = true
        else
            Header.Text = v19
            Header.Visible = not v20

            if v18 then
                TextLabel2.Text = v18.Name
                Frame2.Visible = true
            end
        end

        if v21 then
            p1:setCaption()
        elseif not KeyboardEnabled then
            Frame2.Visible = false
        end

        break
    end

    captionJanitor:add(p1.fakeToggleKeyChanged:Connect(updateHotkey))

    local fakeToggleKey = p1.fakeToggleKey

    if fakeToggleKey then
        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local v22 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v23 = v22 == "_hotkey_"
        local v24

        if KeyboardEnabled then
            Header.Text = v22
            Header.Visible = not v23
            TextLabel2.Text = fakeToggleKey.Name
            v24 = false
            Frame2.Visible = true
        elseif v23 then
            v24 = true
        else
            Header.Text = v22
            Header.Visible = not v23
            TextLabel2.Text = fakeToggleKey.Name
            v24 = false
            Frame2.Visible = true
        end

        if v24 then
            p1:setCaption()
        elseif not KeyboardEnabled then
            Frame2.Visible = false
        end
    end

    local function setCaptionEnabled(p5) -- line: 276
        -- upvalues: p1 (copy), CanvasGroup (copy), Frame2 (copy), v2 (ref), Header (copy), UserInputService (copy), v5 (copy), v6 (copy), TweenService (copy), updatePosition (copy)
        if v2 == p5 then
            return
        end

        local joinedFrame = p1.joinedFrame
        local v25 = (not joinedFrame or not string.match(joinedFrame.Name, "Dropdown")) and p5

        v2 = v25

        local v26, v27

        if v25 then
            v27 = 0
            v26 = v5
        else
            v27 = 1
        end

        if not v25 or not v26 then
            v26 = v6
        end

        TweenService:Create(CanvasGroup, v26, {
            GroupTransparency = v27
        }):Play()
        updatePosition()

        local KeyboardEnabled = UserInputService.KeyboardEnabled
        local v28 = CanvasGroup:GetAttribute("CaptionText") or ""
        local v29 = v28 == "_hotkey_"

        if not KeyboardEnabled and v29 then
            p1:setCaption()

            return
        end

        Header.Text = v28
        Header.Visible = not v29

        if not KeyboardEnabled then
            Frame2.Visible = false
        end
    end

    local iconModule = require(p1.iconModule)

    captionJanitor:add(p1.stateChanged:Connect(function(p6) -- line: 298
        -- upvalues: p1 (copy), setCaptionEnabled (copy), iconModule (copy)
        if p6 ~= "Viewing" then
            iconModule.captionLastClosedClock = os.clock()
            setCaptionEnabled(false)

            return
        end

        local captionLastClosedClock = iconModule.captionLastClosedClock
        local v30 = (captionLastClosedClock and os.clock() - captionLastClosedClock or 999) < 0.3 and 0 or 0.5

        task.delay(v30, function() -- line: 303
            -- upvalues: p1 (copy), setCaptionEnabled (copy)
            if p1.activeState == "Viewing" then
                setCaptionEnabled(true)
            end
        end)
    end))

    return CanvasGroup
end
