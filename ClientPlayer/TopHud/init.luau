-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

require(script.Parent)

local TweenService = game:GetService("TweenService")
local DataMgr = _G.DataMgr
local v1 = _G.New("Utility.Tool")()

local function SetAllBillboardGuis(p1, p2, p3, p4, p5) -- line: 9
    -- upvalues: SetAllBillboardGuis (copy)
    p5 = p5 or 0

    if not p1 then
        return
    end

    local v3 = if not p1:IsA("BillboardGui") or not p1 then nil else p1

    if v3 then
        v3.Enabled = p2

        if p3 then
            if p4 then
                local v4 = p4:GetAttribute("BaseY") or v3.StudsOffsetWorldSpace.Y

                p4:SetAttribute("BaseY", v4)
                v3.StudsOffsetWorldSpace = Vector3.new(0, v4 + p3 + p5, 0)
            else
                v3.StudsOffsetWorldSpace = Vector3.new(0, 4 + p3 + p5, 0)
            end
        end
    end

    for _, child in ipairs(p1:GetChildren()) do
        SetAllBillboardGuis(child, p2, p3, p4, p5)
    end
end

local function ApplyPlayerHUDSettings(p6, p7) -- line: 31
    -- upvalues: DataMgr (copy), SetAllBillboardGuis (copy)
    local v7 = DataMgr:GetSetting("HeadTitle") ~= false
    local v8 = DataMgr:GetSetting("TitlePositon") or 0
    local v9 = if p6 and p6.Main and p6.Main.Guild and p6.Main.Guild.Visible then 0.5 else 0

    if p6 then
        SetAllBillboardGuis(p6, v7, v8, nil, 0)
    end

    if p7 then
        SetAllBillboardGuis(p7, v7, v8, p7, v9)
    end
end

local function WaitAttribute(p8, p9) -- line: 51
    if p8 ~= nil and p8.Parent ~= nil then
        local v10 = p8:GetAttribute(p9)

        while p8.Parent ~= nil and v10 == nil do
            task.wait(0.2)
            v10 = p8:GetAttribute(p9)
        end

        return v10
    end
end

local function InitEntityBuff(p10, p11, p12) -- line: 61
    -- upvalues: DataMgr (copy)
    if p10:IsA("NumberValue") then
        if p12 then
            if not p11:FindFirstChild(p10.Name) then
                local clone = script.Buff:Clone()

                clone.Parent = p11
                clone.Name = p10.Name
                clone.CD.Text = p10.Value
                p10:GetPropertyChangedSignal("Value"):Connect(function() -- line: 69
                    -- upvalues: p10 (copy), clone (copy)
                    clone.CD.Text = p10.Value
                end)

                local Config = DataMgr:GetConfig("BuffData", (tonumber(p10.Name)))

                if Config ~= nil then
                    clone.Icon.Image = DataMgr:GetConfig("ImageData", Config.icon).asset
                end
            end
        elseif p11:FindFirstChild(p10.Name) then
            p11:FindFirstChild(p10.Name):Destroy()
        end
    end
end

