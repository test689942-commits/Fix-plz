-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _ = _G.DataMgr
local TweenService = game:GetService("TweenService")
local New = _G.New

return {
    new = function(p1, p2, p3) -- new | line: 6
        -- upvalues: TweenService (copy), New (copy)
        p1.onOpen = New("CS.Action")()
        p1.onClose = New("CS.Action")()
        p1.trove = New("Utility.Trove")()
        p1.isActive = true
        p1.pp = p2
        p1.m6 = p3
        p1.isOpen = false
        p1.isOn = false
        p1.openSound = nil
        p1.closeSound = nil

        local n1 = 90

        p2.RequiresLineOfSight = false
        task.spawn(function() -- line: 22
            -- upvalues: p1 (copy), p2 (copy), n1 (ref)
            p1.openSound = p2.Parent:WaitForChild("Open", 3)
            p1.closeSound = p2.Parent:WaitForChild("Close", 3)
            n1 = p2.Parent:WaitForChild("Angle", 3)
            n1 = n1 and n1.Value or 90
        end)
        p1.openT = TweenService:Create(p3, TweenInfo.new(1, Enum.EasingStyle.Quint), {
            C1 = CFrame.Angles(0, math.rad(n1), 0)
        })
        p1.openT.Completed:Connect(function() -- line: 30
            -- upvalues: p1 (copy)
            p1.isOn = false
        end)
        p1.closeT = TweenService:Create(p3, TweenInfo.new(1, Enum.EasingStyle.Quint), {
            C1 = CFrame.Angles(0, 0, 0)
        })
        p1.closeT.Completed:Connect(function() -- line: 34
            -- upvalues: p1 (copy)
            p1.isOn = false
        end)
        p1.trove:Add(p2.Triggered:Connect(function(p4) -- line: 38
            -- upvalues: p1 (copy)
            if p1.isActive then
                p1:Triger(p4)
            end
        end))
    end,
    SetActive = function(p5, p6) -- SetActive | line: 46
        p5.isActive = p6
    end,
    SetTrigerAction = function(p7, p8) -- SetTrigerAction | line: 50
        return p7.pp.Triggered:Connect(p8)
    end,
    Triger = function(p9, p10) -- Triger | line: 54
        if p9.isOpen then
            p9:Close(p10)
        else
            p9:Open(p10)
        end
    end,
    Close = function(p11, p12) -- Close | line: 62
        local v3 = true

        if p11.isOn then
        elseif p11.isOpen then
            p11.isOn = true

            if p11.closeSound then
                p11.closeSound:Play()
            end

            v3 = false
        end

        if v3 then
            return
        end

        p11.closeT:Play()
        p11.pp:SetAttribute("Opened", true)
        p11.onClose(p12)
        p11.isOpen = not p11.isOpen
    end,
    Open = function(p13, p14) -- Open | line: 76
        if p13.isOn or p13.isOpen then
            return
        end

        p13.isOn = true

        if p13.openSound then
            p13.openSound:Play()
        end

        p13.openT:Play()
        p13.pp:SetAttribute("Opened", true)
        p13.onOpen(p14)
        p13.isOpen = not p13.isOpen
    end,
    Destroy = function(p15) -- Destroy | line: 90
        p15.trove:Clean()
    end
}
