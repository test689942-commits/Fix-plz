-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return {
    new = function(_, p2, p3, p4, p5) -- new | line: 3
        local Weld = Instance.new("Weld", p3)

        Weld.Part0 = p2
        Weld.Part1 = p3

        if p4 ~= nil then
            Weld.C0 = p4
        end

        if p5 ~= nil then
            Weld.C1 = p5
        end

        return Weld
    end,
    Instance = function(_, p7) -- Instance | line: 16
        local Weld = Instance.new("Weld", p7.Part1)

        Weld.Part0 = p7.Part0
        Weld.Part1 = p7.Part1
        Weld.C0 = p7.c0
        Weld.C1 = p7.c1

        return Weld
    end
}
