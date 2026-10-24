-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local LocalPlayer = game:GetService("Players").LocalPlayer

function t1.createStagger(p1, p2, p3) -- line: 13
    local v1 = p1
    local v2 = false
    local v3 = false

    if not p1 or p1 == 0 then
        v1 = 0.01
    end

    local function staggeredCallback(...) -- line: 29
        -- upvalues: v1 (ref), p2 (copy), p3 (copy), v2 (ref), v3 (ref), staggeredCallback (copy)
        if v2 then
            v3 = true
        else
            local v4 = table.pack(...)

            v2 = true
            v3 = false
            task.spawn(function() -- line: 37
                -- upvalues: v4 (copy), v1 (ref), p2 (copy), p3 (copy)
                if p3 then
                    task.wait(v1)
                end

                p2(table.unpack(v4))
            end)
            task.delay(v1, function() -- line: 43
                -- upvalues: v4 (copy), v2 (ref), v3 (ref), staggeredCallback (copy)
                v2 = false

                if v3 then
                    staggeredCallback(table.unpack(v4))
                end
            end)
        end
    end

    return staggeredCallback
end

function t1.round(p4) -- line: 55
    return (math.floor(p4 + 0.5))
end

function t1.reverseTable(p5) -- line: 60
    for i = 1, math.floor(#p5 / 2) do
        local v7 = #p5 - i + 1
        local v8 = p5[v7]
        local v9 = p5[i]

        p5[i] = v8
        p5[v7] = v9
    end
end

function t1.copyTable(p6) -- line: 67
    -- upvalues: t1 (copy)
    assert(type(p6) == "table", "First argument must be a table")

    local v11 = table.create(#p6)

    for v12, v13 in pairs(p6) do
        if type(v13) == "table" then
            v11[v12] = t1.copyTable(v13)
        else
            v11[v12] = v13
        end
    end

    return v11
end

local t2 = {
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "0",
    "<",
    ">",
    "?",
    "@",
    "{",
    "}",
    "[",
    "]",
    "!",
    "(",
    ")",
    "=",
    "+",
    "~",
    "#"
}

function t1.generateUID(p7) -- line: 82
    -- upvalues: t2 (copy)
    p7 = p7 or 8

    local v15 = #t2
    local v16 = ""

    for _ = 1, p7 do
        v16 ..= t2[math.random(1, v15)]
    end

    return v16
end

local t3 = {}

function t1.setVisible(p8, p9, p10) -- line: 95
    -- upvalues: t3 (copy)
    local v17 = t3[p8]

    if not v17 then
        v17 = {}
        t3[p8] = v17
        p8.Destroying:Once(function() -- line: 104
            -- upvalues: p8 (copy), t3 (copy)
            t3[p8] = nil
        end)
    end

    local v18

    if p9 then
        v17[p10] = nil
        v18 = p9

        for _, _ in pairs(v17) do
            v18 = false
            break
        end
    else
        v17[p10] = true
        v18 = p9
    end

    p8.Visible = v18
end

function t1.formatStateName(p11) -- line: 123
    return string.upper((string.sub(p11, 1, 1))) .. string.lower((string.sub(p11, 2)))
end

function t1.localPlayerRespawned(p12) -- line: 127
    -- upvalues: LocalPlayer (copy)
    LocalPlayer.CharacterRemoving:Connect(p12)
end

function t1.getClippedContainer(p13) -- line: 137
    local ClippedContainer = p13:FindFirstChild("ClippedContainer")

    if not ClippedContainer then
        ClippedContainer = Instance.new("Folder")
        ClippedContainer.Name = "ClippedContainer"
        ClippedContainer.Parent = p13
    end

    return ClippedContainer
end

local Janitor = require(script.Parent.Packages.Janitor)
local GuiService = game:GetService("GuiService")

function t1.clipOutside(p14, p15) -- line: 151
    -- upvalues: t1 (copy), Janitor (copy), GuiService (copy)
    local v19 = p14.janitor:add(Janitor.new())

    p15.Destroying:Once(function() -- line: 153
        -- upvalues: v19 (copy)
        v19:Destroy()
    end)
    p14.janitor:add(p15)

    local Parent = p15.Parent
    local v20 = v19:add(Instance.new("Frame"))

    v20:SetAttribute("IsAClippedClone", true)
    v20.Name = p15.Name
    v20.AnchorPoint = p15.AnchorPoint
    v20.Size = p15.Size
    v20.Position = p15.Position
    v20.BackgroundTransparency = 1
    v20.LayoutOrder = p15.LayoutOrder
    v20.Parent = Parent

    local ObjectValue = Instance.new("ObjectValue")

    ObjectValue.Name = "OriginalInstance"
    ObjectValue.Value = p15
    ObjectValue.Parent = v20

    local clone = ObjectValue:Clone()

    p15:SetAttribute("HasAClippedClone", true)
    clone.Name = "ClippedClone"
    clone.Value = v20
    clone.Parent = p15

    local ScreenGui

    local function updateScreenGui() -- line: 181
        -- upvalues: p15 (copy), Parent (copy), ScreenGui (ref), t1 (copy)
        local ScreenGui2 = Parent:FindFirstAncestorWhichIsA("ScreenGui")

        if not string.match(ScreenGui2.Name, "Clipped") then
            ScreenGui2 = ScreenGui2.Parent[ScreenGui2.Name .. "Clipped"]
        end

        ScreenGui = ScreenGui2
        p15.AnchorPoint = Vector2.new(0, 0)
        p15.Parent = t1.getClippedContainer(ScreenGui)
    end

    v19:add(p14.alignmentChanged:Connect(updateScreenGui))
    updateScreenGui()

    for _, child in pairs(p15:GetChildren()) do
        if child:IsA("UIAspectRatioConstraint") then
            child:Clone().Parent = v20
        end
    end

    local widget = p14.widget
    local v21 = false
    local IgnoreVisibilityUpdater = p15:GetAttribute("IgnoreVisibilityUpdater")

    local function updateVisibility() -- line: 203
        -- upvalues: p15 (copy), widget (copy), v21 (ref), IgnoreVisibilityUpdater (copy), t1 (copy)
        if IgnoreVisibilityUpdater then
            return
        end

        local Visible = widget.Visible

        if v21 then
            Visible = false
        end

        t1.setVisible(p15, Visible, "ClipHandler")
    end

    v19:add(widget:GetPropertyChangedSignal("Visible"):Connect(updateVisibility))

    local joinedFrame
    local iconModule = require(p14.iconModule)

    local function checkIfOutsideParentXBounds() -- line: 218
        -- upvalues: p14 (copy), p15 (copy), v19 (copy), widget (copy), v21 (ref), IgnoreVisibilityUpdater (copy), joinedFrame (ref), iconModule (copy), checkIfOutsideParentXBounds (copy), t1 (copy)
        task.defer(function() -- line: 220
            -- upvalues: p14 (copy), p15 (copy), v19 (copy), widget (copy), v21 (ref), IgnoreVisibilityUpdater (copy), joinedFrame (ref), iconModule (copy), checkIfOutsideParentXBounds (copy), t1 (copy)
            local UID = p14.UID
            local joinedFrame2

            if p15:GetAttribute("ClipToJoinedParent") then
                local v22 = UID

                for _ = 1, 10 do
                    local v23 = iconModule.getIconByUID(v22)

                    if not v23 then
                        break
                    end

                    local joinedFrame = v23.joinedFrame

                    v22 = v23.parentIconUID

                    if not joinedFrame then
                        break
                    end

                    joinedFrame2 = joinedFrame
                end
            end

            if joinedFrame2 then
                local AbsolutePosition = p15.AbsolutePosition
                local v24 = p15.AbsoluteSize / 2
                local AbsolutePosition2, AbsoluteSize = joinedFrame2.AbsolutePosition, joinedFrame2.AbsoluteSize
                local v25 = AbsolutePosition + v24
                local v26 = v25.X < AbsolutePosition2.X
                local v27 = v25.X > AbsolutePosition2.X + AbsoluteSize.X
                local v28 = v25.Y < AbsolutePosition2.Y
                local v29 = v25.Y > AbsolutePosition2.Y + AbsoluteSize.Y
                local v30 = v26 or v27 or v28 or v29

                if v30 ~= v21 then
                    v21 = v30

                    local Visible

                    if not IgnoreVisibilityUpdater then
                        Visible = widget.Visible

                        if v21 then
                            Visible = false
                        end

                        t1.setVisible(p15, Visible, "ClipHandler")
                    end
                end

                if joinedFrame2:IsA("ScrollingFrame") and joinedFrame ~= joinedFrame2 then
                    joinedFrame = joinedFrame2
                    v19:add(joinedFrame2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- line: 262
                        -- upvalues: checkIfOutsideParentXBounds (copy)
                        checkIfOutsideParentXBounds()
                    end), "Disconnect", "TrackUtilityScroller-" .. UID)
                end
            else
                v21 = false

                if not IgnoreVisibilityUpdater then
                    local Visible = widget.Visible

                    if v21 then
                        Visible = false
                    end

                    t1.setVisible(p15, Visible, "ClipHandler")
                end
            end
        end)
    end

    local CurrentCamera = workspace.CurrentCamera
    local v31 = p15:GetAttribute("AdditionalOffsetX") or 0

    local function trackProperty(p16) -- line: 272
        -- upvalues: p14 (copy), p15 (copy), v19 (copy), v20 (copy), ScreenGui (ref), widget (copy), v21 (ref), IgnoreVisibilityUpdater (copy), joinedFrame (ref), iconModule (copy), checkIfOutsideParentXBounds (copy), CurrentCamera (copy), v31 (copy), t1 (copy), GuiService (copy)
        local v32 = "Absolute" .. p16

        local function updateProperty() -- line: 274
            -- upvalues: p16 (copy), v32 (copy), p14 (copy), p15 (copy), v19 (copy), v20 (copy), ScreenGui (ref), widget (copy), v21 (ref), IgnoreVisibilityUpdater (copy), joinedFrame (ref), iconModule (copy), checkIfOutsideParentXBounds (copy), CurrentCamera (copy), v31 (copy), t1 (copy), GuiService (copy)
            local v33 = v20[v32]
            local v34 = UDim2.fromOffset(v33.X, v33.Y)
            local v35

            if p16 == "Position" then
                local v36 = CurrentCamera.ViewportSize.X - p15.AbsoluteSize.X - 4
                local Offset = v34.X.Offset

                if Offset < 4 then
                    v36 = 4
                elseif not (v36 < Offset) then
                    v36 = Offset
                end

                local v37 = UDim2.fromOffset(v36, v34.Y.Offset)
                local TopbarInset = GuiService.TopbarInset
                local X = workspace.CurrentCamera.ViewportSize.X
                local X2 = ScreenGui.AbsoluteSize.X
                local X3 = ScreenGui.AbsolutePosition.X
                local _ = X3 - TopbarInset.Min.X

                if not p14.isOldTopbar then
                    X3 = X - X2 - 0
                end

                local v38 = X3 - v31

                v35 = v37 + UDim2.fromOffset(-v38, TopbarInset.Height)
                task.defer(function() -- line: 220
                    -- upvalues: p14 (copy), p15 (copy), v19 (copy), widget (copy), v21 (ref), IgnoreVisibilityUpdater (copy), joinedFrame (ref), iconModule (copy), checkIfOutsideParentXBounds (copy), t1 (copy)
                    local UID = p14.UID
                    local joinedFrame2

                    if p15:GetAttribute("ClipToJoinedParent") then
                        local v39 = UID

                        for _ = 1, 10 do
                            local v40 = iconModule.getIconByUID(v39)

                            if not v40 then
                                break
                            end

                            local joinedFrame = v40.joinedFrame

                            v39 = v40.parentIconUID

                            if not joinedFrame then
                                break
                            end

                            joinedFrame2 = joinedFrame
                        end
                    end

                    if joinedFrame2 then
                        local AbsolutePosition = p15.AbsolutePosition
                        local v41 = p15.AbsoluteSize / 2
                        local AbsolutePosition2, AbsoluteSize = joinedFrame2.AbsolutePosition, joinedFrame2.AbsoluteSize
                        local v42 = AbsolutePosition + v41
                        local v43 = v42.X < AbsolutePosition2.X
                        local v44 = v42.X > AbsolutePosition2.X + AbsoluteSize.X
                        local v45 = v42.Y < AbsolutePosition2.Y
                        local v46 = v42.Y > AbsolutePosition2.Y + AbsoluteSize.Y
                        local v47 = v43 or v44 or v45 or v46

                        if v47 ~= v21 then
                            v21 = v47

                            local Visible

                            if not IgnoreVisibilityUpdater then
                                Visible = widget.Visible

                                if v21 then
                                    Visible = false
                                end

                                t1.setVisible(p15, Visible, "ClipHandler")
                            end
                        end

                        if joinedFrame2:IsA("ScrollingFrame") and joinedFrame ~= joinedFrame2 then
                            joinedFrame = joinedFrame2
                            v19:add(joinedFrame2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- line: 262
                                -- upvalues: checkIfOutsideParentXBounds (copy)
                                checkIfOutsideParentXBounds()
                            end), "Disconnect", "TrackUtilityScroller-" .. UID)
                        end
                    else
                        v21 = false

                        if not IgnoreVisibilityUpdater then
                            local Visible = widget.Visible

                            if v21 then
                                Visible = false
                            end

                            t1.setVisible(p15, Visible, "ClipHandler")
                        end
                    end
                end)
            else
                v35 = v34
            end

            p15[p16] = v35
        end

        local v48 = t1.createStagger(0.01, updateProperty)

        v19:add(v20:GetPropertyChangedSignal(v32):Connect(v48))

        local v49 = t1.createStagger(0.5, updateProperty, true)

        v19:add(v20:GetPropertyChangedSignal(v32):Connect(v49))
    end

    task.delay(0.1, checkIfOutsideParentXBounds)
    task.defer(function() -- line: 220
        -- upvalues: p14 (copy), p15 (copy), v19 (copy), widget (copy), v21 (ref), IgnoreVisibilityUpdater (copy), joinedFrame (ref), iconModule (copy), checkIfOutsideParentXBounds (copy), t1 (copy)
        local UID = p14.UID
        local joinedFrame2

        if p15:GetAttribute("ClipToJoinedParent") then
            local v50 = UID

            for _ = 1, 10 do
                local v51 = iconModule.getIconByUID(v50)

                if not v51 then
                    break
                end

                local joinedFrame = v51.joinedFrame

                v50 = v51.parentIconUID

                if not joinedFrame then
                    break
                end

                joinedFrame2 = joinedFrame
            end
        end

        if joinedFrame2 then
            local AbsolutePosition = p15.AbsolutePosition
            local v52 = p15.AbsoluteSize / 2
            local AbsolutePosition2, AbsoluteSize = joinedFrame2.AbsolutePosition, joinedFrame2.AbsoluteSize
            local v53 = AbsolutePosition + v52
            local v54 = v53.X < AbsolutePosition2.X
            local v55 = v53.X > AbsolutePosition2.X + AbsoluteSize.X
            local v56 = v53.Y < AbsolutePosition2.Y
            local v57 = v53.Y > AbsolutePosition2.Y + AbsoluteSize.Y
            local v58 = v54 or v55 or v56 or v57

            if v58 ~= v21 then
                v21 = v58

                local Visible

                if not IgnoreVisibilityUpdater then
                    Visible = widget.Visible

                    if v21 then
                        Visible = false
                    end

                    t1.setVisible(p15, Visible, "ClipHandler")
                end
            end

            if joinedFrame2:IsA("ScrollingFrame") and joinedFrame ~= joinedFrame2 then
                joinedFrame = joinedFrame2
                v19:add(joinedFrame2:GetPropertyChangedSignal("AbsoluteWindowSize"):Connect(function() -- line: 262
                    -- upvalues: checkIfOutsideParentXBounds (copy)
                    checkIfOutsideParentXBounds()
                end), "Disconnect", "TrackUtilityScroller-" .. UID)
            end
        else
            v21 = false

            if not IgnoreVisibilityUpdater then
                local Visible = widget.Visible

                if v21 then
                    Visible = false
                end

                t1.setVisible(p15, Visible, "ClipHandler")
            end
        end
    end)

    if not IgnoreVisibilityUpdater then
        local Visible = widget.Visible

        if v21 then
            Visible = false
        end

        t1.setVisible(p15, Visible, "ClipHandler")
    end

    trackProperty("Position")
    v19:add(p15:GetPropertyChangedSignal("Visible"):Connect(function() -- line: 333
    end))

    if p15:GetAttribute("TrackCloneSize") then
        trackProperty("Size")
    else
        v19:add(p15:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 343
            -- upvalues: p15 (copy), v20 (copy)
            local AbsoluteSize = p15.AbsoluteSize

            v20.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y)
        end))
    end

    return v20
