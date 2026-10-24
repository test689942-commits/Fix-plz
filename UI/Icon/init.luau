-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

game:GetService("LocalizationService")

local UserInputService = game:GetService("UserInputService")

game:GetService("RunService")
game:GetService("TextService")

local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local _script = script
local Reference = require(_script.Reference)
local v1 = Reference.getObject()
local v2 = v1 and v1.Value

if v2 and v2 ~= _script then
    return require(v2)
end

if not v1 then
    Reference.addToReplicatedStorage()
end

local GoodSignal = require(_script.Packages.GoodSignal)
local Janitor = require(_script.Packages.Janitor)
local Utility = require(_script.Utility)

require(_script.Attribute)

local Themes = require(_script.Features.Themes)
local Gamepad = require(_script.Features.Gamepad)
local Overflow = require(_script.Features.Overflow)
local t1 = {}

t1.__index = t1

local LocalPlayer = Players.LocalPlayer
local Themes2 = _script.Features.Themes
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local t2 = {}
local v3 = GoodSignal.new()
local Elements = _script.Elements
local n1 = 0

if GuiService.TopbarInset.Height == 0 then
    GuiService:GetPropertyChangedSignal("TopbarInset"):Wait()
end

t1.baseDisplayOrderChanged = GoodSignal.new()
t1.baseDisplayOrder = 10
t1.baseTheme = require(Themes2.Default)
t1.isOldTopbar = GuiService.TopbarInset.Height == 36
t1.iconsDictionary = t2
t1.container = require(Elements.Container)(t1)
t1.topbarEnabled = true
t1.iconAdded = GoodSignal.new()
t1.iconRemoved = GoodSignal.new()
t1.iconChanged = GoodSignal.new()

function t1.getIcons() -- line: 112
    -- upvalues: t1 (copy)
    return t1.iconsDictionary
end

function t1.getIconByUID(p1) -- line: 116
    -- upvalues: t1 (copy)
    local v4 = t1.iconsDictionary[p1]

    if v4 then
        return v4
    end
end

function t1.getIcon(p2) -- line: 123
    -- upvalues: t1 (copy), t2 (copy)
    local v5 = t1.getIconByUID(p2)

    if v5 then
        return v5
    end

    for _, v6 in pairs(t2) do
        if v6.name == p2 then
            return v6
        end
    end
end

function t1.setTopbarEnabled(p3, p4) -- line: 135
    -- upvalues: t1 (copy)
    local v7 = if typeof(p3) == "boolean" then p3 else t1.topbarEnabled

    if not p4 then
        t1.topbarEnabled = v7
    end

    for _, v8 in pairs(t1.container) do
        v8.Enabled = v7
    end
end

function t1.modifyBaseTheme(p5) -- line: 147
    -- upvalues: Themes (copy), t1 (copy), t2 (copy)
    local v9 = Themes.getModifications(p5)

    for _, v10 in pairs(v9) do
        for _, v11 in pairs(t1.baseTheme) do
            Themes.merge(v11, v10)
        end
    end

    for _, v12 in pairs(t2) do
        v12:setTheme(t1.baseTheme)
    end
end

function t1.setDisplayOrder(p6) -- line: 159
    -- upvalues: t1 (copy)
    t1.baseDisplayOrder = p6
    t1.baseDisplayOrderChanged:Fire(p6)
end

task.defer(Gamepad.start, t1)
task.defer(Overflow.start, t1)

for _, v13 in pairs(t1.container) do
    v13.Parent = PlayerGui
end

if t1.isOldTopbar then
    t1.modifyBaseTheme(require(Themes2.Classic))
end

