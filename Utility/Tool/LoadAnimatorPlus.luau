-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local Players = game:GetService("Players")
local New = _G.New

local function LoadCharacter(p1) -- line: 4
    -- upvalues: New (copy)
    task.spawn(function() -- line: 5
        -- upvalues: p1 (copy), New (copy)
        New("AnimatorPlus")(p1, p1:WaitForChild("Humanoid"):WaitForChild("Animator"))
    end)
end

local function LoadPlayer(p2) -- line: 10
    -- upvalues: New (copy)
    if p2.Character then
        local Character = p2.Character

        task.spawn(function() -- line: 5
            -- upvalues: Character (copy), New (copy)
            New("AnimatorPlus")(Character, Character:WaitForChild("Humanoid"):WaitForChild("Animator"))
        end)
    end

    p2.CharacterAdded:Connect(function(p3) -- line: 14
        -- upvalues: New (copy)
        task.spawn(function() -- line: 5
            -- upvalues: p3 (copy), New (copy)
            New("AnimatorPlus")(p3, p3:WaitForChild("Humanoid"):WaitForChild("Animator"))
        end)
    end)
end

local function LoadDic(p4) -- line: 19
    -- upvalues: New (copy)
    if p4 == nil then
        return
    end

    for _, child in p4:GetChildren() do
        task.spawn(function() -- line: 5
            -- upvalues: child (copy), New (copy)
            New("AnimatorPlus")(child, child:WaitForChild("Humanoid"):WaitForChild("Animator"))
        end)
    end

    p4.ChildAdded:Connect(function(p5) -- line: 26
        -- upvalues: New (copy)
        task.spawn(function() -- line: 5
            -- upvalues: p5 (copy), New (copy)
            New("AnimatorPlus")(p5, p5:WaitForChild("Humanoid"):WaitForChild("Animator"))
        end)
    end)
end

return function(...) -- line: 31
    -- upvalues: Players (copy), New (copy), LoadDic (copy)
    for _, v1 in { ... } do
        LoadDic(v1)
    end

    for _, player in Players:GetPlayers() do
        if player.Character then
            local Character = player.Character

            task.spawn(function() -- line: 5
                -- upvalues: Character (copy), New (copy)
                New("AnimatorPlus")(Character, Character:WaitForChild("Humanoid"):WaitForChild("Animator"))
            end)
        end

        player.CharacterAdded:Connect(function(p6) -- line: 14
            -- upvalues: New (copy)
            task.spawn(function() -- line: 5
                -- upvalues: New (copy), p6 (copy)
                New("AnimatorPlus")(p6, p6:WaitForChild("Humanoid"):WaitForChild("Animator"))
            end)
        end)
    end

    Players.PlayerAdded:Connect(function(p7) -- line: 38
        -- upvalues: New (copy)
        if p7.Character then
            local Character = p7.Character

            task.spawn(function() -- line: 5
                -- upvalues: Character (copy), New (copy)
                New("AnimatorPlus")(Character, Character:WaitForChild("Humanoid"):WaitForChild("Animator"))
            end)
        end

        p7.CharacterAdded:Connect(function(p8) -- line: 14
            -- upvalues: New (copy)
            task.spawn(function() -- line: 5
                -- upvalues: New (copy), p8 (copy)
                New("AnimatorPlus")(p8, p8:WaitForChild("Humanoid"):WaitForChild("Animator"))
            end)
        end)
    end)
end
