-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=1461025953

-- ! Source from the asset above; the game may have edited it since.

--[=[
-- Camera Shake Instance
-- Stephen Leitnick
-- February 26, 2018

--[[
	
	cameraShakeInstance = CameraShakeInstance.new(magnitude, roughness, fadeInTime, fadeOutTime)
	
--]]



local CameraShakeInstance = {}
CameraShakeInstance.__index = CameraShakeInstance

local V3 = Vector3.new
local NOISE = math.noise


CameraShakeInstance.CameraShakeState = {
	FadingIn = 0;
	FadingOut = 1;
	Sustained = 2;
	Inactive = 3;
}


function CameraShakeInstance.new(magnitude, roughness, fadeInTime, fadeOutTime)
	
	if (fadeInTime == nil) then fadeInTime = 0 end
	if (fadeOutTime == nil) then fadeOutTime = 0 end
	
	assert(type(magnitude) == "number", "Magnitude must be a number")
	assert(type(roughness) == "number", "Roughness must be a number")
	assert(type(fadeInTime) == "number", "FadeInTime must be a number")
	assert(type(fadeOutTime) == "number", "FadeOutTime must be a number")
	
	local self = setmetatable({
		Magnitude = magnitude;
		Roughness = roughness;
		PositionInfluence = V3();
		RotationInfluence = V3();
		DeleteOnInactive = true;
		roughMod = 1;
		magnMod = 1;
		fadeOutDuration = fadeOutTime;
		fadeInDuration = fadeInTime;
		sustain = (fadeInTime > 0);
		currentFadeTime = (fadeInTime > 0 and 0 or 1);
		tick = Random.new():NextNumber(-100, 100);
		_camShakeInstance = true;
	}, CameraShakeInstance)
	
	return self
	
end


function CameraShakeInstance:UpdateShake(dt)
	
	local _tick = self.tick
	local currentFadeTime = self.currentFadeTime
	
	local offset = V3(
		NOISE(_tick, 0) * 0.5,
		NOISE(0, _tick) * 0.5,
		NOISE(_tick, _tick) * 0.5
	)
	
	if (self.fadeInDuration > 0 and self.sustain) then
		if (currentFadeTime < 1) then
			currentFadeTime = currentFadeTime + (dt / self.fadeInDuration)
		elseif (self.fadeOutDuration > 0) then
			self.sustain = false
		end
	end
	
	if (not self.sustain) then
		currentFadeTime = currentFadeTime - (dt / self.fadeOutDuration)
	end
	
	if (self.sustain) then
		self.tick = _tick + (dt * self.Roughness * self.roughMod)
	else
		self.tick = _tick + (dt * self.Roughness * self.roughMod * currentFadeTime)
	end
	
	self.currentFadeTime = currentFadeTime
	
	return offset * self.Magnitude * self.magnMod * currentFadeTime
	
end


function CameraShakeInstance:StartFadeOut(fadeOutTime)
	if (fadeOutTime == 0) then
		self.currentFadeTime = 0
	end
	self.fadeOutDuration = fadeOutTime
	self.fadeInDuration = 0
	self.sustain = false
end


function CameraShakeInstance:StartFadeIn(fadeInTime)
	if (fadeInTime == 0) then
		self.currentFadeTime = 1
	end
	self.fadeInDuration = fadeInTime or self.fadeInDuration
	self.fadeOutDuration = 0
	self.sustain = true
end


function CameraShakeInstance:GetScaleRoughness()
	return self.roughMod
end


function CameraShakeInstance:SetScaleRoughness(v)
	self.roughMod = v
end


function CameraShakeInstance:GetScaleMagnitude()
	return self.magnMod
end


function CameraShakeInstance:SetScaleMagnitude(v)
	self.magnMod = v
end


function CameraShakeInstance:GetNormalizedFadeTime()
	return self.currentFadeTime
end


function CameraShakeInstance:IsShaking()
	return (self.currentFadeTime > 0 or self.sustain)
end


function CameraShakeInstance:IsFadingOut()
	return ((not self.sustain) and self.currentFadeTime > 0)
end


function CameraShakeInstance:IsFadingIn()
	return (self.currentFadeTime < 1 and self.sustain and self.fadeInDuration > 0)
end


function CameraShakeInstance:GetState()
	if (self:IsFadingIn()) then
		return CameraShakeInstance.CameraShakeState.FadingIn
	elseif (self:IsFadingOut()) then
		return CameraShakeInstance.CameraShakeState.FadingOut
	elseif (self:IsShaking()) then
		return CameraShakeInstance.CameraShakeState.Sustained
	else
		return CameraShakeInstance.CameraShakeState.Inactive
	end
end


return CameraShakeInstance
]=]

