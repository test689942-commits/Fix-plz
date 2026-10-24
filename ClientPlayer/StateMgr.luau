-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("TweenService")
game:GetService("SoundService")

local _ = game:GetService("Players").LocalPlayer.PlayerGui
local Parent = require(script.Parent)
local _, _, _, _ = _G.DataMgr, _G.InputMgr, _G.UIManager, _G.EventMgr
local t2 = {}

function t1.Init(p1) -- line: 13
    -- upvalues: t2 (copy)
    p1.State = {}
    p1.Character.ChildAdded:Connect(function(p2) -- line: 15
        if p2:IsA("ProximityPrompt") then
            p2:Destroy()
        end
    end)
    p1.OnAttributeChange:Add(function(p3, p4) -- line: 20
        -- upvalues: p1 (copy), t2 (copy)
        if t2[p3] then
            t2[p3](p1, p4)
        end
    end)
    p1.Humanoid.Jumping:Connect(function() -- line: 26
        -- upvalues: p1 (copy)
        p1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        task.delay(1.5, function() -- line: 28
            -- upvalues: p1 (copy)
            p1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        end)
    end)
    p1.characterLevel = 1
end

function Parent.SetState(p5, p6, p7) -- line: 36
    local v1 = p7
    local t3

    if type(p7) == "boolean" then
        task.spawn(function() -- line: 39
            -- upvalues: v1 (ref), p5 (copy), p6 (copy)
            p5:ReplicatedPlayer("SetState", p6, v1)
        end)

        local v3 = not v1

        t3 = {}

        function t3.Destroy() -- line: 44
            -- upvalues: p5 (copy), p6 (copy), v3 (copy)
            p5:SetState(p6, v3)
        end

        v1 = math.max(0, (p5.State[p6] or 0) + (if v1 then 1 else -1))
    end

    if p5.State[p6] == nil then
        p5.State[p6] = 0
    end

    if v1 == 0 then
        if p5.State[p6] ~= 0 then
            p5:TrigerEvent("StateChange", p6, false)
        end
    elseif p5.State[p6] == 0 then
        p5:TrigerEvent("StateChange", p6, true)
    end

    p5.State[p6] = v1

    return t3
end

function Parent.ChackState(p8, p9) -- line: 69
    return p8.State[p9] and p8.State[p9] ~= 0
end

function Parent.SetAttribute(p10, p11, p12) -- line: 73
    local v5

    if p11 == "speed" then
        p10.speed:SetValue(p12)
        v5 = p10.speed()
    else
        p10[p11] = p12
        v5 = p12
    end

    p10.OnAttributeChange(p11, v5)
end

function Parent.ReplicatedState(p13, p14) -- line: 83
    for v6, v7 in p14 do
        p13:SetAttribute(v6, v7)
    end
end

function Parent.AddEnergy(p15, p16) -- line: 89
    p15.energy:AddValue(p16)
end

t2.speed = function(p17, p18) -- line: 93
    if p17.canMoveCount == 0 then
        p17.Humanoid.WalkSpeed = p18
    end
end

t2.hp = function(_, _) -- line: 99
end

t2.maxEnergy = function(p21, p22) -- line: 122
    p21.energy:SetLimit(0, p22)
end

return t1
