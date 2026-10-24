-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local LocalPlayer = game:GetService("Players").LocalPlayer
local PoolMgr, DataMgr, GameMgr, Camera = _G.PoolMgr, _G.DataMgr, _G.GameMgr, workspace.Camera

local function GenLine(p1, p2, p3) -- line: 10
    -- upvalues: TweenService (copy), PoolMgr (copy)
    local v1 = PoolMgr:Get("Effect_GunLine", script.Line)

    v1.Parent = workspace.FX
    v1.Start.Anchored = true
    v1.Start.CFrame = p1

    if p3 then
        v1.Start.Beam.Color = p3.Color
    else
        v1.Start.Beam.Color = script.Line.Start.Beam.Color
    end

    v1.End.Anchored = true
    v1.End.CFrame = p1
    TweenService:Create(v1.End, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
        CFrame = CFrame.new(p2)
    }):Play()
    task.delay(0.1, function() -- line: 25
        -- upvalues: v1 (copy), PoolMgr (copy)
        PoolMgr:Push("Effect_GunLine", v1)
    end)
end

function t1.Show(_, p5, p6, p7, p8) -- line: 30
    -- upvalues: Debris (copy), LocalPlayer (copy), DataMgr (copy), GameMgr (copy), Camera (copy), GenLine (copy)
    if p5 ~= nil and p7 ~= nil then
        local MuzzleFX = p5:FindFirstChild("MuzzleFX")

        if MuzzleFX ~= nil then
            local v2 = p7 == LocalPlayer.Character
            local _ = (Camera.CFrame.Position - p5.CFrame.Position).Magnitude

            if MuzzleFX:FindFirstChild("FireSound") then
                GameMgr:PlayWorldSound(MuzzleFX, MuzzleFX.FireSound):Play()
            end

            if MuzzleFX:FindFirstChild("Spark") then
                local clone = MuzzleFX.Spark:Clone()

                clone.Name = "_" .. clone.Name
                clone.Enabled = true
                clone.Parent = MuzzleFX
                Debris:AddItem(clone, 0.05)
            end

            local Config = DataMgr:GetConfig("WeaponData", p8)
            local v3 = Config and DataMgr:GetAsset(Config.asset):FindFirstChild("LineColor")

            if type(p6) == "table" then
                for _, v4 in p6 do
                    GenLine(MuzzleFX.WorldCFrame, v4, v3)
                end
            else
                GenLine(MuzzleFX.WorldCFrame, p6, v3)
            end

            local v5 = true

            if v2 then
                local ClientPlayer = DataMgr:GetClientPlayer()

                v5 = (not ClientPlayer or not ClientPlayer:ChackState("aim")) and not ClientPlayer.isFPS
            end

            if not v5 then
                for _, child in pairs(MuzzleFX:GetChildren()) do
                    if child:IsA("ParticleEmitter") and not child:GetAttribute("NoEmit") then
                        child:Emit(child:GetAttribute("EmitCount") / 2)
                    end
                end
            else
                for _, child in pairs(MuzzleFX:GetChildren()) do
                    if child:IsA("ParticleEmitter") and not child:GetAttribute("NoEmit") then
                        child:Emit(child:GetAttribute("EmitCount"))
                    end
                end
            end
        end
    end
end

function t1.Hide(_) -- line: 87
end

return t1
