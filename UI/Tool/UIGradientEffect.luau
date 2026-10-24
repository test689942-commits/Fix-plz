-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local RunService = game:GetService("RunService")
local _ = _G.New
local t2 = {}
local t3 = {}
local t1 = {}

t1.Wave = function(p1, p2) -- line: 8
    -- upvalues: t1 (copy), t2 (copy), t3 (copy)
    local v1

    if #p1.Color.Keypoints ~= 2 or p1.Color.Keypoints[1].Value ~= p1.Color.Keypoints[2].Value then
        v1 = t1.WaveColor(p1, p2)
    elseif t2[p1] then
        t2[p1]:Destroy(true)
        t2[p1] = nil
    end

    local v2

    if #p1.Transparency.Keypoints ~= 2 or p1.Transparency.Keypoints[1].Value ~= p1.Transparency.Keypoints[2].Value then
        v2 = t1.WaveTransparency(p1, p2)
    elseif t3[p1] then
        t3[p1]:Destroy(true)
        t3[p1] = nil
    end

    return {
        Destroy = function() -- Destroy | line: 29
            -- upvalues: v1 (ref), v2 (ref)
            if v1 then
                v1:Destroy()
            end

            if v2 then
                v2:Destroy()
            end
        end,
        SetColor = function(p3) -- SetColor | line: 37
            if p3 then
                p3:SetColor(p3)
            else
                error("没有颜色")
            end
        end
    }
end

