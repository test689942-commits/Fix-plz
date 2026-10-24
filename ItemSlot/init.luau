-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("TweenService")

local DataMgr, GameMgr, _, _ = _G.DataMgr, _G.GameMgr, _G.InputMgr, _G.NetMgr
local _, _, New = _G.UIManager, _G.EventMgr, _G.New
local v1 = New("Utility.Tool")()

New("UI.Tool")()

local Slot = script.Slot
local ItemShow = require(script.ItemShow)
local ItemGet = require(script.ItemGet)
local v2 = New("EquipType")()
local t2 = {
    "common",
    "elite",
    "epic",
    "legend"
}
local t3 = {}
local t4 = {}

for _, v3 in DataMgr:GetConfig("ItemData") do
    if v3.type == "Resources" then
        t3[v3.script] = v3.id
        t4[v3.id] = v3.script
    end
end

function t1.new(p1, p2, p3, p4, ...) -- line: 35
    -- upvalues: GameMgr (copy), New (copy), Slot (copy)
    p1.itemSlot = p3 or Slot:Clone()
    p1.id = 0
    p1.change = nil
    p1.clickFunc = nil
    p1.doubleFunc = nil
    p1.trove = New("Utility.Trove")()
    p1.trove:Add(p1.itemSlot)
    p1.info = {
        p4,
        ...
    }
    p1:Change(p2)

    if p1.itemSlot:FindFirstChild("UIScale") == nil then
        Instance.new("UIScale", p1.itemSlot)
    end

    p1.itemSlot.MouseEnter:Connect(function() -- line: 50
        -- upvalues: p1 (copy), GameMgr (copy)
        GameMgr:PlaySound(1080)

        if p1.item == nil then
        end
    end)
    p1.clickTick = tick()

    if p1.itemSlot:FindFirstChild("TextButton") then
        p1.itemSlot.TextButton.MouseButton1Click:Connect(function() -- line: 79
            -- upvalues: p1 (copy), GameMgr (copy)
            GameMgr:PlaySound(1038)

            if tick() - p1.clickTick < 0.2 and p1.doubleFunc then
                p1.doubleFunc()
            elseif p1.clickFunc then
                p1.clickFunc()
            end

            if p1.item == nil then
            end
        end)
    end
end

function t1.Change(p5, p6) -- line: 97
    -- upvalues: DataMgr (copy), New (copy), ItemShow (copy), ItemGet (copy), v2 (copy), t2 (copy), t3 (copy)
    if p6 ~= nil then
        p5.itemSlot.Visible = true

        local v4

        if p6[1] == "Item" then
            if type(p6[2]) == "table" then
                v4 = New("ItemDetails", true)(p6[2])
            else
                local Config = DataMgr:GetConfig("ItemData", (tonumber(p6[2])))

                if v2[Config.type] then
                    local v7 = t2[p6[3]]

                    v4 = New("ItemDetails")(tonumber(p6[2]), 1)
                    v4.quality = v7
                    v4.level = Config.level
                else
                    v4 = New("ItemDetails")(tonumber(p6[2]), p6[3])
                end
            end
        elseif p6[1] == "Weapon" then
            if type(p6[2]) == "table" then
                v4 = New("ItemDetails", true)(p6[2])
                v4.amount = v4[3]
            else
                v4 = New("ItemDetails")(tonumber(p6[2]), 1)
            end
        elseif p6[1] == "Resources" then
            v4 = New("ItemDetails")(t3[p6[2]], p6[3])
        else
            if p6[1] == "Authority" then
                p5.itemSlot.Visible = false

                return
            end

            v4 = p6
        end

        if v4 ~= nil then
            if v4[1] ~= nil then
                p5.item = v4

                if p5.model then
                    p5.model:Destroy()
                end

                p5.itemSlot.ItemInfo.Visible = true
                p5.itemSlot.NoItem.Visible = false
                ItemGet[v4[1]](p5)
            else
                local v12 = false

                if p5.item and p5.item.id == v4.id then
                    v12 = true
                elseif p5.model then
                    p5.model:Destroy()
                end

                p5.item = v4
                p5.itemSlot.ItemInfo.Visible = true
                p5.itemSlot.NoItem.Visible = false

                if v12 then
                    (ItemShow[p5.data.type] or ItemShow.Normal)[2](p5)
                else
                    p5.data = DataMgr:GetConfig("ItemData", v4.id)

                    if p5.data == nil then
                        print(p5)
                    end

                    (ItemShow[p5.data.type] or ItemShow.Normal)[1](p5)
                end
            end
        end

        if p5.change then
            p5.change(v4)
        end
    else
        p5.item = p6

        if p5.model then
            p5.model:Destroy()
        end

        if p5.itemSlot:FindFirstChild("ItemInfo") then
            p5.itemSlot.ItemInfo.Visible = false
            p5.itemSlot.NoItem.Visible = true
            p5.itemSlot.BG.UIStroke.Color = Color3.new(0.4, 0.4, 0.4)
            p5.itemSlot.BG.BG.ImageColor3 = Color3.new(0.4, 0.4, 0.4)
            p5.itemSlot.BG.Amount.Amount.Text = ""
        end

        if p5.change then
            p5.change(p6)
        end
    end
