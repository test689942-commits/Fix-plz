-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return {
    new = function(_, p2, p3) -- new | line: 3
        return (Vector3.new(p2, p3))
    end,
    Instance = function(_, p5) -- Instance | line: 7
        return (Vector3.new(unpack(p5)))
    end
}
