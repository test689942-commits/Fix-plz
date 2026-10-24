-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.show = New(t1.show)()
end

t1.id = 0
t1.name = ""
t1.gameType = ""
t1.music = 0
t1.icon = 0
t1.introduce = ""
t1.show = Type("CS.Array")("Reward")
t1.map = ""
t1.drop = 0

return t1
