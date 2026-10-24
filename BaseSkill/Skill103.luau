-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("TweenService")
game:GetService("Players")

local GameMgr, _ = _G.GameMgr, _G.DataMgr
local t2 = {
    1850, 1851
}
local t3 = {
    1852, 1853
}

function t1.OnInit(p1, _, p3) -- line: 9
    p1.atk = p1.player.atk
    p1.comboData = p3
    p1.combo = 1
    p1.LastCombo = 0
    p1.trove:Add(p1.player:AddEvent("CutSkill", function() -- line: 14
        -- upvalues: p1 (copy)
        for _, v1 in pairs(p1.Animations) do
            v1:Stop()
        end

        p1:ToCoolDown()
    end))
end

local function Atk(p4) -- line: 22
    -- upvalues: GameMgr (copy), t2 (copy), Atk (copy)
    if tick() - p4.LastCombo > 1 or p4.Combo == #p4.comboData then
        p4.Combo = 1
    else
        p4.Combo += 1
    end

    local v2 = p4.Animations["Atk" .. p4.Combo]
    local v3 = (if v2.Length == 0 then 1 else v2.Length) / p4.player.atkSpeed

    p4.LastCombo = tick() + v3
    p4:ToCoolDown(v3, function() -- line: 34
        -- upvalues: p4 (copy), Atk (copy)
        if p4.isEnter then
            Atk(p4)
        else
            p4.player:SetState("action", false)
            p4.player.speed:SetValueMul(nil, "Atk")
        end
    end)

    for _, v4 in pairs(p4.Animations) do
        v4:Stop()
    end

    v2:Play()
    v2:AdjustSpeed(p4.player.atkSpeed)

    if p4.player.Humanoid.FloorMaterial ~= Enum.Material.Air and p4.player.Humanoid.FloorMaterial ~= Enum.Material.Water then
        p4.player:AttackAdsorption({
            distance = 6
        })
    end

    GameMgr:PlaySound(t2[p4.Combo])
end

function t1.OnEnter(p5) -- line: 59
    -- upvalues: Atk (copy)
    if p5:ChackUse(0.3) then
        return
    end

    p5.player:SetState("action", true)
    p5.player.speed:SetValueMul(p5.player.atk_move_speed, "Atk")
    Atk(p5)
end

function t1.Atk(p6, p7) -- line: 68
    -- upvalues: GameMgr (copy), t3 (copy)
    if not p7 or #p7 == 0 then
        return
    end

    p6.player.CameraShaker:ShakeOnce(1, 20, 0, 0.5, 0, 0)

    for _, v5 in p7 do
        if v5[1] and v5[1].PrimaryPart then
            GameMgr:PlayWorldSound(v5[1].PrimaryPart.CFrame, t3[math.random(#t3)])
            GameMgr:ShowEffect("普通攻击HIT", v5[1].PrimaryPart.CFrame)
            GameMgr:ShowEffect("BroadcastEffect", v5[1].PrimaryPart.CFrame, v5[2])
            p6.player:TrigerEvent("Atk", v5[2], v5[1])
        end
    end
end

function t1.OnExit(_) -- line: 83
end

function t1.OnHit(_, _, ...) -- line: 87
end

function t1.OnEquip(p11) -- line: 91
    for i = 1, #p11.comboData do
        local track = p11:LoadAnimation("Atk" .. i, p11.comboData[i], Enum.AnimationPriority.Action2)

        track:GetMarkerReachedSignal("Atk"):Connect(function(_) -- line: 94
            -- upvalues: p11 (copy)
            p11:Fire("Enter", p11.player.HumanoidRootPart.CFrame, p11.Combo)
        end)
        track:GetMarkerReachedSignal("End"):Connect(function(_) -- line: 97
            -- upvalues: p11 (copy)
            p11:ToCoolDown()
        end)
    end
end

function t1.OnUnequip(_) -- line: 103
end

return t1
