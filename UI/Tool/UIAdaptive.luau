-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Players = game:GetService("Players")
local NetMgr = _G.NetMgr
local t1 = {}
local v1 = workspace.CurrentCamera.ViewportSize.Y / 1080
local v2, t2
local New = _G.New
local v3 = New("Utility.Tool")()

local function Start() -- line: 12
    -- upvalues: Players (copy), NetMgr (copy), t1 (copy), v1 (ref), v2 (ref), t2 (ref), New (copy), v3 (copy)
    local v4 = New("UI.Tool")()

    function v4.Translate(_, p2) -- line: 14
        -- upvalues: t2 (ref)
        if not t2 then
            return p2
        end

        local v5 = t2[p2]

        return v5 or p2
    end

    function v4.FormatByKey(_, p4, p5) -- line: 18
        -- upvalues: t2 (ref), v3 (copy)
        local v6, v7

        if t2 and t2[p4] then
            local v8 = v3:FormatString(t2[p4], p5)

            if v8 then
                v6 = v8
                v7 = true
            else
                v7 = false
            end
        else
            v7 = false
        end

        if not v7 then
            v6 = v3:FormatString(p4, p5)
        end

        return v6
    end

    function v4.FormatString(_, p7, p8, p9) -- line: 22
        for v9, v10 in p9 do
            p7:SetAttribute(v9, v10)
        end

        if not p7:GetAttribute("FormatByKey") then
            p7:SetAttribute("FormatByKey", true)
        end

        p7.Text = p8 or p7:GetAttribute("Source")
    end

    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- line: 33
        -- upvalues: t1 (copy), v1 (ref)
        v1 = workspace.CurrentCamera.ViewportSize.Y / 1080

        for _, v11 in t1 do
            for v12, v13 in v11.ui do
                v11.Updata(v12, v13)
            end
        end
    end)

    local function Transltor(p10, p11) -- line: 41
        -- upvalues: t2 (ref), v3 (copy)
        if p11 == nil then
            return
        end

        p10:SetAttribute("Source", p11)

        if p10:GetAttribute("FormatByKey") then
            if not (t2 and t2[p11]) then
                local v14 = v3:FormatString(p11, p10:GetAttributes())

                p10:SetAttribute("Translation", v14)
                p10.Text = v14
            else
                local v15 = v3:FormatString(t2[p11], p10:GetAttributes())

                p10:SetAttribute("Translation", v15)
                p10.Text = v15
            end
        elseif t2 and t2[p11] then
            local v16 = t2[p11]

            p10:SetAttribute("Translation", v16)
            p10.Text = v16
        end
    end

    t1.UIStroke = {
        ui = {},
        Add = function(p12) -- Add | line: 68
            -- upvalues: t1 (copy)
            local Thickness = p12.Thickness

            t1.UIStroke.ui[p12] = Thickness
            p12.Destroying:Connect(function() -- line: 71
                -- upvalues: p12 (copy), t1 (copy)
                t1.UIStroke.ui[p12] = nil
            end)
            t1.UIStroke.Updata(p12, Thickness)
        end,
        Updata = function(p13, p14) -- Updata | line: 76
            -- upvalues: v1 (ref)
            p13.Thickness = p14 * v1
        end
    }
    t1.TextLabel = {
        ui = {},
        Add = function(p15) -- Add | line: 83
            -- upvalues: Transltor (copy), t1 (copy)
            if p15.AutoLocalize then
                p15:GetPropertyChangedSignal("Text"):Connect(function() -- line: 85
                    -- upvalues: p15 (copy), Transltor (copy)
                    if p15.Text ~= p15:GetAttribute("Translation") then
                        Transltor(p15, p15.Text)
                    end
                end)
                Transltor(p15, p15.Text)
            end

            if p15.TextScaled then
                return
            end

            local TextSize = p15.TextSize

            t1.TextLabel.ui[p15] = TextSize
            p15.Destroying:Connect(function() -- line: 98
                -- upvalues: p15 (copy), t1 (copy)
                t1.TextLabel.ui[p15] = nil
            end)
            t1.TextLabel.Updata(p15, TextSize)
        end,
        Updata = function(p16, p17) -- Updata | line: 103
            -- upvalues: v1 (ref)
            p16.TextSize = p17 * v1
        end
    }
    t1.TextButton = t1.TextLabel
    t1.TextBox = t1.TextLabel
    t1.ImageLabel = {
        ui = {},
        Add = function(p18) -- Add | line: 112
            -- upvalues: t1 (copy)
            if p18.Size.X.Offset == 0 and p18.Size.Y.Offset == 0 then
                return
            end

            local Size = p18.Size

            t1.ImageLabel.ui[p18] = Size
            p18.Destroying:Connect(function() -- line: 118
                -- upvalues: p18 (copy), t1 (copy)
                t1.ImageLabel.ui[p18] = nil
            end)
            t1.ImageLabel.Updata(p18, Size)
        end,
        Updata = function(p19, p20) -- Updata | line: 123
            -- upvalues: v1 (ref)
            p19.Size = UDim2.new(p19.Size.X.Scale, p20.X.Offset * v1, p19.Size.Y.Scale, p20.Y.Offset * v1)
        end
    }
    t1.UIGridLayout = {
        ui = {},
        Add = function(p21) -- Add | line: 134
            -- upvalues: t1 (copy)
            if p21.CellSize.X.Offset == 0 and p21.CellSize.Y.Offset == 0 then
                return
            end

            local CellSize = p21.CellSize

            t1.UIGridLayout.ui[p21] = CellSize
            p21.Destroying:Connect(function() -- line: 140
                -- upvalues: p21 (copy), t1 (copy)
                t1.UIGridLayout.ui[p21] = nil
            end)
            t1.UIGridLayout.Updata(p21, CellSize)
        end,
        Updata = function(p22, p23) -- Updata | line: 145
            -- upvalues: v1 (ref)
            p22.CellSize = UDim2.new(p22.CellSize.X.Scale, p23.X.Offset * v1, p22.CellSize.Y.Scale, p23.Y.Offset * v1)
        end
    }
    t1.UIListLayout = {
        ui = {},
        Add = function(p24) -- Add | line: 156
            -- upvalues: t1 (copy)
            if p24.Padding.Offset == 0 then
                return
            end

            local Padding = p24.Padding

            t1.UIListLayout.ui[p24] = Padding
            p24.Destroying:Connect(function() -- line: 162
                -- upvalues: p24 (copy), t1 (copy)
                t1.UIListLayout.ui[p24] = nil
            end)
            t1.UIListLayout.Updata(p24, Padding)
        end,
        Updata = function(p25, p26) -- Updata | line: 167
            -- upvalues: v1 (ref)
            p25.Padding = UDim.new(p25.Padding.Scale, p26.Offset * v1)
        end
    }
    t1.UIPadding = {
        ui = {},
        Add = function(p27) -- Add | line: 176
            -- upvalues: t1 (copy)
            if p27.PaddingBottom.Offset == 0 and p27.PaddingTop.Offset == 0 and p27.PaddingLeft.Offset == 0 and p27.PaddingRight.Offset == 0 then
                return
            end

            local t5 = {
                PaddingBottom = p27.PaddingBottom.Offset,
                PaddingTop = p27.PaddingTop.Offset,
                PaddingLeft = p27.PaddingLeft.Offset,
                PaddingRight = p27.PaddingRight.Offset
            }

            t1.UIPadding.ui[p27] = t5
            p27.Destroying:Connect(function() -- line: 190
                -- upvalues: p27 (copy), t1 (copy)
                t1.UIPadding.ui[p27] = nil
            end)
            t1.UIPadding.Updata(p27, t5)
        end,
        Updata = function(p28, p29) -- Updata | line: 195
            -- upvalues: v1 (ref)
            p28.PaddingBottom = UDim.new(p28.PaddingBottom.Scale, p29.PaddingBottom * v1)
            p28.PaddingTop = UDim.new(p28.PaddingTop.Scale, p29.PaddingTop * v1)
            p28.PaddingLeft = UDim.new(p28.PaddingLeft.Scale, p29.PaddingLeft * v1)
            p28.PaddingRight = UDim.new(p28.PaddingRight.Scale, p29.PaddingRight * v1)
        end
    }

    local PlayerGui = Players.LocalPlayer.PlayerGui

    for _, descendant in pairs(PlayerGui:GetDescendants()) do
        if t1[descendant.ClassName] then
            t1[descendant.ClassName].Add(descendant)
        end
    end

    PlayerGui.DescendantAdded:Connect(function(p30) -- line: 233
        -- upvalues: t1 (copy)
        if t1[p30.ClassName] then
            t1[p30.ClassName].Add(p30)
        end
    end)

    local t6 = {
        TextLabel = true,
        TextButton = true,
        TextBox = true
    }

    local function LocaleChange() -- line: 240
        -- upvalues: Transltor (copy), PlayerGui (copy), t6 (copy), Players (copy), v2 (ref), t2 (ref)
        t2 = {}

        for _, v17 in v2 do
            t2[v17.Key] = v17.Values[Players.LocalPlayer.LocaleId]
        end

        for _, descendant in PlayerGui:GetDescendants() do
            if t6[descendant.ClassName] and descendant.AutoLocalize then
                Transltor(descendant, descendant:GetAttribute("Source"))
            end
        end
    end

    task.spawn(function() -- line: 254
        -- upvalues: LocaleChange (copy), Players (copy), NetMgr (copy), v2 (ref)
        v2 = NetMgr:InvokeServer("GetLocalization", Players.LocalPlayer.LocaleId)
        LocaleChange()
        Players.LocalPlayer:GetPropertyChangedSignal("LocaleId"):Connect(LocaleChange)
    end)
end

return Start
