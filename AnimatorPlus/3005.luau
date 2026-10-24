-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1
game:GetService("TweenService")
game:GetService("RunService")

local _ = game:GetService("Players").LocalPlayer
local GameMgr, _, _ = _G.GameMgr, _G.DataMgr, _G.EventMgr

_G.New("Utility.Tool")()

function t1.Load(_, p2, p3) -- line: 12
    -- upvalues: GameMgr (copy)
    p3:GetMarkerReachedSignal("EffectEmit"):Connect(function(_) -- line: 13
        -- upvalues: p2 (copy), GameMgr (copy)
        local Tool = p2:FindFirstChild("Tool")

        if Tool ~= nil then
            GameMgr:ShowEffect("WeaponEffect", Tool, "灼热火线")
        end
    end)
end

function t1.Play(_, _) -- line: 22
end

function t1.Stop(_) -- line: 26
end

function t1.Destroy(_) -- line: 30
end

return t1
