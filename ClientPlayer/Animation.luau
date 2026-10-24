-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local Parent = require(script.Parent)
local DataMgr, GameMgr, InputMgr = _G.DataMgr, _G.GameMgr, _G.InputMgr
local t2 = {
    idle = 1052,
    walk = 1021,
    walkBack = 1027,
    run = 1022,
    jump = 1023,
    fall = 1026,
    climb = 1053,
    sit = 1054
}

local function stopAllAnimations(p1) -- line: 22
    p1.animationState = ""
    p1.animation = nil

    if p1.keyframeReached ~= nil then
        p1.keyframeReached:disconnect()
    end

    if p1.animationTrack ~= nil then
        p1.animationTrack:Stop()
        p1.animationTrack:Destroy()
        p1.animationTrack = nil
    end

    return p1.animationState
end

local function setAnimationSpeed(p2, p3) -- line: 36
    if p3 ~= p2.animationSpeed then
        p2.animationSpeed = p3
        p2.animationTrack:AdjustSpeed(p2.animationSpeed)
    end
end

local function keyFrameReachedFunc(p4, p5) -- line: 43
    if p5 ~= "End" then
        return
    end

    playAnimation(p4, p4.animationState, 0, p4.Humanoid)

    local animationSpeed = p4.animationSpeed

    if animationSpeed ~= p4.animationSpeed then
        p4.animationSpeed = animationSpeed
        p4.animationTrack:AdjustSpeed(p4.animationSpeed)
    end
end

function playAnimation(p6, p7, p8, p9) -- line: 50
    -- upvalues: DataMgr (copy), GameMgr (copy)
    local v1 = p6.animationDic[p7]

    if v1 == nil or v1 == p6.animation and v1.AnimationId == p6.animation.AnimationId then
        return
    end

    if p6.animationTrack ~= nil then
        p6.animationTrack:Stop(p8)
        p6.animationTrack:Destroy()
    end

    p6.animationTrack = p9:WaitForChild("Animator"):LoadAnimation(v1)
    p6.animationTrack:Play(p8)
    p6.animationState = p7
    p6.animation = v1
    p6.animationSpeed = 1

    if p6.keyframeReached ~= nil then
        p6.keyframeReached:disconnect()
    end

    p6.keyframeReached = p6.animationTrack.KeyframeReached:connect(function(p10) -- line: 68
        -- upvalues: p6 (copy)
        if p10 ~= "End" then
            return
        end

        playAnimation(p6, p6.animationState, 0, p6.Humanoid)

        local animationSpeed = p6.animationSpeed

        if animationSpeed ~= p6.animationSpeed then
            p6.animationSpeed = animationSpeed
            p6.animationTrack:AdjustSpeed(p6.animationSpeed)
        end
    end)
    p6.animationTrack:GetMarkerReachedSignal("WalkSound"):Connect(function() -- line: 71
        -- upvalues: p6 (copy), DataMgr (copy), GameMgr (copy)
        local Config = DataMgr:GetConfig("WalkSound", p6.Humanoid.FloorMaterial)

        if Config then
            GameMgr:PlayWorldSound(p6.HumanoidRootPart, Config.soundList[math.random(Config.soundList.count)], true).Volume = 0.2
        end
    end)
end

local function move(p11, p12) -- line: 80
    if p11.fallTime > 0 then
        p11.fallTime -= p12
    end

    if p11.animationState == "Standing" then
        playAnimation(p11, "idle", 0.25, p11.Humanoid)
    elseif p11.animationState == "FreeFall" and p11.fallTime <= 0 then
        playAnimation(p11, "fall", 0.75, p11.Humanoid)
    elseif p11.animationState == "Seated" then
        playAnimation(p11, "sit", 0.5, p11.Humanoid)
    elseif p11.animationState == "Running" then
        if p11.Humanoid.MoveDirection:Dot(p11.HumanoidRootPart.CFrame.LookVector) > -0.25 then
            if p11.moveSpeed > 14 then
                playAnimation(p11, "run", 0.25, p11.Humanoid)
            else
                playAnimation(p11, "walk", 0.25, p11.Humanoid)
            end
        else
            playAnimation(p11, "walkBack", 0.25, p11.Humanoid)
        end

        local v2 = p11.moveSpeed / 13

        if v2 ~= p11.animationSpeed then
            p11.animationSpeed = v2
            p11.animationTrack:AdjustSpeed(p11.animationSpeed)
        end
    elseif p11.animationState == "Dead" or p11.animationState == "GettingUp" or p11.animationState == "FallingDown" or p11.animationState == "Seated" or p11.animationState == "-PlatformStanding" then
        p11.animationState = ""
        p11.animation = nil

        if p11.keyframeReached ~= nil then
            p11.keyframeReached:disconnect()
        end

        if p11.animationTrack ~= nil then
            p11.animationTrack:Stop()
            p11.animationTrack:Destroy()
            p11.animationTrack = nil
        end

        local _ = p11.animationState
    end
end

