-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=1461025953

-- ! Source from the asset above; the game may have edited it since.

--[=[
-- Camera Shaker
-- Stephen Leitnick
-- February 26, 2018

--[[
	
	CameraShaker.CameraShakeInstance
	
	cameraShaker = CameraShaker.new(renderPriority, callbackFunction)
	
	CameraShaker:Start()
	CameraShaker:Stop()
	CameraShaker:StopSustained([fadeOutTime])
	CameraShaker:Shake(shakeInstance)
	CameraShaker:ShakeSustain(shakeInstance)
	CameraShaker:ShakeOnce(magnitude, roughness [, fadeInTime, fadeOutTime, posInfluence, rotInfluence])
	CameraShaker:StartShake(magnitude, roughness [, fadeInTime, posInfluence, rotInfluence])
	
	
	
	EXAMPLE:
	
		local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCFrame)
			camera.CFrame = playerCFrame * shakeCFrame
		end)
		
		camShake:Start()
		
		-- Explosion shake:
		camShake:Shake(CameraShaker.Presets.Explosion)
		
		wait(1)
		
		-- Custom shake:
		camShake:ShakeOnce(3, 1, 0.2, 1.5)

		-- Sustained shake:
		camShake:ShakeSustain(CameraShaker.Presets.Earthquake)

		-- Stop all sustained shakes:
		camShake:StopSustained(1) -- Argument is the fadeout time (defaults to the same as fadein time if not supplied)

		-- Stop only one sustained shake:
		shakeInstance = camShake:ShakeSustain(CameraShaker.Presets.Earthquake)
		wait(2)
		shakeInstance:StartFadeOut(1) -- Argument is the fadeout time
	
	
	NOTE:
	
		This was based entirely on the EZ Camera Shake asset for Unity3D. I was given written
		permission by the developer, Road Turtle Games, to port this to Roblox.
		
		Original asset link: https://assetstore.unity.com/packages/tools/camera/ez-camera-shake-33148

		GitHub repository: https://github.com/Sleitnick/RbxCameraShaker
	
	
--]]



local CameraShaker = {}
CameraShaker.__index = CameraShaker

local profileBegin = debug.profilebegin
local profileEnd = debug.profileend
local profileTag = "CameraShakerUpdate"

local V3 = Vector3.new
local CF = CFrame.new
local ANG = CFrame.Angles
local RAD = math.rad
local v3Zero = V3()

local CameraShakeInstance = require(script.CameraShakeInstance)
local CameraShakeState = CameraShakeInstance.CameraShakeState

local defaultPosInfluence = V3(0.15, 0.15, 0.15)
local defaultRotInfluence = V3(1, 1, 1)


CameraShaker.CameraShakeInstance = CameraShakeInstance
CameraShaker.Presets = require(script.CameraShakePresets)


