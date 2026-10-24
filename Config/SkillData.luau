-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.value = New(t1.value)()
    p1.addValue = New(t1.addValue)()
end

t1.id = 0
t1.name = ""
t1.introduce = ""
t1.value = Type("CS.Array")("number")
t1.addValue = Type("CS.Array")("number")
t1.icon = 0
t1.script = ""
t1.cd = 0
t1.animation = 0

return t1
