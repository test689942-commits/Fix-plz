-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local function v1() -- line: 10
    return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding")
end

local ok, result = pcall(v1)
local v2 = ok and result

local function v3() -- line: 14
    return UserSettings():IsUserFeatureEnabled("UserClickToMoveSupportAgentCanClimb2")
end

local ok2, result2 = pcall(v3)
local v4 = ok2 and result2
local UserInputService = game:GetService("UserInputService")
local PathfindingService = game:GetService("PathfindingService")
local Players = game:GetService("Players")

game:GetService("Debris")

local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")
local GuiService = game:GetService("GuiService")
local v5 = true
local v6 = true
local v7 = false
local n1 = 1
local n2 = 8
local t1 = {
    [Enum.KeyCode.W] = true,
    [Enum.KeyCode.A] = true,
    [Enum.KeyCode.S] = true,
    [Enum.KeyCode.D] = true,
    [Enum.KeyCode.Up] = true,
    [Enum.KeyCode.Down] = true
}
local LocalPlayer = Players.LocalPlayer
local ClickToMoveDisplay = require(script.Parent:WaitForChild("ClickToMoveDisplay"))
local t2 = {}

local function FindCharacterAncestor(p1) -- line: 56
    -- upvalues: FindCharacterAncestor (copy)
    if not p1 then
        return
    end

    local Humanoid = p1:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        return p1, Humanoid
    end

    return FindCharacterAncestor(p1.Parent)
end

t2.FindCharacterAncestor = FindCharacterAncestor

local function Raycast(p2, p3, p4) -- line: 68
    -- upvalues: Workspace (copy), FindCharacterAncestor (copy), Raycast (copy)
    p4 = p4 or {}

    local v9, v10, v11, v12 = Workspace:FindPartOnRayWithIgnoreList(p2, p4)

    if not v9 then
        return nil, nil
    end

    if p3 and v9.CanCollide == false then
        local Humanoid = v9:FindFirstChildOfClass("Humanoid")

        if not Humanoid then
            local v13

            v13, Humanoid = FindCharacterAncestor(v9.Parent)
        end

        if Humanoid == nil then
            table.insert(p4, v9)

            return Raycast(p2, p3, p4)
        end
    end

    return v9, v10, v11, v12
end

t2.Raycast = Raycast

local t3 = {}

local function findPlayerHumanoid(p5) -- line: 89
    -- upvalues: t3 (copy)
    local v14 = p5 and p5.Character

    if not v14 then
        return
    end

    local v15 = t3[p5]

    if v15 and v15.Parent == v14 then
        return v15
    end

    t3[p5] = nil

    local Humanoid = v14:FindFirstChildOfClass("Humanoid")

    if Humanoid then
        t3[p5] = Humanoid
    end

    return Humanoid
end

local t4 = nil
local v16, connection, connection2

local function GetCharacter() -- line: 113
    -- upvalues: LocalPlayer (copy)
    return LocalPlayer and LocalPlayer.Character
end

