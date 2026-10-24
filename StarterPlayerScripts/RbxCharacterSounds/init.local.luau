-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local AtomicBinding = require(script:WaitForChild("AtomicBinding"))

local function loadFlag(p1) -- line: 12
    local function v1() -- line: 13
        -- upvalues: p1 (copy)
        return UserSettings():IsUserFeatureEnabled(p1)
    end

    local ok, result = pcall(v1)

    return ok and result
end

local v2 = "UserSoundsUseRelativeVelocity2"

local function v3() -- line: 13
    -- upvalues: v2 (copy)
    return UserSettings():IsUserFeatureEnabled(v2)
end

local ok, result = pcall(v3)
local v4 = ok and result
local v5 = "UserNewCharacterSoundsApi3"

local function v6() -- line: 13
    -- upvalues: v5 (copy)
    return UserSettings():IsUserFeatureEnabled(v5)
end

local ok2, result2 = pcall(v6)
local v7 = ok2 and result2
local v8 = "UserFixCharSoundsEmitters"

local function v9() -- line: 13
    -- upvalues: v8 (copy)
    return UserSettings():IsUserFeatureEnabled(v8)
end

local ok3, result3 = pcall(v9)
local v10 = ok3 and result3
local v11 = "UserFixCharSoundsEmitterRootPart"

local function v12() -- line: 13
    -- upvalues: v11 (copy)
    return UserSettings():IsUserFeatureEnabled(v11)
end

local ok4, result4 = pcall(v12)
local v13 = ok4 and result4
local t1 = {
    Climbing = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looped = true
    },
    Died = {
        SoundId = "rbxasset://sounds/uuhhh.mp3"
    },
    FreeFalling = {
        SoundId = "rbxasset://sounds/action_falling.ogg",
        Looped = true
    },
    GettingUp = {
        SoundId = "rbxasset://sounds/action_get_up.mp3"
    },
    Jumping = {
        SoundId = "rbxasset://sounds/action_jump.mp3"
    },
    Landing = {
        SoundId = "rbxasset://sounds/action_jump_land.mp3"
    },
    Running = {
        SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looped = true,
        Pitch = 1.85
    },
    Splash = {
        SoundId = "rbxasset://sounds/impact_water.mp3"
    },
    Swimming = {
        SoundId = "rbxasset://sounds/action_swim.mp3",
        Looped = true,
        Pitch = 1.6
    }
}
local t2 = {
    Climbing = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looping = true
    },
    Died = {
        AssetId = "rbxasset://sounds/uuhhh.mp3"
    },
    FreeFalling = {
        AssetId = "rbxasset://sounds/action_falling.ogg",
        Looping = true
    },
    GettingUp = {
        AssetId = "rbxasset://sounds/action_get_up.mp3"
    },
    Jumping = {
        AssetId = "rbxasset://sounds/action_jump.mp3"
    },
    Landing = {
        AssetId = "rbxasset://sounds/action_jump_land.mp3"
    },
    Running = {
        AssetId = "rbxasset://sounds/action_footsteps_plastic.mp3",
        Looping = true,
        PlaybackSpeed = 1.85
    },
    Splash = {
        AssetId = "rbxasset://sounds/impact_water.mp3"
    },
    Swimming = {
        AssetId = "rbxasset://sounds/action_swim.mp3",
        Looping = true,
        PlaybackSpeed = 1.6
    }
}

local function map(p2, p3, p4, p5, p6) -- line: 97
    return (p2 - p3) * (p6 - p5) / (p4 - p3) + p5
end

local function getRelativeVelocity(p7, p8) -- line: 101
    if not p7 then
        return p8
    end

    local ActiveController = p7.ActiveController
    local v14, v15

    if ActiveController then
        if p7.ActiveController:IsA("GroundController") then
            local GroundSensor = p7.GroundSensor

            if GroundSensor then
                v14 = GroundSensor
                v15 = true
            else
                v15 = false
            end
        else
            v15 = false
        end
    else
        v14 = ActiveController
        v15 = true
    end

    if not v15 then
        v14 = p7.ActiveController:IsA("ClimbController") and p7.ClimbSensor
    end

    if not (v14 and v14.SensedPart) then
        return p8
    end

    return p8 - v14.SensedPart:GetVelocityAtPosition(p7.RootPart.Position)
end

local function playSound(p9, p10) -- line: 118
    -- upvalues: v7 (copy)
    if not p10 then
        p9.TimePosition = 0
    end

    if v7 and p9:IsA("AudioPlayer") then
        p9:Play()
    else
        p9.Playing = true
    end
end

