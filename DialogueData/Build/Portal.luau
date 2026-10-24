-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DialogueData = _G.SubClass("DialogueData")
local _ = game:GetService("Players").LocalPlayer
local _, New, DataMgr, GameMgr = _G.UIManager, _G.New, _G.DataMgr, _G.GameMgr
local _ = _G.EventMgr

New("Utility.Tool")()

function DialogueData.new(p1, p2) -- line: 10
    -- upvalues: DataMgr (copy)
    p1.pp = p2
    p1.TalkName = "Portal"

    if DataMgr:GetAuthority(100) then
        p1.TalkContent = "Do you want to return to the lobby?"
        p1.TalkChoice = { "No", "Yes" }
    else
        p1.TalkContent = "The threat has not been resolved yet, you cannot return!"
        p1.TalkChoice = { "Yes" }
    end
end

function DialogueData.Choice(_, p4) -- line: 22
    -- upvalues: GameMgr (copy)
    if p4 ~= 1 and p4 == 2 then
        GameMgr:BackLobby()
    end
end

return DialogueData
