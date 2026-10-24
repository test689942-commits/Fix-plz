-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local TweenService = game:GetService("TweenService")
local GameMgr, _, PoolMgr = _G.GameMgr, _G.EventMgr, _G.PoolMgr

return {
    Show = function(p1, p2) -- Show | line: 7
        -- upvalues: TweenService (copy), GameMgr (copy), PoolMgr (copy)
        p1.effect = PoolMgr:Get("Effect_裂地击_Atk", script.Effect)
        p1.effect:PivotTo(p2 * CFrame.new(0, -20, 0))
        p1.effect.Parent = workspace.FX
        TweenService:Create(p1.effect.PrimaryPart, TweenInfo.new(0.25), {
            CFrame = p2
        }):Play()
        p1:SetEnabled(p1.effect, true)
        GameMgr:ShowEffect("RocksEffect", p2.Position, Vector3.new(0, 1, 0), 5, Vector3.new(1.5, 1.5, 1.5), 6)
        task.delay(1.1, function() -- line: 15
            -- upvalues: p1 (copy)
            p1:SetEnabled(p1.effect, false)
        end)
        task.delay(2, function() -- line: 18
            -- upvalues: p1 (copy), PoolMgr (copy)
            PoolMgr:Push("Effect_裂地击_Atk", p1.effect)
        end)
    end,
    Hide = function(_) -- Hide | line: 23
    end
}
