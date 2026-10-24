-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1
setmetatable(t1, {
    __call = function(_, ...) -- __call | line: 10
        -- upvalues: t1 (copy)
        return t1.new(...)
    end
})

function t1.new() -- line: 15
    -- upvalues: t1 (copy)
    return (setmetatable({}, t1))
end

function t1.CharacterAdded(_, _, _) -- line: 21
end

function t1.CharacterRemoving(_, _, _) -- line: 25
end

function t1.OnCameraSubjectChanged(_, _) -- line: 28
end

function t1.GetOcclusionMode(_) -- line: 32
    warn("BaseOcclusion GetOcclusionMode must be overridden by derived classes")

    return nil
end

function t1.Enable(_, _) -- line: 38
    warn("BaseOcclusion Enable must be overridden by derived classes")
end

function t1.Update(_, _, p15, p16) -- line: 42
    warn("BaseOcclusion Update must be overridden by derived classes")

    return p15, p16
end

return t1
