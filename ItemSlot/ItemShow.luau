-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local DataMgr, New = _G.DataMgr, _G.New

New("Utility.Tool")()
New("UI.Tool")()
t1.Normal = {
    function(p1) -- line: 8
        -- upvalues: t1 (copy), DataMgr (copy)
        p1.itemSlot.BG.Amount.Visible = true
        p1.itemSlot.ItemInfo.Module.Visible = false
        p1.itemSlot.ItemInfo.Icon.Image = DataMgr:GetConfig("ImageData", p1.data.icon).asset

        local Config = DataMgr:GetConfig("QualityData", p1.data.quality)
        local _ = DataMgr:GetAsset(Config.color).Color

        p1.itemSlot.BG.UIStroke.Color = Config.color3
        p1.itemSlot.BG.BG.ImageColor3 = Config.color3

        if p1.itemSlot.ItemInfo:FindFirstChild("Divine") then
            p1.itemSlot.ItemInfo.Divine.Visible = false
        end

        t1.Normal[2](p1)
    end,
    function(p2) -- line: 23
        p2.itemSlot.ItemInfo.Lock.Visible = p2.item.lock
        p2.itemSlot.BG.Amount.Amount.Text = "x" .. p2.item.amount
    end
}
t1.Weapon = {
    function(p3) -- line: 30
        -- upvalues: t1 (copy), DataMgr (copy)
        p3.itemSlot.BG.Amount.Visible = true
        p3.itemSlot.ItemInfo.Icon.Image = DataMgr:GetConfig("ImageData", p3.data.icon).asset
        t1.Weapon[2](p3)
    end,
    function(p4) -- line: 36
        -- upvalues: DataMgr (copy)
        local Config = DataMgr:GetConfig("QualityData", p4.item.quality or p4.data.quality)
        local _ = DataMgr:GetAsset(Config.color).Color

        p4.itemSlot.BG.UIStroke.Color = Config.color3
        p4.itemSlot.BG.BG.ImageColor3 = Config.color3

        if p4.itemSlot.ItemInfo:FindFirstChild("Divine") then
            p4.itemSlot.ItemInfo.Divine.Visible = p4.item.divine
        end

        p4.itemSlot.BG.Amount.Amount.Text = "Lv." .. (p4.item.level or p4.data.level)
        p4.itemSlot.ItemInfo.Lock.Visible = p4.item.lock

        if p4.item.skill then
            if #p4.item.skill > 0 then
                p4.itemSlot.ItemInfo.Module.Visible = true

                for i = 1, 4 do
                    if i <= #p4.item.skill then
                        local v2 = p4.itemSlot.ItemInfo.Module["Mod" .. i]

                        v2.Visible = true
                        v2.Image = DataMgr:GetConfig("ImageData", DataMgr:GetConfig("SkillData", p4.item.skill[i].id).icon).asset
                    else
                        p4.itemSlot.ItemInfo.Module["Mod" .. i].Visible = false
                    end
                end
            else
                p4.itemSlot.ItemInfo.Module.Visible = false
            end
        end
    end
}
t1.Helmet = {
    function(p5) -- line: 68
        -- upvalues: t1 (copy), DataMgr (copy)
        p5.itemSlot.BG.Amount.Visible = true
        p5.itemSlot.ItemInfo.Module.Visible = false
        p5.itemSlot.ItemInfo.Icon.Image = DataMgr:GetConfig("ImageData", p5.data.icon).asset
        t1.Weapon[2](p5)
    end,
    function(p6) -- line: 75
        -- upvalues: DataMgr (copy)
        local Config = DataMgr:GetConfig("QualityData", p6.item.quality or p6.data.quality)
        local _ = DataMgr:GetAsset(Config.color).Color

        p6.itemSlot.BG.UIStroke.Color = Config.color3
        p6.itemSlot.BG.BG.ImageColor3 = Config.color3
        p6.itemSlot.ItemInfo.Lock.Visible = p6.item.lock

        if p6.itemSlot.ItemInfo:FindFirstChild("Divine") then
            p6.itemSlot.ItemInfo.Divine.Visible = p6.item.divine
        end

        p6.itemSlot.BG.Amount.Amount.Text = "Lv." .. (p6.item.level or p6.data.level)
    end
}
t1.Cuirass = t1.Helmet
t1.Glove = t1.Helmet
t1.Boots = t1.Helmet
t1.Accessory = t1.Helmet

return t1
