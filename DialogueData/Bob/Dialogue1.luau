-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DialogueData = _G.SubClass("DialogueData")
local _ = game:GetService("Players").LocalPlayer
local UIManager, New, _, _ = _G.UIManager, _G.New, _G.DataMgr, _G.GameMgr
local _ = _G.EventMgr

New("Utility.Tool")()

function DialogueData.new(p1, p2) -- line: 10
    p1.pp = p2
    p1.TalkName = "Bob"
    p1.TalkContent = "This is the forgotten dilapidated temple, and it’s your only safe spot. Come to me if you have quests— the undead outside won’t show you any mercy."
    p1.TalkChoice = { "Check Bounties", "Not Needed For Now" }
end

function DialogueData.Choice(p3, p4) -- line: 17
    -- upvalues: UIManager (copy)
    if p4 == 1 then
        UIManager:ShowPanel("QuestsPanel", nil, true, {
            p3.pp
        })
    end
end

return DialogueData
