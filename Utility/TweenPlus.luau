-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local TweenService = game:GetService("TweenService")
local New = _G.New
local t2 = {
    tweenTime = {
        index = 1,
        value = function(p1) -- value | line: 8
            return p1
        end
    },
    tweenStyle = {
        index = 2,
        value = function(p2) -- value | line: 11
            return Enum.EasingStyle:FromValue(p2)
        end
    },
    tweenDirection = {
        index = 3,
        value = function(p3) -- value | line: 14
            return Enum.EasingDirection:FromValue(p3)
        end
    },
    tweenRepeat = {
        index = 4,
        value = function(p4) -- value | line: 17
            return p4
        end
    },
    tweenResverse = {
        index = 5,
        value = function(p5) -- value | line: 20
            return p5
        end
    },
    tweenDelay = {
        index = 6,
        value = function(p6) -- value | line: 23
            return p6
        end
    }
}
local t3 = {}

local function ChackState(p7, p8) -- line: 27
    -- upvalues: t3 (copy)
    if t3[p7.ClassName] == nil then
        t3[p7.ClassName] = {}
    end

    if t3[p7.ClassName][p8] == nil then
        local v1 = t3[p7.ClassName]

        local function v2() -- line: 32
            -- upvalues: p7 (copy), p8 (copy)
            return p7[p8]
        end

        v1[p8] = pcall(v2)
    end

    return t3[p7.ClassName][p8]
end

function t1.new(p9, p10) -- line: 40
    -- upvalues: TweenService (copy), New (copy), t2 (copy), ChackState (copy)
    local t4 = {}
    local Descendants = p10:GetDescendants()

    table.insert(Descendants, p10)

    local n1 = 0

    for _, v3 in Descendants do
        local tweenTime = v3:GetAttribute("tweenTime")

        if tweenTime then
            local t5 = {
                tweenTime,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.In,
                0,
                false
            }
            local t6 = {}
            local t7 = {}

            for v4, v5 in v3:GetAttributes() do
                local v6 = t2[v4]

                if v6 then
                    t5[v6.index] = v6.value(v5)
                elseif ChackState(v3, v4) then
                    t6[v4] = v5
                    t7[v4] = v3[v4]
                end
            end

            n1 = math.max(n1, if t5[4] == -1 then -1 else (t5[4] + 1) * (tweenTime * (if t5[5] then 2 else 1) + (t5[6] or 0)))
            table.insert(t4, {
                tween = TweenService:Create(v3, TweenInfo.new(unpack(t5)), t6),
                backStates = t7,
                obj = v3
            })
        end
    end

    for _, v8 in t4 do
        v8.tween:Play()
    end

    if n1 == 0 then
        return
    end

    local v9 = New("Utility.Trove")()

    v9:Add(function() -- line: 75
        -- upvalues: t4 (copy)
        for _, v10 in t4 do
            if v10.obj.Parent then
                for v11, v12 in v10.backStates do
                    v10.obj[v11] = v12
                end

                v10.tween:Cancel()
            end
        end
    end)

    if n1 == -1 then
        v9:Add(p10.Destroying:Connect(function() -- line: 86
            -- upvalues: v9 (copy)
            v9:Clean()
        end))
    end

    p9.trove = v9
end

function t1.Destroy(p11, _) -- line: 94
    p11.trove:Clean()
end

return t1