function t1.new() -- line: 179
    -- upvalues: UserInputService (copy), StarterGui (copy), _script (copy), GoodSignal (copy), Janitor (copy), Utility (copy), t1 (copy), t2 (copy), v3 (copy), Elements (copy), n1 (ref)
    local t3 = {}

    setmetatable(t3, t1)

    local v14 = Janitor.new()

    t3.janitor = v14
    t3.themesJanitor = v14:add(Janitor.new())
    t3.singleClickJanitor = v14:add(Janitor.new())
    t3.captionJanitor = v14:add(Janitor.new())
    t3.joinJanitor = v14:add(Janitor.new())
    t3.menuJanitor = v14:add(Janitor.new())
    t3.dropdownJanitor = v14:add(Janitor.new())

    local v15 = Utility.generateUID()

    t2[v15] = t3
    v14:add(function() -- line: 196
        -- upvalues: v15 (copy), t2 (copy)
        t2[v15] = nil
    end)
    t3.selected = v14:add(GoodSignal.new())
    t3.deselected = v14:add(GoodSignal.new())
    t3.toggled = v14:add(GoodSignal.new())
    t3.viewingStarted = v14:add(GoodSignal.new())
    t3.viewingEnded = v14:add(GoodSignal.new())
    t3.stateChanged = v14:add(GoodSignal.new())
    t3.notified = v14:add(GoodSignal.new())
    t3.noticeStarted = v14:add(GoodSignal.new())
    t3.noticeChanged = v14:add(GoodSignal.new())
    t3.endNotices = v14:add(GoodSignal.new())
    t3.toggleKeyAdded = v14:add(GoodSignal.new())
    t3.fakeToggleKeyChanged = v14:add(GoodSignal.new())
    t3.alignmentChanged = v14:add(GoodSignal.new())
    t3.updateSize = v14:add(GoodSignal.new())
    t3.resizingComplete = v14:add(GoodSignal.new())
    t3.joinedParent = v14:add(GoodSignal.new())
    t3.menuSet = v14:add(GoodSignal.new())
    t3.dropdownSet = v14:add(GoodSignal.new())
    t3.updateMenu = v14:add(GoodSignal.new())
    t3.startMenuUpdate = v14:add(GoodSignal.new())
    t3.childThemeModified = v14:add(GoodSignal.new())
    t3.indicatorSet = v14:add(GoodSignal.new())
    t3.dropdownChildAdded = v14:add(GoodSignal.new())
    t3.menuChildAdded = v14:add(GoodSignal.new())
    t3.iconModule = _script
    t3.UID = v15
    t3.isEnabled = true
    t3.isSelected = false
    t3.isViewing = false
    t3.joinedFrame = false
    t3.parentIconUID = false
    t3.deselectWhenOtherIconSelected = true
    t3.totalNotices = 0
    t3.activeState = "Deselected"
    t3.alignment = ""
    t3.originalAlignment = ""
    t3.appliedTheme = {}
    t3.appearance = {}
    t3.cachedInstances = {}
    t3.cachedNamesToInstances = {}
    t3.cachedCollectives = {}
    t3.bindedToggleKeys = {}
    t3.customBehaviours = {}
    t3.toggleItems = {}
    t3.bindedEvents = {}
    t3.notices = {}
    t3.menuIcons = {}
    t3.dropdownIcons = {}
    t3.childIconsDict = {}
    t3.isOldTopbar = t1.isOldTopbar
    t3.creationTime = os.clock()
    t3.widget = v14:add(require(Elements.Widget)(t3, t1))
    t3:setAlignment()
    n1 += 1

    local v16 = n1

    t3:setOrder(v16)
    t3:setTheme(t1.baseTheme)

    local ClickRegion = t3:getInstance("ClickRegion")

    local function handleToggle() -- line: 271
        -- upvalues: t3 (copy)
        if not t3.locked then
            if t3.isSelected then
                t3:deselect("User", t3)
            else
                t3:select("User", t3)
            end
        end
    end

    local v17 = false
    local v18 = false

    ClickRegion.MouseButton1Click:Connect(function() -- line: 283
        -- upvalues: t3 (copy), v17 (ref), v18 (ref)
        if v17 then
            return
        end

        v18 = true
        task.delay(0.01, function() -- line: 288
            -- upvalues: v18 (ref)
            v18 = false
        end)

        if not t3.locked then
            if t3.isSelected then
                t3:deselect("User", t3)
            else
                t3:select("User", t3)
            end
        end
    end)
    ClickRegion.TouchTap:Connect(function() -- line: 293
        -- upvalues: t3 (copy), v17 (ref), v18 (ref)
        if v18 then
            return
        end

        v17 = true
        task.delay(0.01, function() -- line: 300
            -- upvalues: v17 (ref)
            v17 = false
        end)

        if not t3.locked then
            if t3.isSelected then
                t3:deselect("User", t3)
            else
                t3:select("User", t3)
            end
        end
    end)
    v14:add(UserInputService.InputBegan:Connect(function(p7, p8) -- line: 307
        -- upvalues: t3 (copy)
        if t3.locked or not t3.bindedToggleKeys[p7.KeyCode] or p8 or t3.locked then
            return
        end

        if t3.isSelected then
            t3:deselect("User", t3)
        else
            t3:select("User", t3)
        end
    end))

    local function viewingStarted(p9) -- line: 319
        -- upvalues: t3 (copy)
        if t3.locked then
            return
        end

        t3.isViewing = true
        t3.viewingStarted:Fire(true)

        if not p9 then
            t3:setState("Viewing", "User", t3)
        end
    end

    local function viewingEnded() -- line: 329
        -- upvalues: t3 (copy)
        if t3.locked then
            return
        end

        t3.isViewing = false
        t3.viewingEnded:Fire(true)
        t3:setState(nil, "User", t3)
    end

    t3.joinedParent:Connect(function() -- line: 337
        -- upvalues: t3 (copy)
        if t3.isViewing then
            if t3.locked then
                return
            end

            t3.isViewing = false
            t3.viewingEnded:Fire(true)
            t3:setState(nil, "User", t3)
        end
    end)
    ClickRegion.MouseEnter:Connect(function() -- line: 342
        -- upvalues: t3 (copy), UserInputService (copy)
        local v19 = not UserInputService.KeyboardEnabled

        if t3.locked then
            return
        end

        t3.isViewing = true
        t3.viewingStarted:Fire(true)

        if not v19 then
            t3:setState("Viewing", "User", t3)
        end
    end)

    local n2 = 0

    v14:add(UserInputService.TouchEnded:Connect(viewingEnded))
    ClickRegion.MouseLeave:Connect(viewingEnded)
    ClickRegion.SelectionGained:Connect(viewingStarted)
    ClickRegion.SelectionLost:Connect(viewingEnded)
    ClickRegion.MouseButton1Down:Connect(function() -- line: 351
        -- upvalues: t3 (copy), n2 (ref), UserInputService (copy)
        if t3.locked or not UserInputService.TouchEnabled then
            return
        end

        n2 += 1

        local v20 = n2

        task.delay(0.2, function() -- line: 355
            -- upvalues: v20 (copy), t3 (copy), n2 (ref)
            if v20 ~= n2 or t3.locked then
                return
            end

            t3.isViewing = true
            t3.viewingStarted:Fire(true)
            t3:setState("Viewing", "User", t3)
        end)
    end)
    ClickRegion.MouseButton1Up:Connect(function() -- line: 362
        -- upvalues: n2 (ref)
        n2 += 1
    end)

    local IconOverlay = t3:getInstance("IconOverlay")

    t3.viewingStarted:Connect(function() -- line: 368
        -- upvalues: t3 (copy), IconOverlay (copy)
        IconOverlay.Visible = not t3.overlayDisabled
    end)
    t3.viewingEnded:Connect(function() -- line: 371
        -- upvalues: IconOverlay (copy)
        IconOverlay.Visible = false
    end)
    v14:add(v3:Connect(function(p10) -- line: 376
        -- upvalues: t3 (copy)
        if p10 ~= t3 and t3.deselectWhenOtherIconSelected and p10.deselectWhenOtherIconSelected then
            t3:deselect("AutoDeselect", p10)
        end
    end))

    local s = debug.info(2, "s")
    local v21 = string.split(s, ".")
    local _game = game
    local v22 = _game
    local v23

    for _, v24 in pairs(v21) do
        v22 = v22:FindFirstChild(v24)

        if not v22 then
            _game = v22
            break
        end

        _game = v22

        if v22:IsA("ScreenGui") then
            v23 = v22
        end
    end

    if _game and v23 and v23.ResetOnSpawn == true then
        Utility.localPlayerRespawned(function() -- line: 401
            -- upvalues: t3 (copy)
            t3:destroy()
        end)
    end

    t3:getInstance("NoticeLabel")
    t3.toggled:Connect(function(p11) -- line: 408
        -- upvalues: t3 (copy), t1 (copy)
        t3.noticeChanged:Fire(t3.totalNotices)

        for v25, _ in pairs(t3.childIconsDict) do
            local v26 = t1.getIconByUID(v25)

            v26.noticeChanged:Fire(v26.totalNotices)

            if not p11 and v26.isSelected then
                for _, _ in pairs(v26.childIconsDict) do
                    v26:deselect("HideParentFeature", t3)
                end
            end
        end
    end)
    t3.selected:Connect(function() -- line: 431
        -- upvalues: t3 (copy), StarterGui (copy)
        if #t3.dropdownIcons > 0 then
            if StarterGui:GetCore("ChatActive") and t3.alignment ~= "Left" then
                t3.chatWasPreviouslyActive = true
                StarterGui:SetCore("ChatActive", false)
            end

            if StarterGui:GetCoreGuiEnabled("PlayerList") and t3.alignment ~= "Left" then
                t3.playerlistWasPreviouslyActive = true
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
            end
        end
    end)
    t3.deselected:Connect(function() -- line: 444
        -- upvalues: t3 (copy), StarterGui (copy)
        if t3.chatWasPreviouslyActive then
            t3.chatWasPreviouslyActive = nil
            StarterGui:SetCore("ChatActive", true)
        end

        if t3.playerlistWasPreviouslyActive then
            t3.playerlistWasPreviouslyActive = nil
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
        end
    end)
    task.delay(0.1, function() -- line: 459
        -- upvalues: t3 (copy)
        if t3.activeState == "Deselected" then
            t3.stateChanged:Fire("Deselected")
            t3:refresh()
        end
    end)
    t1.iconAdded:Fire(t3)

    return t3
