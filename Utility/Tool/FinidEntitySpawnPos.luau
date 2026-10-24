-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local LocalPlayer = game:GetService("Players").LocalPlayer

return function(p1) -- line: 2
    -- upvalues: LocalPlayer (copy)
    local t1 = {}

    for v1, v2 in p1 do
        t1[v2] = {
            index = v1,
            objs = {}
        }
    end

    for _, child in workspace.EItem:GetChildren() do
        if child.Name == "EnemySpwan" then
            for _, child in child:GetChildren() do
                for _, child in child:GetChildren() do
                    local v3 = tonumber(child:GetAttribute("Id"))

                    if v3 ~= nil and t1[v3] then
                        table.insert(t1[v3].objs, child)
                    end
                end
            end
        end
    end

    local t2 = {}
    local Character = LocalPlayer.Character

    if not (Character and Character.PrimaryPart) then
        for v4, v5 in t1 do
            if v5.objs[1] then
                t2[v5.index] = {
                    id = v4,
                    obj = v5.objs[1]
                }
            end
        end
    else
        for v6, v7 in t1 do
            if v7.objs[1] ~= nil then
                local v8 = 999
                local v9 = v7.objs[1]

                for _, v10 in v7.objs do
                    local Magnitude = (v10.CFrame.Position - Character.PrimaryPart.CFrame.Position).Magnitude

                    if Magnitude < v8 then
                        v9 = v10
                        v8 = Magnitude
                    end
                end

                t2[v7.index] = {
                    id = v6,
                    obj = v9
                }
            end
        end
    end

    return t2
end
