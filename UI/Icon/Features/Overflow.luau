-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t2 = {}
local t3 = {}
local iconsDictionary
local CurrentCamera = workspace.CurrentCamera
local t4 = {}
local t5 = {}
local Utility = require(script.Parent.Parent.Utility)
local v1
local t1 = {}

function t1.start(p1) -- line: 23
    -- upvalues: t1 (copy), t2 (copy), iconsDictionary (ref), CurrentCamera (copy), Utility (copy), v1 (ref)
    v1 = p1
    iconsDictionary = v1.iconsDictionary

    local v2

    for _, v3 in pairs(v1.container) do
        if v2 == nil and v3.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
            v2 = v3
        end

        for _, child in pairs(v3.Holders:GetChildren()) do
            if child:GetAttribute("IsAHolder") then
                t2[child.Name] = child
            end
        end
    end

    local v4 = false
    local v5 = Utility.createStagger(0.1, function(p2) -- line: 41
        -- upvalues: v4 (ref), t1 (copy)
        if not v4 then
            return
        end

        if not p2 then
            t1.updateAvailableIcons("Center")
        end

        t1.updateBoundary("Left")
        t1.updateBoundary("Right")
    end)

    task.delay(1, function() -- line: 51
        -- upvalues: v4 (ref), v5 (copy)
        v4 = true
        v5()
    end)
    v1.iconAdded:Connect(v5)
    v1.iconRemoved:Connect(v5)
    v1.iconChanged:Connect(v5)
    CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- line: 61
        -- upvalues: v5 (copy)
        v5(true)
    end)
    v2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line: 64
        -- upvalues: v5 (copy)
        v5(true)
    end)
end

function t1.getWidth(p3, _) -- line: 69
    local widget = p3.widget

    return widget:GetAttribute("TargetWidth") or widget.AbsoluteSize.X
end

function t1.getAvailableIcons(p5) -- line: 74
    -- upvalues: t1 (copy), t3 (copy)
    return t3[p5] or t1.updateAvailableIcons(p5)
end

function t1.updateAvailableIcons(p6) -- line: 82
    -- upvalues: t2 (copy), t3 (copy), iconsDictionary (ref), t5 (copy)
    local _ = t2[p6].UIListLayout
    local t6 = {}
    local n1 = 0

    for _, v6 in pairs(iconsDictionary) do
        local parentIconUID = v6.parentIconUID
        local v7 = not parentIconUID or t5[parentIconUID]
        local v8 = t5[v6.UID]

        if v7 and v6.alignment == p6 and not v8 then
            table.insert(t6, v6)
            n1 += 1
        end
    end

    if n1 <= 0 then
        return {}
    end

    table.sort(t6, function(p7, p8) -- line: 106
        local LayoutOrder = p7.widget.LayoutOrder
        local LayoutOrder2 = p8.widget.LayoutOrder
        local parentIconUID = p7.parentIconUID
        local parentIconUID2 = p8.parentIconUID

        if parentIconUID == parentIconUID2 then
            if LayoutOrder < LayoutOrder2 then
                return true
            end

            if LayoutOrder2 < LayoutOrder then
                return false
            end

            return p7.widget.AbsolutePosition.X < p8.widget.AbsolutePosition.X
        end

        if parentIconUID2 then
            return false
        end

        if parentIconUID then
            return true
        end
    end)
    t3[p6] = t6

    return t6
end

function t1.getRealXPositions(p9, p10) -- line: 132
    -- upvalues: t1 (copy), t2 (copy), Utility (copy)
    local v9 = p9 == "Left"
    local v10 = t2[p9]
    local X = v10.AbsolutePosition.X
    local X2 = v10.AbsoluteSize.X
    local Offset = v10.UIListLayout.Padding.Offset

    if not v9 or not X then
        X += X2
    end

    local t7 = {}

    if v9 then
        Utility.reverseTable(p10)
    end

    for i = #p10, 1, -1 do
        local v11 = p10[i]
        local v12 = t1.getWidth(v11)

        if not v9 then
            X -= v12
        end

        t7[v11.UID] = X

        if v9 then
            X += v12
        end

        X += if v9 and Offset then Offset else -Offset
    end

    return t7
end

