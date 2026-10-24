-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return {
    id = 0,
    amount = 0,
    time = 0,
    pos = { 0, 0, 0 },
    new = function(p1, p2, p3) -- new | line: 8
        p1.id = p2
        p1.time = os.time()

        if typeof(p3) == "Vector3" then
            p1.pos = {
                p3.X,
                p3.Y,
                p3.Z
            }
        else
            p1.pos = p3
        end
    end
}
