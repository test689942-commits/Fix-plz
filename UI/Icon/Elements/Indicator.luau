-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return function(p1, _) -- line: 1
    local widget = p1.widget
    local Contents = p1:getInstance("Contents")
    local Frame = Instance.new("Frame")

    Frame.Name = "Indicator"
    Frame.LayoutOrder = 9999999
    Frame.ZIndex = 6
    Frame.Size = UDim2.new(0, 42, 0, 42)
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 1
    Frame.Position = UDim2.new(1, 0, 0.5, 0)
    Frame.BorderSizePixel = 0
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.Parent = Contents

    local Frame2 = Instance.new("Frame")

    Frame2.Name = "IndicatorButton"
    Frame2.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame2.BorderSizePixel = 0
    Frame2.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame2.Parent = Frame

    local GuiService = game:GetService("GuiService")
    local GamepadService = game:GetService("GamepadService")
    local ClickRegion = p1:getInstance("ClickRegion")

    local function selectionChanged() -- line: 28
        -- upvalues: Frame2 (copy), GuiService (copy), ClickRegion (copy)
        if GuiService.SelectedObject == ClickRegion then
            Frame2.BackgroundTransparency = 1
            Frame2.Position = UDim2.new(0.5, -2, 0.5, 0)
            Frame2.Size = UDim2.fromScale(1.2, 1.2)
        else
            Frame2.BackgroundTransparency = 0.75
            Frame2.Position = UDim2.new(0.5, 2, 0.5, 0)
            Frame2.Size = UDim2.fromScale(1, 1)
        end
    end

    p1.janitor:add(GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(selectionChanged))
    selectionChanged()

    local ImageLabel = Instance.new("ImageLabel")

    ImageLabel.LayoutOrder = 2
    ImageLabel.ZIndex = 15
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    ImageLabel.Size = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Image = "rbxasset://textures/ui/Controls/XboxController/DPadUp@2x.png"
    ImageLabel.Parent = Frame2

    local UICorner = Instance.new("UICorner")

    UICorner.CornerRadius = UDim.new(0.1, 0)
    UICorner.Parent = Frame2

    local UserInputService = game:GetService("UserInputService")

    local function setIndicatorVisible(p3) -- line: 58
        -- upvalues: p1 (copy), Frame (copy), GamepadService (copy)
        local v1 = if p3 == nil then Frame.Visible else p3

        if GamepadService.GamepadCursorEnabled then
            v1 = false
        end

        if v1 then
            p1:modifyTheme({
                "PaddingRight",
                "Size",
                UDim2.new(0, 0, 1, 0)
            }, "IndicatorPadding")
        elseif Frame.Visible then
            p1:removeModification("IndicatorPadding")
        end

        p1:modifyTheme({
            "Indicator",
            "Visible",
            v1
        })
        p1.updateSize:Fire()
    end

    p1.janitor:add(GamepadService:GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(setIndicatorVisible))
    p1.indicatorSet:Connect(function(p4) -- line: 74
        -- upvalues: ImageLabel (copy), UserInputService (copy), setIndicatorVisible (copy)
        local v2

        if p4 then
            v2 = true
            ImageLabel.Image = UserInputService:GetImageForKeyCode(p4)
        else
            v2 = false
        end

        setIndicatorVisible(v2)
    end)

    local function updateSize() -- line: 83
        -- upvalues: widget (copy), Frame (copy)
        local v3 = widget.AbsoluteSize.Y * 0.96

        Frame.Size = UDim2.new(0, v3, 0, v3)
    end

    widget:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateSize)

    local v4 = widget.AbsoluteSize.Y * 0.96

    Frame.Size = UDim2.new(0, v4, 0, v4)

    return Frame
end
