-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local TweenService = game:GetService("TweenService")
local PoolMgr = _G.PoolMgr
local v1 = _G.New("Utility.Tool")()

return {
    Show = function(p1, p2) -- Show | line: 7
        -- upvalues: TweenService (copy), PoolMgr (copy), v1 (copy)
        p1.effect = PoolMgr:Get("Effect_EnemyHud", script.Hud)
        p1.effect.Parent = p2.Character
        p1:Weld(p2.Character.Head, p1.effect)
        p1.effect.Attachment.Mob.EnemyName.Text = p2.data.name

        local HpValue, Prog, OldProg = p1.effect.Attachment.Mob.Health.HpValue, p1.effect.Attachment.Mob.Health.Prog, p1.effect.Attachment.Mob.Health.OldProg

        HpValue.Text = v1:AN(p2.hp, 1) .. "/" .. v1:AN(p2.maxHp.current, 1)
        Prog.Size = UDim2.new(math.clamp(p2.hp / p2.maxHp, 0, 1), 0, 1, 0)
        OldProg.Size = UDim2.new(math.clamp(p2.hp / p2.maxHp, 0, 1), 0, 1, 0)
        p2.OnAttributeChange:Add(function(p3, _) -- line: 21
            -- upvalues: p2 (copy), HpValue (copy), Prog (copy), OldProg (copy), TweenService (copy), v1 (copy)
            if p3 ~= "hp" then
                return
            end

            HpValue.Text = v1:AN(p2.hp, 1) .. "/" .. v1:AN(p2.maxHp.current, 1)
            Prog.Size = UDim2.new(math.clamp(p2.hp / p2.maxHp, 0, 1), 0, 1, 0)
            TweenService:Create(OldProg, TweenInfo.new(3), {
                Size = UDim2.new(math.clamp(p2.hp / p2.maxHp, 0, 1), 0, 1, 0)
            }):Play()
        end)
    end,
    Hide = function(p5) -- Hide | line: 30
        -- upvalues: PoolMgr (copy)
        PoolMgr:Push("Effect_EnemyHud", p5.effect)
    end
}