local function UpdateIgnoreTag(p6) -- line: 117
    -- upvalues: CollectionService (copy), LocalPlayer (copy), t4 (ref), v16 (ref), connection (ref), connection2 (ref)
    if p6 == v16 then
        return
    end

    if connection then
        connection:Disconnect()
        connection = nil
    end

    if connection2 then
        connection2:Disconnect()
        connection2 = nil
    end

    v16 = p6
    t4 = {
        LocalPlayer and LocalPlayer.Character
    }

    if v16 == nil then
        return
    end

    local Tagged = CollectionService:GetTagged(v16)

    for _, v17 in ipairs(Tagged) do
        table.insert(t4, v17)
    end

    connection = CollectionService:GetInstanceAddedSignal(v16):Connect(function(p7) -- line: 137
        -- upvalues: t4 (ref)
        table.insert(t4, p7)
    end)
    connection2 = CollectionService:GetInstanceRemovedSignal(v16):Connect(function(p8) -- line: 141
        -- upvalues: t4 (ref)
        for i = 1, #t4 do
            if t4[i] == p8 then
                t4[i] = t4[#t4]
                table.remove(t4)

                return
            end
        end
    end)
end

local function minV(p9, p10) -- line: 162
    return (Vector3.new(math.min(p9.X, p10.X), math.min(p9.Y, p10.Y), (math.min(p9.Z, p10.Z))))
end

local function maxV(p11, p12) -- line: 165
    return (Vector3.new(math.max(p11.X, p12.X), math.max(p11.Y, p12.Y), (math.max(p11.Z, p12.Z))))
end

local function getCollidableExtentsSize(p13) -- line: 168
    if p13 ~= nil and p13.PrimaryPart ~= nil then
        assert(p13, "")
        assert(p13.PrimaryPart, "")

        local v24 = p13.PrimaryPart.CFrame:Inverse()
        local v25 = Vector3.new(1e999, 1e999, 1e999)
        local v26 = Vector3.new((-1e999), (-1e999), (-1e999))

        for _, descendant in pairs(p13:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.CanCollide then
                local v27 = v24 * descendant.CFrame
                local v31 = Vector3.new(descendant.Size.X / 2, descendant.Size.Y / 2, descendant.Size.Z / 2)
                local t10 = {
                    Vector3.new(v31.X, v31.Y, v31.Z),
                    Vector3.new(v31.X, v31.Y, -v31.Z),
                    Vector3.new(v31.X, -v31.Y, v31.Z),
                    Vector3.new(v31.X, -v31.Y, -v31.Z),
                    Vector3.new(-v31.X, v31.Y, v31.Z),
                    Vector3.new(-v31.X, v31.Y, -v31.Z),
                    Vector3.new(-v31.X, -v31.Y, v31.Z),
                    (Vector3.new(-v31.X, -v31.Y, -v31.Z))
                }

                for _, v53 in ipairs(t10) do
                    local v54 = v27 * v53

                    v25 = Vector3.new(math.min(v25.X, v54.X), math.min(v25.Y, v54.Y), (math.min(v25.Z, v54.Z)))
                    v26 = Vector3.new(math.max(v26.X, v54.X), math.max(v26.Y, v54.Y), (math.max(v26.Z, v54.Z)))
                end
            end
        end

        local v61 = v26 - v25

        return if not (v61.X < 0) and not (v61.Y < 0) and not (v61.Z < 0) then v61 else nil
    end
end

local function Pather(p14, p15, p16) -- line: 203
    -- upvalues: v2 (copy), v4 (copy), PathfindingService (copy), Workspace (copy), v5 (ref), v7 (ref), n1 (ref), n2 (ref), LocalPlayer (copy), ClickToMoveDisplay (copy), t3 (copy), t4 (ref), getCollidableExtentsSize (copy)
    local v62, v63

    if p16 ~= nil then
        v63 = p16
        v62 = p16
    else
        v63 = v7
        v62 = true
    end

    local t11 = {}

    t11.Cancelled = false
    t11.Started = false
    t11.Finished = Instance.new("BindableEvent")
    t11.PathFailed = Instance.new("BindableEvent")
    t11.PathComputing = false
    t11.PathComputed = false
    t11.OriginalTargetPoint = p14
    t11.TargetPoint = p14
    t11.TargetSurfaceNormal = p15
    t11.DiedConn = nil
    t11.SeatedConn = nil
    t11.BlockedConn = nil
    t11.TeleportedConn = nil
    t11.CurrentPoint = 0
    t11.HumanoidOffsetFromPath = Vector3.new(0, 0, 0)
    t11.CurrentWaypointPosition = nil
    t11.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
    t11.CurrentWaypointPlaneDistance = 0
    t11.CurrentWaypointNeedsJump = false
    t11.CurrentHumanoidPosition = Vector3.new(0, 0, 0)
    t11.CurrentHumanoidVelocity = 0
    t11.NextActionMoveDirection = Vector3.new(0, 0, 0)
    t11.NextActionJump = false
    t11.Timeout = 0

    local v64 = LocalPlayer and LocalPlayer.Character
    local v65

    if v64 then
        v65 = t3[LocalPlayer]

        if not v65 or v65.Parent ~= v64 then
            t3[LocalPlayer] = nil

            local Humanoid = v64:FindFirstChildOfClass("Humanoid")

            v65 = Humanoid

            if Humanoid then
                t3[LocalPlayer] = Humanoid
            end
        end
    end

    t11.Humanoid = v65
    t11.OriginPoint = nil
    t11.AgentCanFollowPath = false
    t11.DirectPath = false
    t11.DirectPathRiseFirst = false
    t11.stopTraverseFunc = nil
    t11.setPointFunc = nil
    t11.pointList = nil

    local v66 = t11.Humanoid and t11.Humanoid.RootPart
    local v67 = false
    local v68 = false
    local v69 = false
    local v70 = false
    local v71 = false
    local v72 = false

    if v66 then
        v67 = true
    else
        v72 = true
    end

    local SeatPart

    if v67 then
        t11.OriginPoint = v66.CFrame.Position
        SeatPart = t11.Humanoid.SeatPart

        if SeatPart then
            v68 = true
        else
            v69 = true
        end
    end

    v67 = false

    if v68 then
        if SeatPart:IsA("VehicleSeat") then
            v67 = true
        else
            v69 = true
        end
    end

    v68 = false

    if v69 then
        if v2 then
            v68 = true
        else
            v70 = true
        end
    end

    v69 = false

    local v74

    if v68 then
        if LocalPlayer then
            v69 = true
        else
            v74 = LocalPlayer
            v71 = true
        end
    end

    v68 = false

    if v69 then
        v74 = LocalPlayer.Character
        v71 = true
    end

    v69 = false

    if v71 then
        if v74 ~= nil then
            v69 = true
        else
            v70 = true
        end
    end

    v71 = false

    local v73

    if v69 then
        v73 = getCollidableExtentsSize(v74)
        v70 = true
    end

    v69 = false

    local v75

    if v70 then
        if v73 ~= nil then
            v75 = v73
            v71 = true
        else
            v69 = true
        end
    end

    v70 = false

    local v76

    if v69 then
        if LocalPlayer then
            v70 = true
        else
            v76 = LocalPlayer
            v68 = true
        end
    end

    if v70 then
        v76 = LocalPlayer.Character
        v68 = true
    end

    v70 = false

    if v68 then
        v75 = v76:GetExtentsSize()
        v71 = true
    end

    v68 = false

    local v77, v78

    if v71 then
        assert(v75, "")
        v77 = n1 * 0.5 * math.sqrt(v75.X * v75.X + v75.Z * v75.Z)

        local v81 = n1

        v78 = v81 * v75.Y

        if t11.Humanoid.JumpPower > 0 then
            v70 = true
        else
            v68 = true
        end
    end

    v71 = false

    local v82

    if v68 then
        v82 = false
        v71 = true
    end

    if v70 then
        v82 = true
        v71 = true
    end

    v70 = false

    local v83, v84, v85

    if v71 then
        t11.AgentCanFollowPath = true
        t11.DirectPath = v63
        t11.DirectPathRiseFirst = t11.Humanoid.Sit
        v83 = v77
        v84 = v78
        v85 = v82
        v72 = false
    end

    v71 = false

    local Model

    if v67 then
        Model = SeatPart:FindFirstAncestorOfClass("Model")

        if Model then
            v71 = true
        else
            v83 = 2
            v84 = 5
            v85 = true
            v72 = false
        end
    end

    v67 = false

    local PrimaryPart, v86, v87, v88

    if v71 then
        PrimaryPart = Model.PrimaryPart
        Model.PrimaryPart = SeatPart

        if v62 then
            v67 = true
        else
            v86 = 2
            v87 = 5
            v88 = true
            v70 = true
        end
    end

    if v67 then
        local ExtentsSize = Model:GetExtentsSize()

        v86 = n1 * 0.5 * math.sqrt(ExtentsSize.X * ExtentsSize.X + ExtentsSize.Z * ExtentsSize.Z)

        local v91 = n1

        v87 = v91 * ExtentsSize.Y
        t11.AgentCanFollowPath = true
        v88 = false
        v70 = true
        t11.DirectPath = v62
    end

    if v70 then
        Model.PrimaryPart = PrimaryPart
        v83 = v86
        v84 = v87
        v85 = v88
        v72 = false
    end

    if not v72 then
        t11.pathResult = if v4 then PathfindingService:CreatePath({
            AgentCanClimb = true,
            AgentRadius = v83,
            AgentHeight = v84,
            AgentCanJump = v85
        }) else PathfindingService:CreatePath({
            AgentRadius = v83,
            AgentHeight = v84,
            AgentCanJump = v85
        })
    end

    function t11.Cleanup(_) -- line: 321
        -- upvalues: t11 (copy)
        if t11.stopTraverseFunc then
            t11.stopTraverseFunc()
            t11.stopTraverseFunc = nil
        end

        if t11.BlockedConn then
            t11.BlockedConn:Disconnect()
            t11.BlockedConn = nil
        end

        if t11.DiedConn then
            t11.DiedConn:Disconnect()
            t11.DiedConn = nil
        end

        if t11.SeatedConn then
            t11.SeatedConn:Disconnect()
            t11.SeatedConn = nil
        end

        if t11.TeleportedConn then
            t11.TeleportedConn:Disconnect()
            t11.TeleportedConn = nil
        end

        t11.Started = false
    end

    function t11.Cancel(_) -- line: 350
        -- upvalues: t11 (copy)
        t11.Cancelled = true
        t11:Cleanup()
    end

    function t11.IsActive(_) -- line: 355
        -- upvalues: t11 (copy)
        return t11.AgentCanFollowPath and t11.Started and not t11.Cancelled
    end

    function t11.OnPathInterrupted(_) -- line: 359
        -- upvalues: t11 (copy)
        t11.Cancelled = true
        t11:OnPointReached(false)
    end

    function t11.ComputePath(_) -- line: 365
        -- upvalues: t11 (copy)
        if t11.OriginPoint then
            if t11.PathComputed or t11.PathComputing then
                return
            end

            t11.PathComputing = true

            if t11.AgentCanFollowPath then
                if t11.DirectPath then
                    t11.pointList = {
                        PathWaypoint.new(t11.OriginPoint, Enum.PathWaypointAction.Walk),
                        PathWaypoint.new(t11.TargetPoint, t11.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk)
                    }
                    t11.PathComputed = true
                else
                    t11.pathResult:ComputeAsync(t11.OriginPoint, t11.TargetPoint)
                    t11.pointList = t11.pathResult:GetWaypoints()
                    t11.BlockedConn = t11.pathResult.Blocked:Connect(function(p22) -- line: 379
                        -- upvalues: t11 (copy)
                        t11:OnPathBlocked(p22)
                    end)
                    t11.PathComputed = t11.pathResult.Status == Enum.PathStatus.Success
                end
            end

            t11.PathComputing = false
        end
    end

    function t11.IsValidPath(_) -- line: 387
        -- upvalues: t11 (copy)
        t11:ComputePath()

        return t11.PathComputed and t11.AgentCanFollowPath
    end

    t11.Recomputing = false

    function t11.OnPathBlocked(_, p25) -- line: 393
        -- upvalues: t11 (copy), v5 (ref), ClickToMoveDisplay (copy)
        if not (t11.CurrentPoint <= p25) or t11.Recomputing then
            return
        else
            t11.Recomputing = true

            if t11.stopTraverseFunc then
                t11.stopTraverseFunc()
                t11.stopTraverseFunc = nil
            end
        end

        t11.OriginPoint = t11.Humanoid.RootPart.CFrame.p
        t11.pathResult:ComputeAsync(t11.OriginPoint, t11.TargetPoint)
        t11.pointList = t11.pathResult:GetWaypoints()

        if #t11.pointList > 0 then
            t11.HumanoidOffsetFromPath = t11.pointList[1].Position - t11.OriginPoint
        end

        t11.PathComputed = t11.pathResult.Status == Enum.PathStatus.Success

        if v5 then
            local v94, v95 = ClickToMoveDisplay.CreatePathDisplay(t11.pointList)

            t11.stopTraverseFunc = v94
            t11.setPointFunc = v95
        end

        if t11.PathComputed then
            t11.CurrentPoint = 1
            t11:OnPointReached(true)
        else
            t11.PathFailed:Fire()
            t11:Cleanup()
        end

        t11.Recomputing = false
    end

    function t11.OnRenderStepped(_, p27) -- line: 429
        -- upvalues: t11 (copy), n2 (ref)
        if not t11.Started or t11.Cancelled then
            return
        end

        t11.Timeout += p27

        if t11.Timeout > n2 then
            t11:OnPointReached(false)
        else
            t11.CurrentHumanoidPosition = t11.Humanoid.RootPart.Position + t11.HumanoidOffsetFromPath
            t11.CurrentHumanoidVelocity = t11.Humanoid.RootPart.Velocity

            while t11.Started and t11:IsCurrentWaypointReached() do
                t11:OnPointReached(true)
            end

            if t11.Started then
                t11.NextActionMoveDirection = t11.CurrentWaypointPosition - t11.CurrentHumanoidPosition
                t11.NextActionMoveDirection = if t11.NextActionMoveDirection.Magnitude > 1E-06 then t11.NextActionMoveDirection.Unit else Vector3.new(0, 0, 0)

                if t11.CurrentWaypointNeedsJump then
                    t11.NextActionJump = true
                    t11.CurrentWaypointNeedsJump = false
                else
                    t11.NextActionJump = false
                end
            end
        end
    end

    function t11.IsCurrentWaypointReached(_) -- line: 467
        -- upvalues: t11 (copy)
        local v96 = t11.CurrentWaypointPlaneNormal == Vector3.new(0, 0, 0) or t11.CurrentWaypointPlaneNormal:Dot(t11.CurrentHumanoidPosition) - t11.CurrentWaypointPlaneDistance < math.max(1, 0.0625 * -t11.CurrentWaypointPlaneNormal:Dot(t11.CurrentHumanoidVelocity))

        if v96 then
            t11.CurrentWaypointPosition = nil
            t11.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
            t11.CurrentWaypointPlaneDistance = 0
        end

        return v96
    end

    function t11.OnPointReached(_, p30) -- line: 493
        -- upvalues: t11 (copy)
        if not p30 or t11.Cancelled then
            t11.PathFailed:Fire()
            t11:Cleanup()

            return
        elseif t11.setPointFunc then
            t11.setPointFunc(t11.CurrentPoint)
        end

        local v100 = t11.CurrentPoint + 1

        if #t11.pointList < v100 then
            if t11.stopTraverseFunc then
                t11.stopTraverseFunc()
            end

            t11.Finished:Fire()
            t11:Cleanup()
        else
            local v101 = t11.pointList[t11.CurrentPoint]
            local v102 = t11.pointList[v100]
            local State = t11.Humanoid:GetState()

            if State == Enum.HumanoidStateType.FallingDown or State == Enum.HumanoidStateType.Freefall or State == Enum.HumanoidStateType.Jumping then
                local v103 = v102.Action == Enum.PathWaypointAction.Jump

                if not v103 and t11.CurrentPoint > 1 then
                    local v104 = t11.pointList[t11.CurrentPoint - 1]
                    local v105 = v101.Position - v104.Position
                    local v106 = v102.Position - v101.Position

                    v103 = Vector2.new(v105.x, v105.z).Unit:Dot(Vector2.new(v106.x, v106.z).Unit) < 0.996
                end

                if v103 then
                    t11.Humanoid.FreeFalling:Wait()
                    wait(0.1)
                end
            end

            t11:MoveToNextWayPoint(v101, v102, v100)
        end
    end

    function t11.MoveToNextWayPoint(_, p32, p33, p34) -- line: 556
        -- upvalues: t11 (copy), v4 (copy)
        t11.CurrentWaypointPlaneNormal = p32.Position - p33.Position

        if not v4 or p33.Label ~= "Climb" then
            t11.CurrentWaypointPlaneNormal = Vector3.new(t11.CurrentWaypointPlaneNormal.X, 0, t11.CurrentWaypointPlaneNormal.Z)
        end

        if t11.CurrentWaypointPlaneNormal.Magnitude > 1E-06 then
            t11.CurrentWaypointPlaneNormal = t11.CurrentWaypointPlaneNormal.Unit
            t11.CurrentWaypointPlaneDistance = t11.CurrentWaypointPlaneNormal:Dot(p33.Position)
        else
            t11.CurrentWaypointPlaneNormal = Vector3.new(0, 0, 0)
            t11.CurrentWaypointPlaneDistance = 0
        end

        t11.CurrentWaypointNeedsJump = p33.Action == Enum.PathWaypointAction.Jump
        t11.CurrentWaypointPosition = p33.Position
        t11.CurrentPoint = p34
        t11.Timeout = 0
    end

    function t11.Start(_, p36) -- line: 588
        -- upvalues: t11 (copy), v5 (ref), ClickToMoveDisplay (copy)
        if not t11.AgentCanFollowPath then
            t11.PathFailed:Fire()

            return
        end

        if not t11.Started then
            t11.Started = true
            ClickToMoveDisplay.CancelFailureAnimation()

            if v5 and (p36 == nil or p36) then
                local v107, v108 = ClickToMoveDisplay.CreatePathDisplay(t11.pointList, t11.OriginalTargetPoint)

                t11.stopTraverseFunc = v107
                t11.setPointFunc = v108
            end

            if #t11.pointList > 0 then
                t11.HumanoidOffsetFromPath = Vector3.new(0, t11.pointList[1].Position.Y - t11.OriginPoint.Y, 0)
                t11.CurrentHumanoidPosition = t11.Humanoid.RootPart.Position + t11.HumanoidOffsetFromPath
                t11.CurrentHumanoidVelocity = t11.Humanoid.RootPart.Velocity
                t11.SeatedConn = t11.Humanoid.Seated:Connect(function(_, _) -- line: 615
                    -- upvalues: t11 (copy)
                    t11:OnPathInterrupted()
                end)
                t11.DiedConn = t11.Humanoid.Died:Connect(function() -- line: 616
                    -- upvalues: t11 (copy)
                    t11:OnPathInterrupted()
                end)
                t11.TeleportedConn = t11.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(function() -- line: 617
                    -- upvalues: t11 (copy)
                    t11:OnPathInterrupted()
                end)
                t11.CurrentPoint = 1
                t11:OnPointReached(true)
            else
                t11.PathFailed:Fire()

                if t11.stopTraverseFunc then
                    t11.stopTraverseFunc()
                end
            end
        end
    end

    local v110 = t11.TargetPoint + t11.TargetSurfaceNormal * 1.5
    local v111 = Ray.new(v110, (Vector3.new(0, -50, 0)))

    if not t4 then
        t4 = {}

        local t12 = t4

        table.insert(t12, LocalPlayer and LocalPlayer.Character)
    end

    local t13 = t4
    local v113, v114 = Workspace:FindPartOnRayWithIgnoreList(v111, t13)

    if v113 then
        t11.TargetPoint = v114
    end

    t11:ComputePath()

    return t11
end

local function CheckAlive() -- line: 644
    -- upvalues: LocalPlayer (copy), t3 (copy)
    local v115 = LocalPlayer and LocalPlayer.Character
    local v116

    if v115 then
        v116 = t3[LocalPlayer]

        if not v116 or v116.Parent ~= v115 then
            t3[LocalPlayer] = nil

            local Humanoid = v115:FindFirstChildOfClass("Humanoid")

            v116 = Humanoid

            if Humanoid then
                t3[LocalPlayer] = Humanoid
            end
        end
    end

    return v116 ~= nil and v116.Health > 0
end

local function GetEquippedTool(p39) -- line: 649
    if p39 == nil then
        return
    end

    for _, child in pairs(p39:GetChildren()) do
        if child:IsA("Tool") then
            return child
        end
    end
end

local v117, connection3, connection4

local function CleanupPath() -- line: 664
    -- upvalues: v117 (ref), connection3 (ref), connection4 (ref)
    if v117 then
        v117:Cancel()
        v117 = nil
    end

    if connection3 then
        connection3:Disconnect()
        connection3 = nil
    end

    if connection4 then
        connection4:Disconnect()
        connection4 = nil
    end
end

local function HandleMoveTo(p40, p41, p42, p43, p44) -- line: 682
    -- upvalues: v6 (ref), ClickToMoveDisplay (copy), GetEquippedTool (copy), v117 (ref), connection3 (ref), connection4 (ref)
    if v117 then
        v117:Cancel()
        v117 = nil

        if connection3 then
            connection3:Disconnect()
            connection3 = nil
        end

        if connection4 then
            connection4:Disconnect()
            connection4 = nil
        end
    end

    v117 = p40
    p40:Start(p44)
    connection3 = p40.Finished.Event:Connect(function() -- line: 689
        -- upvalues: p42 (copy), p43 (copy), GetEquippedTool (copy), v117 (ref), connection3 (ref), connection4 (ref)
        if v117 then
            v117:Cancel()
            v117 = nil
        end

        if connection3 then
            connection3:Disconnect()
            connection3 = nil
        end

        if connection4 then
            connection4:Disconnect()
            connection4 = nil
        end

        if p42 then
            local v118 = GetEquippedTool(p43)

            if v118 then
                v118:Activate()
            end
        end
    end)
    connection4 = p40.PathFailed.Event:Connect(function() -- line: 698
        -- upvalues: p41 (copy), p44 (copy), v6 (ref), ClickToMoveDisplay (copy), v117 (ref), connection3 (ref), connection4 (ref)
        if v117 then
            v117:Cancel()
            v117 = nil
        end

        if connection3 then
            connection3:Disconnect()
            connection3 = nil
        end

        if connection4 then
            connection4:Disconnect()
            connection4 = nil
        end

        if p44 == nil or p44 then
            if v6 and not (v117 and v117:IsActive()) then
                ClickToMoveDisplay.PlayFailureAnimation()
            end

            ClickToMoveDisplay.DisplayFailureWaypoint(p41)
        end
    end)
end

local function ShowPathFailedFeedback(p45) -- line: 710
    -- upvalues: v6 (ref), ClickToMoveDisplay (copy), v117 (ref)
    if v117 and v117:IsActive() then
        v117:Cancel()
    end

    if v6 then
        ClickToMoveDisplay.PlayFailureAnimation()
    end

    ClickToMoveDisplay.DisplayFailureWaypoint(p45)
end

function OnTap(p46, p47, p48) -- line: 720
    -- upvalues: Players (copy), StarterGui (copy), Workspace (copy), v6 (ref), LocalPlayer (copy), ClickToMoveDisplay (copy), t2 (copy), t3 (copy), t4 (ref), Pather (copy), GetEquippedTool (copy), v117 (ref), connection3 (ref), connection4 (ref), HandleMoveTo (copy)
    local CurrentCamera = Workspace.CurrentCamera
    local Character = LocalPlayer.Character
    local v119 = LocalPlayer and LocalPlayer.Character
    local v120

    if v119 then
        v120 = t3[LocalPlayer]

        if not v120 or v120.Parent ~= v119 then
            t3[LocalPlayer] = nil

            local Humanoid = v119:FindFirstChildOfClass("Humanoid")

            v120 = Humanoid

            if Humanoid then
                t3[LocalPlayer] = Humanoid
            end
        end
    end

    if v120 ~= nil and v120.Health > 0 then
        if #p46 == 1 or p47 then
            if CurrentCamera then
                local v121 = CurrentCamera:ScreenPointToRay(p46[1].X, p46[1].Y)
                local v122 = Ray.new(v121.Origin, v121.Direction * 1000)
                local v123 = LocalPlayer and LocalPlayer.Character

                if v123 then
                    local v124 = t3[LocalPlayer]

                    if not v124 or v124.Parent ~= v123 then
                        t3[LocalPlayer] = nil

                        local Humanoid = v123:FindFirstChildOfClass("Humanoid")

                        if Humanoid then
                            t3[LocalPlayer] = Humanoid
                        end
                    end
                end

                local Raycast = t2.Raycast

                if not t4 then
                    t4 = {}

                    local t14 = t4

                    table.insert(t14, LocalPlayer and LocalPlayer.Character)
                end

                local v126, v127, v128 = Raycast(v122, true, t4)
                local v129, v130 = t2.FindCharacterAncestor(v126)

                if p48 and v130 and StarterGui:GetCore("AvatarContextMenuEnabled") and Players:GetPlayerFromCharacter(v130.Parent) then
                    if v117 then
                        v117:Cancel()
                        v117 = nil
                    end

                    if connection3 then
                        connection3:Disconnect()
                        connection3 = nil
                    end

                    if connection4 then
                        connection4:Disconnect()
                        connection4 = nil
                    end
                else
                    if p47 then
                        v127 = p47
                        v129 = nil
                    end

                    if v127 and Character then
                        if v117 then
                            v117:Cancel()
                            v117 = nil
                        end

                        if connection3 then
                            connection3:Disconnect()
                            connection3 = nil
                        end

                        if connection4 then
                            connection4:Disconnect()
                            connection4 = nil
                        end

                        local v131 = Pather(v127, v128)

                        if v131:IsValidPath() then
                            HandleMoveTo(v131, v127, v129, Character)
                        else
                            v131:Cleanup()

                            if v117 and v117:IsActive() then
                                v117:Cancel()
                            end

                            if v6 then
                                ClickToMoveDisplay.PlayFailureAnimation()
                            end

                            ClickToMoveDisplay.DisplayFailureWaypoint(v127)
                        end
                    end
                end
            end
        elseif #p46 >= 2 and CurrentCamera then
            local v132 = GetEquippedTool(Character)

            if v132 then
                v132:Activate()
            end
        end
    end
end

local function DisconnectEvent(p49) -- line: 773
    if p49 then
        p49:Disconnect()
    end
end

local Keyboard = require(script.Parent:WaitForChild("Keyboard"))
local self = setmetatable({}, Keyboard)

self.__index = self

function self.new(p50) -- line: 784
    -- upvalues: Keyboard (copy), self (copy)
    local v135 = setmetatable(Keyboard.new(p50), self)

    v135.fingerTouches = {}
    v135.numUnsunkTouches = 0
    v135.mouse1Down = tick()
    v135.mouse1DownPos = Vector2.new()
    v135.mouse2DownTime = tick()
    v135.mouse2DownPos = Vector2.new()
    v135.mouse2UpTime = tick()
    v135.keyboardMoveVector = Vector3.new(0, 0, 0)
    v135.tapConn = nil
    v135.inputBeganConn = nil
    v135.inputChangedConn = nil
    v135.inputEndedConn = nil
    v135.humanoidDiedConn = nil
    v135.characterChildAddedConn = nil
    v135.onCharacterAddedConn = nil
    v135.characterChildRemovedConn = nil
    v135.renderSteppedConn = nil
    v135.menuOpenedConnection = nil
    v135.running = false
    v135.wasdEnabled = false

    return v135
end

function self.DisconnectEvents(p51) -- line: 816
    local tapConn = p51.tapConn

    if tapConn then
        tapConn:Disconnect()
    end

    local inputBeganConn = p51.inputBeganConn

    if inputBeganConn then
        inputBeganConn:Disconnect()
    end

    local inputChangedConn = p51.inputChangedConn

    if inputChangedConn then
        inputChangedConn:Disconnect()
    end

    local inputEndedConn = p51.inputEndedConn

    if inputEndedConn then
        inputEndedConn:Disconnect()
    end

    local humanoidDiedConn = p51.humanoidDiedConn

    if humanoidDiedConn then
        humanoidDiedConn:Disconnect()
    end

    local characterChildAddedConn = p51.characterChildAddedConn

    if characterChildAddedConn then
        characterChildAddedConn:Disconnect()
    end

    local onCharacterAddedConn = p51.onCharacterAddedConn

    if onCharacterAddedConn then
        onCharacterAddedConn:Disconnect()
    end

    local renderSteppedConn = p51.renderSteppedConn

    if renderSteppedConn then
        renderSteppedConn:Disconnect()
    end

    local characterChildRemovedConn = p51.characterChildRemovedConn

    if characterChildRemovedConn then
        characterChildRemovedConn:Disconnect()
    end

    local menuOpenedConnection = p51.menuOpenedConnection

    if menuOpenedConnection then
        menuOpenedConnection:Disconnect()
    end
end

function self.OnTouchBegan(p52, p53, p54) -- line: 829
    if p52.fingerTouches[p53] == nil and not p54 then
        p52.numUnsunkTouches += 1
    end

    p52.fingerTouches[p53] = p54
end

function self.OnTouchChanged(p55, p56, p57) -- line: 836
    if p55.fingerTouches[p56] == nil then
        p55.fingerTouches[p56] = p57

        if not p57 then
            p55.numUnsunkTouches += 1
        end
    end
end

function self.OnTouchEnded(p58, p59, _) -- line: 845
    if p58.fingerTouches[p59] ~= nil and p58.fingerTouches[p59] == false then
        p58.numUnsunkTouches -= 1
    end

    p58.fingerTouches[p59] = nil
end

function self.OnCharacterAdded(p61, p62) -- line: 853
    -- upvalues: UserInputService (copy), GuiService (copy), t1 (copy), ClickToMoveDisplay (copy), v117 (ref), connection3 (ref), connection4 (ref)
    p61:DisconnectEvents()
    p61.inputBeganConn = UserInputService.InputBegan:Connect(function(p63, p64) -- line: 856
        -- upvalues: p61 (copy), t1 (copy), ClickToMoveDisplay (copy), v117 (ref), connection3 (ref), connection4 (ref)
        if p63.UserInputType == Enum.UserInputType.Touch then
            p61:OnTouchBegan(p63, p64)
        end

        if p61.wasdEnabled and p64 == false and p63.UserInputType == Enum.UserInputType.Keyboard and t1[p63.KeyCode] then
            if v117 then
                v117:Cancel()
                v117 = nil
            end

            if connection3 then
                connection3:Disconnect()
                connection3 = nil
            end

            if connection4 then
                connection4:Disconnect()
                connection4 = nil
            end

            ClickToMoveDisplay.CancelFailureAnimation()
        end

        if p63.UserInputType == Enum.UserInputType.MouseButton1 then
            p61.mouse1DownTime = tick()
            p61.mouse1DownPos = p63.Position
        end

        if p63.UserInputType == Enum.UserInputType.MouseButton2 then
            p61.mouse2DownTime = tick()
            p61.mouse2DownPos = p63.Position
        end
    end)
    p61.inputChangedConn = UserInputService.InputChanged:Connect(function(p65, p66) -- line: 877
        -- upvalues: p61 (copy)
        if p65.UserInputType == Enum.UserInputType.Touch then
            p61:OnTouchChanged(p65, p66)
        end
    end)
    p61.inputEndedConn = UserInputService.InputEnded:Connect(function(p67, p68) -- line: 883
        -- upvalues: p61 (copy), v117 (ref)
        if p67.UserInputType == Enum.UserInputType.Touch then
            p61:OnTouchEnded(p67, p68)
        end

        if p67.UserInputType ~= Enum.UserInputType.MouseButton2 then
            return
        end

        p61.mouse2UpTime = tick()

        local Position = p67.Position
        local v136 = v117 or p61.keyboardMoveVector.Magnitude <= 0

        if p61.mouse2UpTime - p61.mouse2DownTime < 0.25 and (Position - p61.mouse2DownPos).magnitude < 5 and v136 then
            local t16 = {
                Position
            }

            OnTap(t16)
        end
    end)
    p61.tapConn = UserInputService.TouchTap:Connect(function(p69, p70) -- line: 900
        if not p70 then
            OnTap(p69, nil, true)
        end
    end)
    p61.menuOpenedConnection = GuiService.MenuOpened:Connect(function() -- line: 906
        -- upvalues: v117 (ref), connection3 (ref), connection4 (ref)
        if v117 then
            v117:Cancel()
            v117 = nil
        end

        if connection3 then
            connection3:Disconnect()
            connection3 = nil
        end

        if connection4 then
            connection4:Disconnect()
            connection4 = nil
        end
    end)

    local function OnCharacterChildAdded(p71) -- line: 910
        -- upvalues: p61 (copy), UserInputService (copy)
        if UserInputService.TouchEnabled and p71:IsA("Tool") then
            p71.ManualActivationOnly = true
        end

        if p71:IsA("Humanoid") then
            local humanoidDiedConn = p61.humanoidDiedConn

            if humanoidDiedConn then
                humanoidDiedConn:Disconnect()
            end

            p61.humanoidDiedConn = p71.Died:Connect(function() -- line: 918
            end)
        end
    end

    p61.characterChildAddedConn = p62.ChildAdded:Connect(function(p72) -- line: 926
        -- upvalues: OnCharacterChildAdded (copy)
        OnCharacterChildAdded(p72)
    end)
    p61.characterChildRemovedConn = p62.ChildRemoved:Connect(function(p73) -- line: 929
        -- upvalues: UserInputService (copy)
        if UserInputService.TouchEnabled and p73:IsA("Tool") then
            p73.ManualActivationOnly = false
        end
    end)

    for _, child in pairs(p62:GetChildren()) do
        OnCharacterChildAdded(child)
    end
end

function self.Start(p74) -- line: 941
    p74:Enable(true)
end

function self.Stop(p75) -- line: 945
    p75:Enable(false)
end

function self.CleanupPath(_) -- line: 949
    -- upvalues: v117 (ref), connection3 (ref), connection4 (ref)
    if v117 then
        v117:Cancel()
        v117 = nil
    end

    if connection3 then
        connection3:Disconnect()
        connection3 = nil
    end

    if connection4 then
        connection4:Disconnect()
        connection4 = nil
    end
end

function self.Enable(p77, p78, p79, p80) -- line: 953
    -- upvalues: UserInputService (copy), LocalPlayer (copy), v117 (ref), connection3 (ref), connection4 (ref)
    if p78 then
        if not p77.running then
            if LocalPlayer.Character then
                p77:OnCharacterAdded(LocalPlayer.Character)
            end

            p77.onCharacterAddedConn = LocalPlayer.CharacterAdded:Connect(function(p81) -- line: 959
                -- upvalues: p77 (copy)
                p77:OnCharacterAdded(p81)
            end)
            p77.running = true
        end

        p77.touchJumpController = p80

        if p77.touchJumpController then
            p77.touchJumpController:Enable(p77.jumpEnabled)
        end
    else
        if p77.running then
            p77:DisconnectEvents()

            if v117 then
                v117:Cancel()
                v117 = nil
            end

            if connection3 then
                connection3:Disconnect()
                connection3 = nil
            end

            if connection4 then
                connection4:Disconnect()
                connection4 = nil
            end

            if UserInputService.TouchEnabled then
                local Character = LocalPlayer.Character

                if Character then
                    for _, child in pairs(Character:GetChildren()) do
                        if child:IsA("Tool") then
                            child.ManualActivationOnly = false
                        end
                    end
                end
            end

            p77.running = false
        end

        if p77.touchJumpController and not p77.jumpEnabled then
            p77.touchJumpController:Enable(true)
        end

        p77.touchJumpController = nil
    end

    if UserInputService.KeyboardEnabled and p78 ~= p77.enabled then
        p77.forwardValue = 0
        p77.backwardValue = 0
        p77.leftValue = 0
        p77.rightValue = 0
        p77.moveVector = Vector3.new(0, 0, 0)

        if p78 then
            p77:BindContextActions()
            p77:ConnectFocusEventListeners()
        else
            p77:UnbindContextActions()
            p77:DisconnectFocusEventListeners()
        end
    end

    p77.wasdEnabled = not not (p78 and p79) and p79
    p77.enabled = p78
end

function self.OnRenderStepped(p82, p83) -- line: 1014
    -- upvalues: v117 (ref)
    p82.isJumping = false

    if v117 then
        v117:OnRenderStepped(p83)

        if v117 then
            p82.moveVector = v117.NextActionMoveDirection
            p82.moveVectorIsCameraRelative = false

            if v117.NextActionJump then
                p82.isJumping = true
            end
        else
            p82.moveVector = p82.keyboardMoveVector
            p82.moveVectorIsCameraRelative = true
        end
    else
        p82.moveVector = p82.keyboardMoveVector
        p82.moveVectorIsCameraRelative = true
    end

    if p82.jumpRequested then
        p82.isJumping = true
    end
end

function self.UpdateMovement(p84, p85) -- line: 1049
    if p85 == Enum.UserInputState.Cancel then
        p84.keyboardMoveVector = Vector3.new(0, 0, 0)
    elseif p84.wasdEnabled then
        p84.keyboardMoveVector = Vector3.new(p84.leftValue + p84.rightValue, 0, p84.forwardValue + p84.backwardValue)
    end
end

function self.UpdateJump(_) -- line: 1058
end

function self.SetShowPath(_, p88) -- line: 1063
    -- upvalues: v5 (ref)
    v5 = p88
end

function self.GetShowPath(_) -- line: 1067
    -- upvalues: v5 (ref)
    return v5
end

function self.SetWaypointTexture(_, p91) -- line: 1071
    -- upvalues: ClickToMoveDisplay (copy)
    ClickToMoveDisplay.SetWaypointTexture(p91)
end

function self.GetWaypointTexture(_) -- line: 1075
    -- upvalues: ClickToMoveDisplay (copy)
    return ClickToMoveDisplay.GetWaypointTexture()
end

function self.SetWaypointRadius(_, p94) -- line: 1079
    -- upvalues: ClickToMoveDisplay (copy)
    ClickToMoveDisplay.SetWaypointRadius(p94)
end

function self.GetWaypointRadius(_) -- line: 1083
    -- upvalues: ClickToMoveDisplay (copy)
    return ClickToMoveDisplay.GetWaypointRadius()
end

function self.SetEndWaypointTexture(_, p97) -- line: 1087
    -- upvalues: ClickToMoveDisplay (copy)
    ClickToMoveDisplay.SetEndWaypointTexture(p97)
end

function self.GetEndWaypointTexture(_) -- line: 1091
    -- upvalues: ClickToMoveDisplay (copy)
    return ClickToMoveDisplay.GetEndWaypointTexture()
end

function self.SetWaypointsAlwaysOnTop(_, p100) -- line: 1095
    -- upvalues: ClickToMoveDisplay (copy)
    ClickToMoveDisplay.SetWaypointsAlwaysOnTop(p100)
end

function self.GetWaypointsAlwaysOnTop(_) -- line: 1099
    -- upvalues: ClickToMoveDisplay (copy)
    return ClickToMoveDisplay.GetWaypointsAlwaysOnTop()
end

function self.SetFailureAnimationEnabled(_, p103) -- line: 1103
    -- upvalues: v6 (ref)
    v6 = p103
end

function self.GetFailureAnimationEnabled(_) -- line: 1107
    -- upvalues: v6 (ref)
    return v6
end

function self.SetIgnoredPartsTag(_, p106) -- line: 1111
    -- upvalues: UpdateIgnoreTag (copy)
    UpdateIgnoreTag(p106)
end

function self.GetIgnoredPartsTag(_) -- line: 1115
    -- upvalues: v16 (ref)
    return v16
end

function self.SetUseDirectPath(_, p109) -- line: 1119
    -- upvalues: v7 (ref)
    v7 = p109
end

function self.GetUseDirectPath(_) -- line: 1123
    -- upvalues: v7 (ref)
    return v7
end

function self.SetAgentSizeIncreaseFactor(_, p112) -- line: 1127
    -- upvalues: n1 (ref)
    n1 = p112 / 100 + 1
end

function self.GetAgentSizeIncreaseFactor(_) -- line: 1131
    -- upvalues: n1 (ref)
    return (n1 - 1) * 100
end

function self.SetUnreachableWaypointTimeout(_, p115) -- line: 1135
    -- upvalues: n2 (ref)
    n2 = p115
end

function self.GetUnreachableWaypointTimeout(_) -- line: 1139
    -- upvalues: n2 (ref)
    return n2
end

function self.SetUserJumpEnabled(p117, p118) -- line: 1143
    p117.jumpEnabled = p118

    if p117.touchJumpController then
        p117.touchJumpController:Enable(p118)
    end
end

function self.GetUserJumpEnabled(p119) -- line: 1150
    return p119.jumpEnabled
end

function self.MoveTo(_, p121, p122, p123) -- line: 1154
    -- upvalues: LocalPlayer (copy), Pather (copy), HandleMoveTo (copy)
    local Character = LocalPlayer.Character

    if Character == nil then
        return false
    end

    local v140 = Pather(p121, Vector3.new(0, 1, 0), p123)

    if v140 and v140:IsValidPath() then
        HandleMoveTo(v140, p121, nil, Character, p122)

        return true
    end

    return false
end

return self
