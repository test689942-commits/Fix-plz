-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.tag = New(t1.tag)()
    p1.modifier = New(t1.modifier)()
    p1.state = New(t1.state)()
end

t1.id = 0
t1.name = ""
t1.icon = 0
t1.stack = 0
t1.quality = ""
t1.type = ""
t1.script = ""
t1.mass = 0
t1.price = 0
t1.use = false
t1.sell = false
t1.introduce = ""
t1.model = ""
t1.tag = Type("CS.Dictionary")("string", "number")
t1.modifier = Type("CS.Array")("number")
t1.state = Type("CS.Dictionary")("string", "number")

return t1
