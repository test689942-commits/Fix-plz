-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.color3 = New(t1.color3)()
    p1.modifier = New(t1.modifier)()
end

t1.id = 0
t1.name = ""
t1.introduce = ""
t1.color = ""
t1.color3 = Type("Color")
t1.modifier = Type("CS.Array")("number")
t1.asset = ""
t1.badge = ""

return t1
