-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.cost = New(t1.cost)()
end

t1.id = 0
t1.cost = Type("CS.Array")("ItemDetails")
t1.amount = 0

return t1
