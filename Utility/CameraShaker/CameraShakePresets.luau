-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=1461025953

-- ! Source from the asset above; the game may have edited it since.

--[=[
-- Camera Shake Presets
-- Stephen Leitnick
-- February 26, 2018

--[[
	
	CameraShakePresets.Bump
	CameraShakePresets.Explosion
	CameraShakePresets.Earthquake
	CameraShakePresets.BadTrip
	CameraShakePresets.HandheldCamera
	CameraShakePresets.Vibration
	CameraShakePresets.RoughDriving
	
--]]



local CameraShakeInstance = require(script.Parent.CameraShakeInstance)

local CameraShakePresets = {
	
	
	-- A high-magnitude, short, yet smooth shake.
	-- Should happen once.
	Bump = function()
		local c = CameraShakeInstance.new(2.5, 4, 0.1, 0.75)
		c.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
		c.RotationInfluence = Vector3.new(1, 1, 1)
		return c
	end;
	
	
	-- An intense and rough shake.
	-- Should happen once.
	Explosion = function()
		local c = CameraShakeInstance.new(5, 10, 0, 1.5)
		c.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		c.RotationInfluence = Vector3.new(4, 1, 1)
		return c
	end;
	
	
	-- A continuous, rough shake
	-- Sustained.
	Earthquake = function()
		local c = CameraShakeInstance.new(0.6, 3.5, 2, 10)
		c.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
		c.RotationInfluence = Vector3.new(1, 1, 4)
		return c
	end;
	
	
	-- A bizarre shake with a very high magnitude and low roughness.
	-- Sustained.
	BadTrip = function()
		local c = CameraShakeInstance.new(10, 0.15, 5, 10)
		c.PositionInfluence = Vector3.new(0, 0, 0.15)
		c.RotationInfluence = Vector3.new(2, 1, 4)
		return c
	end;
	
	
	-- A subtle, slow shake.
	-- Sustained.
	HandheldCamera = function()
		local c = CameraShakeInstance.new(1, 0.25, 5, 10)
		c.PositionInfluence = Vector3.new(0, 0, 0)
		c.RotationInfluence = Vector3.new(1, 0.5, 0.5)
		return c
	end;
	
	
	-- A very rough, yet low magnitude shake.
	-- Sustained.
	Vibration = function()
		local c = CameraShakeInstance.new(0.4, 20, 2, 2)
		c.PositionInfluence = Vector3.new(0, 0.15, 0)
		c.RotationInfluence = Vector3.new(1.25, 0, 4)
		return c
	end;
	
	
	-- A slightly rough, medium magnitude shake.
	-- Sustained.
	RoughDriving = function()
		local c = CameraShakeInstance.new(1, 2, 1, 1)
		c.PositionInfluence = Vector3.new(0, 0, 0)
		c.RotationInfluence = Vector3.new(1, 1, 1)
		return c
	end;
	
	
}


return setmetatable({}, {
	__index = function(t, i)
		local f = CameraShakePresets[i]
		if (type(f) == "function") then
			return f()
		end
		error("No preset found with index \"" .. i .. "\"")
	end;
})
]=]

-- https://lua.expert

local CameraShakeInstance = require(script.Parent.CameraShakeInstance)
local t1 = {
    Bump = function() -- Bump | line: 26
        -- upvalues: CameraShakeInstance (copy)
        local v1 = CameraShakeInstance.new(2.5, 4, 0.1, 0.75)

        v1.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
        v1.RotationInfluence = Vector3.new(1, 1, 1)

        return v1
    end,
    Explosion = function() -- Explosion | line: 36
        -- upvalues: CameraShakeInstance (copy)
        local v2 = CameraShakeInstance.new(5, 10, 0, 1.5)

        v2.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        v2.RotationInfluence = Vector3.new(4, 1, 1)

        return v2
    end,
    Earthquake = function() -- Earthquake | line: 46
        -- upvalues: CameraShakeInstance (copy)
        local v3 = CameraShakeInstance.new(0.6, 3.5, 2, 10)

        v3.PositionInfluence = Vector3.new(0.25, 0.25, 0.25)
        v3.RotationInfluence = Vector3.new(1, 1, 4)

        return v3
    end,
    BadTrip = function() -- BadTrip | line: 56
        -- upvalues: CameraShakeInstance (copy)
        local v4 = CameraShakeInstance.new(10, 0.15, 5, 10)

        v4.PositionInfluence = Vector3.new(0, 0, 0.15)
        v4.RotationInfluence = Vector3.new(2, 1, 4)

        return v4
    end,
    HandheldCamera = function() -- HandheldCamera | line: 66
        -- upvalues: CameraShakeInstance (copy)
        local v5 = CameraShakeInstance.new(1, 0.25, 5, 10)

        v5.PositionInfluence = Vector3.new(0, 0, 0)
        v5.RotationInfluence = Vector3.new(1, 0.5, 0.5)

        return v5
    end,
    Vibration = function() -- Vibration | line: 76
        -- upvalues: CameraShakeInstance (copy)
        local v6 = CameraShakeInstance.new(0.4, 20, 2, 2)

        v6.PositionInfluence = Vector3.new(0, 0.15, 0)
        v6.RotationInfluence = Vector3.new(1.25, 0, 4)

        return v6
    end,
    RoughDriving = function() -- RoughDriving | line: 86
        -- upvalues: CameraShakeInstance (copy)
        local v7 = CameraShakeInstance.new(1, 2, 1, 1)

        v7.PositionInfluence = Vector3.new(0, 0, 0)
        v7.RotationInfluence = Vector3.new(1, 1, 1)

        return v7
    end
}

return (setmetatable({}, {
    __index = function(_, p2) -- __index | line: 98
        -- upvalues: t1 (copy)
        local v8 = t1[p2]

        if type(v8) == "function" then
            return v8()
        end

        error("No preset found with index \"" .. p2 .. "\"")
    end
}))
