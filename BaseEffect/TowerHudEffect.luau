-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("TweenService")

local PoolMgr, DataMgr = _G.PoolMgr, _G.DataMgr

_G.New("Utility.Tool")()

function t1.Show(p1, p2) -- line: 8
    -- upvalues: PoolMgr (copy), DataMgr (copy)
    p1.effect = PoolMgr:Get("Effect_TowerHud", script.Hud)
    p1.effect.Parent = p2.Character
    p1:Weld(p2.Character.Head, p1.effect)

    local Enchant = p1.effect.Attachment.BillboardGui.Enchant
    local Potential = p1.effect.Attachment.BillboardGui.Info.Potential
    local Val = p1.effect.Attachment.BillboardGui.Info.Level.Val
    local TowerName = p1.effect.Attachment.BillboardGui.Info.TowerName

    TowerName.Text = p2.config.name
    Val.Text = p2.data.level

    if p2.data.enchant == 0 then
        Enchant.Visible = false
    else
        Enchant.Visible = true

        local Config = DataMgr:GetConfig("EnchantData", p2.data.enchant)
        local Color = DataMgr:GetAsset(Config.color).Color

        Enchant.ImageLabel.Image = DataMgr:GetConfig("ImageData", Config.icon).asset
        Enchant.ImageLabel.UIGradient.Color = Color
    end

    if p2.data.potential == 0 then
        Potential.Visible = false
    else
        Potential.Visible = true
        Potential.Image = DataMgr:GetConfig("ImageData", math.min(6, p2.data.potential) + 2097).asset
    end

    p2.OnAttributeChange:Add(function(p3, _) -- line: 38
        -- upvalues: p2 (copy), Enchant (copy), Potential (copy), Val (copy), TowerName (copy), DataMgr (copy)
        if p3 ~= "data" then
            return
        end

        TowerName.Text = p2.config.name
        Val.Text = p2.data.level

        if p2.data.enchant == 0 then
            Enchant.Visible = false
        else
            Enchant.Visible = true

            local Config = DataMgr:GetConfig("EnchantData", p2.data.enchant)
            local Color = DataMgr:GetAsset(Config.color).Color

            Enchant.ImageLabel.Image = DataMgr:GetConfig("ImageData", Config.icon).asset
            Enchant.ImageLabel.UIGradient.Color = Color
        end

        if p2.data.potential == 0 then
            Potential.Visible = false

            return
        end

        Potential.Visible = true
        Potential.Image = DataMgr:GetConfig("ImageData", math.min(6, p2.data.potential) + 2097).asset
    end)
end

function t1.Hide(p5) -- line: 63
    -- upvalues: PoolMgr (copy)
    if p5.effect and p5.effect.Parent then
        PoolMgr:Push("Effect_TowerHud", p5.effect)
    end
end

return t1
