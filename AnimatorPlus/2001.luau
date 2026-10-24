-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

local _ = game:GetService("Players").LocalPlayer
local GameMgr, _, _ = _G.GameMgr, _G.DataMgr, _G.EventMgr

function t1.Load(_, p2, p3) -- line: 8
    -- upvalues: GameMgr (copy)
    p3:GetMarkerReachedSignal("Atk"):Connect(function(_) -- line: 9
        -- upvalues: p2 (copy), GameMgr (copy)
        GameMgr:ShowEffect("RocksEffect", (p2.PrimaryPart.CFrame * CFrame.new(0, -4, -8)).Position, Vector3.new(0, 1, 0), 5, Vector3.new(1.5, 1.5, 1.5), 6)
    end)
end

function t1.Play(_) -- line: 16
end

function t1.Stop(_) -- line: 20
end

function t1.Destroy(_) -- line: 24
end

return t1
