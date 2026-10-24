-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.color3 = New(t1.color3)()
end

t1.id = 0
t1.name = ""
t1.icon = 0
t1.color3 = Type("Color")
t1.modifier = 0
t1.type = ""
t1.asset = ""
t1.quality = ""

return t1
