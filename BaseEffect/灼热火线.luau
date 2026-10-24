-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local TweenService = game:GetService("TweenService")
local PoolMgr = _G.PoolMgr

return {
    Show = function(p1, p2, p3) -- Show | line: 5
        -- upvalues: TweenService (copy), PoolMgr (copy)
        local v1 = PoolMgr:Get("Effect_灼热火线", script.Effect)

        v1.Parent = workspace.FX
        v1.CFrame = CFrame.new(p2)

        local tween = TweenService:Create(v1, TweenInfo.new((p3 - p2).Magnitude / 500, Enum.EasingStyle.Linear), {
            CFrame = CFrame.new(p3)
        })

        tween.Completed:Connect(function() -- line: 11
            -- upvalues: p1 (copy), v1 (copy), PoolMgr (copy)
            p1:Emit(v1.Explode)
            task.delay(1.5, function() -- line: 13
                -- upvalues: v1 (copy), PoolMgr (copy)
                PoolMgr:Push("Effect_灼热火线", v1)
            end)
        end)
        tween:Play()
    end,
    Hide = function(_) -- Hide | line: 21
    end
}
