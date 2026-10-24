-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local Parent = require(script.Parent)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local DataMgr, _, _, _ = _G.DataMgr, _G.GameMgr, _G.EventMgr, _G.NetMgr
local _, CurrentCamera = _G.New, workspace.CurrentCamera
local Mouse = Players.LocalPlayer:GetMouse()
local v1 = RaycastParams.new()

v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = { workspace.Map }

function t1.Init(p1) -- line: 20
    -- upvalues: TweenService (copy), RunService (copy), UserInputService (copy), DataMgr (copy), CurrentCamera (copy), Mouse (copy)
    local t2 = {}

    t2[1] = Vector3.new(0, 0, 0)
    p1.trove:Add(RunService.RenderStepped:Connect(function(p2) -- line: 23
        -- upvalues: p1 (copy), t2 (copy), TweenService (copy)
        t2[1] = t2[1]:Lerp(p1.Humanoid.MoveDirection, 0.15 * (p2 * 60))

        local v2 = t2[1].Unit * TweenService:GetValue(t2[1].Magnitude, Enum.EasingStyle.Quad, Enum.EasingDirection.In)

        if v2.Magnitude > 0 then
            p1.Humanoid:Move(v2)
        end
    end))

    local Character, Humanoid = p1.Character, p1.Humanoid

    Character:WaitForChild("Head").CollisionGroup = "NoCollisions"

    local BodyGyro = Instance.new("BodyGyro")

    BodyGyro.MaxTorque = Vector3.new(0, 1E+06, 0)
    BodyGyro.D = 25
    p1.fireActive = 0

    local Neck = Character:WaitForChild("Torso"):WaitForChild("Neck")
    local v3 = Neck and Neck.C0

    p1.trove:Add(RunService.Heartbeat:Connect(function(p3) -- line: 48
        -- upvalues: p1 (copy), Humanoid (copy), BodyGyro (copy), Neck (copy), v3 (copy), DataMgr (copy), CurrentCamera (copy), Mouse (copy)
        local v4 = Humanoid.RootPart and Humanoid.RootPart.CFrame:toObjectSpace(CurrentCamera.CFrame).lookVector

        if Neck and v4 then
            Neck.C0 = Neck.C0:Lerp(CFrame.new(0, v3.y, 0) * CFrame.Angles(4.71238898038469, 0, 3.141592653589793) * CFrame.Angles(0, 0, -math.asin(v4.x)) * CFrame.Angles(-math.asin(v4.y), 0, 0), p3 * 60 * 0.15)
        end

        local v7 = tick() - p1.fireActive < 3

        if v7 then
            if p1:ChackState("Ragdoll") or Humanoid.Sit then
                BodyGyro.Parent = nil
            else
                BodyGyro.Parent = Humanoid.RootPart
            end

            BodyGyro.CFrame = CFrame.new(CurrentCamera.CFrame.Position, CurrentCamera.CFrame.Position + (not DataMgr:GetSetting("MouseLock") and Mouse.UnitRay.Direction.unit or CurrentCamera.CFrame.LookVector) * 100)
        else
            BodyGyro.Parent = nil
        end

        if not p1:ChackState("Ragdoll") then
            if v7 then
                Humanoid.AutoRotate = false
            else
                Humanoid.AutoRotate = true
            end
        end
    end))
    p1.trove:Add(DataMgr:AddSettingChangeEvent("Sensitivity", function(p4) -- line: 78
        -- upvalues: UserInputService (copy)
        UserInputService.MouseDeltaSensitivity = p4
    end))
    p1.trove:Add(function() -- line: 81
        -- upvalues: UserInputService (copy), DataMgr (copy)
        UserInputService.MouseDeltaSensitivity = DataMgr:GetSetting("Sensitivity") or 1
    end)
    UserInputService.MouseDeltaSensitivity = DataMgr:GetSetting("Sensitivity") or 1
end

function Parent.FindTarget(p5, p6) -- line: 87
    p6 = p6 or 72

    local n1 = 99999
    local v9, v10

    for _, child in workspace.Entity:GetChildren() do
        if child.PrimaryPart ~= nil and not child:GetAttribute("isDie") then
            local LockPart = child:FindFirstChild("LockPart")

            if LockPart then
                for _, child2 in LockPart:GetChildren() do
                    local v14 = child2.CFrame.Position - p5.HumanoidRootPart.CFrame.Position

                    if not (v14.Y > 10) then
                        local v15 = v14.Magnitude / (0.75 + 0.25 * p5.HumanoidRootPart.CFrame.LookVector:Dot(v14.Unit))

                        if v15 < p6 and v15 < n1 then
                            v10 = child2
                            n1 = v15
                            v9 = child
                        end
                    end
                end
            else
                local v16 = child.PrimaryPart.CFrame.Position - p5.HumanoidRootPart.CFrame.Position

                if not (v16.Y > 10) then
                    local v17 = v16.Magnitude / (0.75 + 0.25 * p5.HumanoidRootPart.CFrame.LookVector:Dot(v16.Unit))

                    if v17 < p6 and v17 < n1 then
                        v9 = child
                        n1 = v17
                    end
                end
            end
        end
    end

    return v9, v10 or v9 and v9.PrimaryPart
end

function Parent.AttackAdsorption(p7, p8) -- line: 125
    p8 = p8 or {}

    if p7.atkTarget == nil
        or p7.atkTarget.PrimaryPart == nil
        or p7.atkTarget:GetAttribute("isDie")
        or p7.lockPart == nil
        or p7.lockPart.Parent == nil
        or (p7.lockPart.CFrame.Position - p7.HumanoidRootPart.CFrame.Position).Magnitude > 16 then
        local v23, v24 = p7:FindTarget(p8.range)

        p7.atkTarget = v23
        p7.lockPart = v24
    end

    if not (p7.atkTarget and p7.lockPart) then
        if p8.distance then
            p7:AlignPosition(p7.HumanoidRootPart.CFrame * CFrame.new(0, 0, -p8.distance), 36, 0.1)
        end
    else
        local v25 = p7.lockPart.CFrame.Position - p7.HumanoidRootPart.CFrame.Position

        if p8.distance and v25.Magnitude > 5 then
            local v28 = CFrame.lookAlong(p7.HumanoidRootPart.CFrame.Position + v25.Unit * math.min(p8.distance, v25.Magnitude - 5), Vector3.new(v25.X, 0, v25.Z).Unit)

            p7:AlignPosition(v28, p8.speed, p8.time)

            if p8.target then
                v28 = p7.lockPart or v28
            end

            p7:AlignOrientation(v28, p8.time)
        else
            local v29 = p7.lockPart.CFrame.Position - p7.HumanoidRootPart.CFrame.Position
            local target = p8.target
            local lockPart = if target then p7.lockPart else nil

            if not target or not lockPart then
                lockPart = CFrame.lookAlong(Vector3.new(0, 0, 0), Vector3.new(v29.X, 0, v29.Z).Unit)
            end

            p7:AlignOrientation(lockPart, p8.time)
        end
    end
end

return t1
