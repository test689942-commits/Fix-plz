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

local function GetModifierFr(p1, p2) -- line: 11
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
    local clone = script.Weapon:Clone()
    local config = p3.config

    clone.MainInfo.Icon.Image = DataMgr:GetConfig("ImageData", p3.config.icon).asset
    clone.MainInfo.Info.ItemType.Text = config.type
    clone.Title.WeaponName.Text = v2:Translate(config.name) .. " Lv." .. p3.data.level
    clone.MainAttribute.AttackSpeed.Text = config.rof .. " <font color='#8c8c8c'>" .. v2:Translate("Attack Speed") .. "</font>"
    clone.Information.Information.Text = "“" .. v2:Translate(config.introduce) .. "”"
    p3.ui = clone
    clone.Title.Lock.Button.MouseButton1Click:Connect(function() -- line: 42
        -- upvalues: p3 (copy), DataMgr (copy), GameMgr (copy)
        if p3.index ~= nil then
            GameMgr:PlaySound(1038)
            DataMgr:LockItem(p3.index, not p3.data.lock, p3.type)
        end
    end)
    t1.quality(p3, true)
    t1.modifier(p3)
    t1.skill(p3)
    t1.reinforce(p3)
    t1.lock(p3)
end

t1.lock = function(p4) -- line: 56
    p4.ui.Title.Lock.Lock.Visible = p4.data.lock
    p4.ui.Title.Lock.UnLock.Visible = not p4.data.lock
end

t1.score = function(p5) -- line: 61
    -- upvalues: v1 (copy)
    local EquipmentSorce = v1:GetEquipmentSorce(p5.data)

    p5.ui.MainInfo.Info.Score.Text = v1:AN(EquipmentSorce, 1)
    p5.ui.Info.Price.Val.Text = v1:ThousandNumber(EquipmentSorce ^ 0.8)
end

t1.reinforce = function(p6) -- line: 67
    -- upvalues: v2 (copy)
    p6.ui.MainAttribute.Attack.Text = math.floor(p6.config.atk * (1 + p6.data.reinforce / 100) * 10) / 10 .. (p6.data.reinforce > 0 and "<font color='#00ff51'>(+" .. p6.data.reinforce .. "%)</font>" or "") .. " <font color='#8c8c8c'>" .. v2:Translate("Attack") .. "</font>"
end

t1.divine = function(p7) -- line: 77
    -- upvalues: DataMgr (copy)
    if p7.data.divine then
        p7.ui.Title.BG.UIGradient.Color = DataMgr:GetAsset("Model/Color/Holy").Color
    end
end

t1.quality = function(p8, p9) -- line: 83
    -- upvalues: t1 (copy), DataMgr (copy)
    local Config = DataMgr:GetConfig("QualityData", p8.data.quality)
    local _ = DataMgr:GetAsset(Config.color).Color

    p8.ui.Title.BG.ImageLabel.ImageColor3 = Config.color3
    p8.ui.Title.WeaponName.TextColor3 = Config.color3
    p8.ui.Information.Information.TextColor3 = Config.color3

    if not p9 then
        t1.score(p8)
    end
end

t1.modifier = function(p10) -- line: 97
    -- upvalues: t1 (copy), DataMgr (copy), GetModifierFr (copy)
    if p10.modifier then
        for _, v7 in p10.modifier do
            v7:Destroy()
        end
    end

    if p10.data.modifier then
        p10.modifier = {}

        for _, v8 in p10.data.modifier.prefix do
            local v9 = GetModifierFr(v8, 1)

            v9.Parent = p10.ui.Modifier
            table.insert(p10.modifier, v9)
        end

        for _, v10 in p10.data.modifier.suffix do
            local v11 = GetModifierFr(v10, 2)

            v11.Parent = p10.ui.Modifier
            table.insert(p10.modifier, v11)
        end

        if p10.data.modifier.divine then
            for _, v12 in p10.data.modifier.divine do
                local v13 = GetModifierFr(v12, 3)

                v13.Parent = p10.ui.Modifier
                table.insert(p10.modifier, v13)
                v13.UIGradient.Color = DataMgr:GetAsset("Model/Color/Holy").Color
            end
        end

        if p10.data.modifier.unique then
            for _, v14 in p10.data.modifier.unique do
                local v15 = GetModifierFr(v14, 3)

                v15.Parent = p10.ui.Modifier
                table.insert(p10.modifier, v15)
                v15.UIGradient.Color = DataMgr:GetAsset("Model/Color/Holy").Color
            end
        end
    end

    t1.score(p10)
end

t1.skill = function(p11) -- line: 136
    -- upvalues: DataMgr (copy), v2 (copy)
    if p11.data.skill ~= nil then
        local ClientPlayer = DataMgr:GetClientPlayer(true)
        local v16 = p11.data.level + (ClientPlayer and ClientPlayer.skill_Level_up or 0)

        for i = 1, 3 do
            local v17 = p11.data.skill[i]

            if v17 ~= nil then
                local Config = DataMgr:GetConfig("SkillData", v17.id)
                local v18 = p11.ui.Skill.ScrollingFrame["Skill" .. i]

                v18.Icon.Image = DataMgr:GetConfig("ImageData", Config.icon).asset
                v18.Info.SkillName.Text = v2:Translate(Config.name) .. " Lv." .. math.floor(1 + (v16 - 1) * (v17.mutation or 1))

                local t4 = {}

                for v21, v22 in Config.value do
                    t4[v21] = "<font color='#00ff51'>" .. math.floor((v22 + (v16 - 1) * (v17.mutation or 1) * Config.addValue[v21]) * 100) / 100 .. "</font>"
                end

                v2:FormatString(v18.Info.Information, Config.introduce, t4)
            else
                p11.ui.Skill.ScrollingFrame["Skill" .. i].Visible = false
            end
        end
    else
        p11.ui.Skill.Visible = false
    end
end

return t1
