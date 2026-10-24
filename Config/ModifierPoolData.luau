-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.string = New(t1.string)()
    p1.string = New(t1.string)()
    p1.int = New(t1.int)()
    p1.pool = New(t1.pool)()
end

t1.string = Type("id")
t1.string = Type("name")
t1.int = Type("allWeigh")
t1.pool = Type("CS.Dictionary")("number", "number")

return t1
