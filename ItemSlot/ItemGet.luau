-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DataMgr, New = _G.DataMgr, _G.New
local v1 = New("Utility.Tool")()
local v2 = New("UI.Tool")()
local t2 = {
    coin = 1200,
    gem = 1201
}
local t1 = {}

t1.Resources = function(p1) -- line: 11
    -- upvalues: DataMgr (copy), v1 (copy), v2 (copy), t2 (copy)
    local Config = DataMgr:GetConfig("ItemData", t2[p1.item[2]])

    p1.itemSlot.BG.Amount.Visible = true
    p1.itemSlot.ItemInfo.ItemName.ItemName.Text = Config.name
    p1.itemSlot.ItemInfo.Icon.Image = DataMgr:GetConfig("ImageData", Config.icon).asset

    local Config2 = DataMgr:GetConfig("QualityData", Config.quality)
    local Color = DataMgr:GetAsset(Config2.color).Color

    p1.itemSlot.BG.UIStroke.UIGradient.Color = Color
    p1.itemSlot.BG.BG.ImageColor3 = Config2.color3
    v2:UIGradientEffect(p1.itemSlot.BG.UIStroke.UIGradient, "Wave", -0.8)
    p1.itemSlot.ItemInfo.Lock.Visible = false
    p1.itemSlot.BG.Amount.Text = "x" .. v1:AN(p1.item[3], 1)
end

t1.Product = function(p2) -- line: 25
    -- upvalues: DataMgr (copy)
    p2.itemSlot.BG.Amount.Visible = true
    p2.itemSlot.ItemInfo.Lock.Visible = false

    local Config = DataMgr:GetConfig("ProductData", (tonumber(p2.item[2])))

    p2.itemSlot.ItemInfo.Icon.Image = Config.asset
    p2.itemSlot.BG.Amount.Amount.Text = "x" .. p2.item[3]
end

t1.GamePass = function(p3) -- line: 33
    -- upvalues: DataMgr (copy)
    p3.itemSlot.BG.Amount.Visible = true
    p3.itemSlot.ItemInfo.Lock.Visible = false

    local Config = DataMgr:GetConfig("GamePassData", (tonumber(p3.item[2])))

    p3.itemSlot.ItemInfo.Icon.Image = Config.asset
    p3.itemSlot.BG.Amount.Amount.Text = Config.name
end

t1.Entity = function(p4) -- line: 41
    -- upvalues: DataMgr (copy)
    p4.data = DataMgr:GetConfig("EntityData", (tonumber(p4.item[2])))
    p4.itemSlot.BG.Amount.Visible = true
    p4.itemSlot.ItemInfo.Icon.Image = DataMgr:GetConfig("ImageData", p4.data.icon).asset

    local common = DataMgr:GetConfig("QualityData", "common")
    local _ = DataMgr:GetAsset(common.color).Color

    p4.itemSlot.BG.UIStroke.Color = common.color3
    p4.itemSlot.BG.BG.ImageColor3 = common.color3
    p4.itemSlot.ItemInfo.Lock.Visible = false
    p4.itemSlot.BG.Amount.Amount.Text = p4.data.name
end

t1.Title = function(p5) -- line: 53
    -- upvalues: DataMgr (copy)
    p5.itemSlot.BG.Amount.Visible = true
    p5.itemSlot.ItemInfo.Lock.Visible = false

    local Config = DataMgr:GetConfig("TitleData", (tonumber(p5.item[2])))

    p5.itemSlot.BG.Amount.Amount.Text = Config.name
    p5.itemSlot.BG.Amount.Visible = true
    p5.itemSlot.ItemInfo.Module.Visible = false
    p5.itemSlot.ItemInfo.Icon.Image = ""

    local Asset = DataMgr:GetAsset(Config.asset)

    if Asset then
        local Title = Asset:FindFirstChild("Title")

        if Title then
            local clone = Title:Clone()

            clone.Parent = p5.itemSlot.ItemInfo.Icon
            clone.ZIndex = 2
        end
    end

    p5.itemSlot.BG.UIStroke.Color = Config.color3
    p5.itemSlot.BG.BG.ImageColor3 = Config.color3
end

t1.Skin = function(p6) -- line: 77
    -- upvalues: DataMgr (copy)
    local Config = DataMgr:GetConfig("SkinData", (tonumber(p6.item[2])))

    p6.itemSlot.BG.Amount.Visible = true
    p6.itemSlot.ItemInfo.Module.Visible = false
    p6.itemSlot.ItemInfo.Icon.Image = DataMgr:GetConfig("ImageData", Config.icon).asset

    local Config2 = DataMgr:GetConfig("QualityData", Config.quality)
    local _ = DataMgr:GetAsset(Config2.color).Color

    p6.itemSlot.BG.UIStroke.Color = Config2.color3
    p6.itemSlot.BG.BG.ImageColor3 = Config2.color3
    p6.itemSlot.ItemInfo.Lock.Visible = false
    p6.itemSlot.BG.Amount.Amount.Text = Config.name
end

return t1
