-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DialogueData = _G.SubClass("DialogueData")
local _ = game:GetService("Players").LocalPlayer
local UIManager, New, _, _ = _G.UIManager, _G.New, _G.DataMgr, _G.GameMgr
local _ = _G.EventMgr

New("Utility.Tool")()

function DialogueData.new(p1, p2) -- line: 10
    p1.pp = p2
    p1.TalkName = "Warehouse"
    p1.TalkContent = "The secret chamber of the temple is temporarily used as a warehouse, traveler. Do you want to store the clutter in your backpack or take out the deposited items?"
    p1.TalkChoice = { "Store Items", "Not Needed For Now" }
end

function DialogueData.Choice(p3, p4) -- line: 18
    -- upvalues: UIManager (copy)
    if p4 == 1 then
        UIManager:ShowPanel("InventoryPanel", nil, true, {
            p3.pp
        })
    end
end

return DialogueData
