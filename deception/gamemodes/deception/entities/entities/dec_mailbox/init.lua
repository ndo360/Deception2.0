AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props/CS_militia/mailbox01.mdl") 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.UseDelay = 0
	
	local phys = self:GetPhysicsObject()
 
	if phys and phys:IsValid() then
		phys:EnableMotion(false)
	end
end

function ENT:Use(activator, caller)
	if not CanBuy then
		return
	end
	if CurTime() < self.UseDelay then
		return
	end
	
	local dist = activator:GetPos():Distance(self:GetPos())
	
	if dist <= 64 then
		if #activator.Mail > 0 then
			for k, v in pairs(activator.Mail) do
				umsg.Start("SILENTMAIL", activator) -- we re-send the contents of the mail, because for some people the mail sometimes does not work (no idea why lol)
					umsg.Short(k)
					umsg.Short(v)
				umsg.End()
			end
		end
		
		timer.Simple(0.1, function()
			activator:ConCommand("dec_mail")
		end)
		
		self.UseDelay = CurTime() + 1
	end
end

function ENT:OnRemove()
	return false
end 