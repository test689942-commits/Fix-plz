-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DialogueData = _G.SubClass("DialogueData")
local _ = game:GetService("Players").LocalPlayer
local _, New, _, _ = _G.UIManager, _G.New, _G.DataMgr, _G.GameMgr
local _ = _G.EventMgr

New("Utility.Tool")()

function DialogueData.new(p1, p2) -- line: 10
    p1.pp = p2
    p1.TalkName = "Mushroom Villager"
    p1.TalkContent = "This grove has stood for a thousand years, traveler. The greattree once blessed every root and stream. Now… the goblin curse twists it all. But you've pushed them back, haven't you? The forest still remembers what it was."
    p1.TalkChoice = { "Leave" }
end

function DialogueData.Choice(_, _) -- line: 17
end

return DialogueData
