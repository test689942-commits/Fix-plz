-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local _, GameMgr, EventMgr, UIManager = _G.InputMgr, _G.GameMgr, _G.EventMgr, _G.UIManager
local DataMgr, _, CurrentCamera = _G.DataMgr, _G.New, workspace.CurrentCamera
local Players = game:GetService("Players")
local Mouse = Players.LocalPlayer:GetMouse()
local _ = Players.LocalPlayer.PlayerGui
local clamp = math.clamp

local function worldToScreen(p1) -- line: 17
    -- upvalues: CurrentCamera (copy)
    local v1 = CurrentCamera.CFrame:pointToObjectSpace(p1)
    local v3 = math.tan(math.rad(CurrentCamera.FieldOfView) / 2)

    return Vector2.new(CurrentCamera.ViewportSize.X * (0.5 + 0.5 * (v1.x / v1.z / -(CurrentCamera.ViewportSize.X / CurrentCamera.ViewportSize.Y * v3))), CurrentCamera.ViewportSize.Y * (0.5 + 0.5 * (v1.y / v1.z / v3)))
end

(function()
    local isHumanoid

    function isHumanoid(p2) -- line: 23
        -- upvalues: isHumanoid (ref)
        if p2.Parent:FindFirstChild("Humanoid") then
            return p2.Parent
        end

        if p2.Parent == workspace then
            return false
        end

        return isHumanoid(p2.Parent)
    end

    return isHumanoid
end)()

local function lerp(p3, p4, p5) -- line: 32
    return p3 + (p4 - p3) * p5
end

local function getDistance(p6, p7) -- line: 36
    return ((typeof(p6) == "Instance" and p6.Position or p6) - (typeof(p7) == "Instance" and p7.Position or p7)).magnitude
end

function t1.OnUnequip(p8) -- line: 40
    -- upvalues: TweenService (copy), EventMgr (copy), UIManager (copy)
    EventMgr:Triger("FreeClick", false)
    UIManager:HidePanel("GunPanel")
    p8.player.gunEquipped = false
    p8.inspect = false

    if p8.player.Character:FindFirstChild("Torso") then
        local v4 = p8.player.Character.Torso:FindFirstChild("Right Shoulder")
        local v5 = p8.player.Character.Torso:FindFirstChild("Left Shoulder")

        if v4 then
            TweenService:Create(v4, TweenInfo.new(0.15), {
                C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(0, 1.55, 0)
            }):Play()
        end

        if v5 then
            TweenService:Create(v5, TweenInfo.new(0.15), {
                C0 = CFrame.new(-1, 0.5, 0) * CFrame.Angles(0, -1.55, 0)
            }):Play()
        end
    end

    p8.player.aimAssistController:disable()
end

