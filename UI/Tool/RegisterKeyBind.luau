-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _, _ = _G.GameMgr, script.Red
local _ = 40 / Vector2.new(1920, 1080)
local t1 = {}

return function(_, p2, _, _) -- line: 7
    -- upvalues: t1 (copy)
    if t1[p2] then
        t1[p2]:Destroy()
    end
end
