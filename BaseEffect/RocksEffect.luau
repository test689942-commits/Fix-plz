-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}
local TweenService = game:GetService("TweenService")
local PoolMgr, GameMgr, EventMgr = _G.PoolMgr, _G.GameMgr, _G.EventMgr
local v1 = RaycastParams.new()

v1.FilterType = Enum.RaycastFilterType.Include
v1.FilterDescendantsInstances = { workspace.Map }

local Part = Instance.new("Part")

function CFrameToOrientation(p1) -- line: 13
    local v2, v3, v4 = p1:ToOrientation()

    return (Vector3.new(math.deg(v2), math.deg(v3), (math.deg(v4))))
end

function t1.Show(_, p3, p4, p5, p6, p7) -- line: 18
    -- upvalues: TweenService (copy), PoolMgr (copy), GameMgr (copy), EventMgr (copy), v1 (copy), Part (copy)
    local v8 = Random.new()
    local n1 = 30
    local v9 = 360 / p7
    local v10 = p6 or Vector3.new(2, 2, 2)
    local v11 = CFrame.new(p3, p3 + p4)

    local function OuterRocksLoop() -- line: 28
        -- upvalues: p5 (copy), p7 (copy), v8 (copy), n1 (ref), v9 (copy), v10 (copy), v11 (copy), TweenService (copy), PoolMgr (copy), v1 (copy), Part (copy)
        for _ = 1, p7 do
            local v13 = v11 * CFrame.fromEulerAnglesXYZ(0, 0, (math.rad(n1))) * CFrame.new(0, p5 / 2 + p5 / 2.7, -v10.Y * 2)
            local v14 = workspace:Raycast(v13.Position, v13.LookVector * -20, v1)

            n1 += v9

            if v14 then
                local v15 = PoolMgr:Get("Effect_RocksEffect", Part)
                local v16 = PoolMgr:Get("Effect_RocksEffect", v15)

                v15.Position = v14.Position
                v15.Orientation = CFrameToOrientation(v13)
                v15.Size = Vector3.new(v10.X * 1.3, v10.Y * 1.3, v10.Z / 1.4) * v8:NextNumber(1, 1.5)
                v15.CFrame *= CFrame.new(0, 0, v15.Size.Z)

                local v20 = v15.CFrame * CFrame.new(0, 0, -v15.Size.Z / 2) * CFrame.fromEulerAnglesXYZ(v8:NextNumber(0.25, 0.5), v8:NextNumber(-0.25, 0.25), v8:NextNumber(-0.25, 0.25))

                v16.Size = Vector3.new(v15.Size.X * 1.01, v15.Size.Y * 1.01, v15.Size.Z * 0.25)
                v16.CFrame = v15.CFrame * CFrame.new(0, 0, -v15.Size.Z / 2 - v16.Size.Z / 2.1)
                v16.Anchored = false
                TweenService:Create(v15, TweenInfo.new(0.15), {
                    CFrame = v20
                }):Play()
                TweenService:Create(v16, TweenInfo.new(0.15), {
                    CFrame = v20 * CFrame.new(0, 0, -v15.Size.Z / 2 - v16.Size.Z / 2.1)
                }):Play()
                v15.Parent = workspace.FX
                v16.Parent = workspace.FX
                v15.BrickColor = BrickColor.new("Dark grey")
                v15.Anchored = true
                v15.CanTouch = false
                v15.CanCollide = false
                v16.BrickColor = v14.Instance.BrickColor
                v16.Anchored = true
                v16.CanTouch = false
                v16.CanCollide = false

                if v14.Material == Enum.Material.Concrete or v14.Material == Enum.Material.Air or v14.Material == Enum.Material.Wood or v14.Material == Enum.Material.Neon or v14.Material == Enum.Material.WoodPlanks then
                    v15.Material = v14.Instance.Material
                else
                    v15.Material = Enum.Material.Concrete
                end

                v16.Material = v14.Instance.Material
                task.delay(4, function() -- line: 81
                    -- upvalues: v15 (copy), v16 (copy), TweenService (copy), PoolMgr (copy)
                    TweenService:Create(v15, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(0.01, 0.01, 0.01)
                    }):Play()
                    TweenService:Create(v16, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(0.01, 0.01, 0.01),
                        CFrame = v15.CFrame * CFrame.new(0, v15.Size.Y / 2 - v15.Size.Y / 2.1, 0)
                    }):Play()
                    task.delay(0.6, function() -- line: 85
                        -- upvalues: v15 (copy), v16 (copy), PoolMgr (copy)
                        PoolMgr:Push("Effect_RocksEffect", v15)
                        PoolMgr:Push("Effect_RocksEffect", v16)
                    end)
                end)
            end
        end
    end

    local function InnerRocksLoop() -- line: 94
        -- upvalues: p3 (copy), p4 (copy), p5 (copy), p7 (copy), v8 (copy), n1 (ref), v9 (copy), v10 (copy), TweenService (copy), PoolMgr (copy), v1 (copy), Part (copy)
        for _ = 1, p7 do
            local v26 = CFrame.new(p3, p3 + p4) * CFrame.fromEulerAnglesXYZ(0, 0, (math.rad(n1))) * CFrame.new(0, p5 / 2 + p5 / 10, -10)
            local v27 = game.Workspace:Raycast(v26.Position, v26.LookVector * -20, v1)

            n1 += v9

            if v27 then
                local v28 = PoolMgr:Get("Effect_RocksEffect", Part)
                local v29 = PoolMgr:Get("Effect_RocksEffect", v28)

                v28.Position = v27.Position
                v28.Orientation = CFrameToOrientation(v26)
                v28.Size = Vector3.new(v10.X * 1.3, v10.Y * 1.3, v10.Z * 0.7) * v8:NextNumber(1, 1.5)
                v28.CFrame *= CFrame.new(0, 0, v28.Size.Z)

                local v33 = v28.CFrame * CFrame.new(0, 0, -v28.Size.Z * 0.35) * CFrame.fromEulerAnglesXYZ(v8:NextNumber(-1, -0.35), v8:NextNumber(-0.15, 0.15), v8:NextNumber(-0.15, 0.15))

                v29.Size = Vector3.new(v28.Size.X * 1.01, v28.Size.Y * 1.01, v28.Size.Z * 0.25)
                v29.CFrame = v28.CFrame * CFrame.new(0, 0, -v28.Size.Z / 2 - v29.Size.Z / 2.1)
                TweenService:Create(v28, TweenInfo.new(0.15), {
                    CFrame = v33
                }):Play()
                TweenService:Create(v29, TweenInfo.new(0.15), {
                    CFrame = v33 * CFrame.new(0, 0, -v28.Size.Z / 2 - v29.Size.Z / 2.1)
                }):Play()
                v28.Parent = workspace.FX
                v29.Parent = workspace.FX
                v28.BrickColor = BrickColor.new("Dark grey")
                v28.Anchored = true
                v28.CanTouch = false
                v28.CanCollide = false
                v29.BrickColor = v27.Instance.BrickColor
                v29.Anchored = true
                v29.CanTouch = false
                v29.CanCollide = false

                if v27.Material == Enum.Material.Concrete or v27.Material == Enum.Material.Air or v27.Material == Enum.Material.Wood or v27.Material == Enum.Material.Neon or v27.Material == Enum.Material.WoodPlanks then
                    v28.Material = v27.Instance.Material
                else
                    v28.Material = Enum.Material.Concrete
                end

                v29.Material = v27.Instance.Material
                task.delay(4, function() -- line: 150
                    -- upvalues: v28 (copy), v29 (copy), TweenService (copy), PoolMgr (copy)
                    TweenService:Create(v28, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(0.01, 0.01, 0.01)
                    }):Play()
                    TweenService:Create(v29, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(0.01, 0.01, 0.01),
                        CFrame = v28.CFrame * CFrame.new(0, v28.Size.Y / 2 - v28.Size.Y / 2.1, 0)
                    }):Play()
                    task.delay(0.6, function() -- line: 154
                        -- upvalues: v28 (copy), v29 (copy), PoolMgr (copy)
                        PoolMgr:Push("Effect_RocksEffect", v28)
                        PoolMgr:Push("Effect_RocksEffect", v29)
                    end)
                end)
            end
        end
    end

    InnerRocksLoop()
    OuterRocksLoop()
    EventMgr:Triger("ShakerCamera", p5 / 2, 20, 0, 0.5, 0, 0, p3)

    local v37 = CFrame.new(p3, p3 + p4)
    local v38 = game.Workspace:Raycast(v37.Position, v37.LookVector * -20, v1)

    if v38 then
        for _ = 1, p7 / 2 do
            local v39 = PoolMgr:Get("Effect_RocksEffect", Part)

            v39.Parent = workspace.FX
            v39.Position = v38.Position + p4 * v10.Z * 0.5
            v39.Size = Vector3.new(v10.X * 0.5, v10.Y * 0.5, v10.Z * 0.5) * v8:NextNumber(0.5, 1)
            v39.CFrame *= CFrame.new(0, 0, v39.Size.Z)
            v39.BrickColor = v38.Instance.BrickColor
            v39.Material = v38.Instance.Material
            v39.Anchored = false
            v39.CanTouch = false
            v39.CanCollide = true
            v39.AssemblyLinearVelocity = CFrame.Angles(math.rad((math.random(-30, 30))), 0, (math.rad((math.random(-30, 30))))) * p4 * p5 * 15
            v39.AssemblyAngularVelocity = Vector3.new(math.rad((math.random(90))), 0, (math.rad((math.random(90)))))
            task.delay(4, function() -- line: 183
                -- upvalues: v39 (copy), TweenService (copy), PoolMgr (copy)
                if v39 and v39.Parent ~= nil then
                    TweenService:Create(v39, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        Size = Vector3.new(0.01, 0.01, 0.01)
                    }):Play()
                    task.delay(0.6, function() -- line: 188
                        -- upvalues: v39 (copy), PoolMgr (copy)
                        if v39 and v39.Parent ~= nil then
                            PoolMgr:Push("Effect_RocksEffect", v39)
                        end
                    end)
                end
            end)
        end
    end

    GameMgr:PlayWorldSound(p3, 1812)
end

function t1.Hide(_) -- line: 201
end

return t1
