-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local EasingFunctions = require(script.EasingFunctions)
local New = _G.New
local v1 = New("Utility.Tool")()
local t2 = {}

local function GetInstance(p1) -- line: 10
    -- upvalues: v1 (copy)
    local v2 = {
        game,
        {}
    }
    local n1 = 1

    while n1 < #p1 do
        n1 += 1

        if not v2[2][p1[n1]] then
            v2[2][p1[n1]] = {
                v2[1]:FindFirstChild(p1[n1]),
                {}
            }
        end

        v2 = v2[2][p1[n1]]
    end

    if v2[1] and v2[1]:IsA("BoolValue") then
        v1:SetVFXGroup(v2[1])
    end

    return v2[1]
end

local function FrameHandle(p2, p3) -- line: 28
    -- upvalues: EasingFunctions (copy)
    local t3 = {}

    for _, child in p3:GetChildren() do
        if child:IsA("Folder") then
            local t4 = {}

            t4.time = tonumber(child.Name)

            if t4.time > p2.allFrame then
                p2.allFrame = t4.time
            end

            if child:FindFirstChild("Eases") then
                local v3 = child:FindFirstChild("Eases"):FindFirstChild("0")
                local Value = v3:FindFirstChild("Type").Value
                local t5 = {}

                if v3:FindFirstChild("Params") then
                    t5 = {}

                    for _, child in v3:FindFirstChild("Params"):GetChildren() do
                        t5[child.Name] = child.Value
                    end
                end

                if t5.Direction then
                    t4.func = EasingFunctions[Value .. t5.Direction]

                    if Value == "Back" then
                        if t5.Overshoot == nil then
                            t5.Overshoot = 1.70158
                        end

                        local func = t4.func

                        t4.func = function(p4) -- line: 54
                            -- upvalues: t5 (ref), func (copy)
                            return func(p4, t5.Overshoot)
                        end
                    elseif Value == "Elastic" then
                        if t5.Amplitude == nil then
                            t5.Amplitude = 1
                        end

                        if t5.Period == nil then
                            t5.Period = 0.3
                        end

                        local _func = t4._func

                        t4._func = function(p5) -- line: 62
                            -- upvalues: t5 (ref), _func (copy)
                            return _func(p5, t5.Amplitude, t5.Period)
                        end
                    end
                else
                    t4.func = EasingFunctions[Value]
                end
            else
                t4.func = EasingFunctions.Linear
            end

            t4.value = child:FindFirstChild("Values"):FindFirstChild("0").Value
            table.insert(t3, t4)
        end
    end

    return t3
end

t2.Normal = function(p6, p7, p8) -- line: 78
    -- upvalues: FrameHandle (copy)
    table.insert(p6.Instances, p7)

    local t6 = {
        instance = p7,
        typeKeys = {}
    }

    for _, child in p8:GetChildren() do
        local t7 = {
            typeName = child.Name,
            default = child.default.Value,
            type = typeof(t6.instance[child.Name]),
            index = 1,
            frame = FrameHandle(p6, child)
        }

        table.sort(t7.frame, function(p9, p10) -- line: 90
            return p9.time < p10.time
        end)
        table.insert(t6.typeKeys, t7)
    end

    table.insert(p6.keyFrame, t6)
end

t2.Motor6D = function(p11, p12, p13) -- line: 96
    -- upvalues: FrameHandle (copy)
    local t8 = {
        instance = p12
    }
    local t9 = {
        typeName = "C1",
        default = p13.default.Value,
        type = typeof(t8.instance.C1),
        index = 1,
        frame = FrameHandle(p11, p13._keyframes)
    }

    table.sort(t9.frame, function(p14, p15) -- line: 106
        return p14.time < p15.time
    end)
    t8.typeKeys = { t9 }
    table.insert(p11.keyFrame, t8)
end

t2.Rig = function(p16, p17, p18) -- line: 112
    -- upvalues: t2 (copy)
    local t10 = {}

    for _, descendant in p17:GetDescendants() do
        if descendant:IsA("Motor6D") and descendant.Part0 then
            if t10[descendant.Part0] then
                table.insert(t10[descendant.Part0], descendant)
            else
                t10[descendant.Part0] = { descendant }
            end
        end
    end

    local t11 = {}
    local t12 = {}
    local t13 = {
        p17.PrimaryPart
    }
    local n2 = 1

    while n2 > 0 do
        local v6 = t13[n2]

        n2 -= 1

        if t10[v6] ~= nil then
            for _, v8 in t10[v6] do
                local v9 = if t11[v8.Part0] then t11[v8.Part0] .. "." .. v8.Part1.Name else v8.Part1.Name

                t12[v9] = v8

                if t11[v8.Part1] == nil then
                    t11[v8.Part1] = v9
                    n2 += 1
                    t13[n2] = v8.Part1
                end
            end
        end
    end

    for _, child in p18.Rig:GetChildren() do
        local v10 = t12[child._hier.Value]

        if v10 ~= nil then
            t2.Motor6D(p16, v10, child)
        else
            print(child._hier.Value)
        end
    end
