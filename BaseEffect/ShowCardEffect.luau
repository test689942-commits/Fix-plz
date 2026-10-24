-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local RunService = game:GetService("RunService")
local PoolMgr = _G.PoolMgr

return {
    Show = function(p1, p2) -- Show | line: 6
        -- upvalues: RunService (copy), PoolMgr (copy)
        local v1 = PoolMgr:Get("Effect_ShowCard", script.Effect)

        v1.Parent = workspace.FX
        p1.con = RunService.RenderStepped:Connect(function() -- line: 9
            -- upvalues: v1 (copy)
            v1.CFrame = workspace.CurrentCamera.CFrame * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -6, 0)
        end)

        for _, child in v1:GetChildren() do
            if child:IsA("Attachment") then
                if tonumber(child.Name) == p2 then
                    for _, child in child:GetChildren() do
                        child.Enabled = true
                    end
                else
                    for _, child in child:GetChildren() do
                        child.Enabled = false
                    end
                end
            end
        end

        p1.effect = v1
    end,
    Hide = function(p3) -- Hide | line: 28
        -- upvalues: PoolMgr (copy)
        p3.con:Disconnect()
        PoolMgr:Push("Effect_ShowCard", p3.effect)
    end
}