local function InitPlayerHUD(p13) -- line: 82
    -- upvalues: DataMgr (copy), v1 (copy), ApplyPlayerHUDSettings (copy), WaitAttribute (copy)
    local exp = WaitAttribute(p13, "exp")
    local exp2 = exp
    local score = WaitAttribute(p13, "score")
    local score2 = score
    local title = WaitAttribute(p13, "title")
    local title2 = title

    if title ~= nil then
        local HumanoidRootPart = p13:WaitForChild("HumanoidRootPart")

        if HumanoidRootPart ~= nil then
            local clone = script.PlayerHUD:Clone()

            clone.Parent = HumanoidRootPart
            clone.Name = "HUD"
            clone.Main.PlayerName.Text = "Lvl." .. v1:GetLevelWithExp(exp) .. "┃" .. p13.Name
            clone.Main.Score.ScoreText.Text = v1:TN(score)
            clone.Main.Guild.Visible = false

            local clone2

            local function UpdateGuild() -- line: 102
                -- upvalues: p13 (copy), clone (copy), clone2 (ref), ApplyPlayerHUDSettings (copy)
                local guild = p13:GetAttribute("guild")

                if not guild or guild == "" then
                    clone.Main.Guild.Visible = false
                else
                    clone.Main.Guild.Visible = true
                    clone.Main.Guild.GuildText.Text = guild
                end

                ApplyPlayerHUDSettings(clone, clone2)
            end

            task.spawn(UpdateGuild)

            if title ~= -1 then
                local Asset = DataMgr:GetAsset(DataMgr:GetConfig("TitleData", title).asset)

                if Asset then
                    local TitleUI = Asset:FindFirstChild("TitleUI")

                    if TitleUI then
                        clone2 = TitleUI:Clone()
                        clone2.Parent = HumanoidRootPart

                        local v11 = clone2:FindFirstChildWhichIsA("BillboardGui", true)

                        if v11 then
                            local Y = v11.StudsOffsetWorldSpace.Y

                            clone2:SetAttribute("BaseY", Y)
                        end
                    end
                end
            end

            ApplyPlayerHUDSettings(clone, clone2)
            p13.AttributeChanged:Connect(function(p14) -- line: 135
                -- upvalues: p13 (copy), exp2 (ref), score2 (ref), title2 (ref), HumanoidRootPart (copy), clone (copy), clone2 (ref), DataMgr (copy), v1 (copy), ApplyPlayerHUDSettings (copy)
                if p14 == "exp" then
                    exp2 = p13:GetAttribute("exp")
                    clone.Main.PlayerName.Text = "Lvl." .. v1:GetLevelWithExp(exp2) .. "┃" .. p13.Name
                elseif p14 == "score" then
                    score2 = p13:GetAttribute("score")
                    clone.Main.Score.ScoreText.Text = v1:TN(score2)
                elseif p14 == "title" then
                    title2 = p13:GetAttribute("title")

                    if clone2 then
                        clone2:Destroy()
                        clone2 = nil
                    end

                    if title2 ~= -1 then
                        local Asset = DataMgr:GetAsset(DataMgr:GetConfig("TitleData", title2).asset)

                        if Asset then
                            local TitleUI = Asset:FindFirstChild("TitleUI")

                            if TitleUI then
                                clone2 = TitleUI:Clone()
                                clone2.Parent = HumanoidRootPart

                                local v12 = clone2:FindFirstChildWhichIsA("BillboardGui", true)

                                if v12 then
                                    clone2:SetAttribute("BaseY", v12.StudsOffsetWorldSpace.Y)
                                end
                            end
                        end
                    end

                    ApplyPlayerHUDSettings(clone, clone2)
                elseif p14 == "guild" then
                    local guild = p13:GetAttribute("guild")

                    if not guild or guild == "" then
                        clone.Main.Guild.Visible = false
                    else
                        clone.Main.Guild.Visible = true
                        clone.Main.Guild.GuildText.Text = guild
                    end

                    ApplyPlayerHUDSettings(clone, clone2)
                end
            end)
        end
    end
end

local function InitEnemyHUD(p15) -- line: 170
    -- upvalues: TweenService (copy), DataMgr (copy), WaitAttribute (copy), InitEntityBuff (copy)
    local id = WaitAttribute(p15, "id")
    local hp = WaitAttribute(p15, "hp")
    local hp2 = hp
    local maxHp = WaitAttribute(p15, "maxHp")
    local maxHp2 = maxHp
    local level = WaitAttribute(p15, "level")
    local quality = WaitAttribute(p15, "quality")

    if quality ~= nil then
        local Hbar = p15:WaitForChild("Hbar")

        if Hbar ~= nil and not Hbar:FindFirstChild("HUD") then
            local clone = script.Enemy["Hud" .. math.clamp(quality, 1, 3)]:Clone()

            clone.Parent = Hbar
            clone.Name = "HUD"

            local Config = DataMgr:GetConfig("EntityData", id)

            clone.Main.Hp.Frame.Frame.Size = UDim2.new(math.clamp(hp / maxHp, 0, 1), 0, 1, 0)
            TweenService:Create(clone.Main.Hp.Frame.Frame1, TweenInfo.new(0.3), {
                Size = UDim2.new(math.clamp(hp / maxHp, 0, 1), 0, 1, 0)
            }):Play()
            clone.Main.Level.Level.Text = "Lvl." .. level
            clone.Main.Level.EntityName.Text = Config.name
            p15.AttributeChanged:Connect(function(p16) -- line: 189
                -- upvalues: p15 (copy), hp2 (ref), maxHp2 (ref), clone (copy), TweenService (copy)
                if p16 == "hp" then
                    hp2 = p15:GetAttribute("hp")
                    clone.Main.Hp.Frame.Frame.Size = UDim2.new(math.clamp(hp2 / maxHp2, 0, 1), 0, 1, 0)
                    TweenService:Create(clone.Main.Hp.Frame.Frame1, TweenInfo.new(0.3), {
                        Size = UDim2.new(math.clamp(hp2 / maxHp2, 0, 1), 0, 1, 0)
                    }):Play()

                    if hp2 <= 0 then
                        clone.Enabled = false
                    end
                elseif p16 == "maxHp" then
                    maxHp2 = p15:GetAttribute("maxHp")
                    clone.Main.Hp.Frame.Frame.Size = UDim2.new(math.clamp(hp2 / maxHp2, 0, 1), 0, 1, 0)
                    TweenService:Create(clone.Main.Hp.Frame.Frame1, TweenInfo.new(0.3), {
                        Size = UDim2.new(math.clamp(hp2 / maxHp2, 0, 1), 0, 1, 0)
                    }):Play()

                    if hp2 <= 0 then
                        clone.Enabled = false
                    end
                end
            end)

            local Buff = p15:FindFirstChild("Buff")

            if Buff then
                for _, child in Buff:GetChildren() do
                    InitEntityBuff(child, clone.Main.Buff, true)
                end

                Buff.ChildAdded:Connect(function(p17) -- line: 205
                    -- upvalues: clone (copy), InitEntityBuff (copy)
                    InitEntityBuff(p17, clone.Main.Buff, true)
                end)
                Buff.ChildRemoved:Connect(function(p18) -- line: 206
                    -- upvalues: clone (copy)
                    local Buff = clone.Main.Buff

                    if p18:IsA("NumberValue") and Buff:FindFirstChild(p18.Name) then
                        Buff:FindFirstChild(p18.Name):Destroy()
                    end
                end)
            else
                local connection

                connection = p15.ChildAdded:Connect(function(p19) -- line: 209
                    -- upvalues: clone (copy), connection (ref), InitEntityBuff (copy)
                    if p19.Name == "Buff" then
                        connection:Disconnect()

                        for _, child in p19:GetChildren() do
                            InitEntityBuff(child, clone.Main.Buff, true)
                        end

                        p19.ChildAdded:Connect(function(p20) -- line: 213
                            -- upvalues: clone (copy), InitEntityBuff (copy)
                            InitEntityBuff(p20, clone.Main.Buff, true)
                        end)
                        p19.ChildRemoved:Connect(function(p21) -- line: 214
                            -- upvalues: clone (copy)
                            local Buff = clone.Main.Buff

                            if p21:IsA("NumberValue") and Buff:FindFirstChild(p21.Name) then
                                Buff:FindFirstChild(p21.Name):Destroy()
                            end
                        end)
                    end
                end)
            end
        end
    end