-- https://lua.expert

local t1 = {}

t1.__index = t1

local new, noise = Vector3.new, math.noise

t1.CameraShakeState = {
    FadingIn = 0,
    FadingOut = 1,
    Sustained = 2,
    Inactive = 3
}

function t1.new(p1, p2, p3, p4) -- line: 28
    -- upvalues: t1 (copy), new (copy)
    local v1 = if p3 == nil then 0 else p3
    local v2 = if p4 == nil then 0 else p4

    assert(type(p1) == "number", "Magnitude must be a number")
    assert(type(p2) == "number", "Roughness must be a number")
    assert(type(v1) == "number", "FadeInTime must be a number")
    assert(type(v2) == "number", "FadeOutTime must be a number")

    return (setmetatable({
        DeleteOnInactive = true,
        roughMod = 1,
        magnMod = 1,
        _camShakeInstance = true,
        Magnitude = p1,
        Roughness = p2,
        PositionInfluence = new(),
        RotationInfluence = new(),
        fadeOutDuration = v2,
        fadeInDuration = v1,
        sustain = v1 > 0,
        currentFadeTime = v1 > 0 and 0 or 1,
        tick = Random.new():NextNumber(-100, 100)
    }, t1))
end

function t1.UpdateShake(p5, p6) -- line: 59
    -- upvalues: new (copy), noise (copy)
    local tick, currentFadeTime = p5.tick, p5.currentFadeTime
    local v10 = new(noise(tick, 0) * 0.5, noise(0, tick) * 0.5, noise(tick, tick) * 0.5)

    if p5.fadeInDuration > 0 and p5.sustain then
        if currentFadeTime < 1 then
            currentFadeTime += p6 / p5.fadeInDuration
        elseif p5.fadeOutDuration > 0 then
            p5.sustain = false
        end
    end

    if not p5.sustain then
        currentFadeTime -= p6 / p5.fadeOutDuration
    end

    if p5.sustain then
        p5.tick = tick + p6 * p5.Roughness * p5.roughMod
    else
        p5.tick = tick + p6 * p5.Roughness * p5.roughMod * currentFadeTime
    end

    p5.currentFadeTime = currentFadeTime

    return v10 * p5.Magnitude * p5.magnMod * currentFadeTime
end

function t1.StartFadeOut(p7, p8) -- line: 95
    if p8 == 0 then
        p7.currentFadeTime = 0
    end

    p7.fadeOutDuration = p8
    p7.fadeInDuration = 0
    p7.sustain = false
end

function t1.Destroy(p9) -- line: 104
    p9:StartFadeOut(1)
end

function t1.StartFadeIn(p10, p11) -- line: 108
    if p11 == 0 then
        p10.currentFadeTime = 1
    end

    p10.fadeInDuration = p11 or p10.fadeInDuration
    p10.fadeOutDuration = 0
    p10.sustain = true
end

function t1.GetScaleRoughness(p12) -- line: 118
    return p12.roughMod
end

function t1.SetScaleRoughness(p13, p14) -- line: 123
    p13.roughMod = p14
end

function t1.GetScaleMagnitude(p15) -- line: 128
    return p15.magnMod
end

function t1.SetScaleMagnitude(p16, p17) -- line: 133
    p16.magnMod = p17
end

function t1.GetNormalizedFadeTime(p18) -- line: 138
    return p18.currentFadeTime
end

function t1.IsShaking(p19) -- line: 143
    if p19.currentFadeTime > 0 then
        return true
    end

    return p19.sustain
end

function t1.IsFadingOut(p20) -- line: 148
    return not p20.sustain and p20.currentFadeTime > 0
end

function t1.IsFadingIn(p21) -- line: 153
    if p21.currentFadeTime < 1 then
        return p21.sustain and p21.fadeInDuration > 0
    end

    return false
end

function t1.GetState(p22) -- line: 158
    -- upvalues: t1 (copy)
    if p22:IsFadingIn() then
        return t1.CameraShakeState.FadingIn
    end

    if p22:IsFadingOut() then
        return t1.CameraShakeState.FadingOut
    end

    if p22:IsShaking() then
        return t1.CameraShakeState.Sustained
    end

    return t1.CameraShakeState.Inactive
end

return t1
