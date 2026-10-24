-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Type = _G.Type
local t1 = {}

function t1.new(_) -- line: 4
    -- upvalues: t1 (copy)
    local self = setmetatable({}, t1)

    self.setting = {}

    return self
end

t1.cache = Type("CS.Dictionary")("string", "obj")
t1.authority = Type("CS.Dictionary")("number", "bool")
t1.boost = Type("CS.Dictionary")("number", "BoostDetails")
t1.productBuy = Type("CS.Dictionary")("number", "number")
t1.bag = Type("CS.List")("ItemDetails")
t1.inv = Type("CS.List")("ItemDetails")
t1.mail = Type("CS.List")("MailData")
t1.team = -1
t1.robux = 0
t1.setting = {}
t1.time = 0
t1.onlineTime = 0
t1.loginDay = 0
t1.coin = 0
t1.gem = 0
t1.drawCount = 0
t1.luckUp = 0
t1.exp = 0
t1.level = 0
t1.titleDic = Type("CS.Dictionary")("number", "bool")
t1.title = -1
t1.titleProgress = Type("CS.Dictionary")("number", "number")
t1.equipData = Type("CS.Dictionary")("string", "ItemDetails")
t1.skin = Type("CS.Dictionary")("string", "number")
t1.skinDic = Type("CS.Dictionary")("number", "bool")
t1.kill = 0
t1.dieCount = 0
t1.donate = 0
t1.taskList = Type("CS.Dictionary")("string", "TaskInfo")
t1.taskProgress = Type("CS.Dictionary")("number", "bool")
t1.passPoint = 0
t1.passExp = 0
t1.character = 1001
t1.characterDic = Type("CS.Dictionary")("number", "obj")
t1.world = 1000
t1.worldDic = Type("CS.Dictionary")("number", "number")
t1.power = 0
t1.agile = 0
t1.wisdom = 0
t1.bagCapacity = 150
t1.invCapacity = 150
t1.talent = Type("CS.Dictionary")("number", "bool")
t1.resetPoint = 0
t1.maxLayer = 0
t1.maxScore = 0
t1.raceTick = 0
t1.advraceTick = 0
t1.skinTick = 0
t1.guild = -1
t1.contribution = 0
t1.guildCreat = 0
t1.guildTask = Type("CS.Dictionary")("string", "TaskInfo")

return t1
