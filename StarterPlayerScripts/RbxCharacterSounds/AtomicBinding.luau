-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

local function parsePath(p1) -- line: 4
    local v1 = string.split(p1, "/")

    for i = #v1, 1, -1 do
        if v1[i] == "" then
            table.remove(v1, i)
        end
    end

    return v1
end

local function isManifestResolved(p2, p3) -- line: 14
    local n1 = 0

    for _ in pairs(p2) do
        n1 += 1
    end

    assert(n1 <= p3, n1)

    return n1 == p3
end

local function unbindNodeDescend(p4, p5) -- line: 24
    -- upvalues: unbindNodeDescend (copy)
    if p4.instance == nil then
        return
    end

    p4.instance = nil

    local connections = p4.connections

    if connections then
        for _, v3 in ipairs(connections) do
            v3:Disconnect()
        end

        table.clear(connections)
    end

    if p5 and p4.alias then
        p5[p4.alias] = nil
    end

    local children = p4.children

    if children then
        for _, v4 in pairs(children) do
            unbindNodeDescend(v4, p5)
        end
    end
end

local t1 = {}

t1.__index = t1

function t1.new(p6, p7) -- line: 54
    -- upvalues: parsePath (copy), t1 (copy)
    local t2 = {}
    local t3 = {}
    local t4 = {}
    local t5 = {}
    local t6 = {}
    local n2 = 1

    for v5, v6 in pairs(p6) do
        t6[v5] = parsePath(v6)
        n2 += 1
    end

    return (setmetatable({
        _boundFn = p7,
        _parsedManifest = t6,
        _manifestSizeTarget = n2,
        _dtorMap = t2,
        _connections = t3,
        _rootInstToRootNode = t4,
        _rootInstToManifest = t5
    }, t1))
end

function t1._startBoundFn(p8, p9, p10) -- line: 80
    local _boundFn, _dtorMap = p8._boundFn, p8._dtorMap
    local v7 = _dtorMap[p9]

    if v7 then
        v7()
        _dtorMap[p9] = nil
    end

    local v8 = _boundFn(p10)

    if v8 then
        _dtorMap[p9] = v8
    end
end

function t1._stopBoundFn(p11, p12) -- line: 96
    local _dtorMap = p11._dtorMap
    local v9 = _dtorMap[p12]

    if v9 then
        v9()
        _dtorMap[p12] = nil
    end
end

function t1.bindRoot(p13, p14) -- line: 106
    -- upvalues: unbindNodeDescend (copy)
    debug.profilebegin("AtomicBinding:BindRoot")

    local _parsedManifest, _rootInstToRootNode, _rootInstToManifest, _manifestSizeTarget = p13._parsedManifest, p13._rootInstToRootNode, p13._rootInstToManifest, p13._manifestSizeTarget

    assert(_rootInstToManifest[p14] == nil)

    local t8 = {}

    _rootInstToManifest[p14] = t8
    debug.profilebegin("BuildTree")

    local t9 = {
        alias = "root",
        instance = p14
    }

    if next(_parsedManifest) then
        t9.children = {}
        t9.connections = {}
    end

    _rootInstToRootNode[p14] = t9

    for v11, v12 in pairs(_parsedManifest) do
        local v13 = t9

        for v14, v15 in ipairs(v12) do
            local v16 = v14 == #v12
            local v17 = v13.children[v15] or {}

            if v16 then
                if v17.alias ~= nil then
                    error("Multiple aliases assigned to one instance")
                end

                v17.alias = v11
            else
                v17.children = v17.children or {}
                v17.connections = v17.connections or {}
            end

            v13.children[v15] = v17
            v13 = v17
        end
    end

    debug.profileend()

    local function processNode(p15) -- line: 160
        -- upvalues: p13 (copy), p14 (copy), _manifestSizeTarget (copy), t8 (copy), processNode (copy), unbindNodeDescend (copy)
        local v18 = assert(p15.instance)
        local children, alias = p15.children, p15.alias
        local v19 = not children

        if alias then
            t8[alias] = v18
        end

        if v19 then
            local n3 = 0

            for _ in pairs(t8) do
                n3 += 1
            end

            assert(n3 <= _manifestSizeTarget, n3)

            if n3 == _manifestSizeTarget then
                p13:_startBoundFn(p14, t8)
            end
        else
            local function processAddChild(p16) -- line: 172
                -- upvalues: children (copy), processNode (copy)
                local v21 = children[p16.Name]

                if v21 and v21.instance == nil then
                    v21.instance = p16
                    processNode(v21)
                end
            end

            local function processDeleteChild(p17) -- line: 183
                -- upvalues: v18 (copy), children (copy), p13 (copy), p14 (copy), t8 (copy), processNode (copy), unbindNodeDescend (copy)
                local Name = p17.Name
                local v22 = children[Name]

                if not v22 or v22.instance ~= p17 then
                    return
                end

                p13:_stopBoundFn(p14)
                unbindNodeDescend(v22, t8)
                assert(v22.instance == nil)

                local v24 = v18:FindFirstChild(Name)

                if not v24 then
                    return
                end

                local v25 = children[v24.Name]

                if v25 then
                    if v25.instance ~= nil then
                        return
                    end

                    v25.instance = v24
                    processNode(v25)
                end
            end

            for _, child in ipairs(v18:GetChildren()) do
                local v26 = children[child.Name]

                if v26 and v26.instance == nil then
                    v26.instance = child
                    processNode(v26)
                end
            end

            table.insert(p15.connections, v18.ChildAdded:Connect(processAddChild))
            table.insert(p15.connections, v18.ChildRemoved:Connect(processDeleteChild))
        end
    end

    debug.profilebegin("ResolveTree")
    processNode(t9)
    debug.profileend()
    debug.profileend()
end

function t1.unbindRoot(p18, p19) -- line: 236
    -- upvalues: unbindNodeDescend (copy)
    local _rootInstToRootNode, _rootInstToManifest = p18._rootInstToRootNode, p18._rootInstToManifest

    p18:_stopBoundFn(p19)

    local v27 = _rootInstToRootNode[p19]

    if v27 then
        unbindNodeDescend(v27, (assert(_rootInstToManifest[p19])))
        _rootInstToRootNode[p19] = nil
    end

    _rootInstToManifest[p19] = nil
end

function t1.destroy(p20) -- line: 252
    -- upvalues: unbindNodeDescend (copy)
    debug.profilebegin("AtomicBinding:destroy")

    for _, v30 in pairs(p20._dtorMap) do
        v30:destroy()
    end

    table.clear(p20._dtorMap)

    for _, v31 in ipairs(p20._connections) do
        v31:Disconnect()
    end

    table.clear(p20._connections)

    local _rootInstToManifest = p20._rootInstToManifest

    for v32, v33 in pairs(p20._rootInstToRootNode) do
        unbindNodeDescend(v33, (assert(_rootInstToManifest[v32])))
    end

    table.clear(p20._rootInstToManifest)
    table.clear(p20._rootInstToRootNode)
    debug.profileend()
end

return t1
