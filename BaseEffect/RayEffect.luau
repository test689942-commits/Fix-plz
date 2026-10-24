-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local PoolMgr = _G.PoolMgr
local TweenService = game:GetService("TweenService")
local t2 = {}

return {
    Show = function(_, p2, p3, p4, p5) -- Show | line: 6
        -- upvalues: PoolMgr (copy), TweenService (copy), t2 (copy)
        if not t2[p2] then
            t2[p2] = script:FindFirstChild(p2)
        end

        local v1 = PoolMgr:Get("Effect_Ray" .. p2, t2[p2])

        v1.Parent = workspace.FX
        v1:PivotTo(p3.CFrame)
        v1.End.CFrame = v1.Start.CFrame

        local tween = TweenService:Create(v1.End, TweenInfo.new(p5 and p5 / 2 or 0.5), {
            CFrame = p4.CFrame
        })

        tween.Completed:Connect(function() -- line: 16
            -- upvalues: p4 (copy), p5 (copy), v1 (copy), TweenService (copy)
            TweenService:Create(v1.Start, TweenInfo.new(p5 and p5 / 2 or 0.5), {
                CFrame = p4.CFrame
            }):Play()
        end)
        tween:Play()
        task.delay(p5 or 1, function() -- line: 20
            -- upvalues: p2 (copy), v1 (copy), PoolMgr (copy)
            PoolMgr:Push("Effect_Ray" .. p2, v1)
        end)
    end
}
