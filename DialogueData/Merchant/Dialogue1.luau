-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DialogueData = _G.SubClass("DialogueData")
local _ = game:GetService("Players").LocalPlayer
local UIManager, New, _, _ = _G.UIManager, _G.New, _G.DataMgr, _G.GameMgr
local _ = _G.EventMgr

New("Utility.Tool")()

function DialogueData.new(p1, p2) -- line: 10
    p1.pp = p2
    p1.TalkName = "Merchant"
    p1.TalkContent = "Don’t be fooled by this dilapidated temple, traveler. I have goods that can help you get through the desolate village and necropolis—want to take a look?"
    p1.TalkChoice = { "Check Your Goods", "Sell My Spare Items", "Not Needed For Now" }
end

function DialogueData.Choice(p3, p4) -- line: 16
    -- upvalues: UIManager (copy)
    if p4 == 1 then
        UIManager:ShowPanel("StorePanel", nil, true, {
            p3.pp
        })
    elseif p4 == 2 then
        UIManager:ShowPanel("SellPanel", nil, true, {
            p3.pp
        })
    end
end

return DialogueData
