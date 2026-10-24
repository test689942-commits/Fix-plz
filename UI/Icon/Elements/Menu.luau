-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return function(p1) -- line: 1
    local ScrollingFrame = Instance.new("ScrollingFrame")

    ScrollingFrame.Name = "Menu"
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Visible = true
    ScrollingFrame.ZIndex = 1
    ScrollingFrame.Size = UDim2.fromScale(1, 1)
    ScrollingFrame.ClipsDescendants = true
    ScrollingFrame.TopImage = ""
    ScrollingFrame.BottomImage = ""
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.Always
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1)
    ScrollingFrame.ScrollingEnabled = true
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
    ScrollingFrame.ZIndex = 20
    ScrollingFrame.ScrollBarThickness = 3
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingFrame.ScrollBarImageTransparency = 0.8
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.Selectable = false

    local iconModule = require(p1.iconModule)
    local clone = iconModule.container.TopbarStandard:FindFirstChild("UIListLayout", true):Clone()

    clone.Name = "MenuUIListLayout"
    clone.VerticalAlignment = Enum.VerticalAlignment.Center
    clone.Parent = ScrollingFrame

    local Frame = Instance.new("Frame")

    Frame.Name = "MenuGap"
    Frame.BackgroundTransparency = 1
    Frame.Visible = false
    Frame.AnchorPoint = Vector2.new(0, 0.5)
    Frame.ZIndex = 5
    Frame.Parent = ScrollingFrame

    local v1 = false
    local Themes = require(script.Parent.Parent.Features.Themes)

    local function totalChildrenChanged() -- line: 39
        -- upvalues: p1 (copy), ScrollingFrame (copy), clone (copy), v1 (ref), Themes (copy)
        local menuJanitor = p1.menuJanitor
        local v2 = #p1.menuIcons

        if v1 then
            if v2 <= 0 then
                menuJanitor:clean()
                v1 = false
            end
        else
            v1 = true
            menuJanitor:add(p1.toggled:Connect(function() -- line: 53
                -- upvalues: p1 (copy)
                if #p1.menuIcons > 0 then
                    p1.updateSize:Fire()
                end
            end))

            local _, v4 = p1:modifyTheme({ { "Menu", "Active", true } })

            task.defer(function() -- line: 63
                -- upvalues: menuJanitor (copy), v4 (copy), p1 (copy)
                menuJanitor:add(function() -- line: 64
                    -- upvalues: v4 (copy), p1 (copy)
                    p1:removeModification(v4)
                end)
            end)

            local X = ScrollingFrame.AbsoluteCanvasSize.X

            local function rightAlignCanvas() -- line: 73
                -- upvalues: X (ref), p1 (copy), ScrollingFrame (copy)
                if p1.alignment == "Right" then
                    local X2 = ScrollingFrame.AbsoluteCanvasSize.X
                    local v5 = X - X2

                    X = X2
                    ScrollingFrame.CanvasPosition = Vector2.new(ScrollingFrame.CanvasPosition.X - v5, 0)
                end
            end

            menuJanitor:add(p1.selected:Connect(rightAlignCanvas))
            menuJanitor:add(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(rightAlignCanvas))

            local v6 = p1:getStateGroup()

            if Themes.getThemeValue(v6, "IconImage", "Image", "Deselected") == Themes.getThemeValue(v6, "IconImage", "Image", "Selected") then
                local v7 = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Light, Enum.FontStyle.Normal)

                p1:removeModificationWith("IconLabel", "Text", "Viewing")
                p1:removeModificationWith("IconLabel", "Image", "Viewing")
                p1:modifyTheme({
                    { "IconLabel", "FontFace", v7, "Selected" },
                    { "IconLabel", "Text", "X", "Selected" },
                    { "IconLabel", "TextSize", 20, "Selected" },
                    { "IconLabel", "TextStrokeTransparency", 0.8, "Selected" },
                    { "IconImage", "Image", "", "Selected" }
                })
            end

            local IconSpot = p1:getInstance("IconSpot")
            local MenuGap = p1:getInstance("MenuGap")

            local function updateAlignent() -- line: 105
                -- upvalues: IconSpot (copy), MenuGap (copy), p1 (copy)
                if p1.alignment == "Right" then
                    IconSpot.LayoutOrder = 99999
                    MenuGap.LayoutOrder = 99998
                else
                    IconSpot.LayoutOrder = -99999
                    MenuGap.LayoutOrder = -99998
                end
            end

            menuJanitor:add(p1.alignmentChanged:Connect(updateAlignent))

            if p1.alignment == "Right" then
                IconSpot.LayoutOrder = 99999
                MenuGap.LayoutOrder = 99998
            else
                IconSpot.LayoutOrder = -99999
                MenuGap.LayoutOrder = -99998
            end

            ScrollingFrame:GetAttributeChangedSignal("MenuCanvasWidth"):Connect(function() -- line: 120
                -- upvalues: ScrollingFrame (copy)
                local MenuCanvasWidth = ScrollingFrame:GetAttribute("MenuCanvasWidth")
                local Y = ScrollingFrame.CanvasSize.Y

                ScrollingFrame.CanvasSize = UDim2.new(0, MenuCanvasWidth, Y.Scale, Y.Offset)
            end)
            menuJanitor:add(p1.updateMenu:Connect(function() -- line: 125
                -- upvalues: ScrollingFrame (copy), clone (copy)
                local MaxIcons = ScrollingFrame:GetAttribute("MaxIcons")

                if not MaxIcons then
                    return
                end

                local t1 = {}

                for _, child in pairs(ScrollingFrame:GetChildren()) do
                    if child:GetAttribute("WidgetUID") and child.Visible then
                        table.insert(t1, {
                            child,
                            child.AbsolutePosition.X
                        })
                    end
                end

                table.sort(t1, function(p2, p3) -- line: 137
                    return p2[2] < p3[2]
                end)

                local n1 = 0

                for i = 1, MaxIcons do
                    local v8 = t1[i]

                    if not v8 then
                        break
                    end

                    n1 += v8[1].AbsoluteSize.X + clone.Padding.Offset
                end

                ScrollingFrame:SetAttribute("MenuWidth", n1)
            end))

            local function startMenuUpdate() -- line: 152
                -- upvalues: p1 (copy)
                task.delay(0.1, function() -- line: 153
                    -- upvalues: p1 (copy)
                    p1.startMenuUpdate:Fire()
                end)
            end

            local _ = p1:getInstance("IconButton").AbsoluteSize.X

            menuJanitor:add(ScrollingFrame.ChildAdded:Connect(startMenuUpdate))
            menuJanitor:add(ScrollingFrame.ChildRemoved:Connect(startMenuUpdate))
            menuJanitor:add(ScrollingFrame:GetAttributeChangedSignal("MaxIcons"):Connect(startMenuUpdate))
            menuJanitor:add(ScrollingFrame:GetAttributeChangedSignal("MaxWidth"):Connect(startMenuUpdate))
            task.delay(0.1, function() -- line: 153
                -- upvalues: p1 (copy)
                p1.startMenuUpdate:Fire()
            end)
        end
    end

    p1.menuChildAdded:Connect(totalChildrenChanged)
    p1.menuSet:Connect(function(p4) -- line: 167
        -- upvalues: p1 (copy), iconModule (copy)
        for _, v9 in pairs(p1.menuIcons) do
            iconModule.getIconByUID(v9):destroy()
        end

        local _ = #p4

        if type(p4) == "table" then
            for _, v10 in pairs(p4) do
                v10:joinMenu(p1)
            end
        end
    end)

    return ScrollingFrame
end