local function HumanoidInit(p13) -- line: 113
    p13.Humanoid.Running:connect(function(p14) -- line: 118
        -- upvalues: p13 (copy)
        p13.moveSpeed = p14

        if not p13:ChackState("Fall") then
            if p14 > 0.01 then
                if p13.animationTrack then
                    local v3 = p14 / 13

                    if v3 ~= p13.animationSpeed then
                        p13.animationSpeed = v3
                        p13.animationTrack:AdjustSpeed(p13.animationSpeed)
                    end
                end

                p13.animationState = "Running"
            else
                playAnimation(p13, "idle", 0.25, p13.Humanoid)
                p13.animationState = "Standing"
            end
        end
    end)
    p13.Humanoid.Jumping:connect(function() -- line: 134
        -- upvalues: p13 (copy)
        playAnimation(p13, "jump", 0.1, p13.Humanoid)
        p13.fallTime = 0.3
        p13.animationState = "Jumping"
    end)
    p13.Humanoid.Climbing:connect(function(p15) -- line: 140
        -- upvalues: p13 (copy)
        if p13:ChackState("Fall") then
            return
        end

        playAnimation(p13, "climb", 0.25, p13.Humanoid)

        local v4 = p15 / 12

        if v4 ~= p13.animationSpeed then
            p13.animationSpeed = v4
            p13.animationTrack:AdjustSpeed(p13.animationSpeed)
        end

        p13.animationState = "Climbing"
    end)
    p13.Humanoid.GettingUp:connect(function() -- line: 149
        -- upvalues: p13 (copy)
        if not p13:ChackState("Fall") then
            p13.animationState = "GettingUp"
        end
    end)
    p13.Humanoid.FreeFalling:connect(function() -- line: 156
        -- upvalues: p13 (copy)
        if not p13:ChackState("Fall") then
            if p13.fallTime <= 0 then
                playAnimation(p13, "fall", 0.75, p13.Humanoid)
            end

            p13.animationState = "FreeFall"
        end
    end)
    p13.Humanoid.FallingDown:connect(function() -- line: 166
        -- upvalues: p13 (copy)
        if not p13:ChackState("Fall") then
            p13.animationState = "FallingDown"
        end
    end)
    p13.Humanoid.Seated:connect(function() -- line: 173
        -- upvalues: p13 (copy)
        if not p13:ChackState("Fall") then
            p13.animationState = "Seated"
        end
    end)
    p13.Humanoid.PlatformStanding:connect(function() -- line: 180
        -- upvalues: p13 (copy)
        if not p13:ChackState("Fall") then
            p13.animationState = "PlatformStanding"
        end
    end)
    p13.Humanoid.Swimming:connect(function(p16) -- line: 187
        -- upvalues: p13 (copy)
        if not p13:ChackState("Fall") then
            if p16 > 0 then
                p13.animationState = "Running"
            else
                p13.animationState = "Standing"
            end
        end
    end)
end

function t1.Init(p17) -- line: 199
    -- upvalues: DataMgr (copy), InputMgr (copy), t2 (copy), move (copy), HumanoidInit (copy)
    task.spawn(function() -- line: 201
        -- upvalues: p17 (copy)
        local Running = p17.HumanoidRootPart:WaitForChild("Running")

        if Running then
            Running:Destroy()
        end
    end)
    task.spawn(function() -- line: 208
        -- upvalues: p17 (copy), DataMgr (copy), t2 (copy), move (copy), HumanoidInit (copy)
        local Animate = p17.Character:WaitForChild("Animate")

        if Animate then
            Animate:Destroy()
        end

        for _, v5 in p17.Character.Humanoid.Animator:GetPlayingAnimationTracks() do
            v5:Stop()
            v5:Destroy()
        end

        p17.animationDic = {}
        p17.animationState = "Standing"
        p17.animationTrack = nil
        p17.animationSpeed = 1
        p17.animation = nil
        p17.keyframeReached = nil
        p17.moveSpeed = 0
        p17.fallTime = 0

        for v6, v7 in t2 do
            p17.animationDic[v6] = Instance.new("Animation")
            p17.animationDic[v6].AnimationId = DataMgr:GetConfig("AnimationData", v7).asset
        end

        HumanoidInit(p17)
        playAnimation(p17, "idle", 0.25, p17.Humanoid)
        p17.trove:Add(task.spawn(function() -- line: 236
            -- upvalues: p17 (copy), move (copy)
            while true do
                move(p17, task.wait(0.1))
            end
        end))
    end)

    local v8 = false

    p17.Humanoid.Seated:Connect(function(p18, p19) -- line: 244
        -- upvalues: p17 (copy), v8 (ref), DataMgr (copy), InputMgr (copy), t2 (copy)
        if p18 then
            local Sit = p19:FindFirstChild("Sit")

            if not (Sit and Sit:IsA("Animation")) then
                p17:SetAnimation("sit", DataMgr:GetConfig("AnimationData", t2.sit).asset)
            else
                p17:SetAnimation("sit", Sit.AnimationId)
            end
        end

        if v8 ~= p18 then
            InputMgr:SetProximityPromptActive(not p18)
            v8 = p18
        end
    end)
    p17.trove:Add(function() -- line: 258
        -- upvalues: v8 (ref), InputMgr (copy)
        if v8 then
            InputMgr:SetProximityPromptActive(false)
        end
    end)
end

function Parent.SetAnimation(p20, p21, p22) -- line: 265
    -- upvalues: DataMgr (copy), t2 (copy)
    if p20.animationDic[p21] then
        if p22 ~= nil then
            p20.animationDic[p21].AnimationId = p22
        else
            p20.animationDic[p21].AnimationId = DataMgr:GetConfig("AnimationData", t2[p21]).asset
        end
    else
        p20.animationDic[p21] = Instance.new("Animation")
        p20.animationDic[p21].AnimationId = p22
    end
end

return t1
