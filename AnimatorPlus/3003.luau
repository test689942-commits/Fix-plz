-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1
game:GetService("TweenService")
game:GetService("RunService")

local _ = game:GetService("Players").LocalPlayer
local GameMgr, _, _ = _G.GameMgr, _G.DataMgr, _G.EventMgr

_G.New("Utility.Tool")()

function t1.Load(_, _, _) -- line: 12
end

function t1.Play(_, p5) -- line: 16
    -- upvalues: GameMgr (copy)
    local Tool = p5:FindFirstChild("Tool")

    if Tool ~= nil then
        GameMgr:ShowEffect("WeaponEffect", Tool, "闪电打击", 0.5, true)
    end
end

function t1.Stop(_) -- line: 24
end

function t1.Destroy(_) -- line: 28
end

return t1
