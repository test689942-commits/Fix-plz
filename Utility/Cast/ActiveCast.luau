-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

require(script.Parent.TypeDefinitions)

local TypeMarshaller = require(script.Parent.TypeMarshaller)
local t1 = {}

t1.__index = t1
t1.__type = "ActiveCast"

local RunService = game:GetService("RunService")
local Table = require(script.Parent.Table)
local v1

local function GetFastCastVisualizationContainer() -- line: 61
    local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects")

    if FastCastVisualizationObjects ~= nil then
        return FastCastVisualizationObjects
    end

    local Folder = Instance.new("Folder")

    Folder.Name = "FastCastVisualizationObjects"
    Folder.Archivable = false
    Folder.Parent = workspace.Terrain

    return Folder
end

local function PrintDebug(p1) -- line: 79
    -- upvalues: v1 (ref)
    if v1.DebugLogging == true then
        print(p1)
    end
end

function DbgVisualizeSegment(p2, p3) -- line: 86
    -- upvalues: v1 (ref)
    if v1.VisualizeCasts ~= true then
        return nil
    end

    local ConeHandleAdornment = Instance.new("ConeHandleAdornment")

    ConeHandleAdornment.Adornee = workspace.Terrain
    ConeHandleAdornment.CFrame = p2
    ConeHandleAdornment.Height = p3
    ConeHandleAdornment.Color3 = Color3.new()
    ConeHandleAdornment.Radius = 0.25
    ConeHandleAdornment.Transparency = 0.5

    local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects")

    if FastCastVisualizationObjects == nil then
        FastCastVisualizationObjects = Instance.new("Folder")
        FastCastVisualizationObjects.Name = "FastCastVisualizationObjects"
        FastCastVisualizationObjects.Archivable = false
        FastCastVisualizationObjects.Parent = workspace.Terrain
    end

    ConeHandleAdornment.Parent = FastCastVisualizationObjects

    return ConeHandleAdornment
end

function DbgVisualizeHit(p4, p5) -- line: 100
    -- upvalues: v1 (ref)
    if v1.VisualizeCasts ~= true then
        return nil
    end

    local SphereHandleAdornment = Instance.new("SphereHandleAdornment")

    SphereHandleAdornment.Adornee = workspace.Terrain
    SphereHandleAdornment.CFrame = p4
    SphereHandleAdornment.Radius = 0.4
    SphereHandleAdornment.Transparency = 0.25
    SphereHandleAdornment.Color3 = p5 == false and Color3.new(0.2, 1, 0.5) or Color3.new(1, 0.2, 0.2)

    local FastCastVisualizationObjects = workspace.Terrain:FindFirstChild("FastCastVisualizationObjects")

    if FastCastVisualizationObjects == nil then
        FastCastVisualizationObjects = Instance.new("Folder")
        FastCastVisualizationObjects.Name = "FastCastVisualizationObjects"
        FastCastVisualizationObjects.Archivable = false
        FastCastVisualizationObjects.Parent = workspace.Terrain
    end

    SphereHandleAdornment.Parent = FastCastVisualizationObjects

    return SphereHandleAdornment
end

local function GetPositionAtTime(p6, p7, p8, p9) -- line: 120
    local v5 = Vector3.new(p9.X * p6 ^ 2 / 2, p9.Y * p6 ^ 2 / 2, p9.Z * p6 ^ 2 / 2)

    return p7 + p8 * p6 + v5
end

local function GetVelocityAtTime(p10, p11, p12) -- line: 126
    return p11 + p12 * p10
end

