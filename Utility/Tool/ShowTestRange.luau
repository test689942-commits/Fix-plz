-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return function(p1, p2, p3, p4) -- line: 1
    local Part = Instance.new("Part", workspace.FX)

    Part.CanCollide = false
    Part.CanTouch = false
    Part.CanQuery = false
    Part.Transparency = 0.8
    Part.Anchored = true
    Part.Color = Color3.new(1, 0, 0)
    Part.CFrame = p1
    task.delay(0.3, function() -- line: 10
        -- upvalues: Part (copy)
        Part:Destroy()
    end)

    if p4 then
        Part.Size = Vector3.new(p2, p3, p4)
    else
        Part.Shape = Enum.PartType.Ball
        Part.Size = Vector3.new(p2 * 2, p2 * 2, p2 * 2)
    end
end
