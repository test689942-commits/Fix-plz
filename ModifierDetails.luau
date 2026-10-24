-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return {
    id = 1001,
    quality = 1,
    value = 0,
    new = function(p1, p2, p3, p4) -- new | line: 7
        p1.id = p2
        p1.quality = p3
        p1.value = p4 or math.random()
    end
}
