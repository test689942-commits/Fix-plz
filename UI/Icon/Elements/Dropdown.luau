-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return function(p1) -- line: 1
    local Frame = Instance.new("Frame")

    Frame.Name = "Dropdown"
    Frame.AutomaticSize = Enum.AutomaticSize.XY
    Frame.BackgroundTransparency = 1
    Frame.BorderSizePixel = 0
    Frame.AnchorPoint = Vector2.new(0.5, 0)
    Frame.Position = UDim2.new(0.5, 0, 1, 10)
    Frame.ZIndex = -2
    Frame.ClipsDescendants = true
    Frame.Parent = p1.widget

    local UICorner = Instance.new("UICorner")

    UICorner.Name = "DropdownCorner"
    UICorner.CornerRadius = UDim.new(0.1, 0)
    UICorner.Parent = Frame

    local ScrollingFrame = Instance.new("ScrollingFrame")

    ScrollingFrame.Name = "DropdownScroller"
    ScrollingFrame.AutomaticSize = Enum.AutomaticSize.X
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.AnchorPoint = Vector2.new(0, 0)
    ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.ZIndex = -1
    ScrollingFrame.ClipsDescendants = true
    ScrollingFrame.Visible = true
    ScrollingFrame.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
    ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
    ScrollingFrame.Active = false
    ScrollingFrame.ScrollingEnabled = true
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ScrollingFrame.ScrollBarThickness = 5
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrame.ScrollBarImageTransparency = 0.8
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingFrame.Selectable = false
    ScrollingFrame.Active = true
    ScrollingFrame.Parent = Frame

    local UIPadding = Instance.new("UIPadding")

    UIPadding.Name = "DropdownPadding"
    UIPadding.PaddingTop = UDim.new(0, 8)
    UIPadding.PaddingBottom = UDim.new(0, 8)
    UIPadding.Parent = ScrollingFrame

    local UIListLayout = Instance.new("UIListLayout")

    UIListLayout.Name = "DropdownList"
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly
    UIListLayout.Parent = ScrollingFrame

    local dropdownJanitor = p1.dropdownJanitor
    local iconModule = require(p1.iconModule)

    p1.dropdownChildAdded:Connect(function(p2) -- line: 58
        local _, v1 = p2:modifyTheme({
            { "Widget", "BorderSize", 0 },
            {
                "IconCorners",
                "CornerRadius",
                UDim.new(0, 4)
            },
            { "Widget", "MinimumWidth", 190 },
            { "Widget", "MinimumHeight", 56 },
            { "IconLabel", "TextSize", 19 },
            {
                "PaddingLeft",
                "Size",
                UDim2.fromOffset(25, 0)
            },
            {
                "Notice",
                "Position",
                UDim2.new(1, -24, 0, 5)
            },
            {
                "ContentsList",
                "HorizontalAlignment",
                Enum.HorizontalAlignment.Left
            },
            {
                "Selection",
                "Size",
                UDim2.new(1, -8, 1, -8)
            },
            {
                "Selection",
                "Position",
                UDim2.new(0, 4, 0, 4)
            }
        })

        task.defer(function() -- line: 72
            -- upvalues: p2 (copy), v1 (copy)
            p2.joinJanitor:add(function() -- line: 73
                -- upvalues: p2 (copy), v1 (copy)
                p2:removeModification(v1)
            end)
        end)
    end)
    p1.dropdownSet:Connect(function(p3) -- line: 78
        -- upvalues: p1 (copy), iconModule (copy)
        for _, v2 in pairs(p1.dropdownIcons) do
            iconModule.getIconByUID(v2):destroy()
        end

        local _ = #p3

        if type(p3) == "table" then
            for _, v3 in pairs(p3) do
                v3:joinDropdown(p1)
            end
        end
    end)

    local Utility = require(script.Parent.Parent.Utility)

    local function updateVisibility() -- line: 95
        -- upvalues: p1 (copy), Frame (copy), Utility (copy)
        Utility.setVisible(Frame, p1.isSelected, "InternalDropdown")
    end

    dropdownJanitor:add(p1.toggled:Connect(updateVisibility))
    Utility.setVisible(Frame, p1.isSelected, "InternalDropdown")

    local n1 = 0
    local v4 = false

    local function updateMaxIcons() -- line: 107
        -- upvalues: p1 (copy), Frame (copy), ScrollingFrame (copy), UIPadding (copy), iconModule (copy), n1 (ref), v4 (ref), updateMaxIcons (copy)
        n1 += 1

        if v4 then
            return
        end

        local v5 = n1

        v4 = true
        task.defer(function() -- line: 116
            -- upvalues: v5 (copy), n1 (ref), v4 (ref), updateMaxIcons (copy)
            v4 = false

            if n1 ~= v5 then
                updateMaxIcons()
            end
        end)

        local MaxIcons = Frame:GetAttribute("MaxIcons")

        if not MaxIcons then
            return
        end

        local t1 = {}

        for _, child in pairs(ScrollingFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                table.insert(t1, {
                    child,
                    child.AbsolutePosition.Y
                })
            end
        end

        table.sort(t1, function(p4, p5) -- line: 133
            return p4[2] < p5[2]
        end)

        local n2 = 0
        local v6 = false

        for i = 1, MaxIcons do
            local v7 = t1[i]

            if not v7 then
                break
            end

            local v8 = v7[1]

            n2 += v8.AbsoluteSize.Y

            local WidgetUID = v8:GetAttribute("WidgetUID")
            local v9 = WidgetUID and iconModule.getIconByUID(WidgetUID)

            if v9 then
                local v10, v11

                if v6 then
                    v11 = v6
                else
                    v11 = true
                    v10 = p1:getInstance("ClickRegion")
                end

                v6 = v11
                v9:getInstance("ClickRegion").NextSelectionUp = v10
            end
        end

        local v12 = n2 + UIPadding.PaddingTop.Offset + UIPadding.PaddingBottom.Offset

        ScrollingFrame.Size = UDim2.fromOffset(0, v12)
    end

    dropdownJanitor:add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(updateMaxIcons))
    dropdownJanitor:add(ScrollingFrame.ChildAdded:Connect(updateMaxIcons))
    dropdownJanitor:add(ScrollingFrame.ChildRemoved:Connect(updateMaxIcons))
    dropdownJanitor:add(Frame:GetAttributeChangedSignal("MaxIcons"):Connect(updateMaxIcons))
    dropdownJanitor:add(p1.childThemeModified:Connect(updateMaxIcons))
    updateMaxIcons()

    return Frame
end
