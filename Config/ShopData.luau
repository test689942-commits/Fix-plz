-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.pool = New(t1.pool)()
end

t1.id = 0
t1.name = ""
t1.allWeigh = 0
t1.type = ""
t1.pool = Type("CS.List")("obj")

return t1
