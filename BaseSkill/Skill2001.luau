-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local _ = game:GetService("Players").LocalPlayer

game:GetService("RunService")

local GameMgr, _, _, _ = _G.GameMgr, _G.DataMgr, _G.EventMgr, _G.New
local New = _G.New
local v1 = New("Utility.Tool")()
local _ = workspace.CurrentCamera
local v2 = OverlapParams.new()

v2.FilterType = Enum.RaycastFilterType.Include
v2.FilterDescendantsInstances = { workspace.Entity }

function t1.OnInit(p1) -- line: 18
    -- upvalues: New (copy)
    p1.trove:Add(p1.player:AddEvent("CutSkill", function() -- line: 19
        -- upvalues: p1 (copy)
        p1.Animations.Skill:Stop()
        p1.stateTrove:Clean()
    end))
    p1.stateTrove = New("Utility.Trove")()
end

function t1.OnEnter(p2) -- line: 26
    if p2:ChackUse(0.3) then
        p2.isEnter = false
    else
        p2:ToCoolDown(p2.data.cd / p2.player.skill_speed, function(_) -- line: 32
        end)
        p2.stateTrove:Add(p2.player:CanMove(false))
        p2.Animations.Skill:Play()
        p2.stateTrove:Add(p2.player:SetState("action", true))
        p2.player:AttackAdsorption()
        p2:Fire("Enter")
    end
end

function t1.OnExit(_) -- line: 42
end

function t1.Use(_) -- line: 46
end

function t1.Atk(p6, p7) -- line: 50
    -- upvalues: GameMgr (copy)
    if not p7 or #p7 == 0 then
        return
    end

    p6.player.CameraShaker:ShakeOnce(1, 20, 0, 0.5, 0, 0)

    for _, v3 in p7 do
        if v3[1] and v3[1].PrimaryPart then
            GameMgr:PlayWorldSound(v3[1].PrimaryPart.CFrame, 1855)
            GameMgr:ShowEffect("火球术HIT", v3[1].PrimaryPart.CFrame)
            GameMgr:ShowEffect("BroadcastEffect", v3[1].PrimaryPart.CFrame, v3[2])
            p6.player:TrigerEvent("Atk", v3[2], v3[1])
        end
    end
end

function t1.OnEquip(p8) -- line: 64
    -- upvalues: GameMgr (copy), v1 (copy)
    p8:LoadAnimation("Skill", p8.data.animation, Enum.AnimationPriority.Action3):GetMarkerReachedSignal("Atk"):Connect(function(_) -- line: 65
        -- upvalues: p8 (copy), GameMgr (copy), v1 (copy)
        local CFrame = p8.player.HumanoidRootPart.CFrame
        local v4, v5

        if p8.player.atkTarget and p8.player.atkTarget.PrimaryPart then
            local v6 = v1:Restrict_Vector((p8.player.atkTarget.PrimaryPart.CFrame.Position - p8.player.HumanoidRootPart.CFrame.Position).Unit, p8.player.HumanoidRootPart.CFrame.LookVector, 45) * 50

            if v6 then
                v4 = v6
                v5 = true
            else
                v5 = false
            end
        else
            v5 = false
        end

        if not v5 then
            v4 = p8.player.HumanoidRootPart.CFrame.LookVector * 50
        end

        local v7 = GameMgr:BroadcastEffect("LauncherEffect", "火焰弹", CFrame, v4)

        v7.trove:Add(function() -- line: 71
            -- upvalues: v7 (copy), p8 (copy), GameMgr (copy)
            if v7.hit then
                p8:Fire("Atk", v7.hit.Position)
                GameMgr:BroadcastEffect("火焰弹Boom", v7.hit.Position)
            end
        end)
    end)
    p8.Animations.Skill.Stopped:Connect(function() -- line: 79
        -- upvalues: p8 (copy)
        p8.stateTrove:Clean()
    end)
end

function t1.OnUnequip(p10) -- line: 84
    p10.stateTrove:Clean()
end

return t1
