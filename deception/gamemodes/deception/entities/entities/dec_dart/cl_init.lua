include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self:SetModelScale(0.25)
	self:DrawModel()
end