end

function t1.new(p19, p20) -- line: 160
    -- upvalues: HttpService (copy), New (copy), t2 (copy), GetInstance (copy)
    local v11 = HttpService:JSONDecode(p20.Value)

    p19.data = v11.Information
    p19.Instances = {}
    p19.allFrame = 0
    p19.keyFrame = {}

    for v12, v13 in v11.Items do
        local Path = v13.Path

        if Path.ItemType == "Camera" then
            t2.Normal(p19, workspace.CurrentCamera, p20:FindFirstChild(v12))
        elseif Path.ItemType == "Rig" then
            t2.Rig(p19, GetInstance(Path.InstanceNames), p20:FindFirstChild(v12))
        else
            t2.Normal(p19, GetInstance(Path.InstanceNames), p20:FindFirstChild(v12))
        end
    end

    p19.isPlay = false
    p19.frames = 60
    p19.allTime = p19.allFrame / p19.frames
    p19.time = 0
    p19.loop = p19.data.Looped
    p19.complete = New("CS.Action")()
end

function t1.Play(p21) -- line: 186
    -- upvalues: RunService (copy)
    if p21.isPlay then
        p21:Stop()
    end

    p21.isPlay = true

    for _, v14 in p21.keyFrame do
        for _, v15 in v14.typeKeys do
            v14.instance[v15.typeName] = v15.default
            v15.index = 1
        end
    end

    p21.time = 0
    p21.con = RunService.Stepped:Connect(function(_, p23) -- line: 198
        -- upvalues: p21 (copy)
        p21.time += p23

        if p21.time > p21.allTime then
            p21.time -= p21.allTime

            if not p21.loop then
                p21:Stop()
                p21.complete()

                return
            end

            for _, v16 in p21.keyFrame do
                for _, v17 in v16.typeKeys do
                    v16.instance[v17.typeName] = v17.default
                    v17.index = 1
                end
            end
        end

        local v18 = p21.time * p21.frames

        for _, v19 in p21.keyFrame do
            for _, v20 in v19.typeKeys do
                if #v20.frame ~= 0 then
                    while v20.index ~= 1 and v20.frame[v20.index - 1].time <= v18 do
                        v20.index -= 1
                    end

                    while v20.index ~= #v20.frame and v20.frame[v20.index].time < v18 do
                        v20.index += 1
                    end

                    if v20.index == 1 then
                        if v20.type == "boolean" then
                            if v20.frame[v20.index].time <= v18 then
                                v19.instance[v20.typeName] = v20.frame[v20.index].value
                            else
                                v19.instance[v20.typeName] = v20.default
                            end
                        else
                            v19.instance[v20.typeName] = v20.frame[1].value
                        end
                    elseif v20.type == "boolean" then
                        if v20.frame[v20.index].time <= v18 then
                            v19.instance[v20.typeName] = v20.frame[v20.index].value
                        else
                            v19.instance[v20.typeName] = v20.frame[v20.index - 1].value
                        end
                    elseif v20.type == "number" then
                        local v21 = v20.frame[v20.index - 1]
                        local v22 = v20.frame[v20.index]
                        local v23 = v21.func((v18 - v21.time) / (v22.time - v21.time))

                        if v23 < 1 then
                            v19.instance[v20.typeName] = v21.value + (v22.value - v21.value) * v23
                        else
                            v19.instance[v20.typeName] = v22.value
                        end
                    elseif v20.frame[v20.index].value.Lerp then
                        local v24 = v20.frame[v20.index - 1]
                        local v25 = v20.frame[v20.index]
                        local v26 = v24.func((v18 - v24.time) / (v25.time - v24.time))

                        if v26 < 1 then
                            v19.instance[v20.typeName] = v24.value:Lerp(v25.value, v26)
                        else
                            v19.instance[v20.typeName] = v25.value
                        end
                    else
                        local v27 = v20.frame[v20.index - 1]
                        local v28 = v20.frame[v20.index]
                        local v29 = v27.func((v18 - v27.time) / (v28.time - v27.time))

                        if v29 < 1 then
                            v19.instance[v20.typeName] = v27.value + (v28.value - v27.value) * v29
                        else
                            v19.instance[v20.typeName] = v28.value
                        end
                    end
                end
            end
        end
    end)
end

function t1.Stop(p24) -- line: 268
    if p24.isPlay then
        if p24.con then
            p24.con:Disconnect()
            p24.con = nil
        end

        p24.isPlay = false
    end
end

function t1.Destroy(p25) -- line: 285
    p25:Stop()
end

return t1