end

function t1.setName(p12, p13) -- line: 475
    p12.widget.Name = p13
    p12.name = p13

    return p12
end

function t1.setState(p14, p15, p16, p17) -- line: 481
    -- upvalues: Utility (copy), v3 (copy)
    p15 = p15 or (if p14.isSelected then "Selected" else "Deselected")

    local v28 = Utility.formatStateName(p15)

    if p14.activeState == v28 then
        return
    end

    local isSelected = p14.isSelected

    p14.activeState = v28

    if v28 == "Deselected" then
        p14.isSelected = false

        if isSelected then
            p14.toggled:Fire(false, p16, p17)
            p14.deselected:Fire(p16, p17)
        end

        p14:_setToggleItemsVisible(false, p16, p17)
    elseif v28 == "Selected" then
        p14.isSelected = true

        if not isSelected then
            p14.toggled:Fire(true, p16, p17)
            p14.selected:Fire(p16, p17)
            v3:Fire(p14, p16, p17)
        end

        p14:_setToggleItemsVisible(true, p16, p17)
    end

    p14.stateChanged:Fire(v28, p16, p17)
end

function t1.getInstance(p18, p19) -- line: 514
    -- upvalues: Themes (copy)
    local v29 = p18.cachedNamesToInstances[p19]

    if v29 then
        return v29
    end

    local function cacheInstance(p20, p21) -- line: 522
        -- upvalues: p18 (copy)
        if p18.cachedInstances[p21] then
            return
        end

        local Collective = p21:GetAttribute("Collective")
        local v30 = Collective and p18.cachedCollectives[Collective]

        if v30 then
            table.insert(v30, p21)
        end

        p18.cachedNamesToInstances[p20] = p21
        p18.cachedInstances[p21] = true
        p21.Destroying:Once(function() -- line: 532
            -- upvalues: p20 (copy), p21 (copy), p18 (copy)
            p18.cachedNamesToInstances[p20] = nil
            p18.cachedInstances[p21] = nil
        end)
    end

    local widget = p18.widget

    cacheInstance("Widget", widget)

    if p19 == "Widget" then
        return widget
    end

    local v31, scanChildren

    local function scanChildren2(p22) -- line: 545
        -- upvalues: p18 (copy), p19 (copy), cacheInstance (copy), v31 (ref), scanChildren (ref), Themes (copy)
        for _, child in pairs(p22:GetChildren()) do
            local WidgetUID = child:GetAttribute("WidgetUID")

            if not WidgetUID or WidgetUID == p18.UID then
                local v33 = Themes.getRealInstance(child) or child
                local scanChildren2 = scanChildren

                scanChildren2(v33)

                if v33:IsA("GuiBase") or v33:IsA("UIBase") or v33:IsA("ValueBase") then
                    local Name = v33.Name

                    cacheInstance(Name, v33)

                    if Name == p19 then
                        v31 = v33
                    end
                end
            end
        end
    end

    scanChildren = scanChildren2
    scanChildren2(widget)

    return v31
