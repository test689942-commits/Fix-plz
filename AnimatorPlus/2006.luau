-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1
game:GetService("TweenService")

local _ = game:GetService("Players").LocalPlayer
local GameMgr, _, _, _ = _G.GameMgr, _G.DataMgr, _G.EventMgr, _G.New

function t1.Load(_, p2, p3) -- line: 10
    -- upvalues: GameMgr (copy)
    p3:GetMarkerReachedSignal("Atk"):Connect(function(_) -- line: 11
        -- upvalues: p2 (copy), GameMgr (copy)
        GameMgr:ShowEffect("RocksEffect", (p2.PrimaryPart.CFrame * CFrame.new(0, -4, 0)).Position, Vector3.new(0, 1, 0), 3, Vector3.new(1, 1, 1), 6)
    end)
end

function t1.Play(_, _) -- line: 18
end

function t1.Stop(_) -- line: 22
end

function t1.Destroy(_) -- line: 26
end

return t1
