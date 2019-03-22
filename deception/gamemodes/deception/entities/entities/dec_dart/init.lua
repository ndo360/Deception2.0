AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/crossbow_bolt.mdl") 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_FLYGRAVITY)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NPC)
	self:SetGravity(0.3)
	self.CanPoison = true
	
	local phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
end

function ENT:OnTakeDamage(dmginfo)
	return false
end

function ENT:Use(activator, caller)
	return false
end

function ENT:Touch(ent)
	if self.CanPoison then
		if IsValid(ent) and ent:IsPlayer() then
			ent:Poison(self:GetOwner())
			self.CanPoison = false
		end
	end
	
	self:Remove()
end

function ENT:PhysicsCollide(data, physobj)
	if SERVER then
		if self.CanPoison then
			if data.HitEntity:IsPlayer() then
				data.HitEntity:Poison(self:GetOwner())
			end
		end
		
		self:Remove()
	end
end

function ENT:OnRemove()
end