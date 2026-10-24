-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("UserInputService")

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local DataMgr, _, EventMgr, _ = _G.DataMgr, _G.GameMgr, _G.EventMgr, _G.InputMgr
local New = _G.New

require(script.Parent)

local CurrentCamera = workspace.CurrentCamera
local v1 = RaycastParams.new()

v1.FilterDescendantsInstances = { workspace.Map }
v1.FilterType = Enum.RaycastFilterType.Include

local function getWorldSize(p1) -- line: 22
    local v2 = p1.CFrame:VectorToWorldSpace(p1.Size)

    return (Vector3.new(math.abs(v2.X), math.abs(v2.Y), (math.abs(v2.Z))))
end

function t1.Init(p2) -- line: 27
    -- upvalues: TweenService (copy), RunService (copy), Players (copy), DataMgr (copy), EventMgr (copy), New (copy), CurrentCamera (copy), v1 (copy)
    local Part = Instance.new("Part", p2.Character)

    Part.Name = "FakeCamera"
    Part.Transparency = 1
    Part.CanCollide = false
    Part.CanTouch = false
    Part.CanQuery = false
    Part.Size = Vector3.new(0.5, 0.5, 0.5)

    local Motor6D = Instance.new("Motor6D", Part)

    Motor6D.Name = "Camera"
    Motor6D.Part0 = p2.HumanoidRootPart
    Motor6D.Part1 = Part
    p2.cameraOffset = Players.LocalPlayer:FindFirstChild("CameraOffset")

    if not p2.cameraOffset then
        p2.cameraOffset = Instance.new("Vector3Value")
        p2.cameraOffset.Name = "CameraOffset"
        p2.cameraOffset.Parent = Players.LocalPlayer
        p2.cameraOffset.Value = Vector3.new(3, 0, 4.5)
    end

    CurrentCamera.CameraSubject = p2.Humanoid
    CurrentCamera.CameraType = Enum.CameraType.Custom
    CurrentCamera:ClearAllChildren()
    CurrentCamera.CFrame = p2.HumanoidRootPart.CFrame
    p2.CameraShaker = New("Utility.CameraShaker")(Enum.RenderPriority.Camera.Value, function(p3) -- line: 55
        -- upvalues: DataMgr (copy), CurrentCamera (copy)
        if not DataMgr:GetSetting("CameraShake") then
            CurrentCamera.CFrame *= p3
        end
    end)
    p2.CameraShaker:Start()
    p2.trove:Add(EventMgr:AddEvent("ShakerCamera", function(p4, p5, p6, p7, p8, p9, p10) -- line: 63
        -- upvalues: p2 (copy), DataMgr (copy)
        if DataMgr:GetSetting("CameraShake") then
            return
        end

        local v7, v8, v9

        if p10 then
            if p2.HumanoidRootPart == nil then
                return
            end

            local Magnitude = (p2.HumanoidRootPart.CFrame.Position - p10).Magnitude
            local v10

            if Magnitude <= 8 then
                v10 = 1
            else
                local v11 = (Magnitude - 8) / (p4 * 15 - 8)

                if v11 > 1 then
                    return
                end

                local v12 = 1 - v11

                v10 = v12 * v12
            end

            v7 = p4 * v10
            v8 = p8 * v10
            v9 = p9 * v10
        else
            v7 = p4
            v8 = p8
            v9 = p9
        end

        p2.CameraShaker:ShakeOnce(v7, p5, p6, p7, v8, v9)
    end))
    p2.trove:Add(p2.CameraShaker)

    local v13 = Vector3.new(0, 0, 0)

    p2.trove:Add(EventMgr:AddEvent("CameraOffset", function(p11) -- line: 94
        -- upvalues: v13 (ref)
        v13 = p11 or Vector3.new(0, 0, 0)
    end))
    p2.trove:Add(EventMgr:AddEvent("CameraFOV", function(p12) -- line: 98
        -- upvalues: TweenService (copy), CurrentCamera (copy)
        TweenService:Create(CurrentCamera, TweenInfo.new(0.3), {
            FieldOfView = tonumber(p12) or 70
        }):Play()
    end))
    p2.trove:Add(EventMgr:AddEvent("CameraShake", function(p13) -- line: 102
        -- upvalues: p2 (copy), DataMgr (copy)
        if not DataMgr:GetSetting("CameraShake") then
            p2.CameraShaker:ShakeOnce(tonumber(p13), 20, 0, 0.5, 0, 0)
        end
    end))
    p2.trove:Add(RunService.RenderStepped:Connect(function(p14) -- line: 109
        -- upvalues: p2 (copy), v13 (ref), TweenService (copy), CurrentCamera (copy), v1 (copy)
        if CurrentCamera.CameraSubject ~= p2.Humanoid or CurrentCamera.CameraType == Enum.CameraType.Scriptable or p2.Humanoid.RootPart == nil then
            return
        end

        local _ = {
            {
                CurrentCamera.CFrame.RightVector * -3.5,
                (Vector3.new(1.75, 0, 0))
            },
            {
                CurrentCamera.CFrame.RightVector * 3.5,
                (Vector3.new(1, 0, 1.5))
            },
            {
                CurrentCamera.CFrame.UpVector * 3.5,
                (Vector3.new(0, -1.75, 0))
            },
            {
                CurrentCamera.CFrame.UpVector * -1.5,
                (Vector3.new(0, 1.75, 0))
            }
        }
        local t2 = {
            {
                p2.Humanoid.RootPart.CFrame.RightVector * -5,
                (Vector3.new(1.75, 0, 0))
            },
            {
                p2.Humanoid.RootPart.CFrame.RightVector * 5,
                (Vector3.new(1, 0, 1.5))
            },
            {
                p2.Humanoid.RootPart.CFrame.UpVector * 5,
                (Vector3.new(0, -1.75, 0))
            }
        }
        local v14 = Vector3.new(0, 0, 0)
        local v15 = false

        for _, v16 in pairs(t2) do
            local v17 = workspace:Raycast(p2.Humanoid.RootPart.CFrame.Position, v16[1], v1)

            if v17 then
                local Instance = v17.Instance
                local v18 = Instance.CFrame:VectorToWorldSpace(Instance.Size)

                v17 = Vector3.new(math.abs(v18.X), math.abs(v18.Y), (math.abs(v18.Z)))

                if v17.x > 3 or v17.z > 3 then
                    v14 += v16[2]
                    v15 = true
                end
            end
        end

        if not v15 then
            v14 = t2[1][2]
        end

        local v22 = v14 + v13
        local v26 = CurrentCamera.CFrame:vectorToObjectSpace((Vector3.new(math.clamp(p2.Humanoid.RootPart.Velocity.x, -10, 10) / 5, -math.clamp(p2.Humanoid.RootPart.Velocity.y, -50, 80) / 10, -math.clamp(p2.Humanoid.RootPart.Velocity.z, -20, 20) / 10)))

        p2.cameraOffset.Value += (v22 + v26 - p2.cameraOffset.Value) * TweenService:GetValue(p14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    end))
end

return t1
