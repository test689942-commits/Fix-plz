-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local DataMgr, GameMgr = _G.DataMgr, _G.GameMgr
local t2 = {}
local v1 = false

task.spawn(function() -- line: 6
    -- upvalues: DataMgr (copy), t2 (copy), v1 (ref)
    for _, child in script:GetChildren() do
        t2[DataMgr:GetConfig("AnimationData", (tonumber(child.Name))).asset] = require(child)
    end

    v1 = DataMgr:GetSetting("LowQuality")
    DataMgr:AddSettingChangeEvent("LowQuality", function(p1) -- line: 12
        -- upvalues: v1 (ref)
        v1 = p1
    end)
end)

function t1.new(_, p3, p4) -- line: 17
    -- upvalues: GameMgr (copy), t2 (copy), v1 (ref)
    local t3 = {}

    p4.AnimationPlayed:Connect(function(p5) -- line: 19
        -- upvalues: p3 (copy), t3 (copy), GameMgr (copy), t2 (copy), v1 (ref)
        if t3[p5] then
            if t3[p5][2] then
                t3[p5][2]:Play(p3)
            end
        else
            t3[p5] = { true }
            p5:GetMarkerReachedSignal("Sound"):Connect(function(p6) -- line: 27
                -- upvalues: p3 (copy), GameMgr (copy)
                if p6 ~= nil then
                    local v2 = tonumber(p6)

                    if v2 ~= nil then
                        GameMgr:PlayWorldSound(p3.PrimaryPart, v2)
                    end
                end
            end)
            p5:GetMarkerReachedSignal("Effect"):Connect(function(p7) -- line: 37
                -- upvalues: p3 (copy), GameMgr (copy), v1 (ref)
                if not v1 then
                    GameMgr:ShowEffect(p7, p3.PrimaryPart.CFrame)
                end
            end)

            local v3

            if t2[p5.Animation.AnimationId] then
                local self = setmetatable({}, t2[p5.Animation.AnimationId])

                v3 = self

                local Load = self.Load

                if not pcall(Load, self, p3, p5) then
                    return
                end

                p5.Stopped:Connect(function() -- line: 50
                    -- upvalues: v3 (ref)
                    v3:Stop()
                end)
                p5.Ended:Connect(function() -- line: 53
                    -- upvalues: v3 (ref)
                    v3:Stop()
                end)
                v3:Play(p3)
            end

            t3[p5][2] = v3
            p5.Destroying:Connect(function() -- line: 59
                -- upvalues: p5 (copy), v3 (ref), t3 (copy)
                if v3 then
                    v3:Destroy()
                end

                t3[p5] = nil
            end)
        end
    end)
end

return t1
