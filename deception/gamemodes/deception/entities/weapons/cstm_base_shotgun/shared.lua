
if (SERVER) then

	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false

end

if ( CLIENT ) then

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 75
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.PitchMod = 1
	SWEP.RollMod = 1
	// This is the font that's used to draw the death icons
	surface.CreateFont( "CSKillIcons", {size=ScreenScale( 30 ), weight=500, antialias=true, additive =true, font="csd"} )
	surface.CreateFont( "CSSelectIcons", {size=ScreenScale( 60 ), weight=500, antialias=true, additive =true, font="csd"} )

end

SWEP.Author			= "LEETNOOB"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= "PRIMARY ATTACK key to fire\nSECONDARY ATTACK key to toggle ironsights\nUSE key + SECONDARY ATTACK key - attach suppressor\nUSE key + RELOAD key - switch between semi-auto/auto firemodes (SMGs/ARs)"

// Note: This is how it should have worked. The base weapon would set the category
// then all of the children would have inherited that.
// But a lot of SWEPS have based themselves on this base (probably not on purpose)
// So the category name is now defined in all of the child SWEPS.
//SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound			= Sound( "Weapon_AK47.Single" )
SWEP.Primary.Recoil			= 1.5
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay			= 0.15

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.Base					= "cstm_base_pistol"

function SWEP:Deploy()
	local time = CurTime()
	self.Owner:GetViewModel():SetModel(self.ViewModel)
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(time + 1)
	self:SetNextSecondaryFire(time + 1)
	self.ReloadDelay = time + 1
	self.MeleeDelay = time + 1
	
	return true
end
	
function SWEP:Reload()
	if self.IsReloading == false then
		if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
			if self:Clip1() < self.Primary.ClipSize then
				if CurTime() > self.ReloadDelay then
					self:StartCustomReload("start_reload", self.ReloadSpeed)
					self:SetDTInt(3, 0)
					if SERVER then
						if self.Owner:GetFOV() != 0 then
							self.Owner:SetFOV(0, 0.3)
						end
					end
				end
			end
		end
	end
end

function SWEP:StartCustomReload(anim, ReloadSpeed)

	local vm = self.Owner:GetViewModel()
	local sequence = vm:LookupSequence(anim)
	vm:ResetSequence(sequence)
	vm:SetPlaybackRate(ReloadSpeed)
	if self:Clip1() == 0 then
		self.ShouldBolt = true
	end
	
	local AvailableReload = math.Clamp(self.Owner:GetAmmoCount(self.Primary.Ammo), 0, 1)
	
	timer.Simple((vm:SequenceDuration() / self.ReloadSpeed) - 0.1, function()
		self:InsertAmmo()
	end)
	
	self.IsReloading = true
	self:SetNextPrimaryFire(CurTime() + 1)
end

function SWEP:InsertAmmo()
	local nick = self.Owner:Nick()
	local wep = self.Owner:GetActiveWeapon()
	
	if wep != self then
		return
	end
		
	local vm = self.Owner:GetViewModel()
	vm:SetCycle(0)
	self.MeleeDelay = CurTime() + 0.5
	
	self:SendWeaponAnim(ACT_VM_IDLE)
	
	vm:SetPlaybackRate(self.ReloadSpeed)
	
	timer.Create("ReloadTimer" .. nick, 0.02, 1, function()
		self:SendWeaponAnim(ACT_VM_RELOAD)
		
		if not self or not self.Owner or not self.Owner:Alive() or self.Owner:GetActiveWeapon() != self then
			timer.Destroy("ReloadLogic" .. nick)
		end
	end)
		
	timer.Create("AmmoInc" .. nick, self.IncAmmoPerc, 1, function()	
		if not self or not self.Owner or not self.Owner:Alive() or self.Owner:GetActiveWeapon() != self then
			timer.Destroy("ReloadLogic" .. nick)
		end
		
		self:SetClip1(self:Clip1() + 1)
		self.Owner:RemoveAmmo(1, self.Primary.Ammo)
		self.Owner:SetAnimation(PLAYER_RELOAD)
	end)
	
	timer.Create("ReloadLogic" .. nick, self.IncAmmoPerc + 0.2, 0, function()
		if not self or not self.Owner or not self.Owner:Alive() or self.Owner:GetActiveWeapon() != self then
			timer.Destroy("ReloadLogic" .. nick)
		end
	
		if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) - 1 > 0 then
			self:InsertAmmo()
		else
			self:FinishCustomReload(self.ShouldBolt)
			timer.Destroy("AmmoInc" .. nick)
			timer.Destroy("ReloadLogic" .. nick)
			timer.Destroy("ReloadTimer" .. nick)
		end
	end)
end

