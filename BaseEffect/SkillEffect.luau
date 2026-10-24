-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local PoolMgr = _G.PoolMgr
local t2 = {}

return {
    Show = function(p1, p2, p3, p4, p5) -- Show | line: 5
        -- upvalues: PoolMgr (copy), t2 (copy)
        local v1 = p5

        if p2 == nil then
            return
        end

        if not t2[p3] then
            local v2 = script:FindFirstChild(p3)

            if v2 == nil then
                return
            end

            t2[p3] = v2
        end

        local v3 = PoolMgr:Get("Effect_Skill" .. p3, t2[p3])

        v3.Parent = workspace.FX
        p1.effect = v3

        if typeof(p2) == "CFrame" then
            if v3:IsA("Model") then
                v3:PivotTo(p2)
            else
                v3.CFrame = p2
                v3.Anchored = true
            end
        elseif typeof(p2) == "Vector3" then
            if v3:IsA("Model") then
                v3:PivotTo(CFrame.new(p2))
            else
                v3.CFrame = CFrame.new(p2)
                v3.Anchored = true
            end
        elseif typeof(p2) == "Instance" then
            if v3:IsA("Model") then
                v3:PivotTo(p2.CFrame)
                v3.PrimaryPart.Anchored = false
                p1.root = v3.PrimaryPart
                p1.weld = p1:Weld(p2, v3.PrimaryPart)
            else
                v3.CFrame = p2.CFrame
                v3.Anchored = false
                p1.root = v3
                p1.weld = p1:Weld(p2, v3)
            end
        end

        if p4 == -1 then
            p1.value = p3

            if p5 then
                p1.enableTime = p1:SetEnabled(v3, true)
            end

            return p1
        end

        local v4 = p4 or 1.5

        if p5 then
            v1 = p1:SetEnabled(v3, true)
        else
            v4 = math.max(p1:Emit(v3), v4)
        end

        task.delay(v4, function() -- line: 63
            -- upvalues: v1 (ref), p1 (copy), p3 (copy), v3 (copy), PoolMgr (copy)
            if p1.weld then
                p1.weld:Destroy()
            end

            if v1 then
                p1:SetEnabled(v3, false)
                task.delay(v1, function() -- line: 69
                    -- upvalues: p1 (copy), p3 (copy), PoolMgr (copy)
                    PoolMgr:Push("Effect_Skill" .. p3, p1.effect)
                end)
            else
                PoolMgr:Push("Effect_Skill" .. p3, p1.effect)
            end
        end)
    end,
    Hide = function(p6) -- Hide | line: 79
        -- upvalues: PoolMgr (copy)
        if p6.weld then
            p6.weld:Destroy()

            if p6.root then
                p6.root.Anchored = true
            end
        end

        if p6.value then
            if p6.enableTime then
                p6:SetEnabled(p6.effect, false)
                task.delay(p6.enableTime, function() -- line: 89
                    -- upvalues: p6 (copy), PoolMgr (copy)
                    PoolMgr:Push("Effect_Skill" .. p6.value, p6.effect)
                end)
            else
                PoolMgr:Push("Effect_Skill" .. p6.value, p6.effect)
            end
        end
    end
}
