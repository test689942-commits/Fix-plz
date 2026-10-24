-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local New = _G.New

return {
    TalkName = "Unknown",
    TalkContent = "...",
    TalkChoice = { "Exit" },
    new = function(_, p2, ...) -- new | line: 8
        -- upvalues: New (copy)
        return p2 and New("DialogueData." .. p2)(...)
    end,
    Choice = function(_, _) -- Choice | line: 12
    end
}
