-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

local _ = game:GetService("Players").LocalPlayer
local GameMgr, _, _ = _G.GameMgr, _G.DataMgr, _G.EventMgr

function t1.Load(p1, _, p3) -- line: 8
    p3:GetMarkerReachedSignal("Atk"):Connect(function(_) -- line: 9
        -- upvalues: p1 (copy)
        if p1.effect then
            p1.effect:Destroy()
            p1.effect = nil
        end
    end)
end

function t1.Play(p5, p6) -- line: 17
    -- upvalues: GameMgr (copy)
    local Tool = p6:FindFirstChild("Tool")

    if Tool ~= nil then
        local Motor6D = Tool:FindFirstChildWhichIsA("Motor6D")

        if Motor6D ~= nil and Motor6D.Part1 ~= nil then
            p5.effect = GameMgr:ShowEffect("爆气斩_Sword", Motor6D.Part1, -1)
        end
    end
end

function t1.Stop(p7) -- line: 29
    if p7.effect then
        p7.effect:Destroy()
        p7.effect = nil
    end
end

function t1.Destroy(_) -- line: 36
end

return t1
