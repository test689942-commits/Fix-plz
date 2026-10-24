-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.collect = New(t1.collect)()
    p1.reward = New(t1.reward)()
    p1.state = New(t1.state)()
end

t1.id = 0
t1.unlock = 0
t1.next = 0
t1.collect = Type("CS.Array")("ItemDetails")
t1.reward = Type("CS.Array")("Reward")
t1.title = ""
t1.unlockTip = ""
t1.info = ""
t1.submit = ""
t1.finish = ""
t1.state = Type("CS.Dictionary")("string", "number")

return t1
