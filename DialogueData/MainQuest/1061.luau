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
    p1.TalkName = "Mushroom Villager"
    p1.TalkContent = "The ancient greattree was once the heart of this forest, blessed by the elder spirits. But goblin dark magic twisted it into a source of corruption. The Stone Golem that once protected these woods has fallen silent. Only by facing the Cursed Treant at the greattree's roots can the forest be freed."
    p1.TalkChoice = { "Accept" }
end

function DialogueData.Choice(p5, p6) -- line: 19
    -- upvalues: GameMgr (copy)
    if p6 == 1 then
        GameMgr:AddTaskValue(p5.taskGuid, 1, p5.taskIndex)
    end
end

return DialogueData
