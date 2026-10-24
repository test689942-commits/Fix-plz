-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local DataMgr, EventMgr, _, New = _G.DataMgr, _G.EventMgr, _G.GameMgr, _G.New
local v1 = New("Utility.Tool")()
local t2 = {}
local t3 = {}
local t4 = {}

local function KeyFrameToVector3(p1) -- line: 13
    -- upvalues: HttpService (copy), t4 (copy)
    if t4[p1] ~= nil then
        return t4[p1]
    end

    local v2 = HttpService:JSONDecode(p1)

    t4[p1] = Vector3.new(v2[1], v2[2], v2[3])

    return t4[p1]
end

function t1.new(_, p3, p4, ...) -- line: 21
    -- upvalues: t1 (copy), DataMgr (copy), New (copy), t3 (copy)
    local Config = DataMgr:GetConfig("SkillData", p3)
    local v6 = if Config then Config.script else p3

    if t3[v6] == nil then
        local v7 = script:FindFirstChild(v6)

        if v7 ~= nil then
            local v8 = require(v7)

            v8.__index = v8
            setmetatable(v8, t1)
            t3[v6] = v8
        else
            t3[v6] = t1
        end
    end

    local self = setmetatable({}, t3[v6])

    self.data = Config

    local id = if Config then Config.id else nil

    self.id = if Config and id then id else v6
    self.player = p4
    self.coolTime = 0
    self.locked = false
    self.isEnter = false
    self.isEquip = false
    self.trove = New("Utility.Trove")()
    self.OnStartCoolDown = New("CS.Action")()
    self.OnEndCoolDown = New("CS.Action")()
    self:OnInit(...)

    return self
end

function t1.Enter(p5, ...) -- line: 52
    p5.isEnter = true
    p5:OnEnter(...)
end

function t1.Exit(p6, ...) -- line: 57
    if p6.isEnter then
        p6.isEnter = false
        p6:OnExit(...)
    end
end

function t1.Fire(p7, p8, ...) -- line: 64
    p7.player:ReplicatedPlayer("TrigerSkill", p7.id, p8, ...)
end

function t1.ToCoolDown(p9, p10, p11) -- line: 69
    -- upvalues: RunService (copy)
    p9.OnStartCoolDown:Invoke(p10 or 0)

    if p10 ~= nil then
        p9.coolTime = p10 or 0

        if p9.coolDownConnect then
            if p9.finishFunc then
                local finishFunc = p9.finishFunc

                p9.finishFunc = nil
                finishFunc()
            end

            p9.finishFunc = p11
        else
            p9.finishFunc = p11
            p9.coolDownConnect = RunService.Stepped:Connect(function(_, p13) -- line: 98
                -- upvalues: p9 (copy)
                p9.coolTime -= p13

                if not (p9.coolTime <= 0) then
                    return
                end

                p9.coolDownConnect:Disconnect()
                p9.coolDownConnect = nil
                p9.coolTime = 0
                p9.OnEndCoolDown:Invoke()

                if p9.finishFunc then
                    local finishFunc = p9.finishFunc

                    p9.finishFunc = nil
                    finishFunc(true)
                end
            end)
        end
    elseif p9.coolDownConnect then
        p9.coolDownConnect:Disconnect()
        p9.coolDownConnect = nil
        p9.coolTime = 0
        p9.OnEndCoolDown:Invoke()

        if p9.finishFunc then
            local finishFunc = p9.finishFunc

            p9.finishFunc = nil
            finishFunc()
        end
    end
end

function t1.OnCoolDown(p14) -- line: 114
    return p14.coolTime ~= 0
end

function t1.GetValue(p15, p16) -- line: 118
    if p15.player.equippedItem then
        return p15.data.value[p16] + (p15.player.equippedItem.detail.level - 1 + (p15.player.skill_Level_up or 0)) * (p15.player.equippedItem.detail.mutation or 1) * p15.data.addValue[p16]
    end

    return p15.data.value[p16] + (p15.player.skill_Level_up or 0) * p15.data.addValue[p16]
end

function t1.GetAnimation(_, p18) -- line: 127
    -- upvalues: DataMgr (copy), t2 (copy)
    local v11 = t2[p18]

    if v11 == nil then
        v11 = Instance.new("Animation")
        v11.AnimationId = DataMgr:GetConfig("AnimationData", p18).asset
        t2[p18] = v11
    end

    return v11
end