end

function t1.getCollective(p23, p24) -- line: 575
    local v34 = p23.cachedCollectives[p24]

    if v34 then
        return v34
    end

    local t4 = {}

    for v35, _ in pairs(p23.cachedInstances) do
        if v35:GetAttribute("Collective") == p24 then
            table.insert(t4, v35)
        end
    end

    p23.cachedCollectives[p24] = t4

    return t4
end

function t1.getInstanceOrCollective(p25, p26) -- line: 596
    local v36 = {}
    local v37 = p25:getInstance(p26)

    if v37 then
        table.insert(v36, v37)
    end

    if #v36 == 0 then
        v36 = p25:getCollective(p26)
    end

    return v36
end

function t1.getStateGroup(p27, p28) -- line: 610
    p28 = p28 or p27.activeState

    local v39 = p27.appearance[p28]

    if not v39 then
        v39 = {}
        p27.appearance[p28] = v39
    end

    return v39
end

function t1.refreshAppearance(p29, p30, p31) -- line: 620
    -- upvalues: Themes (copy)
    Themes.refresh(p29, p30, p31)

    return p29
end

function t1.refresh(p32) -- line: 625
    p32:refreshAppearance(p32.widget)
    p32.updateSize:Fire()

    return p32
end

function t1.updateParent(p33) -- line: 631
    -- upvalues: t1 (copy)
    local v40 = t1.getIconByUID(p33.parentIconUID)

    if v40 then
        v40.updateSize:Fire()
    end
