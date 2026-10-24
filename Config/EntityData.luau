-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.skill = New(t1.skill)()
    p1.animations = New(t1.animations)()
    p1.sound = New(t1.sound)()
    p1.state = New(t1.state)()
end

t1.id = 0
t1.name = ""
t1.icon = 0
t1.level = 0
t1.atk = 0
t1.maxHp = 0
t1.exp = 0
t1.speed = 0
t1.physical_resistance = 0
t1.magic_resistance = 0
t1.atk_time = 0
t1.range = 0
t1.script = ""
t1.skill = Type("CS.Dictionary")("string", "number")
t1.model = ""
t1.animations = Type("CS.Dictionary")("string", "number")
t1.sound = Type("CS.Dictionary")("string", "number")
t1.state = Type("CS.Dictionary")("string", "string")

return t1
