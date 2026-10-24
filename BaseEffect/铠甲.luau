-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local TweenService = game:GetService("TweenService")
local PoolMgr, New = _G.PoolMgr, _G.New

return {
    Show = function(p1, p2, p3) -- Show | line: 6
        -- upvalues: TweenService (copy), PoolMgr (copy), New (copy)
        if p2 == nil then
            return
        end

        local v1 = PoolMgr:Get("Effect_铠甲", script.Effect)

        v1.Parent = workspace.FX

        local v2 = PoolMgr:Get("Effect_铠甲VFX", script:FindFirstChild("护甲VFX"))

        v2.Parent = workspace.FX

        local v3, v4, v5

        if typeof(p2) == "CFrame" then
            v1.PrimaryPart.Anchored = true
            v1.PrimaryPart.CFrame = p2
            v2.PrimaryPart.Anchored = true
            v2:PivotTo(p2)
        else
            v1.PrimaryPart.Anchored = false
            v1:PivotTo(p2.CFrame)
            v3 = New("Utility.Weld")(p2, v1.PrimaryPart)
            v2.PrimaryPart.Anchored = false
            v2:PivotTo(p2.CFrame)
            v5 = New("Utility.Weld")(p2, v2.PrimaryPart)
            v4 = v5
            v5.C1 = CFrame.new(0, -12, 0)
        end

        for _, descendant in v1:GetDescendants() do
            if descendant:IsA("Motor6D") then
                descendant.C1 = descendant:GetAttribute("C1")
                TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
                    C1 = CFrame.new()
                }):Play()
            end
        end

        TweenService:Create(v5, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
            C1 = CFrame.new()
        }):Play()
        task.delay(0.5, function() -- line: 43
            -- upvalues: p1 (copy), p3 (copy), v1 (copy), v2 (copy), v3 (ref), v4 (ref), TweenService (copy), PoolMgr (copy)
            v3:Destroy()
            PoolMgr:Push("Effect_铠甲", v1)
            p1:Emit(v2.PrimaryPart)

            local tween = TweenService:Create(v4, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {
                C1 = CFrame.Angles(0, 6.283185307179586, 0)
            })

            tween:Play()
            task.delay(p3 or 1, function() -- line: 49
                -- upvalues: tween (copy), v2 (copy), v4 (ref), PoolMgr (copy)
                PoolMgr:Push("Effect_铠甲VFX", v2)
                tween:Destroy()
                v4:Destroy()
            end)
        end)
    end,
    Hide = function(_) -- Hide | line: 57
    end
}
