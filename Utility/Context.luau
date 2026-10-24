-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return {
    new = function(p1) -- new | line: 3
        p1.context = {}
    end,
    Start = function(p2, p3) -- Start | line: 7
        p2.context[p3] = true
    end,
    Wait = function(p4, p5) -- Wait | line: 11
        while p4.context[p5] do
            task.wait()
        end
    end,
    Destroy = function(p6, p7) -- Destroy | line: 17
        p6.context[p7] = nil
    end,
    Get = function(p8, p9) -- Get | line: 21
        return p8.context[p9]
    end
}