function t1.LoadAnimation(p19, p20, p21, p22, p23) -- line: 138
    -- upvalues: HttpService (copy), EventMgr (copy), t4 (copy)
    if p19.Animations == nil then
        p19.Animations = {}
    end

    local track = p19.player.Humanoid.Animator:LoadAnimation(p19:GetAnimation(p21))

    track.Priority = p22 or Enum.AnimationPriority.Action
    track.Looped = p23 or false
    p19.Animations[p20] = track

    local v12

    track:GetMarkerReachedSignal("CameraFOV"):Connect(function(p24) -- line: 147
        -- upvalues: track (copy), v12 (ref), EventMgr (copy)
        EventMgr:Triger("CameraFOV", if p24 == "" or not p24 then nil else p24)

        if not v12 then
            v12 = true
            track.Stopped:Connect(function() -- line: 151
                -- upvalues: EventMgr (copy)
                EventMgr:Triger("CameraFOV")
            end)
        end
    end)

    local v14

    track:GetMarkerReachedSignal("CameraOffset"):Connect(function(p25) -- line: 158
        -- upvalues: track (copy), v14 (ref), HttpService (copy), EventMgr (copy), t4 (copy)
        local v15, v16

        if p25 == "" then
            v16 = false
        else
            if t4[p25] == nil then
                local v17 = HttpService:JSONDecode(p25)

                t4[p25] = Vector3.new(v17[1], v17[2], v17[3])
            end

            local v21 = t4[p25]

            if v21 then
                v15 = v21
                v16 = true
            else
                v16 = false
            end
        end

        if not v16 then
            v15 = nil
        end

        EventMgr:Triger("CameraOffset", v15)

        if not v14 then
            v14 = true
            track.Stopped:Connect(function() -- line: 162
                -- upvalues: EventMgr (copy)
                EventMgr:Triger("CameraOffset")
            end)
        end
    end)
    track:GetMarkerReachedSignal("CameraShake"):Connect(function(p26) -- line: 168
        -- upvalues: EventMgr (copy)
        EventMgr:Triger("CameraShake", p26)
    end)

    return p19.Animations[p20]
end

function t1.CatchHumanoid(p27, p28, p29) -- line: 176
    -- upvalues: v1 (copy)
    return v1:BoxCatchHumanoid(p28, p29, nil, {
        workspace.Map,
        workspace.FX,
        workspace.EItem,
        p27.player.Character
    })
end

function t1.BreakMap(p30, p31, p32) -- line: 181
    -- upvalues: v1 (copy)
    for _, v22 in ipairs(v1:BoxCatch(p31, p32, Enum.RaycastFilterType.Include, { workspace.Map.BreakMap })) do
        v1:Disintegrate(v22, p30.player.Character.HumanoidRootPart.CFrame.LookVector * 30, true)
    end
end

function t1.PlaySound(p33, p34) -- line: 187
    p33.item:PlaySound(p34)
end

local function ChackUse(p35) -- line: 192
    return p35.coolTime ~= 0 or p35.locked or p35.player:ChackState("action")
end

function t1.ChackUse(p36, p37) -- line: 198
    if p37 == nil then
        return p36.coolTime ~= 0 or p36.locked or p36.player:ChackState("action")
    end

    if p36.coolTime ~= 0 or p36.locked or p36.player:ChackState("action") then
        p36.preInputTick = tick() + p37

        if not p36.preInput then
            p36.preInput = true

            while true do
                if p36.coolTime ~= 0 or p36.locked or p36.player:ChackState("action") then
                    task.wait()

                    if p36.isEquip then
                        if tick() > p36.preInputTick then
                            break
                        end

                        continue
                    end

                    break
                end

                p36.preInput = false

                return false
            end

            p36.preInput = false
        end

        return true
    end

    return false
end

function t1.Equip(p38) -- line: 221
    p38.isEquip = true
    p38:OnEquip()
end

function t1.Unequip(p39) -- line: 226
    p39.isEquip = false

    if p39.isEnter then
        p39:Exit()
    end

    if p39.coolDownConnect then
        p39.coolDownConnect:Disconnect()
        p39.coolDownConnect = nil

        if p39.finishFunc then
            p39.finishFunc()
        end
    end

    if p39.Animations ~= nil then
        for _, v23 in pairs(p39.Animations) do
            v23:Stop()
            v23:Destroy()
        end
    end

    p39:OnUnequip()
    p39.trove:Clean()
end

function t1.Lock(p40) -- line: 250
    p40.locked = true
end

function t1.UnLock(p41) -- line: 254
    p41.locked = false
end

function t1.OnInit(_, _, ...) -- line: 258
end

function t1.OnEnter(_) -- line: 262
end

function t1.OnExit(_) -- line: 266
end

function t1.OnEquip(_) -- line: 270
end

function t1.OnUnequip(_) -- line: 274
end

function t1.OnHit(_) -- line: 278
    -- upvalues: EventMgr (copy)
    EventMgr:Triger("HitItem")
end

return t1
