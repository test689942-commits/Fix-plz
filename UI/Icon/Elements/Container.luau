-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return function(p1) -- line: 1
    local GuiService = game:GetService("GuiService")
    local isOldTopbar = p1.isOldTopbar
    local t1 = {}
    local GuiInset = GuiService:GetGuiInset()
    local v1 = GuiService:IsTenFootInterface()
    local v2 = if isOldTopbar then 12 else GuiInset.Y - 46

    if v1 then
        v2 = 10
    end

    local ScreenGui = Instance.new("ScreenGui")

    ScreenGui:SetAttribute("StartInset", v2)
    ScreenGui.Name = "TopbarStandard"
    ScreenGui.Enabled = true
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
    t1[ScreenGui.Name] = ScreenGui
    ScreenGui.DisplayOrder = p1.baseDisplayOrder
    p1.baseDisplayOrderChanged:Connect(function() -- line: 22
        -- upvalues: p1 (copy), ScreenGui (copy)
        ScreenGui.DisplayOrder = p1.baseDisplayOrder
    end)

    local Frame = Instance.new("Frame")
    local v3 = if isOldTopbar then 2 else 0
    local n1 = -2
    local v4 = -2

    if v1 then
        v3 += 13
        n1 = 50
        v4 = 50
    end

    Frame.Name = "Holders"
    Frame.BackgroundTransparency = 1
    Frame.Position = UDim2.new(0, 0, 0, v3)
    Frame.Size = UDim2.new(1, 0, 1, v4)
    Frame.Visible = true
    Frame.ZIndex = 1
    Frame.Parent = ScreenGui

    local clone = ScreenGui:Clone()
    local Holders = clone.Holders
    local GuiService2 = game:GetService("GuiService")

    local function updateCenteredHoldersHeight() -- line: 44
        -- upvalues: n1 (ref), Holders (copy), GuiService2 (copy)
        Holders.Size = UDim2.new(1, 0, 0, GuiService2.TopbarInset.Height + n1)
    end

    clone.Name = "TopbarCentered"
    clone.ScreenInsets = Enum.ScreenInsets.None
    p1.baseDisplayOrderChanged:Connect(function() -- line: 49
        -- upvalues: p1 (copy), clone (copy)
        clone.DisplayOrder = p1.baseDisplayOrder
    end)
    t1[clone.Name] = clone
    GuiService2:GetPropertyChangedSignal("TopbarInset"):Connect(updateCenteredHoldersHeight)
    Holders.Size = UDim2.new(1, 0, 0, GuiService2.TopbarInset.Height + n1)

    local clone2 = ScreenGui:Clone()

    clone2.Name ..= "Clipped"
    clone2.DisplayOrder += 1
    p1.baseDisplayOrderChanged:Connect(function() -- line: 59
        -- upvalues: p1 (copy), clone2 (copy)
        clone2.DisplayOrder = p1.baseDisplayOrder + 1
    end)
    t1[clone2.Name] = clone2

    local clone3 = clone:Clone()

    clone3.Name ..= "Clipped"
    clone3.DisplayOrder += 1
    p1.baseDisplayOrderChanged:Connect(function() -- line: 67
        -- upvalues: p1 (copy), clone3 (copy)
        clone3.DisplayOrder = p1.baseDisplayOrder + 1
    end)
    t1[clone3.Name] = clone3

    if isOldTopbar then
        task.defer(function() -- line: 73
            -- upvalues: p1 (copy), GuiService2 (copy)
            local function decideToHideTopbar() -- line: 74
                -- upvalues: p1 (copy), GuiService2 (copy)
                if GuiService2.MenuIsOpen then
                    p1.setTopbarEnabled(false, true)
                else
                    p1.setTopbarEnabled()
                end
            end

            GuiService2:GetPropertyChangedSignal("MenuIsOpen"):Connect(decideToHideTopbar)

            if GuiService2.MenuIsOpen then
                p1.setTopbarEnabled(false, true)
            else
                p1.setTopbarEnabled()
            end
        end)
    end

    local ScrollingFrame = Instance.new("ScrollingFrame")

    ScrollingFrame:SetAttribute("IsAHolder", true)
    ScrollingFrame.Name = "Left"
    ScrollingFrame.Position = UDim2.fromOffset(v2, 0)
    ScrollingFrame.Size = UDim2.new(1, -24, 1, 0)
    ScrollingFrame.BackgroundTransparency = 1
    ScrollingFrame.Visible = true
    ScrollingFrame.ZIndex = 1
    ScrollingFrame.Active = false
    ScrollingFrame.ClipsDescendants = true
    ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, -1)
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
    ScrollingFrame.ScrollBarThickness = 0
    ScrollingFrame.BorderSizePixel = 0
    ScrollingFrame.Selectable = false
    ScrollingFrame.ScrollingEnabled = false
    ScrollingFrame.ElasticBehavior = Enum.ElasticBehavior.Never
    ScrollingFrame.Parent = Frame

    local UIListLayout = Instance.new("UIListLayout")

    UIListLayout.Padding = UDim.new(0, v2)
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    UIListLayout.Parent = ScrollingFrame

    local clone4 = ScrollingFrame:Clone()

    clone4.ScrollingEnabled = false
    clone4.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    clone4.Name = "Center"
    clone4.Parent = Holders

    local clone5 = ScrollingFrame:Clone()

    clone5.UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    clone5.Name = "Right"
    clone5.AnchorPoint = Vector2.new(1, 0)
    clone5.Position = UDim2.new(1, -12, 0, 0)
    clone5.Parent = Frame

    return t1
end
