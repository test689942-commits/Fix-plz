-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DataMgr, New = _G.DataMgr, _G.New
local v1 = New("Utility.Tool")()
local v2 = New("UI.Tool")()
local t1 = {}

t1.Normal = function(p1, p2) -- line: 7
    -- upvalues: DataMgr (copy), v2 (copy)
    local clone = script.Item:Clone()
    local Config = DataMgr:GetConfig("QualityData", p1.quality)
    local Color = DataMgr:GetAsset(Config.color).Color

    clone.Title.BG.UIGradient.Color = Color
    v2:UIGradientEffect(clone.Title.BG.UIGradient, "Wave", -0.8)
    clone.Title.WeaponType.TextColor3 = Config.color3
    clone.Title.WeaponType.Text = p1.type
    clone.MainInfo.Info.ItemName.Text = p1.name
    clone.MainInfo.Info.Amount.Text = "x" .. p2.amount
    clone.Information.Information.Text = p1.introduce

    return clone
end

local function GetModifierFr(p3) -- line: 23
    -- upvalues: DataMgr (copy), v1 (copy)
    local Config = DataMgr:GetConfig("ModifierData", p3.id)
    local clone = script.Modifier:Clone()
    local t2 = {}

    for v3, _ in Config.base do
        local v4 = self.data.quality - (1 - self.data.value)

        self.value[index] = math.floor((((v4 * v4 - 1) * self.config.mul[index] + 1) * self.config.value[index] + self.config.base[index]) * 10) / 10
        t2[v3] = "<font color='#00ff51'>" .. math.floor(((u + p3.value * (n - u)) * Config.value[v3] + Config.base[v3]) * 10) / 10 .. "</font>"
    end

    clone.Text = v1:FormatString(Config.introduce, t2)
    clone.UIGradient.Color = DataMgr:GetAsset(DataMgr:GetConfig("QualityData")[p3.quality].color).Color

    return clone
end

t1.Weapon = function(p4, p5) -- line: 42
    -- upvalues: DataMgr (copy), v1 (copy), v2 (copy), GetModifierFr (copy)
    local clone = script.Weapon:Clone()
    local Config = DataMgr:GetConfig("QualityData", p5.quality)
    local Color = DataMgr:GetAsset(Config.color).Color

    clone.Title.BG.UIGradient.Color = Color
    v2:UIGradientEffect(clone.Title.BG.UIGradient, "Wave", -0.8)
    clone.Title.WeaponType.TextColor3 = Config.color3
    clone.Title.WeaponType.Text = p4.type .. " Lv." .. p5.level
    clone.MainInfo.Info.ItemName.Text = p4.name
    clone.MainInfo.Info.Attack.Text = p4.atk .. " <font color='#8c8c8c'>Attack</font>"
    clone.MainInfo.Info.AttackSpeed.Text = p4.rof .. " <font color='#8c8c8c'>Attack Speed</font>"
    clone.MainInfo.Info.Score.Score.Text = v1:AN(v1:GetEquipmentSorce(p5))

    if p5.modifier then
        print(p5.modifier)

        for _, v7 in p5.modifier.prefix do
            GetModifierFr(v7).Parent = clone.Modifier
        end

        for _, v8 in p5.modifier.suffix do
            GetModifierFr(v8).Parent = clone.Modifier
        end

        if p5.modifier.divine then
            for _, v9 in p5.modifier.divine do
                local v10 = GetModifierFr(v9)

                v10.Parent = clone.Modifier
                v10.UIGradient.Color = DataMgr:GetAsset("Modle/Color/Holy").Color
            end
        end
    end

    if p5.skill ~= nil then
        local ClientPlayer = DataMgr:GetClientPlayer(true)
        local v11 = p5.level + (ClientPlayer and ClientPlayer.skill_Level_up or 0)

        for i = 1, 3 do
            local v12 = p5.skill[i]

            if v12 ~= nil then
                local Config = DataMgr:GetConfig("SkillData", v12.id)
                local v13 = clone.Skill["Skill" .. i]

                v13.Icon.Image = DataMgr:GetConfig("ImageData", Config.icon).asset
                v13.Info.SkillName.Text = Config.name .. " Lv." .. v11

                local t3 = {}

                for v14, v15 in Config.value do
                    t3[v14] = "<font color='#00ff51'>" .. math.floor((v15 + (v11 - 1) * Config.addValue[v14]) * 10) / 10 .. "</font>"
                end

                v13.Info.Information.Text = v1:FormatString(Config.introduce, t3)
            else
                clone.Skill["Skill" .. i].Visible = false
            end
        end
    else
        clone.Skill.Visible = false
    end

    clone.Information.Information.Text = p4.introduce

    return clone
end

t1.Equipment = function(_, p7) -- line: 101
    -- upvalues: DataMgr (copy), v1 (copy), v2 (copy), GetModifierFr (copy)
    local Config = DataMgr:GetConfig("EquipData", p7.id)
    local clone = script.Equipment:Clone()
    local Config2 = DataMgr:GetConfig("QualityData", p7.quality)
    local Color = DataMgr:GetAsset(Config2.color).Color

    clone.Title.BG.UIGradient.Color = Color
    v2:UIGradientEffect(clone.Title.BG.UIGradient, "Wave", -0.8)
    clone.Title.WeaponType.TextColor3 = Config2.color3
    clone.Title.WeaponType.Text = Config.type .. " Lv." .. p7.level
    clone.MainInfo.Info.ItemName.Text = Config.name

    for v17, v18 in Config.attribute do
        local clone2 = script.Attribute:Clone()

        clone2.Parent = clone.MainInfo.Info.Attribute
        clone2.Text = v18 .. " <font color='#8c8c8c'>" .. string.upper(v17) .. "</font>"
    end

    clone.MainInfo.Info.Score.Score.Text = v1:AN(v1:GetEquipmentSorce(p7))

    if p7.modifier then
        print(p7.modifier)

        for _, v19 in p7.modifier.prefix do
            GetModifierFr(v19).Parent = clone.Modifier
        end

        for _, v20 in p7.modifier.suffix do
            GetModifierFr(v20).Parent = clone.Modifier
        end

        if p7.modifier.divine then
            for _, v21 in p7.modifier.divine do
                local v22 = GetModifierFr(v21)

                v22.Parent = clone.Modifier
                v22.UIGradient.Color = DataMgr:GetAsset("Modle/Color/Holy").Color
            end
        end
    end

    clone.Information.Information.Text = Config.introduce

    return clone
end

t1.Helmet = t1.Equipment
t1.Cuirass = t1.Equipment
t1.Glove = t1.Equipment
t1.Boots = t1.Equipment

return function(p8) -- line: 145
    -- upvalues: DataMgr (copy), t1 (copy)
    local Config = DataMgr:GetConfig("ItemData", p8.id)

    if t1[Config.type] then
        return t1[Config.type](Config, p8)
    end

    return t1.Normal(Config, p8)
end