end

function t1.setBehaviour(p34, p35, p36, p37, p38) -- line: 638
    local v41 = p35 .. "-" .. p36

    p34.customBehaviours[v41] = p37

    if p38 then
        local v42 = p34:getInstanceOrCollective(p35)

        for _, v43 in pairs(v42) do
            p34:refreshAppearance(v43, p36)
        end
    end
end

function t1.modifyTheme(p39, p40, p41) -- line: 651
    -- upvalues: Themes (copy)
    return p39, (Themes.modify(p39, p40, p41))
end

function t1.modifyChildTheme(p42, p43, p44) -- line: 656
    -- upvalues: t1 (copy)
    p42.childModifications = p43
    p42.childModificationsUID = p44

    for v44, _ in pairs(p42.childIconsDict) do
        t1.getIconByUID(v44):modifyTheme(p43, p44)
    end

    p42.childThemeModified:Fire()

    return p42
end

function t1.removeModification(p45, p46) -- line: 669
    -- upvalues: Themes (copy)
    Themes.remove(p45, p46)

    return p45
end

function t1.removeModificationWith(p47, p48, p49, p50) -- line: 674
    -- upvalues: Themes (copy)
    Themes.removeWith(p47, p48, p49, p50)

    return p47
end

function t1.setTheme(p51, p52) -- line: 679
    -- upvalues: Themes (copy)
    Themes.set(p51, p52)

    return p51
end

function t1.setEnabled(p53, p54) -- line: 684
    p53.isEnabled = p54
    p53.widget.Visible = p54
    p53:updateParent()

    return p53
