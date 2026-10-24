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
t1.color = ""
t1.color3 = Type("Color")

return t1
