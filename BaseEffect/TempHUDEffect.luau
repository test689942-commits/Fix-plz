-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local _, _, New = _G.PoolMgr, _G.DataMgr, _G.New
local t2 = {}

local function ShakeHUD(p1) -- line: 10
    -- upvalues: TweenService (copy)
    local Main = p1.BillboardGui.Main
    local MainPosition = Main.Position

    TweenService:Create(Main, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Position = MainPosition + UDim2.new(0.01, 0, 0, 0)
    }):Play()
    task.delay(0.1, function() -- line: 20
        -- upvalues: Main (copy), MainPosition (copy), TweenService (copy)
        TweenService:Create(Main, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = MainPosition - UDim2.new(0.01, 0, 0, 0)
        }):Play()
    end)
    task.delay(0.2, function() -- line: 26
        -- upvalues: Main (copy), MainPosition (copy), TweenService (copy)
        TweenService:Create(Main, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Position = MainPosition
        }):Play()
    end)
end

local function ShowHUD(p2, p3, p4) -- line: 33
    -- upvalues: TweenService (copy), ShakeHUD (copy)
    p2.BillboardGui.TextLabel.Text = math.floor(p4 / p3 * 100) .. "%"
    p2.BillboardGui.Main.BarBG.Bar.Size = UDim2.new(p4 / p3, 0, 1, 0)

    local Hit = p2.BillboardGui.Main.BarBG.Hit

    Hit.Position = UDim2.new(p4 / p3, 0, 0.5, 0)
    Hit.Size = UDim2.new(0.3, 0, 3, 0)
    Hit.BackgroundTransparency = 0
    TweenService:Create(Hit, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0.05, 0, 3, 0)
    }):Play()
    task.delay(0.05, function() -- line: 50
        -- upvalues: Hit (copy), TweenService (copy)
        TweenService:Create(Hit, TweenInfo.new(0.15, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        }):Play()
    end)
    ShakeHUD(p2)
end

function t1.Show(_, p6) -- line: 60
    -- upvalues: RunService (copy), New (copy), t2 (copy), ShowHUD (copy)
    if p6 == nil or p6.PrimaryPart == nil then
        return
    end

    if t2[p6] then
        t2[p6].time = 5
    else
        local t3 = {
            time = 5,
            trove = New("Utility.Trove")()
        }

        t3.Destroy = function(p7) -- line: 70
            -- upvalues: p6 (copy), t2 (copy)
            if p7.trove then
                p7.trove:Clean()
                t2[p6] = nil
            end
        end

        local clone = script.Part:Clone()

        clone.Parent = workspace.FX
        clone.CFrame = CFrame.new(p6.PrimaryPart.Position)
        t3.trove:Add(clone)
        t3.ui = clone

        local v2 = p6:GetAttribute("maxHp") or 100

        ShowHUD(clone, v2, p6:GetAttribute("hp") or v2)
        t3.trove:Add(p6:GetAttributeChangedSignal("hp"):Connect(function() -- line: 91
            -- upvalues: p6 (copy), clone (copy), v2 (copy), ShowHUD (copy)
            ShowHUD(clone, v2, (p6:GetAttribute("hp")))
        end))
        t3.trove:Add(p6.AncestryChanged:Connect(function() -- line: 96
            -- upvalues: t3 (copy)
            t3:Destroy()
        end))
        t3.trove:Add(RunService.RenderStepped:Connect(function(p8) -- line: 100
            -- upvalues: p6 (copy), t3 (copy), clone (copy)
            t3.time -= p8

            if not (t3.time <= 0) and p6:IsDescendantOf(game) and p6.PrimaryPart ~= nil then
                clone.CFrame = CFrame.new(p6.PrimaryPart.Position)
            else
                t3:Destroy()
            end
        end))
        t2[p6] = t3
    end
end

return t1
