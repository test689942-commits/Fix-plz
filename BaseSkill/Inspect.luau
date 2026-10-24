-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("UserInputService")
game:GetService("TweenService")

local _ = _G.GameMgr

function t1.OnInit(p1, p2) -- line: 6
    p1.item = p2
    p1.isOn = false
end

function t1.OnEnter(p3) -- line: 11
    local Animations = p3.item.Animations

    if p3:ChackUse() or p3.player:ChackState("reload") or Animations.inspect and Animations.inspect.IsPlaying or Animations.inspect_empty and Animations.inspect_empty.IsPlaying then
        return
    end

    Animations.fire.Priority = Enum.AnimationPriority.Core

    if not (p3.item.detail.bullet > 0) and Animations.inspect_empty then
        Animations.inspect_empty:Play()

        if Animations.noammo then
            Animations.noammo:Stop()
            Animations.inspect_empty.Stopped:Once(function() -- line: 29
                -- upvalues: Animations (copy)
                Animations.noammo:Play(1E-07)
            end)
        end

        return
    end

    Animations.inspect:Play()
end

function t1.OnExit(_) -- line: 36
end

function t1.OnHit(_, _, ...) -- line: 39
end

function t1.OnEquip(_) -- line: 43
end

function t1.OnUnequip(_) -- line: 47
end

return t1
