-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return function(p1, p2) -- line: 6
    local Frame = Instance.new("Frame")

    Frame:SetAttribute("WidgetUID", p1.UID)
    Frame.Name = "Widget"
    Frame.BackgroundTransparency = 1
    Frame.Visible = true
    Frame.ZIndex = 20
    Frame.Active = false
    Frame.ClipsDescendants = true

    local Frame2 = Instance.new("Frame")

    Frame2.Name = "IconButton"
    Frame2.Visible = true
    Frame2.ZIndex = 2
    Frame2.BorderSizePixel = 0
    Frame2.Parent = Frame
    Frame2.ClipsDescendants = true
    Frame2.Active = false
    p1.deselected:Connect(function() -- line: 25
        -- upvalues: Frame2 (copy)
        Frame2.ClipsDescendants = true
    end)
    p1.selected:Connect(function() -- line: 28
        -- upvalues: p1 (copy), Frame2 (copy)
        task.defer(function() -- line: 29
            -- upvalues: p1 (copy), Frame2 (copy)
            p1.resizingComplete:Once(function() -- line: 30
                -- upvalues: p1 (copy), Frame2 (copy)
                if p1.isSelected then
                    Frame2.ClipsDescendants = false
                end
            end)
        end)
    end)

    local UICorner = Instance.new("UICorner")

    UICorner:SetAttribute("Collective", "IconCorners")
    UICorner.Parent = Frame2

    local v1 = require(script.Parent.Menu)(p1)
    local MenuUIListLayout, MenuGap = v1.MenuUIListLayout, v1.MenuGap

    v1.Parent = Frame2

    local Frame3 = Instance.new("Frame")

    Frame3.Name = "IconSpot"
    Frame3.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
    Frame3.BackgroundTransparency = 0.9
    Frame3.Visible = true
    Frame3.AnchorPoint = Vector2.new(0, 0.5)
    Frame3.ZIndex = 5
    Frame3.Parent = v1
    UICorner:Clone().Parent = Frame3

    local clone = Frame3:Clone()

    clone.Name = "IconOverlay"
    clone.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    clone.ZIndex = Frame3.ZIndex + 1
    clone.Size = UDim2.new(1, 0, 1, 0)
    clone.Position = UDim2.new(0, 0, 0, 0)
    clone.AnchorPoint = Vector2.new(0, 0)
    clone.Visible = false
    clone.Parent = Frame3

    local TextButton = Instance.new("TextButton")

    TextButton:SetAttribute("CorrespondingIconUID", p1.UID)
    TextButton.Name = "ClickRegion"
    TextButton.BackgroundTransparency = 1
    TextButton.Visible = true
    TextButton.Text = ""
    TextButton.ZIndex = 20
    TextButton.Selectable = true
    TextButton.SelectionGroup = true
    TextButton.Parent = Frame3
    require(script.Parent.Parent.Features.Gamepad).registerButton(TextButton)
    UICorner:Clone().Parent = TextButton

    local Frame4 = Instance.new("Frame")

    Frame4.Name = "Contents"
    Frame4.BackgroundTransparency = 1
    Frame4.Size = UDim2.fromScale(1, 1)
    Frame4.Parent = Frame3

    local UIListLayout = Instance.new("UIListLayout")

    UIListLayout.Name = "ContentsList"
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly
    UIListLayout.Padding = UDim.new(0, 3)
    UIListLayout.Parent = Frame4

    local Frame5 = Instance.new("Frame")

    Frame5.Name = "PaddingLeft"
    Frame5.LayoutOrder = 1
    Frame5.ZIndex = 5
    Frame5.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame5.BackgroundTransparency = 1
    Frame5.BorderSizePixel = 0
    Frame5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame5.Parent = Frame4

    local Frame6 = Instance.new("Frame")

    Frame6.Name = "PaddingCenter"
    Frame6.LayoutOrder = 3
    Frame6.ZIndex = 5
    Frame6.Size = UDim2.new(0, 0, 1, 0)
    Frame6.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame6.BackgroundTransparency = 1
    Frame6.BorderSizePixel = 0
    Frame6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame6.Parent = Frame4

    local Frame7 = Instance.new("Frame")

    Frame7.Name = "PaddingRight"
    Frame7.LayoutOrder = 5
    Frame7.ZIndex = 5
    Frame7.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame7.BackgroundTransparency = 1
    Frame7.BorderSizePixel = 0
    Frame7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame7.Parent = Frame4

    local Frame8 = Instance.new("Frame")

    Frame8.Name = "IconLabelContainer"
    Frame8.LayoutOrder = 4
    Frame8.ZIndex = 3
    Frame8.AnchorPoint = Vector2.new(0, 0.5)
    Frame8.Size = UDim2.new(0, 0, 0.5, 0)
    Frame8.BackgroundTransparency = 1
    Frame8.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame8.Parent = Frame4

    local TextLabel = Instance.new("TextLabel")
    local v2 = workspace.CurrentCamera.ViewportSize.X + 200

    TextLabel.Name = "IconLabel"
    TextLabel.LayoutOrder = 4
    TextLabel.ZIndex = 15
    TextLabel.AnchorPoint = Vector2.new(0, 0)
    TextLabel.Size = UDim2.new(0, v2, 1, 0)
    TextLabel.ClipsDescendants = false
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.fromScale(0, 0)
    TextLabel.RichText = true
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = ""
    TextLabel.TextWrapped = true
    TextLabel.TextWrap = true
    TextLabel.TextScaled = false
    TextLabel.Active = false
    TextLabel.AutoLocalize = true
    TextLabel.Parent = Frame8

    local ImageLabel = Instance.new("ImageLabel")

    ImageLabel.Name = "IconImage"
    ImageLabel.LayoutOrder = 2
    ImageLabel.ZIndex = 15
    ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
    ImageLabel.Size = UDim2.new(0, 0, 0.5, 0)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(0, 11, 0.5, 0)
    ImageLabel.ScaleType = Enum.ScaleType.Stretch
    ImageLabel.Active = false
    ImageLabel.Parent = Frame4

    local clone2 = UICorner:Clone()

    clone2:SetAttribute("Collective", nil)
    clone2.CornerRadius = UDim.new(0, 0)
    clone2.Name = "IconImageCorner"
    clone2.Parent = ImageLabel

    local TweenService = game:GetService("TweenService")
    local n1 = 0

    local function handleLabelAndImageChangesUnstaggered(_) -- line: 184
        -- upvalues: p1 (copy), p2 (copy), Frame (copy), Frame2 (copy), v1 (copy), MenuUIListLayout (copy), MenuGap (copy), Frame3 (copy), TextButton (copy), Frame4 (copy), UIListLayout (copy), Frame5 (copy), Frame6 (copy), Frame7 (copy), Frame8 (copy), TextLabel (copy), v2 (copy), ImageLabel (copy), TweenService (copy), n1 (ref)
        task.defer(function() -- line: 191
            -- upvalues: p1 (copy), p2 (copy), Frame (copy), Frame2 (copy), v1 (copy), MenuUIListLayout (copy), MenuGap (copy), Frame3 (copy), TextButton (copy), Frame4 (copy), UIListLayout (copy), Frame5 (copy), Frame6 (copy), Frame7 (copy), Frame8 (copy), TextLabel (copy), v2 (copy), ImageLabel (copy), TweenService (copy), n1 (ref)
            local indicator = p1.indicator
            local v3 = indicator and indicator.Visible
            local v4 = v3 or TextLabel.Text ~= ""
            local v5 = ImageLabel.Image ~= "" and ImageLabel.Image ~= nil
            local _ = Enum.HorizontalAlignment.Center
            local v6 = UDim2.fromScale(1, 1)

            if not v5 or v4 then
                if v5 or not v4 then
                    if v5 and v4 then
                        Frame8.Visible = true
                        ImageLabel.Visible = true
                        Frame5.Visible = true
                        Frame6.Visible = not v3
                        Frame7.Visible = not v3

                        local _ = Enum.HorizontalAlignment.Left
                    end
                else
                    Frame8.Visible = true
                    ImageLabel.Visible = false
                    Frame5.Visible = true
                    Frame6.Visible = false
                    Frame7.Visible = true
                end
            else
                Frame8.Visible = false
                ImageLabel.Visible = true
                Frame5.Visible = false
                Frame6.Visible = false
                Frame7.Visible = false
            end

            Frame2.Size = v6

            local function getItemWidth(p4) -- line: 221
                return p4:GetAttribute("TargetWidth") or p4.AbsoluteSize.X
            end

            local Offset = UIListLayout.Padding.Offset
            local X = TextLabel.TextBounds.X

            Frame8.Size = UDim2.new(0, X, TextLabel.Size.Y.Scale, 0)

            local v7 = Offset

            for _, child in pairs(Frame4:GetChildren()) do
                if child:IsA("GuiObject") and child.Visible == true then
                    v7 += getItemWidth(child) + Offset
                end
            end

            local MinimumWidth = Frame:GetAttribute("MinimumWidth")
            local MinimumHeight = Frame:GetAttribute("MinimumHeight")
            local BorderSize = Frame:GetAttribute("BorderSize")
            local v8 = math.clamp(v7, MinimumWidth, v2)
            local v9 = #p1.menuIcons > 0 and p1.isSelected
            local v10

            if v9 then
                local n2 = 0

                for _, child in pairs(v1:GetChildren()) do
                    if child ~= Frame3 and child:IsA("GuiObject") and child.Visible then
                        n2 += getItemWidth(child) + MenuUIListLayout.Padding.Offset
                    end
                end

                local v11 = if Frame3.Visible then v8 else v8 - ((Frame3:GetAttribute("TargetWidth") or Frame3.AbsoluteSize.X) + MenuUIListLayout.Padding.Offset * 2 + BorderSize)

                v10 = n2 - BorderSize * 0.5
                v8 = v11 + (v10 - BorderSize * 0.75)
            else
                v10 = 0
            end

            MenuGap.Visible = v9 and Frame3.Visible

            local DesiredWidth = Frame:GetAttribute("DesiredWidth")

            if not (DesiredWidth and v8 < DesiredWidth) then
                DesiredWidth = v8
            end

            p1.updateMenu:Fire()

            local v13 = math.max(DesiredWidth - v10, MinimumWidth) - BorderSize * 2
            local MenuWidth = v1:GetAttribute("MenuWidth")
            local v14 = MenuWidth and MenuWidth + v13 + MenuUIListLayout.Padding.Offset + 10
            local v15 = DesiredWidth

            if v14 then
                local MaxWidth = v1:GetAttribute("MaxWidth")
                local v16 = if MaxWidth then math.max(MaxWidth, MinimumWidth) else v14

                v1:SetAttribute("MenuCanvasWidth", DesiredWidth)

                if v16 < DesiredWidth then
                    v15 = v16
                end
            end

            local Quint = Enum.EasingStyle.Quint
            local Out = Enum.EasingDirection.Out
            local v18 = math.max(v13, Frame3:GetAttribute("TargetWidth") or Frame3.AbsoluteSize.X, Frame3.AbsoluteSize.X)
            local v20 = math.max(v15, Frame:GetAttribute("TargetWidth") or Frame.AbsoluteSize.X, Frame.AbsoluteSize.X)
            local v21 = TweenInfo.new(v18 / 750, Quint, Out)
            local v22 = TweenInfo.new(v20 / 750, Quint, Out)

            TweenService:Create(Frame3, v21, {
                Position = UDim2.new(0, BorderSize, 0.5, 0),
                Size = UDim2.new(0, v13, 1, -BorderSize * 2)
            }):Play()
            TweenService:Create(TextButton, v21, {
                Size = UDim2.new(0, v13, 1, 0)
            }):Play()

            local v23 = UDim2.fromOffset(v15, MinimumHeight)

            if Frame.Size.Y.Offset ~= MinimumHeight then
                Frame.Size = v23
            end

            Frame:SetAttribute("TargetWidth", v23.X.Offset)
            TweenService:Create(Frame, v22, {
                Size = v23
            }):Play()
            n1 += 1

            for i = 1, v22.Time * 100 do
                task.delay(i / 100, function() -- line: 303
                    -- upvalues: p1 (copy), p2 (copy)
                    p2.iconChanged:Fire(p1)
                end)
            end

            task.delay(v22.Time - 0.2, function() -- line: 307
                -- upvalues: p1 (copy), n1 (ref)
                n1 -= 1
                task.defer(function() -- line: 309
                    -- upvalues: p1 (copy), n1 (ref)
                    if n1 == 0 then
                        p1.resizingComplete:Fire()
                    end
                end)
            end)
            p1:updateParent()
        end)
    end

    local v24 = require(script.Parent.Parent.Utility).createStagger(0.01, handleLabelAndImageChangesUnstaggered)
    local v25 = true

    p1:setBehaviour("IconLabel", "Text", v24)
    p1:setBehaviour("IconLabel", "FontFace", function(p5) -- line: 322
        -- upvalues: TextLabel (copy), v24 (copy), v25 (ref)
        if TextLabel.FontFace ~= p5 then
            task.spawn(function() -- line: 327
                -- upvalues: v24 (copy), v25 (ref)
                v24()

                if v25 then
                    v25 = false

                    for _ = 1, 10 do
                        task.wait(1)
                        v24()
                    end
                end
            end)
        end
    end)

    local function updateBorderSize() -- line: 350
        -- upvalues: p1 (copy), Frame (copy), v1 (copy), MenuUIListLayout (copy), MenuGap (copy), Frame3 (copy), v24 (copy)
        task.defer(function() -- line: 351
            -- upvalues: p1 (copy), Frame (copy), v1 (copy), MenuUIListLayout (copy), MenuGap (copy), Frame3 (copy), v24 (copy)
            local BorderSize = Frame:GetAttribute("BorderSize")
            local alignment = p1.alignment
            local v26 = if Frame3.Visible == false then 0 else alignment == "Right" and -BorderSize or BorderSize

            v1.Position = UDim2.new(0, v26, 0, 0)
            MenuGap.Size = UDim2.fromOffset(BorderSize, 0)
            MenuUIListLayout.Padding = UDim.new(0, 0)
            v24()
        end)
    end

    p1:setBehaviour("Widget", "BorderSize", updateBorderSize)
    p1:setBehaviour("IconSpot", "Visible", updateBorderSize)
    p1.startMenuUpdate:Connect(v24)
    p1.updateSize:Connect(v24)
    p1:setBehaviour("ContentsList", "HorizontalAlignment", v24)
    p1:setBehaviour("Widget", "Visible", v24)
    p1:setBehaviour("Widget", "DesiredWidth", v24)
    p1:setBehaviour("Widget", "MinimumWidth", v24)
    p1:setBehaviour("Widget", "MinimumHeight", v24)
    p1:setBehaviour("Indicator", "Visible", v24)
    p1:setBehaviour("IconImageRatio", "AspectRatio", v24)
    p1:setBehaviour("IconImage", "Image", function(p6) -- line: 372
        -- upvalues: ImageLabel (copy), v24 (copy)
        local v28 = tonumber(p6) and "http://www.roblox.com/asset/?id=" .. p6 or p6 or ""

        if ImageLabel.Image ~= v28 then
            v24()
        end

        return v28
    end)
    p1.alignmentChanged:Connect(function(p7) -- line: 379
        -- upvalues: p1 (copy), Frame (copy), v1 (copy), MenuUIListLayout (copy), MenuGap (copy), Frame3 (copy), v24 (copy)
        local v29 = if p7 == "Center" then "Left" else p7

        MenuUIListLayout.HorizontalAlignment = Enum.HorizontalAlignment[v29]
        task.defer(function() -- line: 351
            -- upvalues: p1 (copy), Frame (copy), v1 (copy), MenuUIListLayout (copy), MenuGap (copy), Frame3 (copy), v24 (copy)
            local BorderSize = Frame:GetAttribute("BorderSize")
            local alignment = p1.alignment
            local v30 = if Frame3.Visible == false then 0 else alignment == "Right" and -BorderSize or BorderSize

            v1.Position = UDim2.new(0, v30, 0, 0)
            MenuGap.Size = UDim2.fromOffset(BorderSize, 0)
            MenuUIListLayout.Padding = UDim.new(0, 0)
            v24()
        end)
    end)

    local NumberValue = Instance.new("NumberValue")

    NumberValue.Name = "IconImageScale"
    NumberValue.Parent = ImageLabel
    NumberValue:GetPropertyChangedSignal("Value"):Connect(function() -- line: 390
        -- upvalues: ImageLabel (copy), NumberValue (copy)
        ImageLabel.Size = UDim2.new(NumberValue.Value, 0, NumberValue.Value, 0)
    end)

    local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

    UIAspectRatioConstraint.Name = "IconImageRatio"
    UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
    UIAspectRatioConstraint.DominantAxis = Enum.DominantAxis.Height
    UIAspectRatioConstraint.Parent = ImageLabel

    local UIGradient = Instance.new("UIGradient")

    UIGradient.Name = "IconGradient"
    UIGradient.Enabled = true
    UIGradient.Parent = Frame2

    local UIGradient2 = Instance.new("UIGradient")

    UIGradient2.Name = "IconSpotGradient"
    UIGradient2.Enabled = true
    UIGradient2.Parent = Frame3

    return Frame
end
