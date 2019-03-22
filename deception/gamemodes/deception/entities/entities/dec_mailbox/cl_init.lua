include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()
	
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local up = ang:Up()
	local right = ang:Right()
	local dir = ang:Forward():Angle()
	
	cam.Start3D2D(pos + up * 45 - right * 4, Angle(-ang.p, ang.y + 180, -ang.r + 90), 0.07 )
		draw.ShadowedText("Mailbox", "Trebuchet64_AA", 0, 0, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
	cam.End3D2D()
	
	cam.Start3D2D(pos + up * 45 + right * 4, Angle(ang.p, ang.y, ang.r + 90), 0.07 )
		draw.ShadowedText("Mailbox", "Trebuchet64_AA", 0, 0, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
	cam.End3D2D()
end

function ENT:Think()
end 