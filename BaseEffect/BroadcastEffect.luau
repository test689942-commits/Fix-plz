-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local TweenService = game:GetService("TweenService")
local _, DataMgr, New = _G.PoolMgr, _G.DataMgr, _G.New

return {
    Show = function(_, p2, p3) -- Show | line: 7
        -- upvalues: TweenService (copy), DataMgr (copy), New (copy)
        if DataMgr:GetSetting("DamageDisplay") == false then
            return
        end

        local v1 = New("AtkValue", true)(p3)
        local clone = script.Part:Clone()

        clone.Parent = workspace.FX

        local v4 = p2 + Vector3.new(math.random() * 0.5 - 0.25, 0, math.random() * 0.5 - 0.25)

        clone.CFrame = v4
        clone.Anchored = true

        local BillboardGui = clone.BillboardGui

        BillboardGui.Size = UDim2.new(0, 1, 0, 1)

        local isCrit = v1.isCrit
        local v5 = DataMgr:GetSetting("DamageDetail") == true

        BillboardGui.Main.Normal.Visible = false
        BillboardGui.Main.Crit.Visible = false
        BillboardGui.Main.Physical.Visible = false
        BillboardGui.Main.PhysicalCrit.Visible = false
        BillboardGui.Main.Magic.Visible = false
        BillboardGui.Main.MagicCrit.Visible = false

        local ImageLabel = BillboardGui.Main.Crit.ImageLabel

        ImageLabel.Visible = isCrit

        local t2 = {}

        if v5 then
            local _, ValueDetails, ValueDetails2 = v1:GetValueDetails()
            local PhysicalCrit = isCrit and BillboardGui.Main.PhysicalCrit or BillboardGui.Main.Physical
            local MagicCrit = if isCrit then BillboardGui.Main.MagicCrit else nil

            if not isCrit or not MagicCrit then
                MagicCrit = BillboardGui.Main.Magic
            end

            PhysicalCrit.Text = "-" .. math.floor(ValueDetails)
            MagicCrit.Text = "-" .. math.floor(ValueDetails2)
            PhysicalCrit.Visible = true
            MagicCrit.Visible = true
            table.insert(t2, PhysicalCrit)
            table.insert(t2, MagicCrit)
        else
            local Crit = if isCrit then BillboardGui.Main.Crit else nil

            if not isCrit or not Crit then
                Crit = BillboardGui.Main.Normal
            end

            Crit.Text = "-" .. math.floor((v1:GetValue()))
            Crit.Visible = true
            table.insert(t2, Crit)
        end

        for _, v6 in ipairs(t2) do
            v6.TextTransparency = 1

            if v6:FindFirstChild("UIStroke") then
                v6.UIStroke.Transparency = 1
            end
        end

        if isCrit then
            ImageLabel.ImageTransparency = 1
        end

        local tween = TweenService:Create(BillboardGui, TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            Size = UDim2.new(18, 15, 10, 8)
        })
        local tween2 = TweenService:Create(BillboardGui, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(6, 15, 2, 8)
        })

        for _, v7 in ipairs(t2) do
            TweenService:Create(v7, TweenInfo.new(0.1), {
                TextTransparency = 0
            }):Play()

            if v7:FindFirstChild("UIStroke") then
                TweenService:Create(v7.UIStroke, TweenInfo.new(0.1), {
                    Transparency = 0.5
                }):Play()
            end
        end

        if isCrit then
            TweenService:Create(ImageLabel, TweenInfo.new(0.1), {
                ImageTransparency = 0
            }):Play()
        end

        tween:Play()
        tween.Completed:Connect(function() -- line: 103
            -- upvalues: tween2 (copy)
            tween2:Play()
        end)

        local v8 = if math.random(1, 2) == 1 then Vector3.new(-4, 2, 0) else Vector3.new(4, 2, 0)

        TweenService:Create(clone, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            CFrame = v4 + v8
        }):Play()
        task.delay(0.8, function() -- line: 118
            -- upvalues: BillboardGui (copy), isCrit (copy), ImageLabel (copy), t2 (copy), TweenService (copy)
            TweenService:Create(BillboardGui, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
                StudsOffset = Vector3.new(0, 1, 0),
                Size = UDim2.new(1, 0, 0.1, 0)
            }):Play()

            for _, v9 in ipairs(t2) do
                TweenService:Create(v9, TweenInfo.new(0.4), {
                    TextTransparency = 1
                }):Play()

                if v9:FindFirstChild("UIStroke") then
                    TweenService:Create(v9.UIStroke, TweenInfo.new(0.4), {
                        Transparency = 1
                    }):Play()
                end
            end

            if isCrit then
                TweenService:Create(ImageLabel, TweenInfo.new(0.4), {
                    ImageTransparency = 1
                }):Play()
            end
        end)
        task.delay(1.4, function() -- line: 145
            -- upvalues: clone (copy)
            clone:Destroy()
        end)
    end
}