function SWEP:FinishCustomReload(bolt)
	local vm = self.Owner:GetViewModel()
	local time = CurTime()

	if bolt == false or self.NoBoltAnim == true then
		self.IsReloading = false
		self.ShouldBolt = false
		local sequence = vm:LookupSequence("idle")
		vm:ResetSequence(sequence)
		vm:SetSequence(sequence)
		vm:SetPlaybackRate(self.ReloadSpeed)
		self:SetNextPrimaryFire(time + 0.3)
		self:SetNextSecondaryFire(time + 0.3)
		self.MeleeDelay = time + 0.3
	else
		self:BoltWeaponry()
	end
end

function SWEP:BoltWeaponry()
	local vm = self.Owner:GetViewModel()
	local time = CurTime()

	local sequence = vm:LookupSequence("after_reload")
	vm:ResetSequence(sequence)
	vm:SetSequence(sequence)
	vm:SetPlaybackRate(self.ReloadSpeed)
	timer.Simple((vm:SequenceDuration() / self.ReloadSpeed) - 0.2, function()
		self.IsReloading = false
		self.ShouldBolt = false
	end)
	self:SetNextPrimaryFire(time + 0.8)
	self:SetNextSecondaryFire(time + 0.8)
end

function SWEP:PrimaryAttack()
	local nick = self.Owner:Nick()
	local time = CurTime()
	local DTInt3 = self:GetDTInt(3)
	
	if self.ShouldBolt == true or self.IsReloading == true then
		self:FinishCustomReload(self.ShouldBolt)
		timer.Destroy("AmmoInc" .. nick)
		timer.Destroy("ReloadLogic" .. nick)
		timer.Destroy("ReloadTimer" .. nick)
		return
	end
	
	if self:Clip1() == 0 or self.Owner:WaterLevel() == 3 then
		self:EmitSound("weapons/shotgun/shotgun_empty.wav", 65, math.random(99, 101))
		self:SetNextSecondaryFire( time + 0.05 )
		self:SetNextPrimaryFire( time + 0.25 )
		return
	end
	
	if DTInt3 == 2 then
		return
	end
	
	self:SetNextSecondaryFire( time + self.Primary.Delay )
	self:SetNextPrimaryFire( time + self.Primary.Delay )
	
	local RecMod = GetConVarNumber("cstm_recoilmod")
	
	if SERVER then
		if self.IsSilenced == false then
			self.Owner:EmitSound(self.Primary.Sound, 101, math.random(99, 101))
		else
			if self.AltSilencedSound == true then
				self.Owner:EmitSound("weapons/scout/scout_fire-1.wav", 70, math.random(99, 101))
			else
				self.Owner:EmitSound(((self:GetClass():find("^cstm_pistol_") or self:GetClass():find("^cstm_smg_")) and "weapons/usp/usp1.wav") or "weapons/m4a1/m4a1-1.wav", 70, math.random(99, 101))
			end
		end
	end
	
	if self:GetDTInt(2) == 2 then
		local ent = ents.Create("round_frag")
		local AimVec = self.Owner:GetAimVector()
		local EyeAng = self.Owner:EyeAngles()
		local Offset
		
		if DTInt3 != 1 then
			Offset = EyeAng:Up() * -5 + EyeAng:Right() * 6
		else
			Offset = EyeAng:Up() * -5
		end
		
		ent:SetPos(self.Owner:GetShootPos() + AimVec * 30 + Offset)
		ent:SetAngles(self.Owner:EyeAngles())
		ent:Spawn()
		ent:GetPhysicsObject():SetVelocity(AimVec * 2000)
		ent.Owner = self.Owner
		
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK) 		// View model animation
		self.Owner:GetViewModel():SetPlaybackRate(self.PlaybackRate or 1) -- some weapons in the pack have slow recoil animation, so I've decided to slightly speed it up
			
		if self.IsSilenced == false then
			self.Owner:MuzzleFlash()								// Crappy muzzle light
		end
			
		self.Owner:SetAnimation(PLAYER_ATTACK1)				// 3rd Person Animation
		
		if DTInt3 == 1 then
			self:Recoil(self.Primary.Recoil * 0.75 * RecMod)
		else
			self:Recoil(self.Primary.Recoil * 1.2 * RecMod)
		end
		
		self.Owner:ViewPunch( Angle(-1 * (self.Primary.Recoil + self.ConeInaccuracy * 4) * (1 - (self.RecoilAff1 + self.RecoilAff2 + self.RecoilAff3)), 0, 0 ) * RecMod )
		
		return
	end
	
	if ( !self:CanPrimaryAttack() ) then return end
	
	self.ReloadDelay = time + 0.5
	
	if DTInt3 != 1 then
		self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil * 1.2, self.Primary.NumShots, self:GetDTFloat(0))
	else
		self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil * 0.75, self.Primary.NumShots, self:GetDTFloat(0))
	end
	
	if self.Owner:Crouching() then
		ConeDecAff1 = 0.02
		self.RecoilAff2 = 0.3
	else
		ConeDecAff1 = 0
		self.RecoilAff2 = 0
	end
	
	if self:GetDTInt(3) == 1 then
		ConeDecAff2 = 0.01
		self.RecoilAff1 = 0.3
	else
		ConeDecAff2 = 0
		self.RecoilAff1 = 0
	end
	
	if DTInt3 == 1 then
		self:Recoil(self.Primary.Recoil * 0.75 * RecMod)
	else
		self:Recoil(self.Primary.Recoil * 1.2 * RecMod)
	end
	
	self.Owner:ViewPunch( Angle(-1 * (self.Primary.Recoil + self.ConeInaccuracy * 4) * (1 - (self.RecoilAff1 + self.RecoilAff2 + self.RecoilAff3)), 0, 0 ) * RecMod )
	self:TakePrimaryAmmo( 1 )
	
	if ( self.Owner:IsNPC() ) then return end
