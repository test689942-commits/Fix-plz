-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local RunService = game:GetService("RunService")
local PoolMgr = _G.PoolMgr
local LocalPlayer = game:GetService("Players").LocalPlayer

return {
    Show = function(p1, p2) -- Show | line: 6
        -- upvalues: RunService (copy), PoolMgr (copy), LocalPlayer (copy)
        p1.effect = PoolMgr:Get("Effect_Task", script.Part)
        p1.effect.Parent = workspace.FX
        p1.effect.CFrame = CFrame.new(p2)
        p1.con = RunService.RenderStepped:Connect(function() -- line: 10
            -- upvalues: p1 (copy), p2 (copy), LocalPlayer (copy)
            if p1.effect == nil or p1.effect.Parent == nil then
                p1.effect = nil
                p1:Destroy()
            end

            if not (LocalPlayer.Character and LocalPlayer.Character.PrimaryPart) then
                return
            end

            p1.effect.Icon.Label.Text = math.floor((LocalPlayer.Character.PrimaryPart.CFrame.Position - p2).Magnitude) .. " m"
        end)
    end,
    Hide = function(p3) -- Hide | line: 21
        -- upvalues: PoolMgr (copy)
        p3.con:Disconnect()
        p3.con = nil

        if p3.effect then
            PoolMgr:Push("Effect_Task", p3.effect)
        end

        p3.effect = nil
    end
}
