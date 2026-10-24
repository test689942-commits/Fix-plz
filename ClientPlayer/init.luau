-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local BaseEntity = _G.SubClass("BaseEntity")
local PlayerReplicated = game:GetService("ReplicatedStorage"):WaitForChild("Remote"):WaitForChild("PlayerReplicated")
local GameMgr, UIManager, EventMgr, DataMgr = _G.GameMgr, _G.UIManager, _G.EventMgr, _G.DataMgr
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local New = _G.New
local t1 = {
    1815, 1816
}
local _ = workspace.CurrentCamera

function BaseEntity.new(p1, p2) -- line: 20
    -- upvalues: BaseEntity (copy), EventMgr (copy), LocalPlayer (copy), New (copy)
    p1:Super(LocalPlayer.Character)
    p1.player = LocalPlayer
    p1.data = p2
    p1.Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")
    p1.HumanoidRootPart = LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    p1.HumanoidRootPart.CanCollide = true
    p1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    p1.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    p1.atk = 1
    p1.maxHp = 100
    p1.def = 1
    p1.atkSpeed = 1
    p1.skill_speed = 1
    p1.range = New("Attribute")(5, function(p3, _) -- line: 37
        -- upvalues: p1 (copy)
        p1.OnAttributeChange:Invoke("range", p3)
    end)
    p1.atk_per = 0
    p1.ex_physics = 0
    p1.ex_magic = 0
    p1.ex_physics_per = 0
    p1.ex_magic_per = 0
    p1.add_physics_per = 0
    p1.add_magic_per = 0
    p1.crit = 0
    p1.crit_damage = 0
    p1.hp = 100
    p1.NetMessage = {}
    p1.canMoveCount = 0

    local n1 = 0

    p1.trove:Add(EventMgr:AddEvent("LockPlayer", function(p5) -- line: 62
        -- upvalues: p1 (copy), n1 (ref)
        if p5 then
            if n1 == 0 then
                p1:SetState("action", true)
                p1:CanMove(false)
            end

            n1 += 1
        else
            n1 -= 1

            if n1 == 0 then
                p1:SetState("action", false)
                p1:CanMove(true)
            end
        end
    end))
    p1.HumanoidRootPart.CanCollide = true

    for _, descendant in LocalPlayer.Character:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CollisionGroup = "Player"

            if descendant.Name ~= "HumanoidRootPart" then
                descendant.CanCollide = false
                descendant:GetPropertyChangedSignal("CanCollide"):Connect(function() -- line: 84
                    -- upvalues: descendant (copy)
                    if descendant.CanCollide then
                        descendant.CanCollide = false
                    end
                end)
            end
        end
    end

    p1.eventMgr.Event.Hurt = nil
    p1.eventMgr.Event.Atk = nil
    p1:AddEvent("Atk", function(p6, p7, p8) -- line: 97
        -- upvalues: EventMgr (copy)
        EventMgr:Triger("AtkEntity", p6, p7, p8)
    end)
    p1.trove:Add(LocalPlayer.ChildRemoved:Connect(function() -- line: 101
        -- upvalues: p1 (copy)
        p1:Die()
    end))
    p1.trove:Add(function() -- line: 105
        -- upvalues: p1 (copy), BaseEntity (copy), EventMgr (copy)
        EventMgr:Triger("OnPlayerDestroy", p1)
        BaseEntity.cPlayer = nil
    end)
    p1.Humanoid.Died:Connect(function() -- line: 111
        -- upvalues: p1 (copy)
        p1:Die()
    end)

    for _, child in pairs(script:GetChildren()) do
        local v1 = require(child)

        if v1.Init ~= nil then
            v1.Init(p1)
        end
    end

    BaseEntity.cPlayer = p1
    p1:TrigerEvent("FinishLoad", p1)
    EventMgr:Triger("OnPlayerSpawn", p1)
    task.spawn(function() -- line: 128
        -- upvalues: p1 (copy)
        local function LoadMessage(p9) -- line: 129
            -- upvalues: p1 (copy)
            for _, child in p9:GetChildren() do
                if child:IsA("RemoteEvent") then
                    local Name = child.Name

                    p1.NetMessage[Name] = child
                    child.OnClientEvent:Connect(function(...) -- line: 134
                        -- upvalues: Name (copy), p1 (copy)
                        p1[Name](p1, ...)
                    end)
                end
            end

            p9.ChildAdded:Connect(function(p10) -- line: 139
                -- upvalues: p1 (copy)
                if p10:IsA("RemoteEvent") then
                    local Name = p10.Name

                    p1.NetMessage[Name] = p10
                    p10.OnClientEvent:Connect(function(...) -- line: 143
                        -- upvalues: Name (copy), p1 (copy)
                        p1[Name](p1, ...)
                    end)
                end
            end)
        end

        local NetMessage = p1.Character:FindFirstChild("NetMessage")

        if NetMessage then
            LoadMessage(NetMessage)
        else
            local connection

            connection = p1.Character.ChildAdded:Connect(function(p11) -- line: 154
                -- upvalues: LoadMessage (copy), connection (ref)
                if not p11:IsA("Folder") or p11.Name ~= "NetMessage" then
                    return
                end

                connection:Disconnect()
                LoadMessage(p11)
            end)
        end
    end)
    p1:ReplicatedPlayer("ReplicatedState")
