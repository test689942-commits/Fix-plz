-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local RunService = game:GetService("RunService")

return {
    new = function(p1, p2, p3) -- new | line: 4
        if p2:IsA("BasePart") then
            p1.basePart = p2
        elseif p2:IsA("Model") then
            p1.model = p2
        end

        p1.strength = p3 or 1
    end,
    Start = function(p4) -- Start | line: 14
        -- upvalues: RunService (copy)
        task.wait()

        if p4.basePart then
            p4.runServiceConnect = RunService.RenderStepped:Connect(function(p5) -- line: 17
                -- upvalues: p4 (copy)
                p4:Updata(p5)
            end)
        else
            p4.runServiceConnect = RunService.RenderStepped:Connect(function(p6) -- line: 21
                -- upvalues: p4 (copy)
                p4:UpdataModel(p6)
            end)
        end
    end,
    Stop = function(p7) -- Stop | line: 28
        p7.runServiceConnect:Disconnect()
    end,
    Updata = function(p8, p9) -- Updata | line: 32
        local v1 = workspace.Camera.CFrame.Position - p8.basePart.CFrame.Position
        local LookVector = p8.basePart.CFrame.LookVector
        local Unit = Vector3.new(v1.X, 0, v1.Z).Unit
        local v4 = math.deg((math.acos((Unit:Dot(LookVector)))))
        local v5 = if Unit:Cross(LookVector).Y > 0 then -1 else 1
        local v6 = v4 * p9 * p8.strength * v5

        p8.basePart.CFrame *= CFrame.Angles(0, math.rad(v6), 0)
    end,
    UpdataModel = function(p10, p11) -- UpdataModel | line: 46
        local Pivot = p10.model:GetPivot()
        local v7 = workspace.Camera.CFrame.Position - Pivot.Position
        local LookVector = Pivot.LookVector
        local Unit = Vector3.new(v7.X, 0, v7.Z).Unit
        local v10 = math.deg((math.acos((Unit:Dot(LookVector)))))
        local v11 = if Unit:Cross(LookVector).Y > 0 then -1 else 1
        local v12 = v10 * p11 * p10.strength * v11

        p10.model:PivotTo(Pivot * CFrame.Angles(0, math.rad(v12), 0))
    end
}
