-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local _, _, _ = _G.GameMgr, _G.DataMgr, _G.EventMgr
local v1 = _G.New("Utility.Tool")()

return {
    Load = function(p1, _) -- Load | line: 8
        -- upvalues: v1 (copy)
        local t2 = {}

        for v2, v3 in p1.config.progress do
            t2[v2] = tonumber(v3[1])
        end

        for v5, v6 in (v1:FinidEntitySpawnPos(t2)) do
            t2[v5] = nil
            p1:ChangeTrack(v5, v6.obj, v5)
        end

        if #t2 == 0 then
            return
        end

        p1.trove:Add(task.spawn(function() -- line: 37
            -- upvalues: p1 (copy), t2 (copy), v1 (copy)
            while #t2 ~= 0 do
                task.wait(10)

                for v7, v8 in (v1:FinidEntitySpawnPos(t2)) do
                    t2[v7] = nil
                    p1:ChangeTrack(v7, v8.obj, v7)
                end
            end
        end))
    end
}
