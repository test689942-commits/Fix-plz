-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local GameMgr, DataMgr, _ = _G.GameMgr, _G.DataMgr, _G.EventMgr

_G.New("Utility.Tool")()

function t1.Load(p1, _) -- line: 8
    -- upvalues: GameMgr (copy), DataMgr (copy)
    if game.PlaceId ~= DataMgr.GamePlace.Lobby then
        return
    end

    local Teleport_Door = workspace.EItem:FindFirstChild("Teleport_Door")

    if Teleport_Door then
        p1:ChangeTrack("Teleport", Teleport_Door)
    else
        p1.trove:Add(task.spawn(function() -- line: 14
            -- upvalues: p1 (copy), Teleport_Door (copy)
            while Teleport_Door == nil do
                task.wait(10)

                local Teleport_Door = workspace.EItem:FindFirstChild("Teleport_Door")

                if Teleport_Door then
                    p1:ChangeTrack("Teleport", Teleport_Door)
                end
            end
        end))
    end

    for v1, v2 in p1.config.progress do
        local v3 = GameMgr:AutoGetRedDot("Map" .. v2[1])

        p1:ChangeTrack(v2[1], v3, v1)
    end
end

return t1
