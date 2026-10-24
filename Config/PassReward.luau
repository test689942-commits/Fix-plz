-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type, New = _G.Type, _G.New
local t1 = {}

function t1.new(p1) -- line: 4
    -- upvalues: t1 (copy), New (copy)
    p1.reward = New(t1.reward)()
    p1.payReward = New(t1.payReward)()
end

t1.id = 0
t1.reward = Type("CS.Array")("Reward")
t1.payReward = Type("CS.Array")("Reward")

return t1