end

function t1.select(p55, p56, p57) -- line: 691
    p55:setState("Selected", p56, p57)

    return p55
end

function t1.deselect(p58, p59, p60) -- line: 696
    p58:setState("Deselected", p59, p60)

    return p58
end

function t1.notify(p61, p62, p63) -- line: 701
    -- upvalues: t1 (copy), Elements (copy)
    if not p61.notice then
        p61.notice = require(Elements.Notice)(p61, t1)
    end

    p61.noticeStarted:Fire(p62, p63)

    return p61
end

function t1.clearNotices(p64) -- line: 715
    p64.endNotices:Fire()

    return p64
end

function t1.disableOverlay(p65, p66) -- line: 720
    p65.overlayDisabled = p66

    return p65
end

t1.disableStateOverlay = t1.disableOverlay

function t1.setImage(p67, p68, p69) -- line: 726
    p67:modifyTheme({
        "IconImage",
        "Image",
        p68,
        p69
    })

    return p67
end

function t1.setLabel(p70, p71, p72) -- line: 731
    p70:modifyTheme({
        "IconLabel",
        "Text",
        p71,
        p72
    })

    return p70
end

function t1.setOrder(p73, p74, p75) -- line: 736
    p73:modifyTheme({
        "Widget",
        "LayoutOrder",
        p74,
        p75
    })

    return p73
end

function t1.setCornerRadius(p76, p77, p78) -- line: 741
    p76:modifyTheme({
        "IconCorners",
        "CornerRadius",
        p77,
        p78
    })

    return p76
end

function t1.align(p79, p80, p81) -- line: 746
    -- upvalues: t1 (copy)
    local v45 = tostring(p80):lower()

    if v45 == "mid" or v45 == "centre" then
        v45 = "center"
    end

    if v45 ~= "left" and v45 ~= "center" and v45 ~= "right" then
        v45 = "left"
    end

    local TopbarCentered = v45 == "center" and t1.container.TopbarCentered or t1.container.TopbarStandard
    local Holders = TopbarCentered.Holders
    local v46 = string.upper((string.sub(v45, 1, 1))) .. string.sub(v45, 2)

    if not p81 then
        p79.originalAlignment = v46
    end

    local joinedFrame = p79.joinedFrame
    local v47 = Holders[v46]

    p79.screenGui = TopbarCentered
    p79.alignmentHolder = v47

    if not p79.isDestroyed then
        p79.widget.Parent = joinedFrame or v47
    end

    p79.alignment = v46
    p79.alignmentChanged:Fire(v46)
    t1.iconChanged:Fire(p79)

    return p79
end

t1.setAlignment = t1.align

function t1.setLeft(p82) -- line: 775
    p82:setAlignment("Left")

    return p82
end

function t1.setMid(p83) -- line: 780
    p83:setAlignment("Center")

    return p83
end

function t1.setRight(p84) -- line: 785
    p84:setAlignment("Right")

    return p84
end

function t1.setWidth(p85, p86, p87) -- line: 790
    p85:modifyTheme({
        "Widget",
        "Size",
        UDim2.fromOffset(p86, p85.widget.Size.Y.Offset),
        p87
    })
    p85:modifyTheme({
        "Widget",
        "DesiredWidth",
        p86,
        p87
    })

    return p85
end

function t1.setImageScale(p88, p89, p90) -- line: 800
    p88:modifyTheme({
        "IconImageScale",
        "Value",
        p89,
        p90
    })

    return p88
end

function t1.setImageRatio(p91, p92, p93) -- line: 805
    p91:modifyTheme({
        "IconImageRatio",
        "AspectRatio",
        p92,
        p93
    })

    return p91
end

function t1.setTextSize(p94, p95, p96) -- line: 810
    p94:modifyTheme({
        "IconLabel",
        "TextSize",
        p95,
        p96
    })

    return p94
end

