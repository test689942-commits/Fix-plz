-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local GamepadService = game:GetService("GamepadService")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local v1
local t1 = {}

function t1.start(p1) -- line: 24
    -- upvalues: GamepadService (copy), UserInputService (copy), GuiService (copy), t1 (copy), v1 (ref)
    v1 = p1
    v1.highlightKey = Enum.KeyCode.DPadUp
    v1.highlightIcon = false
    task.delay(1, function() -- line: 33
        -- upvalues: GamepadService (copy), UserInputService (copy), GuiService (copy), t1 (copy), v1 (ref)
        local iconsDictionary = v1.iconsDictionary

        local function getIconFromSelectedObject() -- line: 36
            -- upvalues: iconsDictionary (copy), GuiService (copy)
            local SelectedObject = GuiService.SelectedObject
            local CorrespondingIconUID = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")

            return CorrespondingIconUID and iconsDictionary[CorrespondingIconUID]
        end

        local v3
        local v4 = false
        local v5 = false

        require(script.Parent.Parent.Utility)

        local Selection = require(script.Parent.Parent.Elements.Selection)

        local function updateSelectedObject() -- line: 50
            -- upvalues: iconsDictionary (copy), v3 (ref), v4 (ref), v5 (ref), Selection (copy), UserInputService (copy), GuiService (copy), t1 (copy), v1 (ref)
            local SelectedObject = GuiService.SelectedObject
            local CorrespondingIconUID = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")
            local v6 = CorrespondingIconUID and iconsDictionary[CorrespondingIconUID]
            local GamepadEnabled = UserInputService.GamepadEnabled

            if v6 then
                if GamepadEnabled then
                    local ClickRegion = v6:getInstance("ClickRegion")
                    local selection = v6.selection

                    if not selection then
                        selection = v6.janitor:add(Selection(v1))
                        selection:SetAttribute("IgnoreVisibilityUpdater", true)
                        selection.Parent = v6.widget
                        v6.selection = selection
                        v6:refreshAppearance(selection)
                    end

                    ClickRegion.SelectionImageObject = selection.Selection
                end

                if v3 and v3 ~= v6 then
                    v3:setIndicator()
                end

                local ButtonB = if GamepadEnabled and not v5 and not v6.parentIconUID then Enum.KeyCode.ButtonB else nil

                v3 = v6
                v1.lastHighlightedIcon = v6
                v6:setIndicator(ButtonB)
            else
                local v7 = if GamepadEnabled then v4 else nil
                local highlightKey = if not GamepadEnabled or v7 then nil else v1.highlightKey

                v3 = v3 or t1.getIconToHighlight()

                if highlightKey == v1.highlightKey then
                    v4 = true
                end

                if v3 then
                    v3:setIndicator(highlightKey)
                end
            end
        end

        GuiService:GetPropertyChangedSignal("SelectedObject"):Connect(updateSelectedObject)

        local function checkGamepadEnabled() -- line: 93
            -- upvalues: v4 (ref), v5 (ref), updateSelectedObject (copy), UserInputService (copy)
            if not UserInputService.GamepadEnabled then
                v4 = false
                v5 = false
            end

            updateSelectedObject()
        end

        UserInputService:GetPropertyChangedSignal("GamepadEnabled"):Connect(checkGamepadEnabled)

        if not UserInputService.GamepadEnabled then
            v4 = false
            v5 = false
        end

        updateSelectedObject()
        UserInputService.InputBegan:Connect(function(p2, _) -- line: 107
            -- upvalues: iconsDictionary (copy), GamepadService (copy), GuiService (copy), t1 (copy), v1 (ref)
            if p2.UserInputType == Enum.UserInputType.MouseButton1 then
                local SelectedObject = GuiService.SelectedObject
                local CorrespondingIconUID = SelectedObject and SelectedObject:GetAttribute("CorrespondingIconUID")

                if CorrespondingIconUID and iconsDictionary[CorrespondingIconUID] then
                    GuiService.SelectedObject = nil
                end
            elseif p2.KeyCode == v1.highlightKey then
                local v8 = t1.getIconToHighlight()

                if v8 then
                    if GamepadService.GamepadCursorEnabled then
                        task.wait(0.2)
                        GamepadService:DisableGamepadCursor()
                    end

                    GuiService.SelectedObject = v8:getInstance("ClickRegion")
                end
            end
        end)
    end)
end

function t1.getIconToHighlight() -- line: 134
    -- upvalues: v1 (ref)
    local iconsDictionary = v1.iconsDictionary
    local v9 = v1.highlightIcon or v1.lastHighlightedIcon

    if not v9 then
        local v10 = v9
        local X

        for _, v11 in pairs(iconsDictionary) do
            if not v11.parentIconUID then
                local X2 = v11.widget.AbsolutePosition.X

                if not X or X2 < X then
                    v10 = v11
                    X = v11.widget.AbsolutePosition.X
                end
            end

            v9 = v10
        end
    end

    return v9
end

function t1.registerButton(p4) -- line: 156
    -- upvalues: GamepadService (copy), UserInputService (copy), GuiService (copy)
    local v12 = false

    p4.InputBegan:Connect(function(_) -- line: 162
        -- upvalues: v12 (ref)
        v12 = true
        task.wait()
        task.wait()
        v12 = false
    end)

    local connection = UserInputService.InputBegan:Connect(function(p6) -- line: 171
        -- upvalues: p4 (copy), v12 (ref), GamepadService (copy), GuiService (copy)
        task.wait()

        if p6.KeyCode ~= Enum.KeyCode.ButtonA or not v12 then
            local v13 = GuiService.SelectedObject == p4
            local t2 = {
                "ButtonB",
                "ButtonSelect"
            }
            local Name = p6.KeyCode.Name

            if table.find(t2, Name) and v13 and (Name ~= "ButtonSelect" or GamepadService.GamepadCursorEnabled) then
                GuiService.SelectedObject = nil
            end
        else
            task.wait(0.2)
            GamepadService:DisableGamepadCursor()
            GuiService.SelectedObject = p4
        end
    end)

    p4.Destroying:Once(function() -- line: 192
        -- upvalues: connection (copy)
        connection:Disconnect()
    end)
end

return t1
