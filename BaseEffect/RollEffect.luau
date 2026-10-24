-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer.PlayerGui
local TweenService = game:GetService("TweenService")
local GameMgr, _, _, EventMgr = _G.GameMgr, _G.PoolMgr, _G.DataMgr, _G.EventMgr
local _, New = _G.UIManager, _G.New
local v1 = New("Utility.Tool")()
local Roll, v2, v3, ScreenGui, CFrame, v4

return {
    Show = function(_, p2, p3) -- Show | line: 20
        -- upvalues: Players (copy), PlayerGui (copy), TweenService (copy), GameMgr (copy), EventMgr (copy), New (copy), v1 (copy), Roll (ref), v2 (ref), v3 (ref), ScreenGui (ref), CFrame (ref), v4 (ref)
        if Roll == nil then
            Roll = script.Roll

            local Roll2 = Roll

            Roll2.Parent = workspace
            v2 = New("Utility.MoonanimatorTool")(script:FindFirstChild("Animation"))
            v2.loop = false
            v2.complete:Add(function() -- line: 26
                -- upvalues: PlayerGui (copy), TweenService (copy), EventMgr (copy), Roll (ref), v3 (ref), ScreenGui (ref), CFrame (ref), v4 (ref)
                workspace.CurrentCamera.CFrame = CFrame
                workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                Roll.Parent = nil

                if v4 then
                    v4:Destroy()
                end

                EventMgr:Triger("HideUI", false)
                ScreenGui.Parent = PlayerGui
                ScreenGui.Frame.BackgroundTransparency = 0

                local tween = TweenService:Create(ScreenGui.Frame, TweenInfo.new(1), {
                    BackgroundTransparency = 1
                })

                tween.Completed:Connect(function() -- line: 37
                    -- upvalues: ScreenGui (ref)
                    ScreenGui.Parent = nil
                end)
                tween:Play()
                v3()
            end)
            ScreenGui = Instance.new("ScreenGui")
            ScreenGui.ResetOnSpawn = false
            ScreenGui.IgnoreGuiInset = true

            local Frame = Instance.new("Frame", ScreenGui)

            Frame.Size = UDim2.new(1, 0, 1, 0)
            Frame.BackgroundTransparency = 1
            task.spawn(function() -- line: 50
                -- upvalues: Players (copy), New (copy), Roll (ref)
                local v5 = Players:CreateHumanoidModelFromDescription(Players:GetHumanoidDescriptionFromUserId(Players.LocalPlayer.UserId), Enum.HumanoidRigType.R6)

                v5.Parent = Roll.Player

                for _, descendant in v5:GetDescendants() do
                    if descendant:IsA("Motor6D") then
                        descendant:Destroy()
                    end
                end

                for _, child in Roll.Player:GetChildren() do
                    if child:IsA("Part") then
                        child.Transparency = 1

                        local v6 = v5:FindFirstChild(child.Name)

                        v6.CFrame = child.CFrame
                        New("Utility.Weld")(child, v6)
                    end
                end
            end)
        end

        if v2.isPlay then
            p2()
        else
            EventMgr:Triger("HideUI", true)
            v3 = p2

            local Roll2 = Roll

            Roll2.Parent = workspace

            if v4 then
                v4:Destroy()
            end

            v4 = v1:GetItemModel({
                id = p3
            })
            v4.Parent = Roll
            v4.PrimaryPart.CFrame = Roll.Chest.WeaponsNew.CFrame
            New("Utility.Weld")(Roll.Chest.WeaponsNew, v4.PrimaryPart)
            workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
            CFrame = workspace.CurrentCamera.CFrame
            v2:Play()
            GameMgr:PlaySound(1107)
        end
    end,
    Hide = function(_) -- Hide | line: 96
        -- upvalues: v2 (ref)
        v2:Stop()
        v2.complete()
    end
}