end

function t1.Init(p22) -- line: 220
    -- upvalues: TweenService (copy), DataMgr (copy)
    local v22 = DataMgr:GetPlayerBaseData("exp")

    p22.trove:Add(DataMgr:AddDataChangeEvent("exp", function(p23) -- line: 222
        -- upvalues: p22 (copy), v22 (ref), TweenService (copy)
        local clone = script.Part:Clone()

        clone.CFrame = p22.HumanoidRootPart.CFrame * CFrame.new(0, (math.random() - 0.5) * 2, 0)
        clone.Parent = workspace.FX
        clone.TipList.Main.Tip.Text = "+" .. math.floor(p23 - v22) .. " Exp"

        local UIScale = Instance.new("UIScale", clone.TipList.Main.Tip)

        UIScale.Scale = 0
        TweenService:Create(UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
            Scale = 1
        }):Play()
        task.delay(3, function() -- line: 230
            -- upvalues: clone (copy), UIScale (copy), TweenService (copy)
            TweenService:Create(UIScale, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
                Scale = 0
            }):Play()
            task.delay(0.3, function() -- line: 232
                -- upvalues: clone (copy)
                clone:Destroy()
            end)
        end)
        v22 = p23
    end))
end

task.spawn(function() -- line: 238
    -- upvalues: InitEnemyHUD (copy)
    for _, child in workspace.Entity:GetChildren() do
        task.spawn(InitEnemyHUD, child)
    end

    workspace.Entity.ChildAdded:Connect(function(p24) -- line: 240
        -- upvalues: InitEnemyHUD (copy)
        task.spawn(InitEnemyHUD, p24)
    end)
end)
task.spawn(function() -- line: 242
    -- upvalues: InitPlayerHUD (copy)
    for _, child in workspace.Characters:GetChildren() do
        task.spawn(InitPlayerHUD, child)
    end

    workspace.Characters.ChildAdded:Connect(function(p25) -- line: 244
        -- upvalues: InitPlayerHUD (copy)
        task.spawn(InitPlayerHUD, p25)
    end)
end)
DataMgr:AddSettingChangeEvent("HeadTitle", function() -- line: 247
    -- upvalues: ApplyPlayerHUDSettings (copy)
    for _, child in ipairs(workspace.Characters:GetChildren()) do
        local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

        if HumanoidRootPart then
            ApplyPlayerHUDSettings(HumanoidRootPart:FindFirstChild("HUD"), (HumanoidRootPart:FindFirstChild("TitleUI")))
        end
    end
end)
DataMgr:AddSettingChangeEvent("TitlePositon", function() -- line: 258
    -- upvalues: ApplyPlayerHUDSettings (copy)
    for _, child in ipairs(workspace.Characters:GetChildren()) do
        local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

        if HumanoidRootPart then
            ApplyPlayerHUDSettings(HumanoidRootPart:FindFirstChild("HUD"), (HumanoidRootPart:FindFirstChild("TitleUI")))
        end
    end
end)

return t1