t1.WaveColor = function(p4, p5) -- line: 47
    -- upvalues: RunService (copy), t2 (copy)
    local v3 = p5

    if t2[p4] then
        t2[p4]:Destroy(true)
    end

    local t4 = {}

    v3 = p5 or 0.3

    local Keypoints = p4.Color.Keypoints
    local Keypoints2 = Keypoints

    if Keypoints[1].Time ~= 0 then
        table.insert(Keypoints, 1, ColorSequenceKeypoint.new(0, Keypoints[1].Value))
    end

    if Keypoints[#Keypoints].Time ~= 1 then
        table.insert(Keypoints, ColorSequenceKeypoint.new(1, Keypoints[#Keypoints].Value))
    end

    if #Keypoints > 15 then
        return
    end

    local v4 = #Keypoints
    local v5 = v4
    local t5 = {}
    local t6 = {}

    t6[1] = t5

    for i = v4, 2, -1 do
        table.insert(t5, ColorSequenceKeypoint.new(-Keypoints[i].Time, Keypoints[i].Value))
    end

    for _, v7 in Keypoints do
        table.insert(t5, v7)
    end

    for i = v4 - 1, 1, -1 do
        table.insert(t5, ColorSequenceKeypoint.new(2 - Keypoints[i].Time, Keypoints[i].Value))
    end

    local n1 = 0
    local v9 = v4
    local v10 = v4 * 2 - 1
    local v11 = #t5
    local connection = RunService.RenderStepped:Connect(function(p6) -- line: 86
        -- upvalues: v3 (ref), p4 (copy), t4 (copy), v5 (ref), t6 (copy), n1 (ref), v9 (ref), v10 (ref), v11 (copy)
        if p4 == nil or p4.Parent == nil then
            t4:Destroy(true)
        else
            n1 += p6 * v3

            if v3 > 0 then
                if n1 > 1 then
                    n1 = (n1 + 1) % 2 - 1
                    v9 = 1
                    v10 = v5
                end

                while v9 ~= v11 and t6[1][v9].Time < n1 do
                    v9 += 1
                end

                while v10 ~= v11 and t6[1][v10 + 1].Time <= n1 + 1 do
                    v10 += 1
                end
            else
                if n1 < -1 then
                    n1 = (n1 - 1) % -2 + 1
                    v10 = v11
                    v9 = v10 - v5 + 1
                end

                while v9 ~= 1 and t6[1][v9 - 1].Time >= n1 do
                    v9 -= 1
                end

                while v10 ~= 1 and t6[1][v10].Time > n1 + 1 do
                    v10 -= 1
                end
            end

            local t7 = {}

            if v9 ~= 1 and t6[1][v9].Time ~= n1 then
                local v13 = t6[1][v9].Value:Lerp(t6[1][v9 - 1].Value, (t6[1][v9].Time - n1) / (t6[1][v9].Time - t6[1][v9 - 1].Time))

                table.insert(t7, ColorSequenceKeypoint.new(0, v13))
            end

            for i = v9, v10 do
                table.insert(t7, ColorSequenceKeypoint.new(t6[1][i].Time - n1, t6[1][i].Value))
            end

            if t7[#t7].Time ~= 1 then
                local v17 = t6[1][v10 + 1].Value:Lerp(t6[1][v10].Value, (t6[1][v10 + 1].Time - n1 - 1) / (t6[1][v10 + 1].Time - t6[1][v10].Time))

                table.insert(t7, ColorSequenceKeypoint.new(1, v17))
            end

            local function v18() -- line: 130
                -- upvalues: t7 (copy), p4 (copy)
                p4.Color = ColorSequence.new(t7)
            end

            if not pcall(v18) then
                print(v10)
                print(v9)
                print(t6[1])
                print(t7)
            end
        end
    end)

    t2[p4] = t4

    t4.Destroy = function(_, p8) -- line: 143
        -- upvalues: p4 (copy), Keypoints2 (ref), connection (copy), t2 (copy)
        connection:Disconnect()

        if not p8 then
            p4.Color = ColorSequence.new(Keypoints2)
        end

        t2[p4] = nil
    end

    t4.SetColor = function(_, p10) -- line: 151
        -- upvalues: Keypoints2 (ref), v5 (ref), t6 (copy), n1 (ref), v9 (ref), v10 (ref)
        Keypoints2 = p10.Keypoints

        if Keypoints2[1].Time ~= 0 then
            local Keypoints = Keypoints2

            table.insert(Keypoints, 1, ColorSequenceKeypoint.new(0, Keypoints2[1].Value))
        end

        if Keypoints2[#Keypoints2].Time ~= 1 then
            local Keypoints = Keypoints2
            local new = ColorSequenceKeypoint.new
            local Keypoints3 = Keypoints2

            table.insert(Keypoints, new(1, Keypoints3[#Keypoints2].Value))
        end

        v5 = #Keypoints2
        t6[1] = {}

        for i = v5, 2, -1 do
            table.insert(t6[1], ColorSequenceKeypoint.new(-Keypoints2[i].Time, Keypoints2[i].Value))
        end

        for _, v22 in Keypoints2 do
            table.insert(t6[1], v22)
        end

        for i = v5 - 1, 1, -1 do
            table.insert(t6[1], ColorSequenceKeypoint.new(2 - Keypoints2[i].Time, Keypoints2[i].Value))
        end

        n1 = 0
        v9 = v5
        v10 = v9 * 2 - 1
    end

    return t4
end

t1.WaveTransparency = function(p11, p12) -- line: 180
    -- upvalues: RunService (copy), t3 (copy)
    local v26 = p12
    local t8 = {}

    if t3[p11] then
        t3[p11]:Destroy(true)
    end

    v26 = p12 or 0.3

    local Offset = p11.Offset
    local n2 = 0
    local connection = RunService.RenderStepped:Connect(function(p13) -- line: 190
        -- upvalues: v26 (ref), p11 (copy), t8 (copy), Offset (copy), n2 (ref)
        if p11 == nil or p11.Parent == nil then
            t8:Destroy(true)

            return
        end

        n2 += p13 * v26

        if n2 > 1 then
            n2 = (n2 + 1) % 2 - 1
        elseif n2 < -1 then
            n2 = (n2 - 1) % -2 + 1
        end

        p11.Offset = Vector2.new(math.cos((math.rad(p11.Rotation))) * n2 + Offset.X, math.sin((math.rad(p11.Rotation))) * n2 + Offset.Y)
    end)

    t3[p11] = t8

    t8.Destroy = function(_, p15) -- line: 206
        -- upvalues: p11 (copy), Offset (copy), connection (copy), t3 (copy)
        connection:Disconnect()

        if not p15 then
            p11.Offset = Offset
        end

        t3[p11] = nil
    end

    return t8
end

return t1
