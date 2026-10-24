-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local _, DataMgr, EventMgr, New = _G.GameMgr, _G.DataMgr, _G.EventMgr, _G.New

New("Utility.Tool")()

local LocalPlayer = game:GetService("Players").LocalPlayer

function t1.Load(p1, _) -- line: 9
    -- upvalues: DataMgr (copy), EventMgr (copy), New (copy), LocalPlayer (copy)
    local t2 = {}
    local t3 = {}

    for v1, v2 in p1.config.progress do
        t2[v2[1]] = {
            v1,
            v2[2]
        }

        if game.PlaceId == DataMgr.GamePlace.Game and v2[3] == "Lobby" then
            t3.Portal = { v1, 999 }
        else
            t3[v2[1]] = {
                v1,
                999
            }
        end
    end

    p1.trove:Add(EventMgr:AddFunc("OnDialogue", function(p3, p4) -- line: 20
        -- upvalues: p1 (copy), t2 (copy), New (copy)
        if t2[p3.Name] then
            return New("DialogueData")(t2[p3.Name][2], p4, p1.guid, t2[p3.Name][1])
        end
    end))

    for _, child in workspace.EItem:GetChildren() do
        if t3[child.Name] then
            if child.PrimaryPart and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
                local Magnitude = (child.PrimaryPart.CFrame.Position - LocalPlayer.Character.PrimaryPart.CFrame.Position).Magnitude

                if Magnitude < t3[child.Name][2] then
                    t3[child.Name][2] = Magnitude
                    t3[child.Name][3] = child
                end
            else
                t3[child.Name][2] = 0
                t3[child.Name][3] = child
            end
        end
    end

    for _, v3 in t3 do
        p1:ChangeTrack(v3[1], v3[3], v3[1])
    end

    p1.trove:Add(task.spawn(function() -- line: 45
        -- upvalues: p1 (copy), t3 (copy), LocalPlayer (copy)
        while true do
            task.wait(5)

            for _, v4 in t3 do
                v4[2] = 999
            end

            for _, child in workspace.EItem:GetChildren() do
                if t3[child.Name] then
                    if child.PrimaryPart and LocalPlayer.Character and LocalPlayer.Character.PrimaryPart then
                        local Magnitude = (child.PrimaryPart.CFrame.Position - LocalPlayer.Character.PrimaryPart.CFrame.Position).Magnitude

                        if Magnitude < t3[child.Name][2] then
                            t3[child.Name][2] = Magnitude
                            t3[child.Name][3] = child
                        end
                    else
                        t3[child.Name][2] = 0
                        t3[child.Name][3] = child
                    end
                end
            end

            for _, v5 in t3 do
                p1:ChangeTrack(v5[1], v5[3], v5[1])
            end
        end
    end))
end

return t1
