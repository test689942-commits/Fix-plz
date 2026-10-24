-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local DataMgr, GameMgr, _, New = _G.DataMgr, _G.GameMgr, _G.UIManager, _G.New
local v1 = New("Utility.Tool")()
local v2 = New("UI.Tool")()
local t2 = {
    "◈",
    "◉",
    "❖"
}

local function GetModifierFr(p1, p2) -- line: 10
    -- upvalues: DataMgr (copy), v2 (copy), t2 (copy)
    local Config = DataMgr:GetConfig("ModifierData", p1.id)
    local clone = script.Modifier:Clone()
    local t3 = {}

    for v3, _ in Config.base do
        local v4 = p1.quality - (1 - p1.value)

        t3[v3] = "<font color='#ffffff'>" .. math.floor((((v4 * v4 - 1) * Config.mul[v3] + 1) * Config.value[v3] + Config.base[v3]) * (p1.mutation or 1) * 10) / 10 .. "</font>"
    end

    clone.Text = "<font color='#8c8c8c'>" .. t2[p2] .. " </font>" .. v2:FormatByKey(Config.introduce, t3)
    clone.UIGradient.Color = DataMgr:GetAsset(DataMgr:GetConfig("QualityData")[p1.quality].color).Color

    if p1.lock then
        clone.BackgroundTransparency = 0.8
        clone.BackgroundColor3 = Color3.new(1, 1, 0)
    end

    return clone
end

function t1.Init(p3) -- line: 31
    -- upvalues: t1 (copy), DataMgr (copy), GameMgr (copy), v2 (copy)
    p3.config = DataMgr:GetConfig("EquipData", p3.data.id)

    local clone = script.Equipment:Clone()

    clone.MainInfo.Info.ItemType.Text = p3.config.type
    clone.MainInfo.Icon.Image = DataMgr:GetConfig("ImageData", p3.config.icon).asset
    clone.Title.ItemName.Text = v2:Translate(p3.config.name) .. " Lv." .. p3.data.level
    clone.Information.Information.Text = "“" .. v2:Translate(p3.config.introduce) .. "”"
    p3.ui = clone
    clone.Title.Lock.Button.MouseButton1Click:Connect(function() -- line: 39
        -- upvalues: p3 (copy), DataMgr (copy), GameMgr (copy)
        if p3.index ~= nil then
            GameMgr:PlaySound(1038)
            DataMgr:LockItem(p3.index, not p3.data.lock, p3.type)
        end
    end)
    t1.quality(p3, true)
    t1.modifier(p3)
    t1.reinforce(p3)
    t1.lock(p3)
end

t1.lock = function(p4) -- line: 52
    p4.ui.Title.Lock.Lock.Visible = p4.data.lock
    p4.ui.Title.Lock.UnLock.Visible = not p4.data.lock
end

t1.score = function(p5) -- line: 57
    -- upvalues: v1 (copy)
    local EquipmentSorce = v1:GetEquipmentSorce(p5.data)

    p5.ui.MainInfo.Info.Score.Text = v1:AN(EquipmentSorce, 1)
    p5.ui.Info.Price.Val.Text = v1:ThousandNumber(EquipmentSorce ^ 0.8)
end

t1.reinforce = function(p6) -- line: 63
    if p6.at == nil then
        p6.at = {}
    end

    for v6, v7 in p6.config.attribute do
        if p6.at[v6] == nil then
            p6.at[v6] = script.Attribute:Clone()
            p6.at[v6].Parent = p6.ui.MainAttribute
        end

        p6.at[v6].Text = math.floor(v7 * (1 + p6.data.reinforce / 100) * 10) / 10 .. (p6.data.reinforce > 0 and "<font color='#00ff51'>(+" .. p6.data.reinforce .. "%)</font>" or "") .. " <font color='#8c8c8c'>" .. string.upper(v6) .. "</font>"
    end
end

t1.divine = function(p7) -- line: 82
    -- upvalues: DataMgr (copy)
    if p7.data.divine then
        p7.ui.Title.BG.UIGradient.Color = DataMgr:GetAsset("Model/Color/Holy").Color
    end
end

t1.quality = function(p8, p9) -- line: 88
    -- upvalues: t1 (copy), DataMgr (copy)
    local Config = DataMgr:GetConfig("QualityData", p8.data.quality)
    local _ = DataMgr:GetAsset(Config.color).Color

    p8.ui.Title.BG.ImageLabel.ImageColor3 = Config.color3
    p8.ui.Title.ItemName.TextColor3 = Config.color3
    p8.ui.Information.Information.TextColor3 = Config.color3

    if not p9 then
        t1.score(p8)
    end
end

t1.modifier = function(p10) -- line: 103
    -- upvalues: t1 (copy), DataMgr (copy), GetModifierFr (copy)
    if p10.modifier then
        for _, v10 in p10.modifier do
            v10:Destroy()
        end
    end

    if p10.data.modifier then
        p10.modifier = {}

        for _, v11 in p10.data.modifier.prefix do
            local v12 = GetModifierFr(v11, 1)

            v12.Parent = p10.ui.Modifier
            table.insert(p10.modifier, v12)
        end

        for _, v13 in p10.data.modifier.suffix do
            local v14 = GetModifierFr(v13, 2)

            v14.Parent = p10.ui.Modifier
            table.insert(p10.modifier, v14)
        end

        if p10.data.modifier.divine then
            for _, v15 in p10.data.modifier.divine do
                local v16 = GetModifierFr(v15, 3)

                v16.Parent = p10.ui.Modifier
                table.insert(p10.modifier, v16)
                v16.UIGradient.Color = DataMgr:GetAsset("Model/Color/Holy").Color
            end
        end

        if p10.data.modifier.unique then
            for _, v17 in p10.data.modifier.unique do
                local v18 = GetModifierFr(v17, 3)

                v18.Parent = p10.ui.Modifier
                table.insert(p10.modifier, v18)
                v18.UIGradient.Color = DataMgr:GetAsset("Model/Color/Holy").Color
            end
        end
    end

    t1.score(p10)
end

return t1
