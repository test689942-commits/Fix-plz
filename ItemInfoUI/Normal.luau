-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local DataMgr, GameMgr, New = _G.DataMgr, _G.GameMgr, _G.New
local v1 = New("Utility.Tool")()

New("UI.Tool")()

function t1.Init(p1) -- line: 8
    -- upvalues: t1 (copy), DataMgr (copy), GameMgr (copy), New (copy), v1 (copy)
    local clone = script.Item:Clone()
    local Config = DataMgr:GetConfig("QualityData", p1.config.quality)
    local _ = DataMgr:GetAsset(Config.color).Color

    clone.MainInfo.Icon.Image = DataMgr:GetConfig("ImageData", p1.config.icon).asset
    clone.Title.BG.ImageLabel.ImageColor3 = Config.color3
    clone.Title.ItemName.TextColor3 = Config.color3
    clone.MainInfo.Info.ItemType.Text = p1.config.type
    clone.Info.Price.Val.Text = v1:ThousandNumber(p1.config.price ^ 0.8)
    clone.Title.ItemName.Text = p1.config.name
    clone.MainInfo.Info.ScrollingDescription.Information.Text = p1.config.introduce
    p1.ui = clone
    clone.Title.Lock.Button.MouseButton1Click:Connect(function() -- line: 23
        -- upvalues: p1 (copy), DataMgr (copy), GameMgr (copy)
        if p1.index ~= nil then
            GameMgr:PlaySound(1038)
            DataMgr:LockItem(p1.index, not p1.data.lock, p1.type)
        end
    end)

    if p1.config.script == "Chest" and p1.config.state.pool then
        local clone2 = script.Chest:Clone()

        clone2.Parent = clone

        local Config = DataMgr:GetConfig("ShopData", (tonumber(p1.config.state.pool)))

        for _, v2 in Config.pool do
            local v3 = if Config.type == "" then New("ItemSlot")(New("ItemDetails")(v2[1], v2[2])) else New("ItemSlot")({
                Config.type,
                v2[1],
                v2[2]
            })

            v3.itemSlot.Parent = clone2.ScrollingFrame
            v3.itemSlot.BG.Amount.Amount.Text = v1:AN(v2[3] / Config.allWeigh * 100, 2) .. "%"

            if p1.panel and v3.item and v3.item.id then
                v3:SetClick(function() -- line: 44
                    -- upvalues: p1 (copy), v3 (copy)
                    p1.panel:ShowChilentPanel("ItemInfoPanel", nil, {
                        v3.item
                    })
                end)
            end
        end
    end

    t1.amount(p1)
    t1.lock(p1)
end

t1.lock = function(p2) -- line: 54
    p2.ui.Title.Lock.Lock.Visible = p2.data.lock
    p2.ui.Title.Lock.UnLock.Visible = not p2.data.lock
end

t1.amount = function(p3) -- line: 59
    p3.ui.Info.Amount.Val.Text = "x" .. p3.data.amount
end

return t1
