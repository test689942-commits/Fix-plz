-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return function(p1, p2) -- line: 1
    local Frame = Instance.new("Frame")

    Frame.Name = "Notice"
    Frame.ZIndex = 25
    Frame.AutomaticSize = Enum.AutomaticSize.X
    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BorderSizePixel = 0
    Frame.BackgroundTransparency = 0.1
    Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Frame.Visible = false
    Frame.Parent = p1.widget

    local UICorner = Instance.new("UICorner")

    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = Frame
    Instance.new("UIStroke").Parent = Frame

    local TextLabel = Instance.new("TextLabel")

    TextLabel.Name = "NoticeLabel"
    TextLabel.ZIndex = 26
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.AutomaticSize = Enum.AutomaticSize.X
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.5, 0, 0.515, 0)
    TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.FontSize = Enum.FontSize.Size14
    TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.Text = "1"
    TextLabel.TextWrapped = true
    TextLabel.TextWrap = true
    TextLabel.Font = Enum.Font.Arial
    TextLabel.Parent = Frame

    local ParentParent = script.Parent.Parent
    local Packages = ParentParent.Packages
    local Janitor = require(Packages.Janitor)
    local GoodSignal = require(Packages.GoodSignal)
    local Utility = require(ParentParent.Utility)

    p1.noticeChanged:Connect(function(p3) -- line: 43
        -- upvalues: p1 (copy), p2 (copy), Frame (copy), TextLabel (copy), Utility (copy)
        if not p3 then
            return
        end

        local v1 = p3 > 99

        TextLabel.Text = if v1 then "99+" else p3

        if v1 then
            TextLabel.TextSize = 11
        end

        local v3 = not (p3 < 1)
        local v4 = p2.getIconByUID(p1.parentIconUID)
        local v5 = #p1.dropdownIcons > 0 or #p1.menuIcons > 0

        if p1.isSelected and v5 or v4 and not v4.isSelected then
            v3 = false
        end

        Utility.setVisible(Frame, v3, "NoticeHandler")
    end)
    p1.noticeStarted:Connect(function(p4, p5) -- line: 71
        -- upvalues: p1 (copy), p2 (copy), Janitor (copy), GoodSignal (copy), Utility (copy)
        local v6 = p5

        p4 = p4 or p1.deselected

        local v8 = p2.getIconByUID(p1.parentIconUID)

        if v8 then
            v8:notify(p4)
        end

        local v9 = p1.janitor:add(Janitor.new())
        local v10 = v9:add(GoodSignal.new())

        v9:add(p1.endNotices:Connect(function() -- line: 83
            -- upvalues: v10 (copy)
            v10:Fire()
        end))
        v9:add(p4:Connect(function() -- line: 86
            -- upvalues: v10 (copy)
            v10:Fire()
        end))
        p5 = p5 or Utility.generateUID()
        v6 = p5
        p1.notices[p5] = {
            completeSignal = v10,
            clearNoticeEvent = p4
        }
        p1:getInstance("NoticeLabel")

        local function updateNotice() -- line: 95
            -- upvalues: p1 (copy)
            p1.noticeChanged:Fire(p1.totalNotices)
        end

        p1.notified:Fire(p5)
        p1.totalNotices += 1
        p1.noticeChanged:Fire(p1.totalNotices)
        v10:Once(function() -- line: 101
            -- upvalues: v6 (ref), v9 (copy), p1 (copy)
            v9:destroy()
            p1.totalNotices -= 1
            p1.notices[v6] = nil
            p1.noticeChanged:Fire(p1.totalNotices)
        end)
    end)
    Frame:SetAttribute("ClipToJoinedParent", true)
    p1:clipOutside(Frame)

    return Frame
end
