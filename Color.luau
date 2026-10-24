-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return {
    new = function(_, p2, p3, p4) -- new | line: 3
        return Color3.new(p2, p3, p4)
    end,
    Instance = function(_, p6) -- Instance | line: 7
        return Color3.fromRGB(unpack(p6))
    end
}
