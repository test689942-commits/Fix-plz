-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

game:GetService("TweenService")

local _, DataMgr, InputMgr, _ = _G.GameMgr, _G.DataMgr, _G.InputMgr, _G.EventMgr

local function StateChange(p1, p2) -- line: 8
    -- upvalues: InputMgr (copy)
    if p2 then
        if p1.player.unLockMouse then
            p1.player.unLockMouse:Destroy()
            p1.player.unLockMouse = nil
        end

        if p1.player.lockMouse == nil then
            p1.player.lockMouse = InputMgr:LockMouse(true)
        end
    else
        if p1.player.LockMouse then
            p1.player.lockMouse:Destroy()
            p1.player.lockMouse = nil
        end

        if p1.player.unLockMouse == nil then
            p1.player.unLockMouse = InputMgr:LockMouse(false)
        end
    end
end

function t1.OnInit(p3, ...) -- line: 29
    -- upvalues: DataMgr (copy), StateChange (copy)
    StateChange(p3, DataMgr:GetSetting("MouseLock"))
    p3.trove:Add(DataMgr:AddSettingChangeEvent("MouseLock", function(p4) -- line: 31
        -- upvalues: p3 (copy), StateChange (copy)
        StateChange(p3, p4)
    end))
end

function t1.OnEnter(_) -- line: 36
    -- upvalues: DataMgr (copy), InputMgr (copy)
    if InputMgr:MouseIsLock() then
        DataMgr:ChangeSetting("MouseLock", false)
    else
        DataMgr:ChangeSetting("MouseLock", true)
    end
end

function t1.OnExit(_) -- line: 44
end

function t1.OnHit(_, _, ...) -- line: 48
end

function t1.OnEquip(_) -- line: 52
end

function t1.OnUnequip(p10) -- line: 56
    if p10.player.unLockMouse then
        p10.player.unLockMouse:Destroy()
        p10.player.unLockMouse = nil
    end

    if p10.player.LockMouse then
        p10.player.lockMouse:Destroy()
        p10.player.lockMouse = nil
    end
end

return t1