local function GetTrajectoryInfo(p13, p14) -- line: 130
    assert(p13.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

    local v7 = p13.StateInfo.Trajectories[p14]
    local v8 = v7.EndTime - v7.StartTime
    local Origin, InitialVelocity, Acceleration = v7.Origin, v7.InitialVelocity, v7.Acceleration
    local v12 = Vector3.new(Acceleration.X * v8 ^ 2 / 2, Acceleration.Y * v8 ^ 2 / 2, Acceleration.Z * v8 ^ 2 / 2)

    return {
        Origin + InitialVelocity * v8 + v12,
        InitialVelocity + Acceleration * v8
    }
end

local function GetLatestTrajectoryEndInfo(p15) -- line: 143
    -- upvalues: GetTrajectoryInfo (copy)
    assert(p15.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

    return (GetTrajectoryInfo(p15, #p15.StateInfo.Trajectories))
end

local function CloneCastParams(p16) -- line: 148
    local v14 = RaycastParams.new()

    v14.CollisionGroup = p16.CollisionGroup
    v14.FilterType = p16.FilterType
    v14.FilterDescendantsInstances = p16.FilterDescendantsInstances
    v14.IgnoreWater = p16.IgnoreWater

    return v14
end

local function SendRayHit(p17, p18, p19, p20) -- line: 157
    p17.Caster.RayHit:Fire(p17, p18, p19, p20)
end

local function SendRayPierced(p21, p22, p23, p24) -- line: 162
    p21.Caster.RayPierced:Fire(p21, p22, p23, p24)
end

local function SendLengthChanged(p25, p26, p27, p28, p29, p30) -- line: 167
    p25.Caster.LengthChanged:Fire(p25, p26, p27, p28, p29, p30)
end

local function SimulateCast(p31, p32, p33) -- line: 173
    -- upvalues: Table (copy), v1 (ref)
    assert(p31.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

    if v1.DebugLogging == true then
        print("Casting for frame.")
    end

    local v16 = p31.StateInfo.Trajectories[#p31.StateInfo.Trajectories]
    local Origin = v16.Origin
    local v17 = p31.StateInfo.TotalRuntime - v16.StartTime
    local InitialVelocity, Acceleration = v16.InitialVelocity, v16.Acceleration
    local v21 = Vector3.new(Acceleration.X * v17 ^ 2 / 2, Acceleration.Y * v17 ^ 2 / 2, Acceleration.Z * v17 ^ 2 / 2)
    local v22 = Origin + InitialVelocity * v17 + v21
    local _ = InitialVelocity + Acceleration * v17
    local v23 = p31.StateInfo.TotalRuntime - v16.StartTime

    p31.StateInfo.TotalRuntime += p32

    local v24 = p31.StateInfo.TotalRuntime - v16.StartTime
    local v28 = Vector3.new(Acceleration.X * v24 ^ 2 / 2, Acceleration.Y * v24 ^ 2 / 2, Acceleration.Z * v24 ^ 2 / 2)
    local v29 = Origin + InitialVelocity * v24 + v28
    local v30 = InitialVelocity + Acceleration * v24
    local v31 = (v29 - v22).Unit * v30.Magnitude * p32
    local WorldRoot = p31.RayInfo.WorldRoot
    local v32 = WorldRoot:Raycast(v22, v31, p31.RayInfo.Parameters)
    local Air = Enum.Material.Air

    Vector3.new()

    local v33, Instance

    if v32 ~= nil then
        v33 = v32.Position
        Instance = v32.Instance
        Air = v32.Material

        local _ = v32.Normal
    else
        v33 = v29
    end

    local Magnitude = (v33 - v22).Magnitude
    local Unit = v31.Unit
    local CosmeticBulletObject = p31.RayInfo.CosmeticBulletObject

    p31.Caster.LengthChanged:Fire(p31, v22, Unit, Magnitude, v30, CosmeticBulletObject)
    p31.StateInfo.DistanceCovered += Magnitude

    local v34 = if p32 > 0 then DbgVisualizeSegment(CFrame.new(v22, v22 + v31), Magnitude) else nil

    if Instance and Instance ~= p31.RayInfo.CosmeticBulletObject then
        tick()

        if v1.DebugLogging == true then
            print("Hit something, testing now.")
        end

        if p31.RayInfo.CanPierceCallback ~= nil then
            if p33 == false and p31.StateInfo.IsActivelySimulatingPierce then
                p31:Terminate()
                error("ERROR: The latest call to CanPierceCallback took too long to complete! This cast is going to suffer desyncs which WILL cause unexpected behavior and errors. Please fix your performance problems, or remove statements that yield (e.g. wait() calls)")
            end

            p31.StateInfo.IsActivelySimulatingPierce = true
        end

        if p31.RayInfo.CanPierceCallback ~= nil and (p31.RayInfo.CanPierceCallback == nil or p31.RayInfo.CanPierceCallback(p31, v32, v30, p31.RayInfo.CosmeticBulletObject) ~= false) then
            if v1.DebugLogging == true then
                print("Piercing function returned TRUE to pierce this part.")
            end

            if v34 ~= nil then
                v34.Color3 = Color3.new(0.4, 0.05, 0.05)
            end

            DbgVisualizeHit(CFrame.new(v33), true)

            local Parameters = p31.RayInfo.Parameters
            local t2 = {}
            local FilterDescendantsInstances = Parameters.FilterDescendantsInstances
            local n1 = 0
            local v35

            while true do
                if v32.Instance:IsA("Terrain") then
                    if Air == Enum.Material.Water then
                        p31:Terminate()
                        error("Do not add Water as a piercable material. If you need to pierce water, set cast.RayInfo.Parameters.IgnoreWater = true instead", 0)
                    end

                    warn("WARNING: The pierce callback for this cast returned TRUE on Terrain! This can cause severely adverse effects.")
                end

                if Parameters.FilterType == Enum.RaycastFilterType.Blacklist then
                    local FilterDescendantsInstances = Parameters.FilterDescendantsInstances

                    Table.insert(FilterDescendantsInstances, v32.Instance)
                    Table.insert(t2, v32.Instance)
                    Parameters.FilterDescendantsInstances = FilterDescendantsInstances
                else
                    local FilterDescendantsInstances = Parameters.FilterDescendantsInstances

                    Table.removeObject(FilterDescendantsInstances, v32.Instance)
                    Table.insert(t2, v32.Instance)
                    Parameters.FilterDescendantsInstances = FilterDescendantsInstances
                end

                local CosmeticBulletObject = p31.RayInfo.CosmeticBulletObject

                p31.Caster.RayPierced:Fire(p31, v32, v30, CosmeticBulletObject)
                v32 = WorldRoot:Raycast(v22, v31, Parameters)

                if v32 == nil then
                    v35 = false
                    break
                end

                if n1 >= 100 then
                    v35 = false
                    warn("WARNING: Exceeded maximum pierce test budget for a single ray segment (attempted to test the same segment " .. 100 .. " times!)")
                    break
                end

                n1 += 1

                if p31.RayInfo.CanPierceCallback(p31, v32, v30, p31.RayInfo.CosmeticBulletObject) == false then
                    v35 = true
                    break
                end
            end

            p31.RayInfo.Parameters.FilterDescendantsInstances = FilterDescendantsInstances
            p31.StateInfo.IsActivelySimulatingPierce = false

            if v35 then
                local v36 = "Broke because the ray hit something solid (" .. tostring(v32.Instance) .. ") while testing for a pierce. Terminating the cast."

                if v1.DebugLogging == true then
                    print(v36)
                end

                local CosmeticBulletObject = p31.RayInfo.CosmeticBulletObject

                p31.Caster.RayHit:Fire(p31, v32, v30, CosmeticBulletObject)
                p31:Terminate()
                DbgVisualizeHit(CFrame.new(v32.Position), false)

                return
            end
        else
            if v1.DebugLogging == true then
                print("Piercing function is nil or it returned FALSE to not pierce this hit.")
            end

            p31.StateInfo.IsActivelySimulatingPierce = false

            if p31.StateInfo.HighFidelityBehavior == 2 and v16.Acceleration ~= Vector3.new() and p31.StateInfo.HighFidelitySegmentSize ~= 0 then
                p31.StateInfo.CancelHighResCast = false

                if p31.StateInfo.IsActivelyResimulating then
                    p31:Terminate()
                    error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.")
                end

                p31.StateInfo.IsActivelyResimulating = true

                if v1.DebugLogging == true then
                    print("Hit was registered, but recalculation is on for physics based casts. Recalculating to verify a real hit...")
                end

                local v38 = math.floor(Magnitude / p31.StateInfo.HighFidelitySegmentSize)
                local _ = Magnitude / v38
                local v39 = p32 / v38

                for i = 1, v38 do
                    if p31.StateInfo.CancelHighResCast then
                        p31.StateInfo.CancelHighResCast = false
                        break
                    end

                    local v40 = v23 + v39 * i
                    local v44 = Vector3.new(Acceleration.X * v40 ^ 2 / 2, Acceleration.Y * v40 ^ 2 / 2, Acceleration.Z * v40 ^ 2 / 2)
                    local v45 = Origin + InitialVelocity * v40 + v44
                    local v46 = InitialVelocity + Acceleration * (v23 + v39 * i)
                    local v47 = WorldRoot:Raycast(v45, v46 * p32, p31.RayInfo.Parameters)
                    local Magnitude = (v45 - (v45 + v46)).Magnitude

                    if v47 ~= nil then
                        local Magnitude = (v45 - v47.Position).Magnitude
                        local v49 = DbgVisualizeSegment(CFrame.new(v45, v45 + v46), Magnitude)

                        if v49 ~= nil then
                            v49.Color3 = Color3.new(0.286275, 0.329412, 0.247059)
                        end

                        if p31.RayInfo.CanPierceCallback == nil or p31.RayInfo.CanPierceCallback ~= nil and p31.RayInfo.CanPierceCallback(p31, v47, v46, p31.RayInfo.CosmeticBulletObject) == false then
                            p31.StateInfo.IsActivelyResimulating = false

                            local CosmeticBulletObject = p31.RayInfo.CosmeticBulletObject

                            p31.Caster.RayHit:Fire(p31, v47, v46, CosmeticBulletObject)
                            p31:Terminate()

                            local v50 = DbgVisualizeHit(CFrame.new(v33), false)

                            if v50 ~= nil then
                                v50.Color3 = Color3.new(0.0588235, 0.87451, 1)
                            end

                            return
                        end

                        local CosmeticBulletObject = p31.RayInfo.CosmeticBulletObject

                        p31.Caster.RayPierced:Fire(p31, v47, v46, CosmeticBulletObject)

                        local v51 = DbgVisualizeHit(CFrame.new(v33), true)

                        if v51 ~= nil then
                            v51.Color3 = Color3.new(1, 0.113725, 0.588235)
                        end

                        if v49 ~= nil then
                            v49.Color3 = Color3.new(0.305882, 0.243137, 0.329412)
                        end
                    else
                        local v48 = DbgVisualizeSegment(CFrame.new(v45, v45 + v46), Magnitude)

                        if v48 ~= nil then
                            v48.Color3 = Color3.new(0.286275, 0.329412, 0.247059)
                        end
                    end
                end

                p31.StateInfo.IsActivelyResimulating = false
            else
                if p31.StateInfo.HighFidelityBehavior == 1 or p31.StateInfo.HighFidelityBehavior == 3 then
                    local v52 = v1

                    if v52.DebugLogging == true then
                        print("Hit was successful. Terminating.")
                    end

                    local CosmeticBulletObject = p31.RayInfo.CosmeticBulletObject

                    p31.Caster.RayHit:Fire(p31, v32, v30, CosmeticBulletObject)
                    p31:Terminate()
                    DbgVisualizeHit(CFrame.new(v33), false)

                    return
                end

                p31:Terminate()
                error("Invalid value " .. p31.StateInfo.HighFidelityBehavior .. " for HighFidelityBehavior.")
            end
        end
    end

    if p31.StateInfo.DistanceCovered >= p31.RayInfo.MaxDistance then
        p31:Terminate()
        DbgVisualizeHit(CFrame.new(v29), false)
    end
end

function t1.new(p34, p35, p36, p37, p38) -- line: 422
    -- upvalues: TypeMarshaller (copy), t1 (copy), RunService (copy), Table (copy), v1 (ref), SimulateCast (copy)
    local v53 = if TypeMarshaller(p37) == "number" then p36.Unit * p37 else p37

    if p38.HighFidelitySegmentSize <= 0 then
        error("Cannot set FastCastBehavior.HighFidelitySegmentSize <= 0!", 0)
    end

    local t3 = {
        Caster = p34,
        StateInfo = {
            UpdateConnection = nil,
            Paused = false,
            TotalRuntime = 0,
            DistanceCovered = 0,
            IsActivelySimulatingPierce = false,
            IsActivelyResimulating = false,
            CancelHighResCast = false,
            HighFidelitySegmentSize = p38.HighFidelitySegmentSize,
            HighFidelityBehavior = p38.HighFidelityBehavior,
            Trajectories = {
                {
                    StartTime = 0,
                    EndTime = -1,
                    Origin = p35,
                    InitialVelocity = v53,
                    Acceleration = p38.Acceleration
                }
            }
        },
        RayInfo = {
            Parameters = p38.RaycastParams,
            WorldRoot = workspace,
            MaxDistance = p38.MaxDistance or 1000,
            CosmeticBulletObject = p38.CosmeticBulletTemplate,
            CanPierceCallback = p38.CanPierceFunction
        },
        UserData = {}
    }

    if t3.StateInfo.HighFidelityBehavior == 2 then
        t3.StateInfo.HighFidelityBehavior = 3
    end

    if t3.RayInfo.Parameters ~= nil then
        local RayInfo = t3.RayInfo
        local Parameters = t3.RayInfo.Parameters
        local v54 = RaycastParams.new()

        v54.CollisionGroup = Parameters.CollisionGroup
        v54.FilterType = Parameters.FilterType
        v54.FilterDescendantsInstances = Parameters.FilterDescendantsInstances
        v54.IgnoreWater = Parameters.IgnoreWater
        RayInfo.Parameters = v54
    else
        t3.RayInfo.Parameters = RaycastParams.new()
    end

    local v55

    if p38.CosmeticBulletProvider ~= nil then
        if TypeMarshaller(p38.CosmeticBulletProvider) == "PartCache" then
            if t3.RayInfo.CosmeticBulletObject ~= nil then
                warn("Do not define FastCastBehavior.CosmeticBulletTemplate and FastCastBehavior.CosmeticBulletProvider at the same time! The provider will be used, and CosmeticBulletTemplate will be set to nil.")
                t3.RayInfo.CosmeticBulletObject = nil
                p38.CosmeticBulletTemplate = nil
            end

            t3.RayInfo.CosmeticBulletObject = p38.CosmeticBulletProvider:GetPart()
            v55 = true
            t3.RayInfo.CosmeticBulletObject.CFrame = CFrame.new(p35, p35 + p36)
        else
            warn("FastCastBehavior.CosmeticBulletProvider was not an instance of the PartCache module (an external/separate model)! Are you inputting an instance created via PartCache.new? If so, are you on the latest version of PartCache? Setting FastCastBehavior.CosmeticBulletProvider to nil.")
            v55 = false
            p38.CosmeticBulletProvider = nil
        end
    else
        if t3.RayInfo.CosmeticBulletObject ~= nil then
            t3.RayInfo.CosmeticBulletObject = t3.RayInfo.CosmeticBulletObject:Clone()
            t3.RayInfo.CosmeticBulletObject.CFrame = CFrame.new(p35, p35 + p36)
            t3.RayInfo.CosmeticBulletObject.Parent = p38.CosmeticBulletContainer
        end

        v55 = false
    end

    local v56 = if v55 then p38.CosmeticBulletProvider.CurrentCacheParent else p38.CosmeticBulletContainer

    if p38.AutoIgnoreContainer == true and v56 ~= nil then
        local FilterDescendantsInstances = t3.RayInfo.Parameters.FilterDescendantsInstances

        if Table.find(FilterDescendantsInstances, v56) == nil then
            Table.insert(FilterDescendantsInstances, v56)
            t3.RayInfo.Parameters.FilterDescendantsInstances = FilterDescendantsInstances
        end
    end

    local v57 = if RunService:IsClient() then RunService.RenderStepped else RunService.Heartbeat

    setmetatable(t3, t1)
    t3.StateInfo.UpdateConnection = v57:Connect(function(p39) -- line: 535
        -- upvalues: t3 (copy), v1 (ref), SimulateCast (copy)
        if t3.StateInfo.Paused then
            return
        end

        if v1.DebugLogging == true then
            print("Casting for frame.")
        end

        local v58 = t3.StateInfo.Trajectories[#t3.StateInfo.Trajectories]
        local v59, v60

        if t3.StateInfo.HighFidelityBehavior ~= 3 or v58.Acceleration == Vector3.new() then
            v60 = true
        elseif t3.StateInfo.HighFidelitySegmentSize > 0 then
            v59 = tick()

            if t3.StateInfo.IsActivelyResimulating then
                t3:Terminate()
                error("Cascading cast lag encountered! The caster attempted to perform a high fidelity cast before the previous one completed, resulting in exponential cast lag. Consider increasing HighFidelitySegmentSize.")
            end

            v60 = false
        else
            v60 = true
        end

        if v60 then
            SimulateCast(t3, p39, false)

            return
        end

        t3.StateInfo.IsActivelyResimulating = true

        local Origin = v58.Origin
        local v61 = t3.StateInfo.TotalRuntime - v58.StartTime
        local InitialVelocity, Acceleration = v58.InitialVelocity, v58.Acceleration
        local v65 = Vector3.new(Acceleration.X * v61 ^ 2 / 2, Acceleration.Y * v61 ^ 2 / 2, Acceleration.Z * v61 ^ 2 / 2)
        local v66 = Origin + InitialVelocity * v61 + v65
        local _ = InitialVelocity + Acceleration * v61
        local _ = t3.StateInfo.TotalRuntime - v58.StartTime

        t3.StateInfo.TotalRuntime += p39

        local v67 = t3.StateInfo.TotalRuntime - v58.StartTime
        local v71 = Vector3.new(Acceleration.X * v67 ^ 2 / 2, Acceleration.Y * v67 ^ 2 / 2, Acceleration.Z * v67 ^ 2 / 2)
        local v72 = Origin + InitialVelocity * v67 + v71
        local v73 = InitialVelocity + Acceleration * v67
        local v74 = (v72 - v66).Unit * v73.Magnitude * p39
        local v75 = t3.RayInfo.WorldRoot:Raycast(v66, v74, t3.RayInfo.Parameters)

        if v75 ~= nil then
            v72 = v75.Position
        end

        local Magnitude = (v72 - v66).Magnitude

        t3.StateInfo.TotalRuntime -= p39

        local v77 = math.floor(Magnitude / t3.StateInfo.HighFidelitySegmentSize)

        if v77 == 0 then
            v77 = 1
        end

        local v78 = p39 / v77

        for i = 1, v77 do
            if getmetatable(t3) == nil then
                return
            end

            if t3.StateInfo.CancelHighResCast then
                t3.StateInfo.CancelHighResCast = false
                break
            end

            local v79 = "[" .. i .. "] Subcast of time increment " .. v78

            if v1.DebugLogging == true then
                print(v79)
            end

            SimulateCast(t3, v78, true)
        end

        if getmetatable(t3) ~= nil then
            t3.StateInfo.IsActivelyResimulating = false

            if tick() - v59 > 0.08 then
                warn("Extreme cast lag encountered! Consider increasing HighFidelitySegmentSize.")
            end
        end
    end)

    return t3
end

function t1.SetStaticFastCastReference(p40) -- line: 619
    -- upvalues: v1 (ref)
    v1 = p40
end

local function ModifyTransformation(p41, p42, p43, p44) -- line: 625
    -- upvalues: Table (copy), GetTrajectoryInfo (copy)
    local Trajectories = p41.StateInfo.Trajectories
    local v80 = Trajectories[#Trajectories]

    if v80.StartTime == p41.StateInfo.TotalRuntime then
        local v81 = if p42 == nil then v80.InitialVelocity else p42
        local v82 = if p43 == nil then v80.Acceleration else p43

        if p44 ~= nil then
            v80.Origin = p44
        else
            v80.Origin = v80.Origin
        end

        v80.InitialVelocity = v81
        v80.Acceleration = v82
    else
        v80.EndTime = p41.StateInfo.TotalRuntime
        assert(p41.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

        local v85, v86 = unpack((GetTrajectoryInfo(p41, #p41.StateInfo.Trajectories)))

        if p42 ~= nil then
            v86 = p42
        end

        local v87 = if p43 == nil then v80.Acceleration else p43

        if p44 ~= nil then
            v85 = p44
        end

        Table.insert(p41.StateInfo.Trajectories, {
            EndTime = -1,
            StartTime = p41.StateInfo.TotalRuntime,
            Origin = v85,
            InitialVelocity = v86,
            Acceleration = v87
        })
        p41.StateInfo.CancelHighResCast = true
    end
end

function t1.SetVelocity(p45, p46) -- line: 671
    -- upvalues: t1 (copy), ModifyTransformation (copy)
    assert(getmetatable(p45) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("SetVelocity", "ActiveCast.new(...)"))
    assert(p45.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
    ModifyTransformation(p45, p46, nil, nil)
end

function t1.SetAcceleration(p47, p48) -- line: 677
    -- upvalues: t1 (copy), ModifyTransformation (copy)
    assert(getmetatable(p47) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("SetAcceleration", "ActiveCast.new(...)"))
    assert(p47.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
    ModifyTransformation(p47, nil, p48, nil)
end

function t1.SetPosition(p49, p50) -- line: 683
    -- upvalues: t1 (copy), ModifyTransformation (copy)
    assert(getmetatable(p49) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("SetPosition", "ActiveCast.new(...)"))
    assert(p49.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
    ModifyTransformation(p49, nil, nil, p50)
end

function t1.GetVelocity(p51) -- line: 689
    -- upvalues: t1 (copy)
    assert(getmetatable(p51) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("GetVelocity", "ActiveCast.new(...)"))
    assert(p51.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

    local v96 = p51.StateInfo.Trajectories[#p51.StateInfo.Trajectories]
    local v97 = p51.StateInfo.TotalRuntime - v96.StartTime

    return v96.InitialVelocity + v96.Acceleration * v97
end

function t1.GetAcceleration(p52) -- line: 696
    -- upvalues: t1 (copy)
    assert(getmetatable(p52) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("GetAcceleration", "ActiveCast.new(...)"))
    assert(p52.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

    return p52.StateInfo.Trajectories[#p52.StateInfo.Trajectories].Acceleration
end

function t1.GetPosition(p53) -- line: 703
    -- upvalues: t1 (copy)
    assert(getmetatable(p53) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("GetPosition", "ActiveCast.new(...)"))
    assert(p53.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

    local v102 = p53.StateInfo.Trajectories[#p53.StateInfo.Trajectories]
    local v103 = p53.StateInfo.TotalRuntime - v102.StartTime
    local Origin, InitialVelocity, Acceleration = v102.Origin, v102.InitialVelocity, v102.Acceleration
    local v107 = Vector3.new(Acceleration.X * v103 ^ 2 / 2, Acceleration.Y * v103 ^ 2 / 2, Acceleration.Z * v103 ^ 2 / 2)

    return Origin + InitialVelocity * v103 + v107
end

function t1.AddVelocity(p54, p55) -- line: 712
    -- upvalues: t1 (copy)
    assert(getmetatable(p54) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("AddVelocity", "ActiveCast.new(...)"))
    assert(p54.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
    p54:SetVelocity(p54:GetVelocity() + p55)
end

function t1.AddAcceleration(p56, p57) -- line: 718
    -- upvalues: t1 (copy)
    assert(getmetatable(p56) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("AddAcceleration", "ActiveCast.new(...)"))
    assert(p56.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
    p56:SetAcceleration(p56:GetAcceleration() + p57)
end

function t1.AddPosition(p58, p59) -- line: 724
    -- upvalues: t1 (copy)
    assert(getmetatable(p58) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("AddPosition", "ActiveCast.new(...)"))
    assert(p58.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
    p58:SetPosition(p58:GetPosition() + p59)
end

function t1.Pause(p60) -- line: 732
    -- upvalues: t1 (copy)
    assert(getmetatable(p60) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Pause", "ActiveCast.new(...)"))
    assert(p60.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
    p60.StateInfo.Paused = true
end

function t1.Resume(p61) -- line: 738
    -- upvalues: t1 (copy)
    assert(getmetatable(p61) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Resume", "ActiveCast.new(...)"))
    assert(p61.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")
    p61.StateInfo.Paused = false
end

function t1.Terminate(p62) -- line: 744
    -- upvalues: t1 (copy)
    assert(getmetatable(p62) == t1, ("Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"):format("Terminate", "ActiveCast.new(...)"))
    assert(p62.StateInfo.UpdateConnection ~= nil, "This ActiveCast has been terminated. It can no longer be used.")

    local Trajectories = p62.StateInfo.Trajectories

    Trajectories[#Trajectories].EndTime = p62.StateInfo.TotalRuntime
    p62.StateInfo.UpdateConnection:Disconnect()
    p62.Caster.CastTerminating:FireSync(p62)
    p62.StateInfo.UpdateConnection = nil
    p62.Caster = nil
    p62.StateInfo = nil
    p62.RayInfo = nil
    p62.UserData = nil
    setmetatable(p62, nil)
end

return t1
