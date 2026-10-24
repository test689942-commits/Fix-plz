-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local Parent = require(script.Parent)
local New, DataMgr, EventMgr = _G.New, _G.DataMgr, _G.EventMgr

local function InitBag(p1) -- line: 7
    -- upvalues: New (copy), DataMgr (copy)
    p1.bag = DataMgr:GetPlayerBaseData("bag")
    p1.trove:Add(DataMgr:AddItemChangeEvent("bag", function(p2, p3, p4) -- line: 10
        -- upvalues: p1 (copy)
        if p2 == p1.equipIndex then
            p1.equippedItem:Change(p3, p4)
        end
    end))
    p1.equip = {}

    for v1, v2 in DataMgr:GetPlayerBaseData("equipData") do
        p1.equip[v1] = New("BaseItem")(p1, v2, v1)

        if v1 ~= "main" then
            p1.equip[v1]:Equip()
        end
    end

    p1.trove:Add(DataMgr:AddDataChangeEvent("equipData", function(p5, p6) -- line: 24
        -- upvalues: p1 (copy), New (copy)
        if p1.equip[p5] then
            p1.equip[p5]:Destroy()
        end

        if p6 then
            p1.equip[p5] = New("BaseItem")(p1, p6, p5)

            if p5 ~= "main" then
                p1.equip[p5]:Equip()
            end
        else
            p1.equip[p5] = nil
        end
    end))
    p1.trove:Add(DataMgr:AddItemChangeEvent("equipData", function(p7, p8, p9) -- line: 37
        -- upvalues: p1 (copy)
        p1.equip[p7]:Change(p8, p9)
    end))
    p1.trove:Add(function() -- line: 41
        -- upvalues: p1 (copy)
        p1:OnUnequipItem()
    end)
    p1.Humanoid.Seated:Connect(function() -- line: 45
        -- upvalues: p1 (copy)
        p1:OnUnequipItem()
    end)
    p1.trove:Add(task.spawn(function() -- line: 49
        -- upvalues: p1 (copy)
        while true do
            task.wait(0.1)

            if p1.equippedItem == nil and p1.equip.main ~= nil then
                p1:EquipItem("main")
            end
        end
    end))
end

function t1.Init(p10) -- line: 59
    -- upvalues: InitBag (copy)
    p10.equippedItem = nil
    p10.equipIndex = -1
    p10:AddEvent("FinishLoad", InitBag)
end

function Parent.SetPunch(p11, p12) -- line: 66
    if p12 then
        if not p11.punchSkill then
            p11.punchSkill = p11:AddSkill("Punch", Enum.UserInputType.MouseButton1)
            p11.blockSkill = p11:AddSkill("BlockSkill", Enum.KeyCode.F)
        end
    elseif p11.punchSkill then
        p11.punchSkill:Unequip()
        p11.punchSkill = nil
        p11.blockSkill:Unequip()
        p11.blockSkill = nil
    end
end

function Parent.EquipItem(p13, p14) -- line: 83
    if p13:ChackState("action") or p13.Humanoid.Sit or p13.equipIndex == p14 then
        return
    end

    local v3 = type(p14) == "string"
    local v4, v5

    if v3 then
        v4 = p13.equip[p14] == nil
    else
        v5 = p13.bag[p14] == nil
    end

    if v3 and not v4 or not v3 and not v5 then
        p13:ReplicatedPlayer("EquipItem", p14)
    end
end

function Parent.OnEquipItem(p15, p16, p17) -- line: 103
    -- upvalues: EventMgr (copy)
    p15.equippedItem = type(p16) == "number" and p15.bag[p16] or p15.equip[p16]
    p15.equipItemModel = p17 or p15.Character:FindFirstChild("Tool")

    if p15.equippedItem ~= nil then
        p15.equippedItem.model = p15.equipItemModel
        p15.equippedItem:Equip()
        p15.equipIndex = p16
        p15.eventMgr:Triger("EquipItem", p15.equippedItem)
        EventMgr:Triger("EquipItem", p15.equippedItem)
    else
        p15.equipIndex = -1
    end

    p15.eventMgr:Triger("OnEquipItemChange", p15.equipIndex)
end

function Parent.UnequipItem(p18) -- line: 120
    if not p18:ChackState("action") then
        p18.equipItemModel = nil

        if p18.equippedItem ~= nil then
            p18:ReplicatedPlayer("UnequipItem")
            p18:OnUnequipItem()
        end
    end
end

function Parent.OnUnequipItem(p19) -- line: 131
    -- upvalues: EventMgr (copy)
    if p19.equippedItem == nil then
        return
    end

    local equippedItem = p19.equippedItem

    p19.equippedItem.model = nil
    p19.equippedItem:Unequip()
    p19.equippedItem = nil
    p19.equipIndex = -1
    p19.eventMgr:Triger("UnEquipItem", equippedItem)
    EventMgr:Triger("EquipItem")
    p19.eventMgr:Triger("OnEquipItemChange", p19.equipIndex)
end

function Parent.IsHaveItem(p20, p21, p22) -- line: 144
    local count = p20.bag.count
    local v6 = p22

    for i = 1, count do
        local v7 = p20.bag[i]

        if v7 ~= nil and v7.detail.id == p21 then
            v6 -= v7.detail.amount

            if v6 <= 0 then
                return true
            end
        end
    end

    return false
end

return t1
