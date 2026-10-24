-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local GameMgr, New, Red = _G.GameMgr, _G.New, script.Red
local v1 = 40 / Vector2.new(1920, 1080)
local t1 = {}

return function(_, p2, p3, p4, p5) -- line: 8
    -- upvalues: GameMgr (copy), New (copy), Red (copy), v1 (copy), t1 (copy)
    if t1[p2] then
        t1[p2]:Destroy()
    end

    local t2 = {
        trove = New("Utility.Trove")(),
        Destroy = function(p6) -- Destroy | line: 15
            -- upvalues: p2 (copy), t1 (copy)
            if p6.isDestroy then
                return
            end

            p6.isDestroy = true
            p6.trove:Clean()
            t1[p2] = nil
            p6.node.trove:Remove(p6)
        end
    }
    local v2 = GameMgr:AutoGetRedDot(p3, p4)

    t2.node = v2
    t1[p2] = t2
    v2.trove:Add(t2)
    v2.showCount = p5

    local clone = Red:Clone()

    clone.Parent = p2

    local v3 = v1 * workspace.CurrentCamera.ViewportSize / p2.AbsoluteSize

    clone.Size = UDim2.new(v3.X, 0, v3.Y, 0)
    t2.trove:Add(clone)

    if clone:FindFirstChild("Eff") then
        local Eff = clone.Eff

        Eff.Size = UDim2.new(1, 0, 1, 0)
        Eff.ImageTransparency = 0.5

        local v4 = TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true)
        local t3 = {
            ImageTransparency = 1,
            Size = UDim2.new(1.5, 0, 1.5, 0)
        }
        local v5 = game:GetService("TweenService"):Create(Eff, v4, t3)

        v5:Play()
        t2.trove:Add(function() -- line: 63
            -- upvalues: v5 (copy)
            v5:Cancel()
        end)
    end

    if v2.nodeCount > 0 then
        clone.Visible = true

        if v2.showCount then
            clone.TextLabel.Text = v2.nodeCount
        end
    else
        clone.Visible = false
    end

    v2.changeFunc:Add(function() -- line: 77
        -- upvalues: v2 (copy), clone (copy)
        local v6 = v2.nodeCount > 0
        local showCount

        if v6 then
            clone.Visible = true
            showCount = v2.showCount
        else
            clone.Visible = false
        end

        if (not v6 or showCount) and v6 then
            clone.TextLabel.Text = v2.nodeCount
        end
    end)

    return t2
end