end

function t1.SetHighLight(p7, p8) -- line: 181
    p7.itemSlot.Sel.Visible = p8
end

function t1.SetIndex(p9, p10) -- line: 192
    p9.index = p10

    if p10 then
        p9.itemSlot.Index.Text = tostring(p10)
    else
        p9.itemSlot.Index.Visible = false
    end
end

function t1.ShowDemand(p11, p12) -- line: 201
    -- upvalues: DataMgr (copy), t4 (copy)
    p11.demandValue = p12
    p11.itemSlot.BG.Amount.Amount.Visible = true

    if p11.inv == nil then
        if p11.item[1] ~= nil then
            if p11.item[1] == "Resources" then
                p11.inv = DataMgr:GetPlayerBaseData(p11.item[2])
                p11.trove:Add(DataMgr:AddDataChangeEvent(p11.item[2], function(p19) -- line: 235
                    -- upvalues: p11 (copy)
                    p11.inv = p19
                    p11:UpdataDemand(p11.inv)
                end))
            end
        elseif t4[p11.item.id] then
            local v13 = t4[p11.item.id]

            p11.inv = DataMgr:GetPlayerBaseData(v13)
            p11.trove:Add(DataMgr:AddDataChangeEvent(v13, function(p13) -- line: 209
                -- upvalues: p11 (copy)
                p11.inv = p13
                p11:UpdataDemand(p11.inv)
            end))
        else
            p11.inv = DataMgr:GetItemAmount(p11.item.id)
            p11.trove:Add(DataMgr:AddDataChangeEvent("bag", function(_, _) -- line: 215
                -- upvalues: p11 (copy)
                if p11.itemSlot == nil or p11.itemSlot.Parent == nil then
                    p11:Destroy()
                else
                    p11:UpdataDemand()
                end
            end))
            p11.trove:Add(DataMgr:AddItemChangeEvent("bag", function(p16, p17, _) -- line: 222
                -- upvalues: p11 (copy), DataMgr (copy)
                if DataMgr:GetPlayerBaseData("bag")[p16].id == p11.item.id and p17 == "amount" then
                    if p11.itemSlot == nil or p11.itemSlot.Parent == nil then
                        p11:Destroy()
                    else
                        p11:UpdataDemand()
                    end
                end
            end))
        end
    end

    p11:UpdataDemand(p11.inv)
end

function t1.UpdataDemand(p20, p21) -- line: 244
    -- upvalues: DataMgr (copy), v1 (copy)
    if p21 then
        p20.itemSlot.BG.Amount.Amount.Text = v1:AN(p20.inv, 1) .. "/" .. v1:AN(p20.demandValue, 1)
        p20.itemSlot.BG.Amount.Amount.TextColor3 = p20.demandValue <= p20.inv and Color3.new(0.254902, 1, 0.564706) or Color3.new(1, 0.415686, 0.415686)
    elseif not p20.dirty then
        p20.dirty = true
        task.defer(function() -- line: 254
            -- upvalues: p20 (copy), DataMgr (copy), v1 (copy)
            p20.inv = DataMgr:GetItemAmount(p20.item.id)
            p20.itemSlot.BG.Amount.Amount.Text = v1:AN(p20.inv, 1) .. "/" .. v1:AN(p20.demandValue, 1)
            p20.itemSlot.BG.Amount.Amount.TextColor3 = p20.demandValue <= p20.inv and Color3.new(0.254902, 1, 0.564706) or Color3.new(1, 0.415686, 0.415686)
            p20.dirty = false
        end)
    end
end

function t1.ChackDemand(p22) -- line: 262
    return p22.demandValue <= p22.inv
end

function t1.SetClick(p23, p24) -- line: 266
    p23.clickFunc = p24
end

function t1.SetDoubleClick(p25, p26) -- line: 270
    p25.doubleFunc = p26
end

function t1.Destroy(p27) -- line: 274
    p27.trove:Clean()
end

return t1
