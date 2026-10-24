-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local New = _G.New

return {
    new = function(p1, p2) -- new | line: 4
        -- upvalues: New (copy)
        p1.tweenList = {}
        p1.index = 1
        p1.playTrove = New("Utility.Trove")()
        p1.PlaybackState = Enum.PlaybackState.Begin
        p1.isLoop = p2
        p1.onCompleted = New("CS.Action")()
        p1.partEvent = {}
    end,
    Add = function(p3, p4, p5) -- Add | line: 14
        table.insert(p3.tweenList, {
            p4,
            p5
        })
    end,
    Remove = function(p6, p7) -- Remove | line: 18
        table.remove(p6.tweenList, table.find(p6.tweenList, function(p8) -- line: 19
            -- upvalues: p7 (copy)
            return p8[1] == p7
        end))
    end,
    Next = function(p9) -- Next | line: 22
        p9.PlaybackState = Enum.PlaybackState.Completed

        if p9.partEvent[p9.index] then
            p9.partEvent[p9.index]()
        end

        p9.index += 1

        if not (p9.index > #p9.tweenList) then
            p9:Play()

            return
        end

        for _, v1 in p9.tweenList do
            if v1[1].PlaybackState == Enum.PlaybackState.Playing then
                v1[1]:Cancel()
            end
        end

        p9.index = 1

        if p9.isLoop then
            p9:Play()
        else
            p9.onCompleted()
        end
    end,
    Play = function(p10) -- Play | line: 45
        if p10.PlaybackState == Enum.PlaybackState.Playing then
            return
        end

        p10.playTrove:Clean()
        p10.PlaybackState = Enum.PlaybackState.Playing

        local v2 = p10.tweenList[p10.index]

        if p10.PlaybackState == Enum.PlaybackState.Paused then
            for i = 1, p10.index do
                if p10.tweenList[i][1].PlaybackState == Enum.PlaybackState.Paused then
                    p10.tweenList[i][1]:Play()
                end
            end
        else
            v2[1]:Play()
        end

        if v2[2] then
            if v2[2] == 0 then
                p10:Next()
            else
                p10.tick = p10.time and tick() + p10.time or tick() + v2[2]
                p10.playTrove:Add(task.delay(v2[2], p10.Next, p10))
            end
        else
            p10.playTrove:Add(v2[1].Completed:Connect(function() -- line: 69
                -- upvalues: p10 (copy)
                p10:Next()
            end))
        end

        p10.time = 0
    end,
    Pause = function(p11) -- Pause | line: 76
        if p11.PlaybackState ~= Enum.PlaybackState.Playing then
            return
        end

        p11.PlaybackState = Enum.PlaybackState.Paused

        if tick() < p11.tick then
            p11.time = p11.tick - tick()
        end

        for _, v4 in p11.tweenList do
            if v4[1].PlaybackState == Enum.PlaybackState.Playing then
                v4[1]:Pause()
            end
        end

        p11.playTrove:Clean()
    end,
    Stop = function(p12) -- Stop | line: 92
        if p12.PlaybackState ~= Enum.PlaybackState.Playing then
            return
        end

        p12.PlaybackState = Enum.PlaybackState.Cancelled
        p12.playTrove:Clean()

        for _, v5 in p12.tweenList do
            if v5[1].PlaybackState == Enum.PlaybackState.Playing then
                v5[1]:Cancel()
            end
        end

        p12.index = 1
    end,
    Updata = function(p13, p14, p15) -- Updata | line: 106
        if p13.tweenList[p14] ~= nil then
            p13.tweenList[p14][1] = p15
        end
    end,
    Destroy = function(p16) -- Destroy | line: 113
        p16:Stop()

        for _, v6 in p16.tweenList do
            v6[1]:Destroy()
        end
    end,
    AddPartEvent = function(p17, p18, p19) -- AddPartEvent | line: 120
        -- upvalues: New (copy)
        p19 = p19 or #p17.tweenList

        local v8 = p17.partEvent[p19]

        if v8 == nil then
            v8 = New("CS.Action")()
            p17.partEvent[p19] = v8
        end

        return v8:Add(p18)
    end,
    RemovePartEvent = function(p20, p21, p22) -- RemovePartEvent | line: 130
        local v9 = p20.partEvent[p22]

        if v9 ~= nil then
            v9:Remove(p21)
        end
    end
}
