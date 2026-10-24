-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return {
    new = function(p1, p2, p3, p4) -- new | line: 3
        p1.topic = p2
        p1.content = p3
        p1.time = os.time()
        p1.data = p4 or {}
    end,
    topic = "Mail",
    content = "Mail",
    data = nil
}
