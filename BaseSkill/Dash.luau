-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("RunService")

local _, New = _G.EventMgr, _G.New

function t1.OnInit(p1, ...) -- line: 6
    -- upvalues: New (copy)
    p1.tick = 0
    p1.comba = 0
    p1.stateTrove = New("Utility.Trove")()
end

function t1.OnEnter(p2) -- line: 12
    p2.player:TrigerEvent("CutSkill")

    if p2:ChackUse() then
        p2.isEnter = false
    else
        if tick() - p2.tick > 2 then
            p2.comba = 1
            p2.tick = tick()
        else
            p2.comba += 1

            if p2.comba == 2 then
                p2:ToCoolDown(2 - (tick() - p2.tick), function(_) -- line: 25
                    -- upvalues: p2 (copy)
                    p2.comba = 0
                    p2.tick = tick()
                end)
            end
        end

        p2.stateTrove:Add(p2.player:CanMove(false))
        p2.stateTrove:Add(p2.player:SetState("action", true))

        if p2.player.Humanoid.MoveDirection == Vector3.new(0, 0, 0) then
            p2.Animations[1]:Play()
            p2.player:AddPower(p2.player.Humanoid.RootPart.CFrame.LookVector * 48, 0.3)
        else
            local v4 = math.deg((math.acos((p2.player.HumanoidRootPart.CFrame.LookVector:Dot(p2.player.Humanoid.MoveDirection)))))

            if v4 < 45 then
                p2.Animations[1]:Play()
            elseif v4 > 135 then
                p2.Animations[4]:Play()
            elseif p2.player.HumanoidRootPart.CFrame.LookVector:Cross(p2.player.Humanoid.MoveDirection).Y > 0 then
                p2.Animations[2]:Play()
            else
                p2.Animations[3]:Play()
            end

            p2.player:AddPower(p2.player.Humanoid.MoveDirection * 48, 0.3)
        end

        p2:Fire("Enter")
    end
end

function t1.OnExit(_) -- line: 54
end

function t1.OnHit(_, _, ...) -- line: 58
end

function t1.OnEquip(p7) -- line: 62
    for i = 1, 4 do
        p7:LoadAnimation(i, i + 1000, Enum.AnimationPriority.Action3).Stopped:Connect(function() -- line: 65
            -- upvalues: p7 (copy)
            p7.stateTrove:Clean()
        end)
    end
end

function t1.OnUnequip(p8) -- line: 71
    p8.stateTrove:Clean()
end

return t1