local function stopSound(p11) -- line: 129
    -- upvalues: v7 (copy)
    if not (v7 and p11:IsA("AudioPlayer")) then
        p11.Playing = false
    else
        p11:Stop()
    end
end

local function playSoundIf(p12, p13) -- line: 137
    -- upvalues: v7 (copy)
    if not (v7 and p12:IsA("AudioPlayer")) then
        p12.Playing = p13
    elseif p12.IsPlaying and not p13 then
        p12:Stop()
    elseif not p12.IsPlaying and p13 then
        p12:Play()
    end
end

local function setSoundLooped(p14, p15) -- line: 149
    -- upvalues: v7 (copy)
    if not (v7 and p14:IsA("AudioPlayer")) then
        p14.Looped = p15
    else
        p14.Looping = p15
    end
end

local function shallowCopy(p16) -- line: 157
    local t3 = {}

    for v16, v17 in pairs(p16) do
        t3[v16] = v17
    end

    return t3
end

local function initializeSoundSystem(p17) -- line: 165
    -- upvalues: Players (copy), RunService (copy), SoundService (copy), v4 (copy), v7 (copy), v10 (copy), v13 (copy), t1 (copy), t2 (copy), getRelativeVelocity (copy)
    local humanoid, rootPart = p17.humanoid, p17.rootPart
    local AudioEmitter, ControllerManager

    if v4 then
        ControllerManager = humanoid.Parent:FindFirstChild("ControllerManager")
    end

    local t4 = {}

    if v7 and SoundService.CharacterSoundsUseNewApi == Enum.RolloutState.Enabled then
        local v18, Character

        if v10 then
            if v13 then
                v18 = humanoid.RootPart or humanoid.Parent
            else
                Character = nil
                v18 = humanoid.RootPart
            end
        else
            Character = Players.LocalPlayer.Character
        end

        local t5 = {}
        local n1 = 5

        while n1 < 150 do
            t5[n1] = 5 / n1
            n1 *= 1.25
        end

        t5[150] = 0

        local AudioEmitter2 = if v10 then Instance.new("AudioEmitter", v18) else Instance.new("AudioEmitter", Character)

        AudioEmitter = AudioEmitter2
        AudioEmitter2.Name = "RbxCharacterSoundsEmitter"
        AudioEmitter2:SetDistanceAttenuation(t5)

        for v19, v20 in pairs(t2) do
            local AudioPlayer = Instance.new("AudioPlayer")
            local Wire = Instance.new("Wire")

            AudioPlayer.Name = v19
            Wire.Name = v19 .. "Wire"
            AudioPlayer.Archivable = false
            AudioPlayer.Volume = 0.65

            for v21, v22 in pairs(v20) do
                AudioPlayer[v21] = v22
            end

            AudioPlayer.Parent = rootPart
            Wire.Parent = AudioPlayer
            Wire.SourceInstance = AudioPlayer
            Wire.TargetInstance = AudioEmitter2
            t4[v19] = AudioPlayer
        end
    else
        for v23, v24 in pairs(t1) do
            local Sound = Instance.new("Sound")

            Sound.Name = v23
            Sound.Archivable = false
            Sound.RollOffMinDistance = 5
            Sound.RollOffMaxDistance = 150
            Sound.Volume = 0.65

            for v25, v26 in pairs(v24) do
                Sound[v25] = v26
            end

            Sound.Parent = rootPart
            t4[v23] = Sound
        end
    end

    local t6 = {}

    local function stopPlayingLoopedSounds(p18) -- line: 241
        -- upvalues: t6 (copy), v7 (copy)
        p18 = p18 or nil

        local _pairs = pairs
        local t7 = {}

        for v28, v29 in pairs(t6) do
            t7[v28] = v29
        end

        for v30 in _pairs(t7) do
            if v30 ~= p18 then
                if v7 and v30:IsA("AudioPlayer") then
                    v30:Stop()
                else
                    v30.Playing = false
                end

                t6[v30] = nil
            end
        end
    end

    local t8 = {
        [Enum.HumanoidStateType.FallingDown] = function() -- line: 253
            -- upvalues: stopPlayingLoopedSounds (copy)
            stopPlayingLoopedSounds()
        end,
        [Enum.HumanoidStateType.GettingUp] = function() -- line: 257
            -- upvalues: t4 (copy), stopPlayingLoopedSounds (copy), v7 (copy)
            stopPlayingLoopedSounds()

            local GettingUp = t4.GettingUp

            GettingUp.TimePosition = 0

            if not (v7 and GettingUp:IsA("AudioPlayer")) then
                GettingUp.Playing = true
            else
                GettingUp:Play()
            end
        end,
        [Enum.HumanoidStateType.Jumping] = function() -- line: 262
            -- upvalues: t4 (copy), stopPlayingLoopedSounds (copy), v7 (copy)
            stopPlayingLoopedSounds()

            local Jumping = t4.Jumping

            Jumping.TimePosition = 0

            if not (v7 and Jumping:IsA("AudioPlayer")) then
                Jumping.Playing = true
            else
                Jumping:Play()
            end
        end,
        [Enum.HumanoidStateType.Swimming] = function() -- line: 267
            -- upvalues: rootPart (copy), t4 (copy), t6 (copy), stopPlayingLoopedSounds (copy), v7 (copy)
            local v31 = math.abs(rootPart.AssemblyLinearVelocity.Y)

            if v31 > 0.1 then
                t4.Splash.Volume = math.clamp((v31 - 100) * 0.72 / 250 + 0.28, 0, 1)

                local Splash2 = t4.Splash

                Splash2.TimePosition = 0

                if not (v7 and Splash2:IsA("AudioPlayer")) then
                    Splash2.Playing = true
                else
                    Splash2:Play()
                end
            end

            stopPlayingLoopedSounds(t4.Swimming)

            local Swimming = t4.Swimming

            if not (v7 and Swimming:IsA("AudioPlayer")) then
                Swimming.Playing = true
            else
                Swimming:Play()
            end

            t6[t4.Swimming] = true
        end,
        [Enum.HumanoidStateType.Freefall] = function() -- line: 278
            -- upvalues: t4 (copy), t6 (copy), stopPlayingLoopedSounds (copy), v7 (copy)
            t4.FreeFalling.Volume = 0
            stopPlayingLoopedSounds(t4.FreeFalling)

            local FreeFalling = t4.FreeFalling

            if not (v7 and FreeFalling:IsA("AudioPlayer")) then
                FreeFalling.Looped = true
            else
                FreeFalling.Looping = true
            end

            if t4.FreeFalling:IsA("Sound") then
                t4.FreeFalling.PlaybackRegionsEnabled = true
            end

            t4.FreeFalling.LoopRegion = NumberRange.new(2, 9)

            local FreeFalling2 = t4.FreeFalling

            FreeFalling2.TimePosition = 0

            if not (v7 and FreeFalling2:IsA("AudioPlayer")) then
                FreeFalling2.Playing = true
            else
                FreeFalling2:Play()
            end

            t6[t4.FreeFalling] = true
        end,
        [Enum.HumanoidStateType.Landed] = function() -- line: 292
            -- upvalues: rootPart (copy), t4 (copy), stopPlayingLoopedSounds (copy), v7 (copy)
            stopPlayingLoopedSounds()

            local v33 = math.abs(rootPart.AssemblyLinearVelocity.Y)

            if not (v33 > 75) then
                return
            end

            t4.Landing.Volume = math.clamp((v33 - 50) * 1 / 50 + 0, 0, 1)

            local Landing2 = t4.Landing

            Landing2.TimePosition = 0

            if v7 and Landing2:IsA("AudioPlayer") then
                Landing2:Play()
            else
                Landing2.Playing = true
            end
        end,
        [Enum.HumanoidStateType.Running] = function() -- line: 301
            -- upvalues: t4 (copy), t6 (copy), stopPlayingLoopedSounds (copy), v7 (copy)
            stopPlayingLoopedSounds(t4.Running)

            local Running = t4.Running

            if not (v7 and Running:IsA("AudioPlayer")) then
                Running.Playing = true
            else
                Running:Play()
            end

            t6[t4.Running] = true
        end,
        [Enum.HumanoidStateType.Climbing] = function() -- line: 307
            -- upvalues: rootPart (copy), ControllerManager (ref), t4 (copy), t6 (copy), stopPlayingLoopedSounds (copy), v4 (copy), v7 (copy), getRelativeVelocity (copy)
            local Climbing = t4.Climbing
            local AssemblyLinearVelocity = rootPart.AssemblyLinearVelocity

            if v4 then
                AssemblyLinearVelocity = getRelativeVelocity(ControllerManager, AssemblyLinearVelocity)
            end

            if math.abs(AssemblyLinearVelocity.Y) > 0.1 then
                if v7 and Climbing:IsA("AudioPlayer") then
                    Climbing:Play()
                else
                    Climbing.Playing = true
                end

                stopPlayingLoopedSounds(Climbing)
            else
                stopPlayingLoopedSounds()
            end

            t6[Climbing] = true
        end,
        [Enum.HumanoidStateType.Seated] = function() -- line: 320
            -- upvalues: stopPlayingLoopedSounds (copy)
            stopPlayingLoopedSounds()
        end,
        [Enum.HumanoidStateType.Dead] = function() -- line: 324
            -- upvalues: t4 (copy), stopPlayingLoopedSounds (copy), v7 (copy)
            stopPlayingLoopedSounds()

            local Died = t4.Died

            Died.TimePosition = 0

            if not (v7 and Died:IsA("AudioPlayer")) then
                Died.Playing = true
            else
                Died:Play()
            end
        end
    }
    local t9 = {
        [t4.Climbing] = function(_, p20, p21) -- line: 332
            -- upvalues: ControllerManager (ref), v4 (copy), v7 (copy), getRelativeVelocity (copy)
            local v35 = (if v4 then getRelativeVelocity(ControllerManager, p21) else p21).Magnitude > 0.1

            if not (v7 and p20:IsA("AudioPlayer")) then
                p20.Playing = v35
            elseif p20.IsPlaying and not v35 then
                p20:Stop()
            elseif not p20.IsPlaying and v35 then
                p20:Play()
            end
        end,
        [t4.FreeFalling] = function(p22, p23, p24) -- line: 337
            if p24.Magnitude > 75 then
                p23.Volume = math.clamp(p23.Volume + p22 * 0.9, 0, 1)
            else
                p23.Volume = 0
            end
        end,
        [t4.Running] = function(_, p26, p27) -- line: 345
            -- upvalues: humanoid (copy), v7 (copy)
            local v37 = p27.Magnitude > 0.5 and humanoid.MoveDirection.Magnitude > 0.5

            if not (v7 and p26:IsA("AudioPlayer")) then
                p26.Playing = v37
            elseif p26.IsPlaying and not v37 then
                p26:Stop()
            elseif not p26.IsPlaying and v37 then
                p26:Play()
            end
        end
    }
    local t10 = {
        [Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running
    }
    local v38 = t10[humanoid:GetState()]
    local v39 = v38

    if not v38 then
        v39 = humanoid:GetState()
    end

    local function transitionTo(p28) -- line: 357
        -- upvalues: t8 (copy), v39 (ref)
        local v40 = t8[p28]

        if v40 then
            v40()
        end

        v39 = p28
    end

    local v41 = v39
    local v42 = t8[v41]

    if v42 then
        v42()
    end

    v39 = v41

    local connection = humanoid.StateChanged:Connect(function(_, p30) -- line: 369
        -- upvalues: t8 (copy), t10 (copy), v39 (ref)
        local v43 = t10[p30] or p30

        if v43 == v39 then
            return
        end

        local v44 = t8[v43]

        if v44 then
            v44()
        end

        v39 = v43
    end)
    local connection2 = RunService.Stepped:Connect(function(_, p32) -- line: 377
        -- upvalues: rootPart (copy), t6 (copy), t9 (copy)
        for v45 in pairs(t6) do
            local v46 = t9[v45]

            if v46 then
                v46(p32, v45, rootPart.AssemblyLinearVelocity)
            end
        end
    end)

    local function terminate() -- line: 388
        -- upvalues: AudioEmitter (ref), t4 (copy), connection (copy), connection2 (copy), v13 (copy)
        connection:Disconnect()
        connection2:Disconnect()

        if v13 and AudioEmitter then
            AudioEmitter:Destroy()
        end

        for _, v47 in pairs(t4) do
            v47:Destroy()
        end

        table.clear(t4)
    end

    return terminate
end

local v48 = AtomicBinding.new({
    humanoid = "Humanoid",
    rootPart = "HumanoidRootPart"
}, initializeSoundSystem)
local t11 = {}

local function characterAdded(p33) -- line: 415
    -- upvalues: v48 (copy)
    v48:bindRoot(p33)
end

local function characterRemoving(p34) -- line: 419
    -- upvalues: v48 (copy)
    v48:unbindRoot(p34)
end

local function playerAdded(p35) -- line: 423
    -- upvalues: v48 (copy), t11 (copy), characterAdded (copy), characterRemoving (copy)
    local v49 = t11[p35]

    if not v49 then
        v49 = {}
        t11[p35] = v49
    end

    if p35.Character then
        v48:bindRoot(p35.Character)
    end

    table.insert(v49, p35.CharacterAdded:Connect(characterAdded))
    table.insert(v49, p35.CharacterRemoving:Connect(characterRemoving))
end

local function playerRemoving(p36) -- line: 437
    -- upvalues: v48 (copy), t11 (copy)
    local v50 = t11[p36]

    if v50 then
        for _, v51 in ipairs(v50) do
            v51:Disconnect()
        end

        t11[p36] = nil
    end

    if p36.Character then
        v48:unbindRoot(p36.Character)
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    task.spawn(playerAdded, player)
end

Players.PlayerAdded:Connect(playerAdded)
Players.PlayerRemoving:Connect(playerRemoving)
