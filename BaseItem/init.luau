-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("RunService")

local DataMgr, _, New = _G.DataMgr, _G.GameMgr, _G.New

New("Utility.Tool")()

local t2 = {}
local t3 = {}

t1.data = nil
t1.detail = nil
t1.player = nil
t1.ifEquip = false
t1.index = 0

function t1.new(_, p2, p3, p4) -- line: 17
    -- upvalues: t1 (copy), DataMgr (copy), New (copy), t3 (copy)
    local Config = DataMgr:GetConfig("ItemData", p3.id)
    local v1 = t3[Config.script]

    if v1 == nil then
        if script:FindFirstChild(Config.script) ~= nil then
            v1 = require(script:FindFirstChild(Config.script))
            setmetatable(v1, t1)
            v1.__index = v1
            t3[Config.script] = v1
        else
            v1 = t1
            t3[Config.script] = t1
        end
    end

    local self = setmetatable({}, v1)

    self.player = p2
    self.data = Config
    self.detail = p3
    self.index = p4
    self.trove = New("Utility.Trove")()
    self.OnDurabilityChange = New("CS.Action")()

    return self
end

function t1.Unequip(p5) -- line: 42
    if p5.ifEquip then
        p5.ifEquip = false
        p5:OnUnequip()
        p5.trove:Clean()

        if p5.Animations then
            for _, v3 in pairs(p5.Animations) do
                v3:Stop()
                v3:Destroy()
            end
        end

        if p5.modifier then
            for _, v4 in p5.modifier do
                v4:Destroy()
            end
        end
    end
end

function t1.Equip(p6) -- line: 61
    if p6.ifEquip then
        return
    end

    p6.ifEquip = true
    p6:LoadModifier()
    p6:OnEquip()
end

function t1.Change(p7, p8, p9) -- line: 69
    if p7.ifEquip then
        p7:OnChange(p8, p9)
    end
end

function t1.Remove(p10, p11) -- line: 75
    -- upvalues: DataMgr (copy)
    DataMgr:RemoveItemAt(p10.player, p10.index, p11)
end

function t1.GetMainAttribute(p12, p13) -- line: 79
    return p12.data[p13] * (1 + p12.detail.reinforce / 100)
end

function t1.LoadModifier(p14) -- line: 83
    -- upvalues: New (copy)
    if p14.detail.modifier == nil then
        return
    end

    p14.modifier = {}

    for _, v5 in p14.detail.modifier do
        for _, v6 in v5 do
            local v7 = New("Modifier")(v6, p14)

            table.insert(p14.modifier, v7)
            v7:Init()
        end
    end
end

function t1.Destroy(p15, _) -- line: 97
    p15:Unequip()
end

function t1.GetAnimation(_, p18) -- line: 107
    -- upvalues: DataMgr (copy), t2 (copy)
    local v8 = t2[p18]

    if v8 ~= nil then
        return v8
    end

    local Animation = Instance.new("Animation")
    local Config = DataMgr:GetConfig("AnimationData", p18)

    if Config then
        Animation.AnimationId = Config.asset
    else
        Animation.AnimationId = "rbxassetid://" .. p18
    end

    t2[p18] = Animation

    return Animation
end

function t1.LoadAnimation(p19, p20, p21, p22, p23) -- line: 123
    if p19.Animations == nil then
        p19.Animations = {}
    end

    p19.Animations[p20] = p19.player.Humanoid.Animator:LoadAnimation(p19:GetAnimation(p21))
    p19.Animations[p20].Priority = p22 or Enum.AnimationPriority.Action
    p19.Animations[p20].Looped = p23 or false

    return p19.Animations[p20]
end

function t1.PlayAnimation(p24, p25) -- line: 133
    if p24.Animations[p25] then
        p24.Animations[p25]:Play()
    end
end

function t1.OnChange(_) -- line: 139
end

function t1.OnUnequip(_) -- line: 143
end

function t1.OnEquip(_) -- line: 147
end

return t1
