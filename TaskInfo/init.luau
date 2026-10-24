-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _, DataMgr, GameMgr, New = _G.NetMgr, _G.DataMgr, _G.GameMgr, _G.New
local t2 = {}
local t1 = {}

t1.id = 0
t1.time = 0
t1.track = false
t1.claim = false
t1.client = false
t1.isFinish = false

function t1.new(_, p2) -- line: 15
    -- upvalues: t1 (copy), DataMgr (copy), New (copy), t2 (copy)
    local Config = DataMgr:GetConfig("TaskData", p2)
    local v1 = t2[p2]

    if v1 == nil then
        local v2 = script:FindFirstChild(Config.taskType)

        if v2 ~= nil then
            v1 = require(v2)
            v1.__index = v1
            setmetatable(v1, t1)
            t2[p2] = v1
        else
            v1 = t1
            t2[p2] = t1
        end
    end

    local self = setmetatable({}, v1)

    self.__index = self
    self.trove = New("Utility.Trove")()
    self.config = Config
    self.onValueChange = New("CS.Action")()
    self.onTrackChange = New("CS.Action")()
    self.trackObj = {}

    local v4 = setmetatable({
        id = p2,
        value = {},
        data = {}
    }, self)

    v4:Init()

    return v4
end

function t1.Instance(_, p4) -- line: 48
    -- upvalues: t1 (copy), DataMgr (copy), New (copy), t2 (copy)
    local Config = DataMgr:GetConfig("TaskData", p4.id)
    local v5 = t2[p4.id]

    if v5 == nil then
        local v6 = script:FindFirstChild(Config.taskType)

        if v6 ~= nil then
            v5 = require(v6)
            v5.__index = v5
            setmetatable(v5, t1)
            t2[p4.id] = v5
        else
            v5 = t1
            t2[p4.id] = t1
        end
    end

    local self = setmetatable({}, v5)

    self.__index = self
    self.trove = New("Utility.Trove")()
    self.config = Config
    self.onValueChange = New("CS.Action")()
    self.onTrackChange = New("CS.Action")()
    self.trackObj = {}
    setmetatable(p4, self)

    return p4
end

function t1.Init(_) -- line: 76
end

function t1.Load(_) -- line: 80
end

function t1.AddTask(p7, p8, p9) -- line: 84
    table.insert(p7.data, p8)
    table.insert(p7.value, p9 or 0)
end

function t1.AddValue(p10, p11, p12) -- line: 89
    -- upvalues: GameMgr (copy)
    p12 = p12 or 1
    p10.value[p12] += p11
    p10.onValueChange(p12, p10.value[p12])

    if p10.guid then
        GameMgr:AddTaskValue(p10.guid, p11, p12)
    end
end

function t1.AutoChange(p13, p14, p15) -- line: 98
    if p13[p14] ~= nil then
        p13[p14] = p15
    else
        p13.value[p14] = p15
        p13.onValueChange(p14, p13.value[p14])
    end
end

function t1.Destroy(p16) -- line: 107
    p16.trove:Clean()
end

function t1.IsFinish(p17) -- line: 111
    if p17.isFinish then
        return p17.isFinish
    end

    for v10, v11 in p17.value do
        if v11 < p17.data[v10] then
            return false
        end
    end

    p17.isFinish = true

    return true
end

function t1.ChangeTrack(p18, p19, p20, p21) -- line: 124
    p21 = p21 or -1

    if p18.trackObj[p21] then
        p18.trackObj[p21][p19] = p20
    else
        p18.trackObj[p21] = {
            [p19] = p20
        }
    end

    p18.onTrackChange(p19, p20, p21)
end

return t1
