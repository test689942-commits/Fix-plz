-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Parent = require(script.Parent)
local InputMgr, _, New = _G.InputMgr, _G.DataMgr, _G.New
local _ = {
    Enum.KeyCode.G,
    Enum.KeyCode.F,
    Enum.KeyCode.Q
}
local t1 = {
    Init = function(p1) -- Init | line: 10
        p1.skillList = {}
        p1.trove:Add(function() -- line: 12
            -- upvalues: p1 (copy)
            for v1, v2 in pairs(p1.skillList) do
                p1:RemovedSkill(v1, v2)
            end
        end)
        p1:AddSkill("Dash", Enum.KeyCode.LeftShift, p1)
        p1:AddSkill("LockMouse", Enum.KeyCode.LeftControl, p1)
    end
}

function Parent.AddSkill(p2, p3, p4, ...) -- line: 23
    -- upvalues: InputMgr (copy), New (copy)
    p2:RemovedSkill(p3)

    local v3 = New("BaseSkill")(p3, p2, ...)
    local v4 = InputMgr:AddInputEnterEvent(p4, function(p5) -- line: 26
        -- upvalues: p2 (copy), v3 (copy)
        if not p5 and p2:IfCanMove() then
            task.spawn(v3.Enter, v3)
        end
    end)
    local v5 = InputMgr:AddInputExitEvent(p4, function(_) -- line: 31
        -- upvalues: v3 (copy)
        task.spawn(v3.Exit, v3)
    end)

    v3:Equip()

    local t2 = {
        key = p4,
        skill = v3
    }

    t2.Destroy = function() -- line: 40
        -- upvalues: p2 (copy), p3 (copy), v3 (copy), v4 (copy), v5 (copy), t2 (copy)
        v3:Unequip()
        v4:Disconnect()
        v5:Disconnect()
        p2.skillList[p3] = nil
        p2:TrigerEvent("RemoveSkill", t2)
    end

    p2.skillList[p3] = t2
    p2:TrigerEvent("AddSkill", t2)

    return t2
end

function Parent.RemovedSkill(p7, p8, p9) -- line: 54
    local v6 = p9 == nil
    local v7, v8

    if v6 then
        v7 = p7.skillList[p8]
        v8 = v7 == nil
    end

    if not v6 or not v8 then
        if not v6 then
            v7 = p9
        end

        v7:Destroy()
    end
end

function Parent.TrigerSkill(p10, p11, p12, ...) -- line: 64
    if p10.skillList[p11] then
        local skill = p10.skillList[p11].skill

        skill[p12](skill, ...)
    end
end

function Parent.GetSkill(p13, p14) -- line: 71
    if p14 then
        return p13.skillList[p14]
    end

    return p13.skillList
end

return t1
