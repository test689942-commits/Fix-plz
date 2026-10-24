-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DialogueData = _G.SubClass("DialogueData")
local _ = game:GetService("Players").LocalPlayer
local UIManager, New, _, GameMgr = _G.UIManager, _G.New, _G.DataMgr, _G.GameMgr
local _ = _G.EventMgr

New("Utility.Tool")()

function DialogueData.new(p1, p2, p3, p4) -- line: 10
    -- upvalues: GameMgr (copy)
    p1.pp = p2
    p1.taskGuid = p3
    p1.taskIndex = p4
    p1.TalkName = "Blacksmith"
    p1.TalkContent = "Out of money? It's okay, we recycle all the equipment here."
    p1.TalkChoice = { "Accept" }
    GameMgr:AddTaskValue(p1.taskGuid, 1, p1.taskIndex)
end

function DialogueData.Choice(p5, p6) -- line: 20
    -- upvalues: UIManager (copy)
    if p6 == 1 then
        UIManager:ShowPanel("SellPanel", nil, true, {
            p5.pp
        })
    end
end

return DialogueData
