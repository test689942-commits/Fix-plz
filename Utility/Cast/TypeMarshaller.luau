-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _typeof = typeof

local function _typeof2(p1) -- line: 5
    -- upvalues: _typeof (copy)
    local v1 = _typeof(p1)

    if v1 ~= "table" then
        return v1
    end

    local mt = getmetatable(p1)

    if _typeof(mt) ~= "table" then
        return v1
    end

    local __type = mt.__type

    if __type == nil then
        return v1
    end

    return __type
end

return _typeof2
