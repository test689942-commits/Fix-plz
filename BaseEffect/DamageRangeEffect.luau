-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local TweenService = game:GetService("TweenService")
local PoolMgr = _G.PoolMgr

return {
    Show = function(_, p2, p3, p4, p5) -- Show | line: 5
        -- upvalues: TweenService (copy), PoolMgr (copy)
        local v1 = PoolMgr:Get("Effect_DamageRange_" .. p5, script:FindFirstChild(p5))

        v1.Parent = workspace.FX

        if p5 == "Box" then
            v1.PrimaryPart.Size = Vector3.new(p3.X, 0.1, p3.Z)
            v1.PrimaryPart.CFrame = p2
            v1.Hit.Size = Vector3.new(p3.X, 0.1, 0)
            v1.Hit.CFrame = p2 * CFrame.new(0, 0, p3.Z / 2)

            local tween = TweenService:Create(v1.Hit, TweenInfo.new(p4, Enum.EasingStyle.Linear), {
                Size = Vector3.new(p3.X, 0.1, p3.Z),
                CFrame = p2
            })

            tween:Play()
            tween.Completed:Connect(function() -- line: 16
                -- upvalues: p5 (copy), v1 (copy), PoolMgr (copy)
                PoolMgr:Push("Effect_DamageRange_" .. p5, v1)
            end)
        elseif p5 == "Circle" then
            v1.PrimaryPart.Size = Vector3.new(0.1, p3.Y, p3.Y)
            v1.PrimaryPart.CFrame = p2 * CFrame.Angles(0, 0, 1.5707963267948966)
            v1.Hit.Size = Vector3.new(0.1, 0, 0)
            v1.Hit.CFrame = p2 * CFrame.Angles(0, 0, 1.5707963267948966)

            local tween = TweenService:Create(v1.Hit, TweenInfo.new(p4, Enum.EasingStyle.Linear), {
                Size = Vector3.new(0.1, p3.Y, p3.Y)
            })

            tween:Play()
            tween.Completed:Connect(function() -- line: 26
                -- upvalues: p5 (copy), v1 (copy), PoolMgr (copy)
                PoolMgr:Push("Effect_DamageRange_" .. p5, v1)
            end)
        end
    end,
    Hide = function(_) -- Hide | line: 32
    end
}
