-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local t1 = {}

t1.__index = t1

local _, _, _ = _G.GameMgr, _G.DataMgr, _G.EventMgr
local t2 = {}

for _, child in script:GetChildren() do
    t2[child.Name] = child
end

function t1.Load(_, _, _) -- line: 11
end

function t1.Play(p4, p5) -- line: 15
    -- upvalues: t2 (copy)
    local Tool = p5:FindFirstChild("Tool")

    if Tool ~= nil then
        local v1 = Tool:WaitForChild("Handle", 5)

        if v1 ~= nil then
            local v2 = v1:WaitForChild("EffectPart", 5)

            if v2 ~= nil then
                p4.effect = {}

                for v3, _ in Tool:GetAttributes() do
                    if t2[v3] then
                        p4.effect[v3] = {}

                        for _, child in t2[v3]:GetChildren() do
                            local clone = child:Clone()

                            clone.Parent = v2
                            table.insert(p4.effect[v3], clone)
                        end
                    end
                end

                Tool.AttributeChanged:Connect(function(p6) -- line: 40
                    -- upvalues: p4 (copy), Tool (copy), v2 (copy), t2 (copy)
                    print(p6)

                    if t2[p6] ~= nil then
                        if Tool:GetAttribute(p6) ~= nil then
                            if p4.effect[p6] then
                                return
                            end

                            p4.effect[p6] = {}

                            for _, child in t2[p6]:GetChildren() do
                                local clone = child:Clone()

                                clone.Parent = v2
                                table.insert(p4.effect[p6], clone)
                            end
                        elseif p4.effect[p6] then
                            for _, v5 in p4.effect[p6] do
                                v5:Destroy()
                            end
                        end
                    end
                end)
            end
        end
    end
end

function t1.Stop(_) -- line: 66
end

function t1.Destroy(_) -- line: 70
end

return t1
