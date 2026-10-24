-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.tag = New(t1.tag)()
    p1.base = New(t1.base)()
    p1.value = New(t1.value)()
    p1.mul = New(t1.mul)()
end

t1.id = 0
t1.name = ""
t1.icon = 0
t1.script = ""
t1.price = 0
t1.quality = 0
t1.tag = Type("CS.Array")("string")
t1.base = Type("CS.Array")("number")
t1.value = Type("CS.Array")("number")
t1.mul = Type("CS.Array")("number")
t1.introduce = ""

return t1
