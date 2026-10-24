-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local function SetPhysicsPart(_) -- line: 5
end

for _, _ in pairs(CollectionService:GetTagged("PhysicsWaterPart")) do
end

CollectionService:GetInstanceAddedSignal("PhysicsWaterPart"):Connect(function(_) -- line: 13
    task.wait()
end)

function t1.new(p3, p4) -- line: 20
    -- upvalues: RunService (copy)
    local t2 = {}

    p3.Body = p4
    p3.Cd = 0.5
    p4.CanTouch = true
    p4.CanCollide = false
    p4.Touched:Connect(function(p5) -- line: 27
        -- upvalues: t2 (copy)
        local PhysicsWaterDir = p5:GetAttribute("PhysicsWaterDir")

        if not PhysicsWaterDir then
            return
        end

        table.insert(t2, {
            p5,
            PhysicsWaterDir,
            (p5:GetAttribute("PhysicsWaterSize"))
        })
    end)
    p4.TouchEnded:Connect(function(p6) -- line: 34
        -- upvalues: t2 (copy)
        for v1, v2 in t2 do
            if v2[1] == p6 then
                local v3 = #t2

                if v3 ~= v1 then
                    t2[v1] = t2[v3]
                end

                t2[v3] = nil

                return
            end
        end
    end)
    p3.update = RunService.Stepped:Connect(function(_, _) -- line: 49
        -- upvalues: p3 (copy), p4 (copy), t2 (copy)
        local Size, CFrame = p4.Size, p4.CFrame
        local v4 = CFrame:Inverse()

        for _, v5 in t2 do
            local v6 = v5[1].CFrame * v4
            local v11 = math.max(0, (math.min((Size.X + v5[1].CFrame.Position.X) / 2 - math.abs(v6.X - CFrame.Position.X), Size.X, v5[1].Size.X)))
            local v16 = math.max(0, (math.min((Size.Y + v5[1].CFrame.Position.Y) / 2 - math.abs(v6.Y - CFrame.Position.Y), Size.Y, v5[1].Size.Y)))
            local v21 = math.max(0, (math.min((Size.Z + v5[1].CFrame.Position.Z) / 2 - math.abs(v6.Z - CFrame.Position.Z), Size.Z, v5[1].Size.Z)))
            local v22 = v11 / v5[1].Size.X * v16 / v5[1].Size.Y * v21 / v5[1].Size.Z * v5[3] * (p4.CurrentPhysicalProperties.Density - v5[1].CurrentPhysicalProperties.Density)
            local v23 = 0.5 * p4.CurrentPhysicalProperties.Density * p3.Cd
            local AssemblyLinearVelocity = v5[1].AssemblyLinearVelocity
            local t4 = {
                AssemblyLinearVelocity.X,
                AssemblyLinearVelocity.Y,
                AssemblyLinearVelocity.Z
            }
            local v24

            if AssemblyLinearVelocity.X > 0 then
                if bit32.band(1, v5[2]) == 0 then
                    v24 = 0
                else
                    v24 = AssemblyLinearVelocity.X * AssemblyLinearVelocity.X * v23 * v16 * v21

                    if not v24 then
                        v24 = if bit32.band(2, v5[2]) == 0 then 0 else AssemblyLinearVelocity.X * AssemblyLinearVelocity.X * v23 * v16 * v21
                    end
                end
            else
                v24 = if bit32.band(2, v5[2]) == 0 then 0 else AssemblyLinearVelocity.X * AssemblyLinearVelocity.X * v23 * v16 * v21
            end

            t4[1] = v24

            local v28

            if AssemblyLinearVelocity.Y > 0 then
                if bit32.band(4, v5[2]) == 0 then
                    v28 = 0
                else
                    v28 = AssemblyLinearVelocity.Y * AssemblyLinearVelocity.Y * v23 * v11 * v21

                    if not v28 then
                        v28 = if bit32.band(8, v5[2]) == 0 then 0 else AssemblyLinearVelocity.Y * AssemblyLinearVelocity.Y * v23 * v11 * v21
                    end
                end
            else
                v28 = if bit32.band(8, v5[2]) == 0 then 0 else AssemblyLinearVelocity.Y * AssemblyLinearVelocity.Y * v23 * v11 * v21
            end

            t4[2] = v28

            local v32

            if AssemblyLinearVelocity.Z > 0 then
                if bit32.band(16, v5[2]) == 0 then
                    v32 = 0
                else
                    v32 = AssemblyLinearVelocity.Z * AssemblyLinearVelocity.Z * v23 * v16 * v11

                    if not v32 then
                        v32 = if bit32.band(32, v5[2]) == 0 then 0 else AssemblyLinearVelocity.Z * AssemblyLinearVelocity.Z * v23 * v16 * v11
                    end
                end
            else
                v32 = if bit32.band(32, v5[2]) == 0 then 0 else AssemblyLinearVelocity.Z * AssemblyLinearVelocity.Z * v23 * v16 * v11
            end

            t4[3] = v32

            local v39 = Vector3.new(t4[1] / 2, t4[2] / 2, t4[3] / 2)

            v5[1]:ApplyImpulse(v39 + v22)
        end
    end)
end

return t1
