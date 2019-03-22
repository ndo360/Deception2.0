if CLIENT then
    SWEP.PrintName = "Dart gun"
    SWEP.Slot = 3
    SWEP.SlotPos = 3
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
	SWEP.BounceWeaponIcon = false
	
	language.Add("SniperRound", "Darts")
end

if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.IsCustomWeapon = true
	SWEP.TakesUpSlot = false
	SWEP.Unique = true
end

SWEP.Author            = "Spy"
SWEP.Instructions    = "Left click to fire out a dart."
SWEP.Contact        = ""
SWEP.Purpose        = ""
SWEP.HoldType = "pistol"

SWEP.ViewModelFOV    = 65
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true


SWEP.ViewModel      = "models/weapons/v_pistol.mdl"
SWEP.WorldModel   = "models/weapons/w_pistol.mdl"
  
-- Primary Fire Attributes --
SWEP.Primary.Recoil            = 0
SWEP.Primary.Damage            = 0
SWEP.Primary.NumShots        = 1
SWEP.Primary.Cone            = 0
SWEP.Primary.ClipSize        = 1
SWEP.Primary.DefaultClip    = 1
SWEP.Primary.Automatic       = false    
SWEP.Primary.Ammo             = "SniperRound"
 
-- Secondary Fire Attributes --
SWEP.Secondary.Recoil        = 0
SWEP.Secondary.Damage        = 0
SWEP.Secondary.NumShots        = 1
SWEP.Secondary.Cone            = 0
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

SWEP.ReloadDelay = 0
SWEP.Size = 4
SWEP.Caliber = "Poison dart"
SWEP.HideFMJ = true

local aimvec, dart, offset, Dist, CT, dt3

function SWEP:Initialize()
    self:SetWeaponHoldType("normal")
	self:SetDTInt(3, 20)
end

function SWEP:Precache()
end

function SWEP:Deploy()
	CT = CurTime()
	self.Owner:GetViewModel():SetModel(self.ViewModel)
	self:SendWeaponAnim(ACT_VM_DRAW)
	self.ReloadDelay = CT + 0.8
	self:SetNextPrimaryFire(CT + 0.8)
    return true
end

function SWEP:Holster()
    return true
end

function SWEP:Reload()
    self:DefaultReload(ACT_VM_RELOAD)
	self.Owner:SetAnimation(PLAYER_RELOAD)
	
	if CLIENT then
		if self:Clip1() == 0 and self:GetDTInt(3) == 0 then
			self:EmitSound("weapons/pistol/pistol_reload1.wav", 70, 100)
		end
	end
end

function SWEP:PrimaryAttack()
	dt3 = self:GetDTInt(3)
	
	if dt3 == 20 then
		return
	end
	
	Dist = self.Owner:GetShootPos():Distance(self.Owner:GetEyeTrace().HitPos)
	
	if Dist <= 30 then
		return
	end

	if self:Clip1() == 0 then
		return
	end
	
	if SERVER then
		aimvec = self.Owner:GetAimVector()
		dart = ents.Create("dec_dart")
		offset = Vector(aimvec.x * (5 * math.random(-1, 1)), aimvec.y * (5 * math.random(-1, 1)), 0)
		dart:SetPos(self.Owner:GetShootPos() - Vector(0, 0, 5) + aimvec * 45 + self.Owner:GetRight() * 4.5)
		dart:SetAngles(self.Owner:EyeAngles())
		dart:Spawn()
		dart:SetOwner(self.Owner)
		dart:SetVelocity(aimvec * 2000 + offset)
	end
	
	CT = CurTime()
	
	self:SetNextPrimaryFire(CT + 0.5)
	self.ReloadDelay = CT + 0.5
	self:EmitSound("weapons/crossbow/fire1.wav", 65, 100)
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self:SetClip1(0)
end

function SWEP:SecondaryAttack()
	return false
end

if CLIENT then
	local X, Y
	
	function SWEP:DrawHUD()
		X = ScrW()
		Y = ScrH()
		
		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(X / 2 - 2, Y / 2 - 2, 4, 4)
				
		surface.SetDrawColor(255, 255, 255, 255)
		surface.DrawRect(X / 2 - 1, Y / 2 - 1, 2, 2)
	end

	function SWEP:DrawWorldModel()
		if self:GetDTInt(3) == 20 then
			self:DrawShadow(false)
		else
			self:DrawShadow(true)
			self:DrawModel()
		end
	end
	
	local BlendAng = Vector(0, 0, 0)
	local BlendPos = Vector(0, 0, 0)
	local TargetPos = Vector(0, 0, 0)
	local TargetAng = Vector(0, 0, 0)
	local FT, Right, Up, Forward
	
	function SWEP:GetViewModelPosition(pos, ang)
		FT = FrameTime()
		
		if self:GetDTInt(3) == 20 then
			TargetPos = Vector(0, 0, -20)
			TargetAng = Vector(0, 0, 0)
		else
			TargetPos = Vector(0, 0, 0)
			TargetAng = Vector(0, 0, 0)
		end
		
		BlendPos = LerpVector(FT * 15, BlendPos, TargetPos)
		BlendAng = LerpVector(FT * 15, BlendAng, TargetAng)
				
		ang:RotateAroundAxis( ang:Right(), 		BlendAng.x)
		ang:RotateAroundAxis( ang:Up(), 		BlendAng.y)
		ang:RotateAroundAxis( ang:Forward(), 	BlendAng.z)

		Right 	= ang:Right()
		Up 		= ang:Up()
		Forward 	= ang:Forward()	
			
		pos = pos + BlendPos.x * Right
		pos = pos + BlendPos.y * Forward
		pos = pos + BlendPos.z * Up
		
		return pos, ang
	end
	
	function SWEP:FireAnimationEvent(pos, ang, ev)
		return true
	end
end

if SERVER then
	function SWEP:HolsterWeapon(ply, wep)
		dt3 = wep:GetDTInt(3)
		CT = CurTime()
		
		if CT > self.ReloadDelay then
			if dt3 == 20 then
				wep:SetDTInt(3, 0)
				
				wep:SetNextPrimaryFire(CT + 0.4)
			else
				if dt3 != 0 then
					ply:SetFOV(0, 0.3)
				end
				
				wep:SetDTInt(3, 20)
			end
			
			wep.ReloadDelay = CT + 0.4
		end
	end
end