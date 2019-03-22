AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self.Entity:SetModel("models/weapons/w_rif_ak47.mdl") 
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetCollisionGroup(COLLISION_GROUP_NPC)
	self.UseDelay = CurTime() + 1
	local phys = self.Entity:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
end

function ENT:OnTakeDamage(dmginfo)
	self.Entity:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() * 0.1)
end

function ENT:Use(activator, caller)
	local CT = CurTime()
	
	if CT < self.UseDelay then
		return
	end
	
	if activator:CountWeapons() >= GetConVarNumber("dec_maxweapons_unique") then
		SendUserMessage("NOSPACE", activator)
		self.UseDelay = CT + 1
		return
	end
	
	if self.Unique and activator:CountUniqueWeapons() >= GetConVarNumber("dec_maxweapons_unique") then
		SendUserMessage("NOSPACE", activator)
		self.UseDelay = CT + 1
		return
	end
	
	if activator:HasWeapon(self.WepClass) then
		SendUserMessage("HAVEITEM", activator)
		self.UseDelay = CT + 1
		return
	end
	
	local wep = activator:Give(self.WepClass)
	wep:SetClip1(self.Ammo)
	self:Remove()
end

function ENT:Unload(ply)
	local CT = CurTime()
	
	if CT < self.UseDelay then
		return
	end
	
	if not ply:CanGiveAmmo(self.AmmoType) then
		SendUserMessage("AMMOFULL", ply)
		self.UseDelay = CT + 1
		return
	end
	
	if self.CanUnload and self.Ammo > 0 then
		local ammo2 = self.Ammo
		self.Ammo = ply:GetRemainingAmmo(self.Ammo, self.AmmoType)
		ply:GiveAmmoCap(ammo2, self.AmmoType)
		
		if self.Ammo == 0 then
			SendUserMessage("UNLOADWEAPON", ply)
		else
			SendUserMessage("UNLOADWEAPONPARTIALLY", ply)
		end
		
		self.UseDelay = CT + 1
		return
	end

	if self.Ammo == 0 then
		SendUserMessage("WEAPONEMPTY", ply)
		self.UseDelay = CT + 1
	end
end

function ENT:OnRemove()
	return false
end 