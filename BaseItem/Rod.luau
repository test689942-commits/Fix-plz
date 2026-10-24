-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local RunService = game:GetService("RunService")
local _, UIManager, _, _ = _G.GameMgr, _G.UIManager, _G.EventMgr, _G.DataMgr
local CurrentCamera = workspace.CurrentCamera

return {
    OnUnequip = function(_) -- OnUnequip | line: 10
        -- upvalues: UIManager (copy)
        UIManager:HidePanel("FishPanel")
    end,
    OnEquip = function(p2) -- OnEquip | line: 14
        -- upvalues: RunService (copy), UIManager (copy), CurrentCamera (copy)
        UIManager:ShowPanel("FishPanel")
        p2:LoadAnimation("idle", 1172, nil, true):Play()
        p2.trove:Add(p2.player:AddSkill("Fish", Enum.UserInputType.MouseButton1, p2, 1019, "Throw"))

        local vm = p2.player.vm

        if not vm then
            return
        end

        p2.trove:Add(RunService.RenderStepped:Connect(function(_) -- line: 21
            -- upvalues: vm (copy), CurrentCamera (copy)
            vm.HumanoidRootPart.CFrame = CurrentCamera.CFrame * CFrame.new(0, -1.5, 0)
        end))
    end
}
