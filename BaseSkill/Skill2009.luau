-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local _ = game:GetService("Players").LocalPlayer

game:GetService("RunService")

local GameMgr, _, _, New = _G.GameMgr, _G.DataMgr, _G.EventMgr, _G.New
local t2 = {
    1803, 1804, 1805, 1806, 1807
}
local _ = workspace.CurrentCamera
local v1 = OverlapParams.new()

v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = { workspace.Entity }

function t1.OnInit(p1) -- line: 17
    -- upvalues: New (copy)
    p1.trove:Add(p1.player:AddEvent("CutSkill", function() -- line: 18
        -- upvalues: p1 (copy)
        p1.Animations.Skill:Stop()
        p1.stateTrove:Clean()
    end))
    p1.stateTrove = New("Utility.Trove")()
end

function t1.OnEnter(p2) -- line: 25
    if p2:ChackUse(0.3) then
        p2.isEnter = false
    else
        p2:ToCoolDown(p2.data.cd / p2.player.skill_speed, function(_) -- line: 31
        end)
        p2.stateTrove:Add(p2.player:CanMove(false))
        p2.Animations.Skill:Play()
        p2.stateTrove:Add(p2.player:SetState("action", true))
        p2.player:AttackAdsorption()
        p2:Fire("Enter")
    end
end

function t1.OnExit(_) -- line: 41
end

function t1.Use(_) -- line: 45
end

function t1.Atk(p6, p7) -- line: 49
    -- upvalues: GameMgr (copy), t2 (copy)
    if not p7 or #p7 == 0 then
        return
    end

    p6.player.CameraShaker:ShakeOnce(1, 20, 0, 0.5, 0, 0)

    for _, v2 in p7 do
        if v2[1] and v2[1].PrimaryPart then
            GameMgr:PlayWorldSound(v2[1].PrimaryPart.CFrame, t2[math.random(#t2)])
            GameMgr:ShowEffect("暴烈魔法HIT", v2[1].PrimaryPart.CFrame)
            GameMgr:ShowEffect("BroadcastEffect", v2[1].PrimaryPart.CFrame, v2[2])
            p6.player:TrigerEvent("Atk", v2[2], v2[1])
        end
    end
end

function t1.OnEquip(p8) -- line: 63
    p8:LoadAnimation("Skill", p8.data.animation, Enum.AnimationPriority.Action3):GetMarkerReachedSignal("Atk"):Connect(function(_) -- line: 64
        -- upvalues: p8 (copy)
        p8:Fire("Atk", p8.player.atkTarget or p8.player.Character)
    end)
    p8.Animations.Skill.Stopped:Connect(function() -- line: 68
        -- upvalues: p8 (copy)
        p8.stateTrove:Clean()
    end)
end

function t1.OnUnequip(p10) -- line: 73
    p10.stateTrove:Clean()
end

return t1