end

function t1.joinFeature(p17, p18, p19, p20) -- line: 352
    local joinJanitor = p17.joinJanitor

    joinJanitor:clean()

    if not p20 then
        p17:leave()

        return
    end

    p17.parentIconUID = p18.UID
    p17.joinedFrame = p20

    local function updateAlignent() -- line: 363
        -- upvalues: p17 (copy), p18 (copy)
        local alignment = p18.alignment

        if alignment == "Center" then
            alignment = "Left"
        end

        p17:setAlignment(alignment, true)
    end

    joinJanitor:add(p18.alignmentChanged:Connect(updateAlignent))

    local alignment = p18.alignment

    if alignment == "Center" then
        alignment = "Left"
    end

    p17:setAlignment(alignment, true)
    p17:modifyTheme({
        "IconButton",
        "BackgroundTransparency",
        1
    }, "JoinModification")
    p17:modifyTheme({
        "ClickRegion",
        "Active",
        false
    }, "JoinModification")

    if p18.childModifications then
        task.defer(function() -- line: 378
            -- upvalues: p17 (copy), p18 (copy)
            p17:modifyTheme(p18.childModifications, p18.childModificationsUID)
        end)
    end

    local ClickRegion = p17:getInstance("ClickRegion")

    local function makeSelectable() -- line: 384
        -- upvalues: p18 (copy), ClickRegion (copy)
        ClickRegion.Selectable = p18.isSelected
    end

    joinJanitor:add(p18.toggled:Connect(makeSelectable))
    task.defer(makeSelectable)
    joinJanitor:add(function() -- line: 389
        -- upvalues: ClickRegion (copy)
        ClickRegion.Selectable = true
    end)

    local UID = p17.UID

    table.insert(p19, UID)
    p18:autoDeselect(false)
    p18.childIconsDict[UID] = true

    if not p18.isEnabled then
        p18:setEnabled(true)
    end

    p17.joinedParent:Fire(p18)
    joinJanitor:add(function() -- line: 407
        -- upvalues: p17 (copy), p18 (copy), p19 (copy), UID (copy)
        if p17.joinedFrame then
            for v59, v60 in pairs(p19) do
                if v60 == UID then
                    table.remove(p19, v59)
                    break
                end
            end

            local v61 = require(p17.iconModule).getIconByUID(p17.parentIconUID)

            if not v61 then
                return
            end

            p17:setAlignment(p17.originalAlignment)
            p17.parentIconUID = false
            p17.joinedFrame = false
            p17:setBehaviour("IconButton", "BackgroundTransparency", nil, true)
            p17:removeModification("JoinModification")

            local childIconsDict = v61.childIconsDict

            childIconsDict[UID] = nil

            local v62 = true

            for _, _ in pairs(childIconsDict) do
                v62 = false
                break
            end

            if v62 and not v61.isAnOverflow then
                v61:setEnabled(false)
            end

            local alignment = p18.alignment

            if alignment == "Center" then
                alignment = "Left"
            end

            p17:setAlignment(alignment, true)
        end
    end)
end

return t1
