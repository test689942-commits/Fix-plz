-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return {
    new = function(p1, p2, p3, p4) -- new | line: 3
        p1.loginTime = p2
        p1.getData = p3
        p1.loginDay = p4
        p1.stayTime = 0
    end,
    loginDay = 0,
    loginTime = 0,
    getData = nil,
    stayTime = 0
}
