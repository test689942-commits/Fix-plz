-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local BaseManager = require(game:GetService("ReplicatedFirst"):WaitForChild("Scripts").BaseManager)
local NetMgr = BaseManager:GetManager("NetMgr")
local EventMgr = BaseManager:GetManager("EventMgr")
local DataMgr = BaseManager:GetManager("DataMgr")
local GameMgr = BaseManager:GetManager("GameMgr")
local UIManager = BaseManager:GetManager("UIManager")
local InputMgr = BaseManager:GetManager("InputMgr")
local PoolMgr = BaseManager:GetManager("PoolMgr")
local _ = _G.New

NetMgr:SetClientEventSignal("LoadSuccess", function() -- line: 13
    -- upvalues: GameMgr (copy)
    print("success")
    GameMgr.FinishLoad = true
end)
task.spawn(function() -- line: 17
    -- upvalues: NetMgr (copy), GameMgr (copy)
    local n1 = 0

    while not GameMgr.FinishLoad do
        task.wait(0.1)
        n1 += 0.1

        if n1 > 5 then
            n1 = 0
            GameMgr.FinishLoad = NetMgr:InvokeServer("LoadSuccess")
        end
    end
end)

local LoadSuccess = NetMgr:InvokeServer("LoadSuccess")

GameMgr.FinishLoad = if GameMgr.FinishLoad then true else LoadSuccess
GameMgr:WaitLoad()
NetMgr:Init()
EventMgr:Init()
DataMgr:Init()
GameMgr:Init()
UIManager:Init()
InputMgr:Init()
PoolMgr:Init()
EventMgr:Triger("ManagerLoadFinish")
BaseManager.isFinish = true
_G.FinishLoad = true
GameMgr:StartGame()
EventMgr:Triger("LoadSuccess")
NetMgr:FireServer("LoadSuccess")
