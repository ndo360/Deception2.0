function EFFECT:Init(ef)
	if IsValid(ef:GetEntity()) then
		self:SetPos(ef:GetOrigin())
		self.Emitter = ParticleEmitter(ef:GetOrigin())
		local ent = ef:GetEntity()
		local ply = ent:GetOwner()
		local att = ent:GetAttachment("1")
		local finalpos = att.Pos
		
		ParticleEffect(ent.SmokeEffect or "cstm_child_smoke_small", finalpos, ply:EyeAngles(), att)
					
		if ent.Silenced == 0 or ((ent.WElements and ent.WElements["silencer"] != nil and ent.WElements["silencer"].color.a != 255) or ent.WElements and ent.WElements["silencer"] == nil) then -- I check if it's not nil and then if it's nil to ensure that weapons that don't have a silencer don't bug
			ParticleEffect(ent.SparkEffect or "cstm_child_sparks_pistol", finalpos, ply:EyeAngles(), att)
			ParticleEffect(ent.Muzzle or "cstm_child_muzzle_small", finalpos, ply:EyeAngles(), att)
		end
	end
	
	self.DieTime = CurTime() + 0.01
end

function EFFECT:Think()
	if not IsValid(self.Emitter) then
		return false
	end
	
	if CurTime() > self.DieTime then
		self.Emitter:Finish()
		return false
	else
		return true
	end
end

function EFFECT:Render()
end