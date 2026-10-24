-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local HttpService = game.HttpService

return {
    id = 1001,
    amount = 0,
    level = 1,
    reinforce = 0,
    reinforce_times = 0,
    lock = false,
    divine = false,
    new = function(p1, p2, p3) -- new | line: 15
        -- upvalues: HttpService (copy)
        p1.uid = HttpService:GenerateGUID(false)
        p1.id = p2
        p1.amount = p3 or 1
    end
}
