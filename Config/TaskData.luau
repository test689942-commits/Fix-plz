-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.progressInfo = New(t1.progressInfo)()
    p1.progress = New(t1.progress)()
    p1.reward = New(t1.reward)()
    p1.state = New(t1.state)()
end

t1.id = 0
t1.taskName = ""
t1.index = 0
t1.icon = 0
t1.type = ""
t1.taskInfo = ""
t1.progressInfo = Type("CS.Array")("string")
t1.progress = Type("CS.Array")("Data")
t1.reward = Type("CS.Array")("Reward")
t1.taskType = ""
t1.state = Type("CS.Dictionary")("string", "string")

return t1
