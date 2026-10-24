-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DialogueData = _G.SubClass("DialogueData")
local _ = game:GetService("Players").LocalPlayer
local _, New, _, GameMgr = _G.UIManager, _G.New, _G.DataMgr, _G.GameMgr
local _ = _G.EventMgr

New("Utility.Tool")()

function DialogueData.new(p1, p2, p3, p4) -- line: 10
    p1.pp = p2
    p1.taskGuid = p3
    p1.taskIndex = p4
    p1.TalkName = "Bob"
    p1.TalkContent = "Silver Valley to the south has been occupied by bandits for three months. Come get your new task."
    p1.TalkChoice = { "Accept" }
end

function DialogueData.Choice(p5, p6) -- line: 19
    -- upvalues: GameMgr (copy)
    if p6 == 1 then
        GameMgr:AddTaskValue(p5.taskGuid, 1, p5.taskIndex)
    end
end

return DialogueData