function t1.setTextFont(p97, p98, p99, p100, p101) -- line: 815
    p99 = p99 or Enum.FontWeight.Regular
    p100 = p100 or Enum.FontStyle.Normal

    local v50 = typeof(p98)
    local v51 = if v50 == "number" then Font.fromId(p98, p99, p100)
        elseif v50 == "EnumItem" then Font.fromEnum(p98)
        elseif v50 == "string" and not p98:match("rbxasset") then Font.fromName(p98, p99, p100)
        else nil

    p97:modifyTheme({
        "IconLabel",
        "FontFace",
        v51 or Font.new(p98, p99, p100),
        p101
    })

    return p97
end

function t1.bindToggleItem(p102, p103) -- line: 836
    if not p103:IsA("GuiObject") and not p103:IsA("LayerCollector") then
        error("Toggle item must be a GuiObject or LayerCollector!")
    end

    p102.toggleItems[p103] = true
    p102:_updateSelectionInstances()

    return p102
end

function t1.unbindToggleItem(p104, p105) -- line: 845
    p104.toggleItems[p105] = nil
    p104:_updateSelectionInstances()

    return p104
end

function t1._updateSelectionInstances(p106) -- line: 851
    for v52, _ in pairs(p106.toggleItems) do
        local t5 = {}

        for _, descendant in pairs(v52:GetDescendants()) do
            if (descendant:IsA("TextButton") or descendant:IsA("ImageButton")) and descendant.Active then
                table.insert(t5, descendant)
            end
        end

        p106.toggleItems[v52] = t5
    end
end

function t1._setToggleItemsVisible(p107, p108, _, p110) -- line: 865
    for v53, _ in pairs(p107.toggleItems) do
        if not p110 or p110 == p107 or p110.toggleItems[v53] == nil then
            v53[v53:IsA("LayerCollector") and "Enabled" or "Visible"] = p108
        end
    end
end

function t1.bindEvent(p111, p112, p113) -- line: 877
    local v54 = p111[p112]

    assert(v54 and typeof(v54) == "table" and v54.Connect, "argument[1] must be a valid topbarplus icon event name!")
    assert(typeof(p113) == "function", "argument[2] must be a function!")
    p111.bindedEvents[p112] = v54:Connect(function(...) -- line: 881
        -- upvalues: p111 (copy), p113 (copy)
        p113(p111, ...)
    end)

    return p111
end

function t1.unbindEvent(p114, p115) -- line: 887
    local v57 = p114.bindedEvents[p115]

    if v57 then
        v57:Disconnect()
        p114.bindedEvents[p115] = nil
    end

    return p114
end

function t1.bindToggleKey(p116, p117) -- line: 896
    assert(typeof(p117) == "EnumItem", "argument[1] must be a KeyCode EnumItem!")
    p116.bindedToggleKeys[p117] = true
    p116.toggleKeyAdded:Fire(p117)
    p116:setCaption("_hotkey_")

    return p116
end

function t1.unbindToggleKey(p118, p119) -- line: 904
    assert(typeof(p119) == "EnumItem", "argument[1] must be a KeyCode EnumItem!")
    p118.bindedToggleKeys[p119] = nil

    return p118
end

function t1.call(p120, p121, ...) -- line: 910
    local v60 = table.pack(...)

    task.spawn(function() -- line: 912
        -- upvalues: p120 (copy), p121 (copy), v60 (copy)
        p121(p120, table.unpack(v60))
    end)

    return p120
end

function t1.addToJanitor(p122, p123) -- line: 918
    p122.janitor:add(p123)

    return p122
end

function t1.lock(p124) -- line: 923
    p124:getInstance("ClickRegion").Visible = false
    p124.locked = true

    return p124
end

function t1.unlock(p125) -- line: 931
    p125:getInstance("ClickRegion").Visible = true
    p125.locked = false

    return p125
end

function t1.debounce(p126, p127) -- line: 938
    p126:lock()
    task.wait(p127)
    p126:unlock()

    return p126
end

function t1.autoDeselect(p128, p129) -- line: 945
    if p129 ~= nil then
        p128.deselectWhenOtherIconSelected = p129
    else
        p128.deselectWhenOtherIconSelected = true
    end

    return p128