end

function SWEP:CSShootBullet( dmg, recoil, numbul, cone )
	numbul 	= numbul 	or 1
	cone 	= cone 		or 0.01
		
	/*local offset
	
	if self:GetDTInt(3) == 10 then
		offset = self.Owner:EyeAngles():Right() * 10
	elseif self:GetDTInt(3) == 11 then
		offset = self.Owner:EyeAngles():Right() * -10
	elseif self:GetDTInt(3) == 12 then
		offset = self.Owner:EyeAngles():Up() * 10
	else
		offset = Vector(0, 0, 0)
	end*/
		
	local bullet = {}
	bullet.Num 		= numbul
	bullet.Src 		= self.Owner:GetShootPos() //+ offset		// Source
	bullet.Dir 		= ( self.Owner:EyeAngles() + self.Owner:GetPunchAngle() ):Forward()		// Dir of bullet
	bullet.Spread 	= Vector( cone, cone, 0 )			// Aim Cone
	bullet.Tracer	= 4									// Show a tracer on every x bullets 
	bullet.Force	= self.Primary.Damage									// Amount of force to give to phys objects
	if self.IsSilenced then
		damagemod1 = 0.1
	else
		damagemod1 = 0
	end
	
	if self:GetDTInt(2) == 1 then
		damagemod2 = 0.3
	else
		damagemod2 = 0
	end
	
	bullet.Damage = math.Round((self.Primary.Damage * (1 - (damagemod1 + damagemod2 ))) * GetConVarNumber("cstm_damagemod"))
	
	bullet.Callback = function(attacker, trace, dmginfo)
		if SERVER and self:GetDTInt(2) == 1 then
			if IsValid(trace.Entity) then
				trace.Entity:Ignite(6)
			end
		end
		
		--[[local penetrationForce
		local hitMat = trace.MatType 
		
		if hitMat == MAT_PLASTIC then
			penetrationForce = 1.25
		elseif hitMat == MAT_WOOD then
			penetrationForce = 1
		elseif hitMat == MAT_TILE then
			penetrationForce = 0.75
		elseif hitMat == MAT_CONCRETE then
			penetrationForce = 0.5
		elseif hitMat == MAT_METAL or hitMat == MAT_VENT then
			penetrationForce = 0.5
		else
			penetrationForce = 1
		end
		
		local forward = bullet.Dir:Normalize()
		local tr = {}
		tr.start = trace.HitPos
		tr.endpos = tr.start
		tr.filter = self
		
		local trace2 = util.TraceLine(tr)
		
		if not trace2.HitWorld and trace.Entity != trace2.Entity then
			local bullet2 = {}
			bullet2.Num = bullet.Num
			bullet2.Src = trace.HitPos + forward * 8 * penetrationForce
			bullet2.Dir = bullet.Dir
			bullet2.Spread = Vector(0, 0, 0)
			bullet2.Tracer = bullet.Tracer
			bullet2.Force = bullet.Force * 0.5
			bullet2.Damage = bullet.Damage * 0.5
			//ParticleEffect("cstm_penetration_smoke", trace.HitPos + (forward * 4) * penetrationForce, Angle(0, 0, 0), nil)
			
			if SERVER then
				self.Owner:LagCompensation(false)
			end
			
			self.Owner:FireBullets(bullet2)
		end]]--
		
	end
	
	self.Owner:FireBullets(bullet)
	
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK) 		// View model animation
	
	self.Owner:GetViewModel():SetPlaybackRate(self.PlaybackRate or 1) -- some weapons in the pack have slow recoil animation, so I've decided to slightly speed it up
	
	if self.IsSilenced == false then
		self.Owner:MuzzleFlash()								// Crappy muzzle light
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)				// 3rd Person Animation
	
	if ( self.Owner:IsNPC() ) then return end
	
	// CUSTOM RECOIL !
end