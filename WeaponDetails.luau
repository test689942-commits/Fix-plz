-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local HttpService = game:GetService("HttpService")
local New = _G.New

return {
    new = function(_, p2, p3) -- new | line: 5
        -- upvalues: HttpService (copy), New (copy)
        local v1 = New("ItemDetails")(p2, 1)

        v1.uid = HttpService:GenerateGUID(false)
        v1.atk = math.random()
        v1.rate = math.random()
        v1.mag = math.random()
        v1.exp = p3

        return v1
    end
}