end

function BaseEntity.Hurt(p12, p13, p14) -- line: 165
    -- upvalues: GameMgr (copy), TweenService (copy), t1 (copy)
    p12:TrigerEvent("Hurt", p13, p14)
    GameMgr:ShowEffect("受击特效", p12.HumanoidRootPart.CFrame)
    GameMgr:PlaySound(t1[math.random(#t1)])

    local Highlight = Instance.new("Highlight", p12.Character)

    Highlight.FillTransparency = 1
    Highlight.OutlineTransparency = 1
    TweenService:Create(Highlight, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, true), {
        FillTransparency = 0.7
    }):Play()
    task.delay(0.3, function() -- line: 173
        -- upvalues: Highlight (copy)
        Highlight:Destroy()
    end)
end

function BaseEntity.Die(p15) -- line: 178
    -- upvalues: GameMgr (copy), UIManager (copy), DataMgr (copy), RunService (copy)
    if p15.isDie then
        return
    end

    p15.isDie = true
    p15.OnDestroy:Invoke()
    task.delay(3, function() -- line: 185
        -- upvalues: GameMgr (copy)
        GameMgr:PlayerRespawn(-1)
    end)

    if game.PlaceId ~= DataMgr.GamePlace.Lobby or RunService:IsStudio() then
        UIManager:StackPanel("DeathPanel")
    end

    task.spawn(function() -- line: 191
        -- upvalues: p15 (copy), DataMgr (copy)
        local Animation = Instance.new("Animation")

        Animation.AnimationId = DataMgr:GetConfig("AnimationData", 1020).asset

        local track = p15.Humanoid:LoadAnimation(Animation)

        track.Priority = Enum.AnimationPriority.Action4
        track:Play()
    end)
end

function BaseEntity.Kill(_, _, _, _) -- line: 200
end

function BaseEntity.CanMove(p20, p21) -- line: 206
    if p21 then
        if p20.canMoveCount == 0 then
            return
        end

        p20.canMoveCount -= 1

        if p20.canMoveCount == 0 then
            p20.Humanoid.WalkSpeed = p20.speed()
            p20.Humanoid.JumpPower = 50
            p20.Humanoid.JumpHeight = 7.2
        end

        return {
            Destroy = function() -- Destroy | line: 216
                -- upvalues: p20 (copy), p21 (copy)
                p20:CanMove(not p21)
            end
        }
    end

    if p20.canMoveCount == 0 then
        p20.Humanoid.WalkSpeed = 0
        p20.Humanoid.JumpPower = 0
        p20.Humanoid.JumpHeight = 0
    end

    p20.canMoveCount += 1

    return {
        Destroy = function() -- Destroy | line: 229
            -- upvalues: p20 (copy), p21 (copy)
            p20:CanMove(not p21)
        end
    }
end

function BaseEntity.IfCanMove(p22) -- line: 236
    return p22.canMoveCount == 0
end

function BaseEntity.LoadAnimation(p23, p24) -- line: 238
    local Animation = Instance.new("Animation")

    Animation.AnimationId = "rbxassetid://" .. p24

    return p23.Humanoid:WaitForChild("Animator"):LoadAnimation(Animation), Animation:Destroy()
end

function BaseEntity.SetPosition(p25, p26) -- line: 245
    p25.HumanoidRootPart.CFrame = p26
end

function BaseEntity.AddVelocity(p27, p28) -- line: 250
    for _, child in p27.Character:GetChildren() do
        if child:IsA("BasePart") then
            child.AssemblyLinearVelocity = p28
        end
    end
end

function BaseEntity.ShowEffect(_, p30, ...) -- line: 259
    -- upvalues: GameMgr (copy)
    GameMgr:ShowEffect(p30, ...)
    GameMgr:BroadcastEffect(p30, ...)
end

function BaseEntity.ShowEffectOnlySelf(_, p32, ...) -- line: 265
    -- upvalues: GameMgr (copy)
    GameMgr:ShowEffect(p32, ...)
end

PlayerReplicated.OnClientEvent:Connect(function(p33, ...) -- line: 270
    -- upvalues: BaseEntity (copy)
    if BaseEntity.cPlayer ~= nil then
        BaseEntity.cPlayer[p33](BaseEntity.cPlayer, ...)
    end
end)

function BaseEntity.ReplicatedPlayer(p34, p35, ...) -- line: 278
    -- upvalues: PlayerReplicated (copy)
    if p34.NetMessage[p35] then
        p34.NetMessage[p35]:FireServer(...)
    else
        PlayerReplicated:FireServer(p35, ...)
    end
end

task.defer(function() -- line: 286
    for _, child in pairs(script:GetChildren()) do
        require(child)
    end
end)

return BaseEntity
