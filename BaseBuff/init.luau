-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local New, GameMgr, DataMgr = _G.New, _G.GameMgr, _G.DataMgr
local t2 = {}
local t1 = {}

function t1.new(_, p2, p3, p4) -- line: 7
    -- upvalues: t1 (copy), New (copy), DataMgr (copy), t2 (copy)
    if t2[p2] == nil then
        local v1 = script:FindFirstChild(p2)

        if v1 then
            local v2 = require(v1)

            v2.__index = v2
            t2[p2] = setmetatable(v2, t1)
        else
            t2[p2] = t1
        end
    end

    local self = setmetatable({}, t2[p2])

    self.config = DataMgr:GetConfig("BuffData", p2)
    self.entity = p3
    self.own = p4
    self.id = p2
    self.trove = New("Utility.Trove")()

    return self
end

function t1.Init(_, _) -- line: 27
end

function t1.Add(_, _) -- line: 31
end

function t1.Remove(_, _) -- line: 35
end

function t1.Destroy(p11) -- line: 40
    p11.trove:Clean()
end

function t1.ShowEffect(_, p13, ...) -- line: 44
    -- upvalues: GameMgr (copy)
    return GameMgr:ShowEffect(p13, ...)
end

function t1.PlaySound(p14, p15, _) -- line: 48
    -- upvalues: GameMgr (copy)
    return GameMgr:BroadcastSound(p14.entity.Character, p15)
end

return t1
