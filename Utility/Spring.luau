-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert

return {
    new = function(_, p2, p3, p4, p5) -- new | line: 11
        local t1 = {
            Target = Vector3.new(),
            Position = Vector3.new(),
            Velocity = Vector3.new(),
            Mass = p2 or 5,
            Force = p3 or 50,
            Damping = p4 or 4,
            Speed = p5 or 4,
            getstats = function(p6) -- getstats | line: 24
                return p6.Mass, p6.Force, p6.Damping, p6.Speed
            end
        }

        function t1.changestats(p7, p8, p9, p10, p11) -- line: 28
            p7.Mass = p8 or p7.Mass
            p7.Force = p9 or p7.Force
            p7.Damping = p10 or p7.Damping
            p7.Speed = p11 or p7.Speed
        end

        function t1.shove(p12, p13) -- line: 35
            local X, Y, Z = p13.X, p13.Y, p13.Z
            local v1 = if X ~= X or X == 1e999 or X == (-1e999) then 0 else X
            local v3 = if Y ~= Y or Y == 1e999 or Y == (-1e999) then 0 else Y
            local v5 = if Z ~= Z or Z == 1e999 or Z == (-1e999) then 0 else Z

            p12.Velocity += Vector3.new(v1, v3, v5)
        end

        function t1.update(p14, p15) -- line: 49
            local v7 = p15 * p14.Speed / 8

            for _ = 1, 8 do
                local v8 = (p14.Target - p14.Position) * p14.Force / p14.Mass - p14.Velocity * p14.Damping

                p14.Velocity += v8 * v7
                p14.Position += p14.Velocity * v7
            end

            return p14.Position
        end

        return t1
    end
}
