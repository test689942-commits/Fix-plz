-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.state = New(t1.state)()
end

t1.id = 0
t1.name = ""
t1.icon = 0
t1.quality = ""
t1.type = ""
t1.introduce = ""
t1.model = ""
t1.state = Type("CS.Dictionary")("string", "number")

return t1