function t1.updateBoundary(p11) -- line: 162
    -- upvalues: t1 (copy), t2 (copy), t4 (copy), t5 (copy), Utility (copy), v1 (ref)
    local v13 = t2[p11]
    local UIListLayout = v13.UIListLayout
    local X = v13.AbsolutePosition.X
    local X2 = v13.AbsoluteSize.X
    local Offset, Offset2 = UIListLayout.Padding.Offset, UIListLayout.Padding.Offset
    local v14 = t1.updateAvailableIcons(p11)
    local n2 = 0
    local n3 = 0

    for _, v15 in pairs(v14) do
        n2 += t1.getWidth(v15) + Offset2
        n3 += 1
    end

    if n3 <= 0 then
        return
    end

    local v16 = p11 == "Central"
    local v17 = p11 == "Left"
    local v18 = not v17
    local v19 = t4[p11]
    local v21
    local v20 = v19

    if v19 or v16 then
    elseif #v14 > 0 then
        v21 = if v17 then -9999999 else 9999999
        v20 = v1.new()
        v20:setImage(6069276526, "Deselected")
        v20:setName("Overflow" .. p11)
        v20:setOrder(v21)
        v20:setAlignment(p11)
        v20:autoDeselect(false)
        v20.isAnOverflow = true
        v20:select("OverflowStart", v20)
        v20:setEnabled(false)
        t4[p11] = v20
        t5[v20.UID] = true
    end

    local v22 = if p11 == "Left" then "Right" else "Left"
    local v23 = t1.updateAvailableIcons(v22)
    local v24 = v17 and v23[1] or v18 and v23[#v23]
    local v25 = t4[v22]
    local v26 = v17 and X + X2 or X

    if v24 then
        local _ = v24.widget
        local v27 = t1.getRealXPositions(v22, v23)[v24.UID]
        local v28 = t1.getWidth(v24)

        v26 = v17 and v27 - Offset or v27 + v28 + Offset
    end

    local Center = t1.getAvailableIcons("Center")
    local v29 = Center[if v17 then 1 else #Center]

    if v29 and not v29.hasRelocatedInOverflow then
        local v30 = v17 and v14[#v14] or v18 and v14[1]
        local X = v29.widget.AbsolutePosition.X
        local X2 = v30.widget.AbsolutePosition.X
        local v31 = t1.getWidth(v30)
        local v32 = if v17 then X - Offset else nil

        if not v17 or not v32 then
            v32 = X + t1.getWidth(v29) + Offset
        end

        local v33 = if v17 then X2 + v31 else nil

        if v17 and v33 then
            X2 = v33
        end

        if v17 then
            if v32 < X2 then
                v29:align("Left")
                v29.hasRelocatedInOverflow = true
            end
        elseif v18 and X2 < v32 then
            v29:align("Right")
            v29.hasRelocatedInOverflow = true
        end
    end

    local v34 = false
    local v35 = false
    local v36 = false
    local v37 = false

    if v20 then
        v34 = true
    else
        v37 = true
    end

    local Menu, v38, v39

    if v34 then
        Menu = v20:getInstance("Menu")
        v38 = X + X2

        if Menu then
            v35 = true
        else
            v39 = X2
            v37 = false
        end
    end

    v34 = false

    if v35 then
        if v25 then
            v34 = true
        else
            v39 = X2
            v37 = false
        end
    end

    v35 = false

    local X3, v40

    if v34 then
        X3 = v25.widget.AbsolutePosition.X
        v40 = t1.getWidth(v25)

        if v17 then
            v35 = true
        else
            v36 = true
        end
    end

    v34 = false

    local v41

    if v35 then
        local v42 = X3 - Offset

        if v42 then
            v41 = v42
            v34 = true
        else
            v36 = true
        end
    end

    v35 = false

    if v36 then
        v41 = X3 + v40 + Offset
        v34 = true
    end

    v36 = false

    if v34 then
        local Menu2 = v25:getInstance("Menu")

        if Menu.AbsoluteCanvasSize.X >= Menu2.AbsoluteCanvasSize.X then
            v35 = true
        else
            v36 = true
        end
    end

    v34 = false

    local v43

    if v36 then
        v43 = false
        v34 = true
    end

    v36 = false

    if v35 then
        v43 = true
        v34 = true
    end

    v35 = false

    local v44

    if v34 then
        v44 = X + X2 / 2

        if v17 then
            v35 = true
        else
            v36 = true
        end
    end

    v34 = false

    local v45

    if v35 then
        local v46 = v44 - Offset / 2

        if v46 then
            v45 = v46
            v34 = true
        else
            v36 = true
        end
    end

    v35 = false

    if v36 then
        v45 = v44 + Offset / 2
        v34 = true
    end

    v36 = false

    local v47

    if v34 then
        if v43 then
            v36 = true
        else
            v47 = v45
            v35 = true
        end
    end

    v34 = false

    if v36 then
        v47 = v41
        v35 = true
    end

    v36 = false

    if v35 then
        if v17 then
            v36 = true
        else
            v34 = true
        end
    end

    v35 = false

    local v48

    if v36 then
        local v49 = v47 - X

        if v49 then
            v48 = v49
            v35 = true
        else
            v34 = true
        end
    end

    if v34 then
        v48 = v38 - v47
        v35 = true
    end

    if v35 then
        v39 = v48
        v37 = false
    end

    if not v37 then
        local MaxWidth = Menu and Menu:GetAttribute("MaxWidth")
        local v50 = Utility.round(v39)

        if Menu and MaxWidth ~= v50 then
            Menu:SetAttribute("MaxWidth", v50)
        end
    end

    local v51 = t1.getRealXPositions(p11, v14)
    local v52 = #v14
    local v53 = false

    for i = v52, 1, -1 do
        local v54 = v14[i]
        local v55 = t1.getWidth(v54)
        local v56 = v51[v54.UID]

        if v17 and v26 <= v56 + v55 or v18 and v56 <= v26 then
            v53 = true
        end
    end

    for i = #v14, 1, -1 do
        local v57 = v14[i]

        if not t5[v57.UID] then
            local parentIconUID = if v53 then v57.parentIconUID else nil

            if not v53 or parentIconUID then
                if not v53 and v57.parentIconUID then
                    v57:leave()
                end
            else
                v57:joinMenu(v20)
            end
        end
    end

    if v20.isEnabled ~= v53 then
        v20:setEnabled(v53)
    end

    if v20.isEnabled and not v20.overflowAlreadyOpened then
        v20.overflowAlreadyOpened = true
        v20:select()
    end
end

return t1
