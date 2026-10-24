-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.color = New(t1.color)()
end

t1.id = ""
t1.name = ""
t1.color = Type("Color")
t1.introduce = ""

return t1