end

function t1.oneClick(p130, p131) -- line: 955
    local singleClickJanitor = p130.singleClickJanitor

    singleClickJanitor:clean()

    if p131 or p131 == nil then
        singleClickJanitor:add(p130.selected:Connect(function() -- line: 961
            -- upvalues: p130 (copy)
            p130:deselect("OneClick", p130)
        end))
    end

    p130.oneClickEnabled = true

    return p130
end

function t1.setCaption(p132, p133) -- line: 969
    -- upvalues: Elements (copy)
    if p133 == "_hotkey_" and p132.captionText then
        return p132
    end

    local captionJanitor = p132.captionJanitor

    p132.captionJanitor:clean()

    local v61 = if p133 then p133 == "" else nil

    if not p133 or v61 then
        p132.caption = nil
        p132.captionText = nil
    else
        local v62 = captionJanitor:add(require(Elements.Caption)(p132))

        v62:SetAttribute("CaptionText", p133)
        p132.caption = v62
        p132.captionText = p133
    end

    return p132
end

function t1.setCaptionHint(p134, p135) -- line: 987
    assert(typeof(p135) == "EnumItem", "argument[1] must be a KeyCode EnumItem!")
    p134.fakeToggleKey = p135
    p134.fakeToggleKeyChanged:Fire(p135)
    p134:setCaption("_hotkey_")

    return p134
end

function t1.leave(p136) -- line: 995
    p136.joinJanitor:clean()

    return p136
end

function t1.joinMenu(p137, p138) -- line: 1001
    -- upvalues: Utility (copy)
    Utility.joinFeature(p137, p138, p138.menuIcons, p138:getInstance("Menu"))
    p138.menuChildAdded:Fire(p137)

    return p137
end

function t1.setMenu(p139, p140) -- line: 1007
    p139.menuSet:Fire(p140)

    return p139
end

function t1.setFrozenMenu(p141, p142) -- line: 1012
    p141:freezeMenu(p142)
    p141:setMenu(p142)
end

function t1.freezeMenu(p143) -- line: 1017
    p143:select("FrozenMenu", p143)
    p143:bindEvent("deselected", function(p144) -- line: 1021
        -- upvalues: p143 (copy)
        p144:select("FrozenMenu", p143)
    end)
    p143:modifyTheme({
        "IconSpot",
        "Visible",
        false
    })
end

function t1.joinDropdown(p145, p146) -- line: 1027
    -- upvalues: Utility (copy)
    p146:getDropdown()
    Utility.joinFeature(p145, p146, p146.dropdownIcons, p146:getInstance("DropdownScroller"))
    p146.dropdownChildAdded:Fire(p145)

    return p145
end

function t1.getDropdown(p147) -- line: 1034
    -- upvalues: Elements (copy)
    local dropdown = p147.dropdown

    if not dropdown then
        dropdown = require(Elements.Dropdown)(p147)
        p147.dropdown = dropdown
        p147:clipOutside(dropdown)
    end

    return dropdown
end

function t1.setDropdown(p148, p149) -- line: 1044
    p148:getDropdown()
    p148.dropdownSet:Fire(p149)

    return p148
end

function t1.clipOutside(p150, p151) -- line: 1050
    -- upvalues: Utility (copy)
    local v64 = Utility.clipOutside(p150, p151)

    p150:refreshAppearance(p151)

    return p150, v64
end

function t1.setIndicator(p152, p153) -- line: 1061
    -- upvalues: t1 (copy), Elements (copy)
    if not p152.indicator then
        p152.indicator = p152.janitor:add(require(Elements.Indicator)(p152, t1))
    end

    p152.indicatorSet:Fire(p153)
end

function t1.destroy(p154) -- line: 1074
    -- upvalues: t1 (copy)
    if p154.isDestroyed then
        return
    end

    p154:clearNotices()

    if p154.parentIconUID then
        p154:leave()
    end

    p154.isDestroyed = true
    p154.janitor:clean()
    t1.iconRemoved:Fire(p154)
end

t1.Destroy = t1.destroy

return t1