function CameraShaker.new(renderPriority, callback)
	
	assert(type(renderPriority) == "number", "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
	assert(type(callback) == "function", "Callback must be a function")
	
	local self = setmetatable({
		_running = false;
		_renderName = "CameraShaker";
		_renderPriority = renderPriority;
		_posAddShake = v3Zero;
		_rotAddShake = v3Zero;
		_camShakeInstances = {};
		_removeInstances = {};
		_callback = callback;
	}, CameraShaker)
	
	return self
	
end


function CameraShaker:Start()
	if (self._running) then return end
	self._running = true
	local callback = self._callback
	game:GetService("RunService"):BindToRenderStep(self._renderName, self._renderPriority, function(dt)
		profileBegin(profileTag)
		local cf = self:Update(dt)
		profileEnd()
		callback(cf)
	end)
end


function CameraShaker:Stop()
	if (not self._running) then return end
	game:GetService("RunService"):UnbindFromRenderStep(self._renderName)
	self._running = false
end


function CameraShaker:StopSustained(duration)
	for _,c in pairs(self._camShakeInstances) do
		if (c.fadeOutDuration == 0) then
			c:StartFadeOut(duration or c.fadeInDuration)
		end
	end
end


function CameraShaker:Update(dt)
	
	local posAddShake = v3Zero
	local rotAddShake = v3Zero
	
	local instances = self._camShakeInstances
	
	-- Update all instances:
	for i = 1,#instances do
		
		local c = instances[i]
		local state = c:GetState()
		
		if (state == CameraShakeState.Inactive and c.DeleteOnInactive) then
			self._removeInstances[#self._removeInstances + 1] = i
		elseif (state ~= CameraShakeState.Inactive) then
			local shake = c:UpdateShake(dt)
			posAddShake = posAddShake + (shake * c.PositionInfluence)
			rotAddShake = rotAddShake + (shake * c.RotationInfluence)
		end
		
	end
	
	-- Remove dead instances:
	for i = #self._removeInstances,1,-1 do
		local instIndex = self._removeInstances[i]
		table.remove(instances, instIndex)
		self._removeInstances[i] = nil
	end
	
	return CF(posAddShake) *
			ANG(0, RAD(rotAddShake.Y), 0) *
			ANG(RAD(rotAddShake.X), 0, RAD(rotAddShake.Z))
	
end


function CameraShaker:Shake(shakeInstance)
	assert(type(shakeInstance) == "table" and shakeInstance._camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
	self._camShakeInstances[#self._camShakeInstances + 1] = shakeInstance
	return shakeInstance
end


function CameraShaker:ShakeSustain(shakeInstance)
	assert(type(shakeInstance) == "table" and shakeInstance._camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
	self._camShakeInstances[#self._camShakeInstances + 1] = shakeInstance
	shakeInstance:StartFadeIn(shakeInstance.fadeInDuration)
	return shakeInstance
end


function CameraShaker:ShakeOnce(magnitude, roughness, fadeInTime, fadeOutTime, posInfluence, rotInfluence)
	local shakeInstance = CameraShakeInstance.new(magnitude, roughness, fadeInTime, fadeOutTime)
	shakeInstance.PositionInfluence = (typeof(posInfluence) == "Vector3" and posInfluence or defaultPosInfluence)
	shakeInstance.RotationInfluence = (typeof(rotInfluence) == "Vector3" and rotInfluence or defaultRotInfluence)
	self._camShakeInstances[#self._camShakeInstances + 1] = shakeInstance
	return shakeInstance
end


function CameraShaker:StartShake(magnitude, roughness, fadeInTime, posInfluence, rotInfluence)
	local shakeInstance = CameraShakeInstance.new(magnitude, roughness, fadeInTime)
	shakeInstance.PositionInfluence = (typeof(posInfluence) == "Vector3" and posInfluence or defaultPosInfluence)
	shakeInstance.RotationInfluence = (typeof(rotInfluence) == "Vector3" and rotInfluence or defaultRotInfluence)
	shakeInstance:StartFadeIn(fadeInTime)
	self._camShakeInstances[#self._camShakeInstances + 1] = shakeInstance
	return shakeInstance
end


return CameraShaker
]=]

-- https://lua.expert

local t1 = {}

t1.__index = t1

local profilebegin, profileend, new, new2 = debug.profilebegin, debug.profileend, Vector3.new, CFrame.new
local Angles, rad = CFrame.Angles, math.rad
local v1 = new()
local CameraShakeInstance = require(script.CameraShakeInstance)
local CameraShakeState = CameraShakeInstance.CameraShakeState

t1.CameraShakeInstance = CameraShakeInstance
t1.Presets = require(script.CameraShakePresets)

function t1.new(_, p2, p3) -- line: 87
    -- upvalues: t1 (copy), v1 (copy)
    assert(type(p2) == "number", "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)")
    assert(type(p3) == "function", "Callback must be a function")

    return (setmetatable({
        _running = false,
        _renderName = "CameraShaker",
        _renderPriority = p2,
        _posAddShake = v1,
        _rotAddShake = v1,
        _camShakeInstances = {},
        _removeInstances = {},
        _callback = p3
    }, t1))
end

function t1.Start(p4) -- line: 108
    -- upvalues: profilebegin (copy), profileend (copy)
    if p4._running then
        return
    end

    p4._running = true

    local _callback = p4._callback

    game:GetService("RunService"):BindToRenderStep(p4._renderName, p4._renderPriority, function(p5) -- line: 112
        -- upvalues: p4 (copy), _callback (copy), profilebegin (copy), profileend (copy)
        profilebegin("CameraShakerUpdate")

        local v4 = p4:Update(p5)

        profileend()
        _callback(v4)
    end)
end

function t1.Stop(p6) -- line: 121
    if p6._running then
        game:GetService("RunService"):UnbindFromRenderStep(p6._renderName)
        p6._running = false
    end
end

function t1.StopSustained(p7, p8) -- line: 128
    for _, v5 in pairs(p7._camShakeInstances) do
        if v5.fadeOutDuration == 0 then
            v5:StartFadeOut(p8 or v5.fadeInDuration)
        end
    end
end

function t1.Destroy(p9) -- line: 136
    p9:Stop()
end

function t1.Update(p10, p11) -- line: 140
    -- upvalues: new2 (copy), Angles (copy), rad (copy), v1 (copy), CameraShakeState (copy)
    local v6 = v1
    local v7 = v1
    local _camShakeInstances = p10._camShakeInstances

    for i = 1, #_camShakeInstances do
        local v8 = _camShakeInstances[i]
        local State = v8:GetState()

        if State == CameraShakeState.Inactive and v8.DeleteOnInactive then
            p10._removeInstances[#p10._removeInstances + 1] = i
        elseif State ~= CameraShakeState.Inactive then
            local v9 = v8:UpdateShake(p11)

            v6 += v9 * v8.PositionInfluence
            v7 += v9 * v8.RotationInfluence
        end
    end

    for i = #p10._removeInstances, 1, -1 do
        local v10 = p10._removeInstances[i]

        table.remove(_camShakeInstances, v10)
        p10._removeInstances[i] = nil
    end

    return new2(v6) * Angles(0, rad(v7.Y), 0) * Angles(rad(v7.X), 0, (rad(v7.Z)))
end

function t1.Shake(p12, p13) -- line: 177
    assert(type(p13) == "table" and p13._camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
    p12._camShakeInstances[#p12._camShakeInstances + 1] = p13

    return p13
end

function t1.ShakeSustain(p14, p15) -- line: 184
    assert(type(p15) == "table" and p15._camShakeInstance, "ShakeInstance must be of type CameraShakeInstance")
    p14._camShakeInstances[#p14._camShakeInstances + 1] = p15
    p15:StartFadeIn(p15.fadeInDuration)

    return p15
end

function t1.ShakeOnce(p16, p17, p18, p19, p20, p21, p22) -- line: 192
    -- upvalues: CameraShakeInstance (copy)
    local v16 = CameraShakeInstance.new(p17, p18, p19, p20)

    if typeof(p21) ~= "Vector3" or not p21 then
        v16.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
    else
        v16.PositionInfluence = p21
    end

    if typeof(p22) ~= "Vector3" or not p22 then
        v16.RotationInfluence = Vector3.new(1, 1, 1)
    else
        v16.RotationInfluence = p22
    end

    p16._camShakeInstances[#p16._camShakeInstances + 1] = v16

    return v16
end

function t1.StartShake(p23, p24, p25, p26, p27, p28) -- line: 201
    -- upvalues: CameraShakeInstance (copy)
    local v17 = CameraShakeInstance.new(p24, p25, p26)

    if typeof(p27) ~= "Vector3" or not p27 then
        v17.PositionInfluence = Vector3.new(0.15, 0.15, 0.15)
    else
        v17.PositionInfluence = p27
    end

    if typeof(p28) ~= "Vector3" or not p28 then
        v17.RotationInfluence = Vector3.new(1, 1, 1)
    else
        v17.RotationInfluence = p28
    end

    v17:StartFadeIn(p26)
    p23._camShakeInstances[#p23._camShakeInstances + 1] = v17

    return v17
end

return t1
