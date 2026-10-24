-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local DataMgr = _G.DataMgr
local t1 = {}

t1.Animation = function() -- line: 4
    -- upvalues: DataMgr (copy)
    local AnimationData = DataMgr:GetConfig("AnimationData")
    local AnimationController = Instance.new("AnimationController", workspace)
    local Animator = Instance.new("Animator", AnimationController)
    local t2 = {}

    for _, v1 in AnimationData do
        if v1.asset ~= nil and v1.asset ~= "" then
            local Animation = Instance.new("Animation")

            Animation.AnimationId = v1.asset

            local track = Animator:LoadAnimation(Animation)

            track:Play()
            table.insert(t2, track)
        end
    end

    local t3 = {
        count = 0,
        list = t2
    }

    task.spawn(function() -- line: 23
        -- upvalues: AnimationController (copy), t2 (copy), t3 (copy)
        while true do
            for v2, v3 in t2 do
                if v3 ~= -1 and v3.Length ~= 0 then
                    v3:Stop()
                    v3:Destroy()
                    t2[v2] = -1
                    t3.count += 1
                end
            end

            if t3.count == #t2 then
                break
            end

            task.wait()
        end

        AnimationController:Destroy()
        print("finish load animation")
    end)

    t3.Wait = function() -- line: 41
        -- upvalues: t2 (copy), t3 (copy)
        while t3.count ~= #t2 do
            task.wait()
        end
    end

    return t3
end

t1.Sound = function() -- line: 49
    -- upvalues: DataMgr (copy)
    local SoundData = DataMgr:GetConfig("SoundData")
    local t4 = {}

    for _, v4 in SoundData do
        local Sound = Instance.new("Sound")

        Sound.Parent = workspace
        Sound.SoundId = v4.asset
        Sound.Volume = 0
        table.insert(t4, Sound)
    end

    local t5 = {
        count = 0,
        list = t4
    }

    task.spawn(function() -- line: 63
        -- upvalues: t4 (copy), t5 (copy)
        while true do
            for v5, v6 in t4 do
                if v6 ~= -1 and v6.IsLoaded then
                    v6:Destroy()
                    t4[v5] = -1
                    t5.count += 1
                end
            end

            if t5.count == #t4 then
                break
            end

            task.wait()
        end

        print("finish load sound")
    end)

    t5.Wait = function() -- line: 79
        -- upvalues: t4 (copy), t5 (copy)
        while t5.count ~= #t4 do
            task.wait()
        end
    end

    return t5
end

t1.Image = function() -- line: 87
    -- upvalues: DataMgr (copy)
    local ImageData = DataMgr:GetConfig("ImageData")
    local ScreenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer.PlayerGui)

    ScreenGui.Name = "AssetLoad"

    local t6 = {}

    for _, v7 in ImageData do
        local ImageLabel = Instance.new("ImageLabel", ScreenGui)

        ImageLabel.Size = UDim2.new(0.01, 0, 0.01, 0)
        ImageLabel.Image = v7.asset
        table.insert(t6, ImageLabel)
    end

    local t7 = {
        count = 0,
        list = t6
    }

    task.spawn(function() -- line: 102
        -- upvalues: ScreenGui (copy), t6 (copy), t7 (copy)
        while true do
            for v8, v9 in t6 do
                if v9 ~= -1 and v9.IsLoaded then
                    v9:Destroy()
                    t6[v8] = -1
                    t7.count += 1
                end
            end

            if t7.count == #t6 then
                break
            end

            task.wait()
        end

        ScreenGui:Destroy()
        print("finish load image")
    end)

    t7.Wait = function() -- line: 119
        -- upvalues: t6 (copy), t7 (copy)
        while t7.count ~= #t6 do
            task.wait()
        end
    end

    return t7
end

return function(p1) -- line: 127
    -- upvalues: t1 (copy)
    if t1[p1] then
        return t1[p1]()
    end
end
