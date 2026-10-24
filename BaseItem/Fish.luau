-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera

return {
    OnUnequip = function(_) -- OnUnequip | line: 5
    end,
    OnEquip = function(p2) -- OnEquip | line: 9
        -- upvalues: RunService (copy), CurrentCamera (copy)
        local vm = p2.player.vm

        if not vm then
            return
        end

        p2.trove:Add(RunService.RenderStepped:Connect(function(_) -- line: 14
            -- upvalues: vm (copy), CurrentCamera (copy)
            vm.HumanoidRootPart.CFrame = CurrentCamera.CFrame * CFrame.new(0, -1.5, 0)
        end))
    end
}
