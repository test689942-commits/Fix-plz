-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local RunService = game:GetService("RunService")
local _, _, EventMgr, _ = _G.GameMgr, _G.UIManager, _G.EventMgr, _G.DataMgr
local CurrentCamera = workspace.CurrentCamera

return {
    OnUnequip = function(_) -- OnUnequip | line: 10
        -- upvalues: EventMgr (copy)
        EventMgr:Triger("FreeClick", false)
    end,
    OnEquip = function(p2) -- OnEquip | line: 15
        -- upvalues: RunService (copy), EventMgr (copy), CurrentCamera (copy)
        EventMgr:Triger("FreeClick", true)
        p2.trove:Add(p2.player:AddSkill("PlaceTrap", Enum.UserInputType.MouseButton1, p2, 1019, "Place"))

        local vm = p2.player.vm

        if not vm then
            return
        end

        p2.trove:Add(RunService.RenderStepped:Connect(function(_) -- line: 23
            -- upvalues: vm (copy), CurrentCamera (copy)
            vm.HumanoidRootPart.CFrame = CurrentCamera.CFrame * CFrame.new(0, -1.5, 0)
        end))
    end
}