local function onEquipped(p9) -- line: 59
    -- upvalues: RunService (copy), UserInputService (copy), GameMgr (copy), UIManager (copy), DataMgr (copy), CurrentCamera (copy), Mouse (copy), clamp (copy), worldToScreen (copy)
    local frReticle = UIManager:ShowPanel("GunPanel").data.frReticle
    local Sounds = DataMgr:GetAsset(p9.data.asset):FindFirstChild("Sounds")

    for v6, v7 in pairs(p9.data.anims) do
        local track = p9:LoadAnimation(v6, v7)
        local v8 = p9.data.markers[v6]

        if v8 ~= nil then
            for v9, v10 in v8 do
                local v11 = Sounds:FindFirstChild(v10)

                if v11 ~= nil then
                    track:GetMarkerReachedSignal(v9):Connect(function() -- line: 73
                        -- upvalues: p9 (copy), v11 (copy), GameMgr (copy)
                        if v11:IsA("Sound") then
                            GameMgr:PlayWorldSound(p9.model.PrimaryPart, v11)
                            GameMgr:BroadcastSound(p9.model.PrimaryPart, v11)
                        else
                            local Children = v11:GetChildren()

                            GameMgr:PlayWorldSound(p9.model.PrimaryPart, Children[math.random(#Children)])
                            GameMgr:BroadcastSound(p9.model.PrimaryPart, Children[math.random(#Children)])
                        end
                    end)
                end
            end
        end
    end

    local Animations = p9.Animations

    p9.player.gunEquipped = true
    p9.equipTick = tick()
    Animations.idle.Priority = Enum.AnimationPriority.Action
    Animations.equip.Priority = Enum.AnimationPriority.Action3
    Animations.fire.Priority = Enum.AnimationPriority.Action2

    if Animations.inspect then
        Animations.inspect.Priority = Enum.AnimationPriority.Action4
    end

    if Animations.equip_empty then
        Animations.equip_empty.Priority = Enum.AnimationPriority.Action3
    end

    if Animations.inspect_empty then
        Animations.inspect_empty.Priority = Enum.AnimationPriority.Action4
    end

    if p9.detail.bullet > 0 or not Animations.equip_empty then
        Animations.equip:Play()
    else
        Animations.equip_empty:Play()
    end

    Animations.idle:Play()

    if Animations.noammo and p9.detail.bullet <= 0 then
        Animations.noammo:Play()
    end

    p9.player.Humanoid.Running:Connect(function(p10) -- line: 115
        -- upvalues: p9 (copy), Animations (copy)
        if Animations.holster then
            if p9.player.isRun then
                Animations.holster:AdjustSpeed(p10 / 10)
            else
                Animations.holster:AdjustSpeed(0)
            end
        end
    end)

    local v12 = false

    p9.model._mod:WaitForChild(p9.data.handle or "Handle")

    local v13 = p9.player.Character.Torso:WaitForChild("Right Shoulder")
    local v14 = p9.player.Character.Torso:WaitForChild("Left Shoulder")
    local v15 = RaycastParams.new()

    v15.FilterDescendantsInstances = { workspace.Map }
    v15.FilterType = Enum.RaycastFilterType.Include

    local v16
    local n1 = 0
    local n2 = 0
    local n3 = 0
    local aimPos = p9.model._mod.Handle:FindFirstChild("aimPos")
    local MuzzleFX = p9.model._mod.Handle:FindFirstChild("MuzzleFX")
    local n4 = 0.75
    local n5 = 1
    local n6 = 1
    local v17 = CFrame.new()
    local v18 = CFrame.new()
    local t2 = {}

    t2[1] = v18

    local v19 = CFrame.new()
    local v20 = CFrame.new()
    local v21 = CFrame.new()
    local vm = p9.player.vm
    local t3 = {
        x = 0,
        y = 0,
        z = 0
    }
    local v22 = CFrame.new()

    p9.trove:Add(RunService.RenderStepped:Connect(function(_) -- line: 155
        -- upvalues: p9 (copy), Animations (copy)
        Vector3.new(p9.player.Humanoid.RootPart.Velocity.y, 0, p9.player.Humanoid.RootPart.Velocity.z)

        if Animations.holster then
            if not p9.player:ChackState("aim") and tick() - p9.player.fireActive >= 0.5 and not p9.player.isFPS and not Animations.equip.IsPlaying and not Animations.fire.IsPlaying and not p9.player.isCrouch then
                if Animations.holsterIdle then
                    Animations.holsterIdle.Priority = Enum.AnimationPriority.Action2

                    if not Animations.holsterIdle.IsPlaying then
                        Animations.holsterIdle:Play(0.2)
                    end
                end

                Animations.holster.Priority = Enum.AnimationPriority.Action

                if not Animations.holster.IsPlaying then
                    Animations.holster:Play(0.1)
                    Animations.holster:AdjustSpeed(0)
                end
            elseif p9.player.isFPS and p9.player.isRun and not Animations.fire.IsPlaying and not Animations.equip.IsPlaying and not p9.player.isCrouch then
                if Animations.holsterIdle then
                    Animations.holsterIdle:Stop()
                end

                Animations.holster.Priority = Enum.AnimationPriority.Action

                if not Animations.holster.IsPlaying then
                    Animations.fire.Priority = Enum.AnimationPriority.Core
                    Animations.holster:Play(0.15)
                end
            else
                if p9.player:ChackState("aim") and p9.player.isFPS then
                    if not Animations.holster.IsPlaying then
                        Animations.holster:Play()
                    end

                    Animations.holster:Stop(1E-09)
                else
                    Animations.holster:Stop(0.25)
                end

                if Animations.holsterIdle then
                    Animations.holsterIdle:Stop(0.2)
                end
            end
        end

        if p9.player:ChackState("aim") and p9.player.isFPS and Animations.idle.IsPlaying then
            Animations.idle:Stop(1E-09)
        end

        if Animations.holster and Animations.holster.IsPlaying then
            Animations.idle:Stop(0.25)
        elseif not Animations.idle.IsPlaying then
            Animations.idle:Play(if p9.player:ChackState("aim") and p9.player.isFPS then 1E-09 else nil)
        end

        if Animations.holsterIdle and not p9.player.isRun and not p9.player:ChackState("reload") then
            Animations.holsterIdle:AdjustSpeed(0)
        elseif (p9.player.isRun or p9.player:ChackState("reload")) and Animations.holsterIdle then
            Animations.holsterIdle:Stop(0.25)
        end
    end))
    p9.trove:Add(RunService.RenderStepped:Connect(function(p12) -- line: 218
        -- upvalues: p9 (copy), frReticle (copy), Animations (copy), v12 (ref), v13 (copy), v14 (copy), v15 (copy), v16 (ref), n1 (ref), n2 (ref), n3 (ref), aimPos (copy), MuzzleFX (copy), n4 (ref), n5 (ref), n6 (ref), v17 (ref), t2 (copy), v19 (ref), v20 (ref), v21 (ref), vm (copy), t3 (copy), v22 (ref), UserInputService (copy), DataMgr (copy), CurrentCamera (copy), Mouse (copy), clamp (copy), worldToScreen (copy)
        local v23 = false
        local v24 = false
        local v25 = false
        local v26 = false
        local v27 = false
        local v28 = false

        if CurrentCamera.CameraSubject == p9.player.Humanoid then
            v23 = true
        else
            v28 = true
        end

        if v23 then
            if CurrentCamera.CameraType == Enum.CameraType.Scriptable then
                v28 = true
            else
                v24 = true
            end
        end

        v23 = false

        local v29

        if v24 then
            v29 = p12 * 60
            p9.model:FindFirstChild("Motor")

            if p9.player.isFPS then
                v23 = true
            else
                v28 = false
            end
        end

        v24 = false

        if v23 then
            if aimPos then
                v25 = true
            else
                v24 = true
            end
        end

        v23 = false

        if v24 then
            v17 = CFrame.new(0, 0, -0.5)
            v23 = true
        end

        v24 = false

        local WorldPosition, Position

        if v25 then
            WorldPosition = p9.model._mod.Handle.aimPos.WorldPosition
            Position = CurrentCamera.CFrame.Position

            if typeof(WorldPosition) == "Instance" then
                v24 = true
            else
                v26 = true
            end
        end

        v25 = false

        local v30

        if v24 then
            local WorldPositionPosition = WorldPosition.Position

            if WorldPositionPosition then
                v30 = WorldPositionPosition
                v25 = true
            else
                v26 = true
            end
        end

        v24 = false

        if v26 then
            v30 = WorldPosition
            v25 = true
        end

        v26 = false

        if v25 then
            if typeof(Position) == "Instance" then
                v26 = true
            else
                v24 = true
            end
        end

        v25 = false

        local v31

        if v26 then
            local PositionPosition = Position.Position

            if PositionPosition then
                v31 = PositionPosition
                v25 = true
            else
                v24 = true
            end
        end

        v26 = false

        if v24 then
            v31 = Position
            v25 = true
        end

        v24 = false

        local Motor, v32

        if v25 then
            Motor = (v30 - v31).magnitude
            v32 = p9.data.aimLerp or 0.15

            if Motor < 0.01 then
                v24 = true
            else
                v26 = true
            end
        end

        v25 = false

        if v24 then
            if p9.player:ChackState("aim") then
                v25 = true
            else
                v26 = true
            end
        end

        v24 = false

        if v26 then
            if p9.player:ChackState("aim") then
                v27 = true
            else
                v24 = true
            end
        end

        v26 = false

        if v24 then
            v12 = false
            v27 = true
        end

        v24 = false

        if v25 then
            v12 = true
            v27 = true
        end

        v25 = false

        if v27 then
            if Animations.inspect then
                v24 = true
            else
                v25 = true
            end
        end

        v27 = false

        local v33

        if v24 then
            Motor = Animations.inspect.IsPlaying

            if Motor then
                v33 = Motor
                v27 = true
            else
                v25 = true
            end
        end

        v24 = false

        if v25 then
            Motor = Animations.inspect_empty

            if Motor then
                v24 = true
            else
                v33 = Motor
                v27 = true
            end
        end

        v25 = false

        if v24 then
            v33 = Animations.inspect_empty.IsPlaying
            v27 = true
        end

        v24 = false

        if v27 then
            if p9.player:ChackState("aim") then
                v24 = true
            else
                v25 = true
            end
        end

        v27 = false

        local v34, v35

        if v24 then
            v34 = v17
            v35 = aimPos.WorldCFrame:toObjectSpace(vm.Head.CFrame)

            if v12 then
                v27 = true
            else
                v26 = true
            end
        end

        v24 = false

        if v27 then
            if p9.data.aimLock then
                v24 = true
            else
                v26 = true
            end
        end

        v27 = false

        local v36

        if v26 then
            v36 = v32 * v29
            v27 = true
        end

        v26 = false

        if v24 then
            v36 = 0.5
            v27 = true
        end

        v24 = false

        local v37

        if v27 then
            v34 = v34:lerp(v35, v36)

            if v34 then
                v37 = v34
                v24 = true
            else
                v25 = true
            end
        end

        v27 = false

        local v38, new

        if v25 then
            v38 = v17
            new = CFrame.new

            if p9.player.isCrouch then
                v27 = true
            else
                v26 = true
            end
        end

        v25 = false

        if v27 then
            if p9.player:ChackState("reload") then
                v26 = true
            else
                v25 = true
            end
        end

        v27 = false

        if v25 then
            if p9.data.noTacCrouch then
                v26 = true
            else
                v27 = true
            end
        end

        v25 = false

        if v27 then
            if v33 then
                v26 = true
            else
                v25 = true
            end
        end

        v27 = false

        local v39

        if v25 then
            v39 = -0.6
            v27 = true
        end

        v25 = false

        if v26 then
            v39 = 0
            v27 = true
        end

        v26 = false

        if v27 then
            if p9.player.isCrouch then
                v25 = true
            else
                v26 = true
            end
        end

        v27 = false

        if v25 then
            if p9.player:ChackState("reload") then
                v26 = true
            else
                v27 = true
            end
        end

        v25 = false

        if v27 then
            if p9.data.noTacCrouch then
                v26 = true
            else
                v25 = true
            end
        end

        v27 = false

        if v25 then
            if v33 then
                v26 = true
            else
                v27 = true
            end
        end

        v25 = false

        local v40

        if v27 then
            v40 = -0.35
            v25 = true
        end

        v27 = false

        if v26 then
            v40 = 0
            v25 = true
        end

        v26 = false

        local v41, Angles

        if v25 then
            v41 = new(v39, v40, -0.5)
            Angles = CFrame.Angles

            if p9.player.isCrouch then
                v27 = true
            else
                v26 = true
            end
        end

        v25 = false

        if v27 then
            if p9.player:ChackState("reload") then
                v26 = true
            else
                v25 = true
            end
        end

        v27 = false

        if v25 then
            if p9.data.noTacCrouch then
                v26 = true
            else
                v27 = true
            end
        end

        v25 = false

        if v27 then
            if v33 then
                v26 = true
            else
                v25 = true
            end
        end

        v27 = false

        local v42

        if v25 then
            v42 = 30
            v27 = true
        end

        v25 = false

        if v26 then
            v42 = 0
            v27 = true
        end

        v26 = false

        if v27 then
            v37 = v38:lerp(v41 * Angles(0, 0, (math.rad(v42))), 0.1 * v29)
            v24 = true
        end

        v27 = false

        if v24 then
            v17 = v37
            v23 = true
        end

        if v23 then
            if MuzzleFX then
                v27 = true
            else
                v28 = false
            end
        end

        v23 = false

        local v43

        if v27 then
            v43 = workspace:Raycast(CurrentCamera.CFrame.Position, MuzzleFX.WorldCFrame.Position - CurrentCamera.CFrame.Position, v15)

            if v43 then
                v23 = true
            else
                v25 = true
            end
        end

        v27 = false

        if v23 then
            if p9.player:ChackState("reload") then
                v25 = true
            else
                v27 = true
            end
        end

        v23 = false

        local Position2, Position3

        if v27 then
            Position2 = MuzzleFX.WorldCFrame.Position
            Position3 = v43.Position

            if typeof(Position2) == "Instance" then
                v23 = true
            else
                v26 = true
            end
        end

        v27 = false

        local v44

        if v23 then
            new = Position2.Position

            if new then
                v44 = new
                v27 = true
            else
                v26 = true
            end
        end

        v23 = false

        if v26 then
            v44 = Position2
            v27 = true
        end

        v26 = false

        if v27 then
            if typeof(Position3) == "Instance" then
                v26 = true
            else
                v23 = true
            end
        end

        v27 = false

        local v45

        if v26 then
            Angles = Position3.Position

            if Angles then
                v45 = Angles
                v27 = true
            else
                v23 = true
            end
        end

        if v23 then
            v45 = Position3
            v27 = true
        end

        if v27 then
            n3 = (v44 - v45).magnitude
            v28 = false
        end

        if v25 then
            n3 = 0
            v28 = false
        end

        if v28 then
            return
        end

        local v46 = false

        if p9.player.isFPS then
            if v13 then
                v13.C0 = v13.C0:Lerp(CFrame.new(1, 0.5, 0) * CFrame.Angles(0, 1.55, 0), p12 / 0.1)
            end
        elseif p9.player.Humanoid.Health > 0 then
            v46 = true
        elseif v13 then
            v13.C0 = v13.C0:Lerp(CFrame.new(1, 0.5, 0) * CFrame.Angles(0, 1.55, 0), p12 / 0.1)
        end

        local armOffset

        if v46 then
            if v13 then
                v34 = v13.C0
                new = CFrame.new(1, 0.5, 0)
                Angles = CFrame.Angles
                armOffset = p9.player.armOffset
                v42 = (Mouse.Origin.Position - Mouse.Hit.Position).unit.y
                v13.C0 = v34:Lerp(new * Angles(armOffset - math.asin(v42), 1.55, 0), p12 / 0.1)
            end

            if v14 then
                v34 = v14.C0
                new = CFrame.new(-1, 0.5, 0)
                Angles = CFrame.Angles
                armOffset = p9.player.armOffset
                v42 = (Mouse.Origin.Position - Mouse.Hit.Position).unit.y
                v14.C0 = v34:Lerp(new * Angles(armOffset - math.asin(v42), -1.55, 0), p12 / 0.1)
            end
        elseif v14 then
            v14.C0 = v14.C0:Lerp(CFrame.new(-1, 0.5, 0) * CFrame.Angles(0, -1.55, 0), p12 / 0.1)
        end

        local v47 = false
        local v48 = false
        local v49 = false
        local v50 = false

        if vm then
            v47 = true
        else
            v50 = true
        end

        if v47 then
            if p12 < 0.9 then
                v48 = true
            else
                v50 = false
            end
        end

        v47 = false

        if v48 then
            if p9.player:ChackState("reload") then
                v47 = true
            else
                v49 = true
            end
        end

        v48 = false

        local v51

        if v47 then
            v34 = n4
            Position2 = 0.25 * v29
            v32 = v34 + (0.25 - v34) * Position2

            if v32 then
                v51 = v32
                v48 = true
            else
                v49 = true
            end
        end

        v47 = false

        if v49 then
            v34 = n4
            Position2 = 0.1 * v29
            v51 = v34 + (0.75 - v34) * Position2
            v48 = true
        end

        v49 = false

        if v48 then
            n4 = v51

            if p9.player:ChackState("reload") then
                v49 = true
            else
                v47 = true
            end
        end

        v48 = false

        local v52

        if v49 then
            v34 = n5
            Position2 = 0.25 * v29
            v51 = v34 + (0.15 - v34) * Position2

            if v51 then
                v52 = v51
                v48 = true
            else
                v47 = true
            end
        end

        v49 = false

        if v47 then
            v34 = n5
            Position2 = 0.1 * v29
            v52 = v34 + (2 - v34) * Position2
            v48 = true
        end

        v47 = false

        if v48 then
            n5 = v52

            if p9.player:ChackState("reload") then
                v47 = true
            else
                v49 = true
            end
        end

        v48 = false

        local v53

        if v47 then
            v34 = n6
            Position2 = 0.25 * v29
            v52 = v34 + (0.05 - v34) * Position2

            if v52 then
                v53 = v52
                v48 = true
            else
                v49 = true
            end
        end

        if v49 then
            v34 = n6
            Position2 = 0.1 * v29
            v53 = v34 + (1 - v34) * Position2
            v48 = true
        end

        local v54

        if v48 then
            n6 = v53
            v34 = p9.player.Humanoid.RootPart.Velocity.magnitude
            v53 = math.min(v34, 20)
            v35 = 0.5 * (math.random(v53 / 1.35, v53) / 14)
            Angles = tick() * 8
            Position2 = v35 * math.sin(Angles)
            new = 0.5 * (math.random(v53 / 1.35, v53) / 14)
            v40 = tick() * 16
            v35 = new * math.cos(v40)
            v34 = Vector3.new(Position2, v35, 0)
            Angles = 1 * (math.random(v53 / 1.35, v53) / 6)
            armOffset = tick() * 16
            new = Angles * math.sin(armOffset)
            v35 = math.rad(new)
            v40 = 1 * (math.random(v53 / 1.35, v53) / 6)
            Angles = v40 * math.cos(tick() * 8)
            new = math.rad(Angles)
            Position2 = Vector3.new(v35, new, 0)
            p9.player.SP_bobbing:shove(v34 / 10 * (math.random(v53 / 1.35, v53) / 10) * n4 * v29)
            p9.player.SP_bobbingAngle:shove(Position2 / 2.5 * (math.random(v53 / 1.35, v53) / 10) * n4 * v29)
            Position2 = p9.player.SP_bobbing:update(p12)
            v35 = p9.player.SP_bobbingAngle:update(p12)
            Position3 = p9.player.SP_aim:update(p12)
            v31 = p9.player.SP_recoil:update(p12)
            new = p9.player.SP_recoilANG:update(p12)
            t2[1] = t2[1]:Lerp(CFrame.new(Position2.x, Position2.y, 0) * CFrame.Angles(v35.x, v35.y, v35.z), 0.1 * v29)
            v20 = CFrame.new(Position3.x, Position3.y, 0) * CFrame.Angles(0, 0, Position3.z) * CFrame.new(v31.x, v31.y, v31.z) * CFrame.Angles(new.x, new.y, new.z)
            n1 = CurrentCamera.CFrame:vectorToObjectSpace(p9.player.Humanoid.RootPart.Velocity / 10).x
            new = UserInputService:GetMouseDelta()
            Angles = new.x / 400 * n6
            v40 = new.y / 400 * n6
            armOffset = p9.player.SP_sway
            v54 = math.clamp(v40, -0.15 * v29, 0.15 * v29)
            armOffset:shove((Vector3.new(v54, math.clamp(Angles, -0.15 * v29, 0.15 * v29), -math.rad((clamp(n1, -25, 25))))))
            v40 = p9.player.SP_sway:update(p12)
            v19 = CFrame.Angles(v40.x, v40.y, v40.y / 1.5) * CFrame.Angles(0, 0, v40.z)
            v50 = false
        end

        if not v50 then
            local v61

            if p9.player.fakeCam:IsDescendantOf(p9.player.Character) and p9.player.Humanoid.RootPart and p9.player.isFPS then
                v61 = p9.player.fakeCam.CFrame:toObjectSpace(p9.player.Humanoid.RootPart.CFrame)

                if v16 then
                    v34, Position2, v35 = v61:toOrientation()
                    new, Angles = v61:toObjectSpace(v16):toEulerAnglesXYZ()
                    v42 = t3.x
                    v54 = 0.5 * v29
                    t3.x = v42 + (new - v42) * v54
                    v42 = t3.y
                    v54 = 0.5 * v29
                    t3.y = v42 + (Angles - v42) * v54
                    v42 = t3.z
                    v54 = 0.5 * v29
                    t3.z = v42 + (v35 - v42) * v54
                    CurrentCamera.CFrame *= CFrame.Angles(t3.x, t3.y, -t3.z)
                    v22 = CFrame.fromEulerAnglesXYZ(p9.player.fakeCam.Cam.Transform:ToEulerAnglesXYZ()) or CFrame.new()
                end

                v16 = v61
            end

            v61 = worldToScreen((CurrentCamera.CFrame * v22:Inverse() * CFrame.new(0, 0, -4)).Position)
            v34 = CurrentCamera.ViewportSize / 2

            local v62, v63

            if p9.player.isFPS or DataMgr.data.setting.MouseLock then
                v35 = UDim2.new(0, v61.x, 0, v61.y)

                if v35 then
                    v62 = v35
                    v63 = true
                else
                    v63 = false
                end
            else
                v63 = false
            end

            if not v63 then
                v62 = UDim2.new(0, Mouse.x, 0, Mouse.y + 58)
            end

            frReticle.Position = v62
            vm.HumanoidRootPart.CFrame = CurrentCamera.CFrame * v19 * v17 * t2[1] * CFrame.new(0, -1.5, n2) * v20 * v22:Inverse()
            v62 = n2
            new = n3
            Angles = 0.1 * v29
            n2 = v62 + (new - v62) * Angles
        end

        v21 = CurrentCamera.CFrame
    end))
end

function t1.OnEquip(p13) -- line: 325
    -- upvalues: RunService (copy), EventMgr (copy), onEquipped (copy)
    p13.BSpread = 1

    if rawget(p13.detail, "mode") == nil then
        p13.detail.mode = p13.data.mode
    end

    p13.level = math.floor((math.log(math.max(p13.detail.exp, 1), 2))) + 1
    EventMgr:Triger("FreeClick", true)
    p13.trove:Add(p13.player:AddSkill("GunFire", Enum.UserInputType.MouseButton1, p13))
    p13.trove:Add(p13.player:AddSkill("GunReload", Enum.KeyCode.R, p13))
    p13.trove:Add(p13.player:AddSkill("Aim", Enum.UserInputType.MouseButton2, p13))
    p13.trove:Add(p13.player:AddSkill("Inspect", Enum.KeyCode.H, p13))
    p13.trove:Add(p13.player:AddSkill("Switch", Enum.KeyCode.B, p13))
    EventMgr:Triger("EquipWeapon")

    local n7 = 0

    p13.trove:Add(RunService.RenderStepped:Connect(function(_) -- line: 341
        -- upvalues: p13 (copy), n7 (ref)
        local v66 = time()

        if not (v66 - n7 > p13.data.rate * 2 / p13.player.rate) then
            return
        end

        n7 = v66
        p13.BSpread = math.max(1, p13.BSpread - p13.data.recoilVal / 2 / 5)
    end))
    p13.player.aimAssistController:enable()
    onEquipped(p13)
end

function t1.OnChange(p15, p16, _) -- line: 352
    if p16 ~= "exp" then
        return
    end

    p15.level = math.floor((math.log(math.max(p15.detail.exp, 1), 2))) + 1
end

return t1
