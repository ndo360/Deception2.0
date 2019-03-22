
if (SERVER) then

	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
	SWEP.ScopeStatus = 0
	SWEP.LastMag = 0
	SWEP.NoGL = true
	SWEP.SecondaryAtt = 0
	SWEP.GrenadeType = "gren_explosive"
	SWEP.BlastRadius = 256
	SWEP.BlastDamage = 80
	SWEP.Grenade = false
	SWEP.RailType = 1
	SWEP.CanAimWithRail = false
	SWEP.EoTechWithRail = false
	SWEP.NoVertGrip = true
	SWEP.NoCMag = true
	SWEP.MeleeDelay = 0
	SWEP.IsCustomWeapon = true
	SWEP.RequiresRail = true
	SWEP.CanUnload = true
	SWEP.TakesUpSlot = true
end

if ( CLIENT ) then

	SWEP.OffsetBones = {}
	SWEP.IsCustomWeapon = true

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.DrawWeaponInfoBox  = true
	SWEP.HasInstalledScope  = false
	SWEP.TimeToStartOffset = 0
	SWEP.PitchMod = 1
	SWEP.RollMod = 1
	SWEP.EoTechWithRail = false
	SWEP.BoneApproachSpeed = 0.3
	SWEP.RecoilAmt = 0
	SWEP.LaserTune = {
		PosRight = 0,
		PosForward = 0,
		PosUp = 0,
		AngUp = -90,
		AngRight = 0,
		AngForward = 0 }

	// This is the font thats used to draw the death icons
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
SWEP.Base = "dec_cmodel_cstm_base"
SWEP.Category = "Customizable weaponry"

SWEP.RunPos = Vector(-3.587, -11.735, -0.438)
SWEP.RunAng = Vector(0, -70, 0)

SWEP.RunPosPistol = Vector(0.328, -10.82, -4.621)
SWEP.RunAngPistol = Vector(70, 0, 0)

SWEP.RunPosNoFlip = Vector(3.443, -10.164, 0)
SWEP.RunAngNoFlip = Vector(0, 70, 0)

SWEP.FlipOriginsPos = Vector(3.305, -1.968, 0.735)
SWEP.FlipOriginsAng = Vector(0, 0, 0)

SWEP.NoFlipOriginsPos = Vector(-2.25, 0, -0.695)
SWEP.NoFlipOriginsAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(-2.945, -16.951, -6.206)
SWEP.MeleeAng = Vector(0, -90, 29.261)

SWEP.MeleePosNoFlip = Vector(3.769, -9.672, -7.049)
SWEP.MeleeAngNoFlip = Vector(28.688, 70, 0)

SWEP.ConeAff3 = 0
SWEP.ConeInaccuracy = 0
SWEP.ConeInaccuracyDec = 0
SWEP.SilencedSound = Sound("weapons/usp/usp1.wav")
SWEP.SilencedVolume = 70
SWEP.UnsilencedVolume = 101
SWEP.ConeInaccuracyAff1 = 1
SWEP.RecoilAff1 = 0
SWEP.RecoilAff2 = 0
SWEP.RecoilAff3 = 0
SWEP.InaccAff1 = 1
SWEP.ConeInaccDelay = 0
SWEP.ConeDecAff1 = 0
SWEP.ConeDecAff2 = 0
SWEP.MeleeDamageMin = 10
SWEP.MeleeDamageMax = 15

/*---------------------------------------------------------
---------------------------------------------------------*/
function SWEP:Initialize()

	if ( SERVER ) then
		self:SetNPCMinBurst( 30 )
		self:SetNPCMaxBurst( 30 )
		self:SetNPCFireRate( 0.01 )

		if self.BulletLength and self.CaseLength then
			self.EffectiveRange = self.CaseLength * 10 - self.BulletLength * 5 -- setup realistic base effective range
			self.EffectiveRange = self.EffectiveRange / 2 -- halven it, because the maps aren't big enough and we want to balance shit out
			self.EffectiveRange = self.EffectiveRange * 39.37 -- convert units to meters
			self.DamageDecay = self.BulletLength / self.CaseLength -- setup the damage decay over distance in percentage
		end
	end

	self:SetWeaponHoldType("normal")
	self:SetDTInt(3, 20)
	self:SetDTFloat(0, 0)
	self:SetDTInt(2, 0)
	self.ReloadDelay = CurTime() + 0.1
	self.Primary.Recoil = self.DefRecoil

    if CLIENT then

		if self.Primary.Automatic and not self.Burst then
			self.Bullets = 5
		elseif self.Primary.Automatic and self.Burst then
			self.Bullets = 3
		else
			self.Bullets = 1
		end

        self:CreateModels(self.VElements) // create viewmodels
        self:CreateModels(self.WElements) // create worldmodels

        // init view model bone build function
        /*self.BuildViewModelBones = function( s )
            if LocalPlayer():GetActiveWeapon() == self and self.ViewModelBonescales then
                for k, v in pairs( self.ViewModelBonescales ) do
                    local bone = s:LookupBone(k)
                    if (!bone) then continue end
                    local m = s:GetBoneMatrix(bone)
                    if (!m) then continue end
                    m:Scale(v)
                    s:SetBoneMatrix(bone, m)
                end
            end
        end*/

		/*self:GetViewModel().BuildBonePositions = function(self, numbon, numphysbon)
			local bone = self:GetViewModel():LookupBone("Right_U_Arm")
			local matrix = self:GetBoneMatrix(bone)

			if matrix then
				matrix:Translate(Vector(0, 0, -2))
				self:SetBoneMatrix(matrix)
			end
		end*/


		if self.ReposMyBones and self.BonesToRepos then
			self.Owner.BuildBonePositions = self.BoneReposFunc
		end
    end
end

function SWEP:Equip(ply)
	ply.Weight = ply.Weight + (self.Size or 5)
end

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

local initial = false

function SWEP:Holster(weapon)
	self.Owner:GetViewModel().BuildBonePositions = nil

	if self:GetDTInt(3) != 20 then
		self:SetDTInt(3, 0)
	end

	local nick = self.Owner:Nick()
	timer.Destroy("StartCustomReloadTimer" .. nick)
	timer.Destroy("StartCustomReloadTimer2" .. nick)
	timer.Destroy("AmmoInc" .. nick)
	timer.Destroy("ReloadLogic" .. nick)
	timer.Destroy("ReloadTimer" .. nick)


	if SERVER then
		self.Owner:SetFOV(0, 0.3)

		if game.SinglePlayer() then
			self.Owner:SendLua("timer.Destroy('CLATT' .. LocalPlayer():Nick())")
			return true
		end
	end

	if CLIENT then
		timer.Destroy("CLATT" .. nick)
	end

	return true
end

function SWEP:Reload()
	local dt3 = self:GetDTInt(3)

	if dt3 == 20 then
		return
	end

	if dt3 == 18 then
		return
	end

	if self.HasReleasedKey == false or CurTime() < self.ReloadDelay then
		return
	end

	if SERVER then
		if self.Owner:KeyDown(IN_USE) then
			if self.NoAuto != true then
				if self.Primary.Automatic == true then
					self.Primary.Automatic = false
					self.Owner:EmitSound("weapons/smg1/switch_single.wav", 70, math.random(99, 101))
					umsg.Start("FRMD", self.Owner)
						umsg.String("semi")
					umsg.End()
				else
					self.Primary.Automatic = true
					self.Owner:EmitSound("weapons/smg1/switch_burst.wav", 70, math.random(99, 101))
					umsg.Start("FRMD", self.Owner)
						umsg.String("auto")
					umsg.End()
				end
				self.HasReleasedKey = false
				self.ReloadDelay = CurTime() + 0.5
				return
			end
		end
	end

	local clip = self:Clip1()

	if self:GetDTInt(3) != 2 then
		if clip < self.Primary.ClipSize + 1 and clip < self.Primary.ClipSize then
			if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
				if CurTime() > self.ReloadDelay then
					if SERVER then
						if self.Owner:GetFOV() != 0 then
							self.Owner:SetFOV(0, 0.3)
							self.Owner:DrawViewModel(true)
							self.LastMag = clip

							if clip > 1 then
								local ammotype = self:GetPrimaryAmmoType()

								if not self.CantChamber then
									self.Owner:SetAmmo(self.Owner:GetAmmoCount(ammotype) + clip - 1, ammotype)
									self:SetClip1(1)
								else
									self.Owner:SetAmmo(self.Owner:GetAmmoCount(ammotype) + clip, ammotype)
									self:SetClip1(0)
								end
							end
						end
					end

					self:SendWeaponAnim(ACT_VM_IDLE)
					self:StartCustomReload(self.AnimPrefix .. (self.ReloadAct or "reload"), self.ReloadSpeed)
					self.Owner:SetAnimation(PLAYER_RELOAD)
					self.AnimPlayed = false
					self:SetDTInt(3, 0)
				end
			end
		end
	end
end

function SWEP:StartCustomReload(anim, animspeed)
	self:SendWeaponAnim(ACT_VM_RELOAD)

	local vm = self.Owner:GetViewModel()

	vm:SetPlaybackRate(animspeed)

	local clip = self:Clip1()
	local mul = clip == 0 and 1 or 1 - self.IncAmmoPerc

	if clip then
		self.ShouldBolt = true
	end

	local seqdur = vm:SequenceDuration()

	local time = (seqdur / self.ReloadSpeed) - ((seqdur / self.ReloadSpeed) * self.IncAmmoPerc)

	timer.Create("StartCustomReloadTimer" .. self.Owner:Nick(), time, 1, function()
		if not IsValid(self) or (IsValid(self) and IsValid(self.Owner) and self:GetClass() != self.Owner:GetActiveWeapon():GetClass()) then
			return
		end

		self:FinishCustomReload(self.ShouldBolt)
	end)

	local CT = CurTime()

	self:SetNextPrimaryFire(CT + (seqdur / self.ReloadSpeed) * mul)
	self:SetNextSecondaryFire(CT + (seqdur / self.ReloadSpeed) * mul)
	self.ReloadDelay = CT + (seqdur / self.ReloadSpeed + 0.3) * mul
	self.Owner.AttachDelay = CT + (seqdur / self.ReloadSpeed) * mul
	self.MeleeDelay = CT + (seqdur / self.ReloadSpeed) * mul
end

function SWEP:FinishCustomReload(bolt)
	local time = CurTime()
	local clip = self:Clip1()
	local ammo = self.Owner:GetAmmoCount(self.Primary.Ammo)
	//local AvailableReload = math.Clamp(clip + self.Owner:GetAmmoCount(self.Primary.Ammo), 0, self.Primary.ClipSize)
	local AmountToReload = self.Primary.ClipSize - clip

	if self:Clip1() == 0 then
		self.Owner:RemoveAmmo(AmountToReload, self.Primary.Ammo)
		self:SetClip1(math.Clamp(ammo, 0, self.Primary.ClipSize))
	else
		local chamber = self.ChamberAmount or 1

		if ammo > (AmountToReload + chamber) and self.CantChamber != true then
			self.Owner:RemoveAmmo(AmountToReload + chamber, self.Primary.Ammo)
			self:SetClip1(self.Primary.ClipSize + chamber)
		else
			self.Owner:RemoveAmmo(AmountToReload, self.Primary.Ammo)
			self:SetClip1(ammo + clip)
		end

		if self.SkipIdle != true then
			self:SendWeaponAnim(ACT_VM_IDLE)
			self:SetNextPrimaryFire(time + 0.25)
			self:SetNextSecondaryFire(time + 0.25)
			self.ReloadDelay = time + 0.25
			self.Owner.AttachDelay = time + 0.25
			self.MeleeDelay = time + 0.25
		end
	end

	if bolt == false or self.NoBoltAnim == true then
		self.ShouldBolt = false
	else
		self:BoltWeaponry()
		self.ShouldBolt = false
	end
end

function SWEP:BoltWeaponry()
	local vm = self.Owner:GetViewModel()
	local sequence = vm:LookupSequence(self.AnimPrefix .. "draw")
	vm:ResetSequence(sequence)
	vm:SetPlaybackRate(self.ReloadSpeed)

	timer.Simple((vm:SequenceDuration() / self.ReloadSpeed) - 0.2, function()
		if self.Weapon == nil or self:GetClass() != self.Owner:GetActiveWeapon():GetClass() then
			return
		end

		self:SendWeaponAnim(ACT_VM_IDLE)
	end)
end

function SWEP:Think()
	local DTInt3 = self:GetDTInt(3)

	if SERVER then
		if DTInt3 != 20 then
			local AimVec = self.Owner:GetAimVector()

			if not self.Owner.LastView then
				self.Owner.LastView = AimVec
				self.Owner.ViewAff = 0
			else
				self.Owner.ViewAff = Lerp(0.25, self.Owner.ViewAff, (AimVec - self.Owner.LastView):Length() * 0.15)
				self.Owner.LastView = AimVec
			end

			self.Primary.Cone = math.Clamp((self.CurCone + self.ConeInaccuracy + ((self.Owner:GetVelocity():Length() / 10000) * (DTInt3 == 1 and self.VelocitySensivity * 0.3 or self.VelocitySensivity)) - (self.ConeAff1 + self.ConeAff3) + self.Owner.ViewAff), 0.002, 0.15)
			self:SetDTFloat(0, math.Clamp(self.Primary.Cone * self.Owner.InexperienceRatio, 0.002, 0.12 * (1 - (self.RecoilAff1 + self.RecoilAff2))))

			if CurTime() > self.ConeInaccDelay then
				self.ConeInaccuracy = math.Clamp(self.ConeInaccuracy - 0.0015, 0, 0.08 * self.ConeInaccuracyAff1)
			end

			if self.Owner:Crouching() and self.Owner:OnGround() then
				self.ConeAff1 = 0.005
				self.ConeDecAff1 = 0.0025
				self.RecoilAff2 = 0.3
			else
				self.ConeAff1 = 0
				self.ConeDecAff1 = 0
				self.RecoilAff2 = 0
			end

			if self.IsSilenced then
				self.RecoilAff3 = 0.15
			else
				self.RecoilAff3 = 0
			end

			if DTInt3 == 1 then
				self.ConeDecAff2 = 0.0045
				self.RecoilAff1 = 0.3
				if self.ScopeStatus >= 2 then
					self.CurCone = self.ScopeCone - ((self.ScopeStatus == 2 and 0.007) or (self.ScopeStatus == 3 and 0.003) or (self.ScopeStatus == 4 and 0.002) or (self.ScopeStatus == 9 and 0) or 0)
				else
					self.CurCone = self.IronsightsCone
				end

				if self.HeadbobMul == 1 then
					self.HeadbobMul = 0.4
				end

				if (self:GetClass():find("^dec_rif_") or self:GetClass():find("dec_sniper_")) and not self.Primary.Automatic then
					self.ConeAff3 = 0.003
				else
					self.ConeAff3 = 0
				end
			elseif DTInt3 == 17 then
				self.ConeDecAff2 = 0.0045
				self.RecoilAff1 = 0.5
				self.CurCone = self.IronsightsCone
			else
				self.ConeDecAff2 = 0
				self.RecoilAff1 = 0
				self.CurCone = self.HipCone

				if self.HeadbobMul == 0.4 then
					self.HeadbobMul = 1
				end

				if self:GetClass():find("^dec_rif_") or self:GetClass():find("^dec_sniper_") then
					self.ConeAff3 = 0
				end
			end
		end
	end

	if DTInt3 != 20 then
		if not self.Owner:KeyDown(IN_ATTACK) and self.NumShots != 0 and self.Burst then
			self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 2)
			self.NumShots = 0
		end

		local wepclass = self:GetClass()

		if self.Owner:KeyDown(IN_SPEED) and self.Owner:OnGround() and DTInt3 != 6 and DTInt3 != 10 and DTInt3 != 15 and DTInt3 != 17 and DTInt3 != 18 then
			if self.Owner:GetVelocity():Length() > self.Owner:GetWalkSpeed() then
				if DTInt3 != 2 and DTInt3 != 15 and DTInt3 != 18 then
					if wepclass:find("^dec_pistol_") then
						self:SetDTInt(3, 18)
					else
						self:SetDTInt(3, 2)
					end

					if SERVER then
						self.Owner:SetFOV(0, 0.3)
						self.Owner:DrawViewModel(true)
					end
				end

			else
				if DTInt3 != 1 or DTInt3 != 8 and DTInt3 != 10 and DTInt3 != 11 and DTInt3 != 12 and DTInt3 != 15 and DTInt3 != 17 and DTInt3 != 18 then
					self:SetDTInt(3, 0)

					if SERVER then
						self.Owner:SetFOV(0, 0.3)
						self.Owner:DrawViewModel(true)
					end
				end
			end
		elseif not self.Owner:KeyDown(IN_SPEED) and DTInt3 != 1 and DTInt3 != 0 and DTInt3 != 6 and DTInt3 != 8 and DTInt3 != 10 and DTInt3 != 11 and DTInt3 != 12 and DTInt3 != 15 and DTInt3 != 17 or not self.Owner:OnGround() and DTInt3 != 6 and DTInt3 != 0 and DTInt3 != 15 and DTInt3 != 17 then
			self:SetDTInt(3, 0)
			if SERVER then
				self.Owner:SetFOV(0, 0.2)
				self.Owner:DrawViewModel(true)
			end
		end

		if not self.Owner:KeyDown(IN_RELOAD) then
			if self.HasReleasedKey == false then
				self.HasReleasedKey = true
			end
		end

		if self.Burst and not self.Owner:KeyDown(IN_ATTACK) then
			self.Shots = 0
		end
	end

	if CLIENT then
		self.Owner:GetViewModel().BuildBonePositions = function(self, numbon, numphysbon)

			if not IsValid(LocalPlayer():GetActiveWeapon()) then
				return
			end

			local ply = LocalPlayer()
			local vm = ply:GetViewModel()
			local wep = ply:GetActiveWeapon()
			local activity = wep:GetSequenceActivityName(wep:GetSequence())
			local seqdur = vm:SequenceDuration()
			local FT = FrameTime()

			if not wep.IsCustomWeapon then
				return
			end

			if IsValid(wep) then
				if wep.MagBone then
					if wep.VElements and wep.VElements["cmag"].color.a == 255 then
						local bone = vm:LookupBone(wep.MagBone)
						local matrix = vm:GetBoneMatrix(bone)

						if matrix then
							matrix:Scale(Vector(0.01, 0.01, 0.01))
							vm:SetBoneMatrix(bone, matrix)
						end
					end
				end

				if wep.OtherBone then
					if wep.VElements and ((wep.VElements["eotech"] and wep.VElements["eotech"].color.a == 255) or (wep.VElements["aimpoint"] and wep.VElements["aimpoint"].color.a == 255) or (wep.VElements["acog"] and wep.VElements["acog"].color.a == 255)) then
						local bone = vm:LookupBone(wep.OtherBone)
						local matrix = vm:GetBoneMatrix(bone)

						if matrix then
							matrix:Scale(Vector(0.01, 0.01, 0.01))
							vm:SetBoneMatrix(bone, matrix)
						end
					end
				end

				if wep.ViewModelBonescales then
					for k, v in pairs( wep.ViewModelBonescales ) do
						local bone = vm:LookupBone(k)
						if (!bone) then continue end
						local m = vm:GetBoneMatrix(bone)
						if (!m) then continue end
						m:Scale(v)
						vm:SetBoneMatrix(bone, m)
					end
				end

				if self.ViewModelBonescales then
					for k, v in pairs( self.ViewModelBonescales ) do
						local bone = s:LookupBone(k)
						if (!bone) then continue end
						local m = s:GetBoneMatrix(bone)
						if (!m) then continue end
						m:Scale(v)
						s:SetBoneMatrix(bone, m)
					end
				end

				if wep:GetDTInt(3) == 15 then
					if wep.MeleeOffset then
						wep.TargetOffset = wep.MeleeOffset
					else
						if wep.VElements["vertgrip"] and wep.VElements["vertgrip"].color.a == 255 then
							wep.TargetOffset = wep.VertGrip_Idle
						elseif wep.VElements["cmag"] and wep.VElements["cmag"].color.a == 255 then
							wep.TargetOffset = wep.CMag_Idle
						end
					end
				else
					if wep.VElements and (wep.VElements["grenadelauncher"] or wep.VElements["vertgrip"] or wep.VElements["cmag"]) then

						if wep.VElements["grenadelauncher"] and wep.VElements["grenadelauncher"].color.a == 255 then

							if activity == "ACT_VM_RELOAD" or activity == "ACT_VM_RELOAD_SILENCED" or activity == "ACT_VM_DETACH_SILENCER" or activity == "ACT_VM_ATTACH_SILENCER" then

								if wep.OffsetMeStage == 1 then
									wep.TargetOffset = "none"
								elseif wep.OffsetMeStage == 2 then
									wep.TargetOffset = wep.GrenadeLauncher_Idle
								end
							else
								if wep:GetDTInt(3) == 8 then
									wep.TargetOffset = wep.GrenadeLauncher_Active
								else
									wep.TargetOffset = wep.GrenadeLauncher_Idle
								end
							end

						elseif wep.VElements["vertgrip"] and wep.VElements["vertgrip"].color.a == 255 then
							if activity == "ACT_VM_RELOAD" or activity == "ACT_VM_RELOAD_SILENCED" then
								if wep.VElements["cmag"] and wep.VElements["cmag"].color.a == 255 then
									if wep.OffsetMeStage == 1 then
										wep.TargetOffset = "none"
									elseif wep.OffsetMeStage == 2 then
										wep.TargetOffset = wep.CMag_Reload or "none"
									end
								else
									if wep.OffsetMeStage == 1 then
										wep.TargetOffset = "none"
									elseif wep.OffsetMeStage == 2 then
										wep.TargetOffset = wep.VertGrip_Idle
									end
								end
							elseif activity == "ACT_VM_ATTACH_SILENCER" or activity == "ACT_VM_DETACH_SILENCER" then
								if wep.OffsetMeStage == 1 then
									wep.TargetOffset = "none"
								elseif wep.OffsetMeStage == 2 then
									wep.TargetOffset = wep.VertGrip_Idle
								end
							else
								wep.TargetOffset = wep.VertGrip_Idle
							end
						else
							if wep.VElements["cmag"] and wep.VElements["cmag"].color.a == 255 then
								if activity == "ACT_VM_RELOAD" or activity == "ACT_VM_RELOAD_SILENCED" then
									if wep.OffsetMeStage == 1 then
										wep.TargetOffset = "none"
									elseif wep.OffsetMeStage == 2 then
										wep.TargetOffset = wep.CMag_Reload or "none"
									end
								elseif activity == "ACT_VM_ATTACH_SILENCER" or activity == "ACT_VM_DETACH_SILENCER" then
									if wep.OffsetMeStage == 1 then
										wep.TargetOffset = "none"
									elseif wep.OffsetMeStage == 2 then
										wep.TargetOffset = wep.CMag_Idle
									end
								else
									wep.TargetOffset = wep.CMag_Idle
								end
							else
								wep.TargetOffset = {}
							end
						end
					else
						wep.TargetOffset = "none"
					end
				end

				if wep.TargetOffset == "none" and wep.OffsetBones then
					for k, v in pairs(wep.OffsetBones) do

						wep.OffsetBones[k] = wep.OffsetBones[k] or {}

						if v.curoffset then
							v.curoffset = LerpVector(FT * 27, v.curoffset, Vector(0, 0, 0))
						end

						if v.currotation then
							v.currotation = LerpVector(FT * 27, v.currotation, Vector(0, 0, 0))
						end

						local bone = vm:LookupBone(k)
						local matrix = self:GetBoneMatrix(bone)

						if matrix then
							if v.curoffset then
								matrix:Translate(wep.OffsetBones[k].curoffset)
							end

							if v.currotation then
								matrix:Rotate(wep.OffsetBones[k].currotation)
							end

							self:SetBoneMatrix(bone, matrix)
						end
					end

				else

					if wep.TargetOffset and wep.TargetOffset != "none" then
						for k, v in pairs(wep.TargetOffset) do

							wep.OffsetBones[k] = wep.OffsetBones[k] or {}

							if not wep.OffsetBones[k].curoffset and not wep.OffsetBones[k].currotation then
								wep.OffsetBones[k].curoffset = Vector(0, 0, 0)
								wep.OffsetBones[k].currotation = Vector(0, 0, 0)
							end

							if wep.OffsetMeStage == 1 then
								wep.OffsetBones[k].curoffset = LerpVector(FT * 27, wep.OffsetBones[k].curoffset, v.vector or Vector(0, 0, 0))
								wep.OffsetBones[k].currotation = LerpVector(FT * 27, wep.OffsetBones[k].currotation, v.angle or Vector(0, 0, 0))
							elseif wep.OffsetMeStage == 2 then
								wep.OffsetBones[k].curoffset = LerpVector(FT * 27, wep.OffsetBones[k].curoffset, v.vector)
								wep.OffsetBones[k].currotation = LerpVector(FT * 27, wep.OffsetBones[k].currotation, v.angle)
							end

							local bone = vm:LookupBone(k)
							local matrix = self:GetBoneMatrix(bone)

							if matrix then
								matrix:Translate(wep.OffsetBones[k].curoffset)
								matrix:Rotate(wep.OffsetBones[k].currotation)
								self:SetBoneMatrix(bone, matrix)
							end

						end
					end
				end

				if (activity == "ACT_VM_RELOAD" or activity == "ACT_VM_RELOAD_SILENCED" or activity == "ACT_VM_ATTACH_SILENCER" or activity == "ACT_VM_DETACH_SILENCER") and not wep:GetClass():find("^dec_shotgun") then
					if not wep.TimerCreated then

						wep.OffsetMeStage = 1

						local TimeRel, TimeIdle

						if wep:Clip1() > 0 and (activity == "ACT_VM_RELOAD" or activity == "ACT_VM_RELOAD_SILENCED") then
							TimeRel = (seqdur * (1 - wep.IncAmmoPerc)) / wep.ReloadSpeed
							TimeIdle = (seqdur * (1 - wep.IncAmmoPerc)) / wep.ReloadSpeed
						else
							TimeRel = (seqdur / wep.ReloadSpeed) - 0.5
							TimeIdle = (seqdur / wep.ReloadSpeed) - 0.01
						end

						timer.Simple(TimeRel, function()
							wep.OffsetMeStage = 2
						end)

						timer.Simple(TimeIdle, function()
							//if wep.Silenced == 1 then
							//	wep:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
							//else

							if not IsValid(wep) or wep:GetClass() != ply:GetActiveWeapon():GetClass() then
								return
							end
								wep:SendWeaponAnim(ACT_VM_IDLE)
							//end
						end)

						wep.TimerCreated = true
					end
				else
					wep.TimerCreated = false
					wep.OffsetMeStage = 2
				end
			end
		end
	end
end

function SWEP:PrimaryAttack()
	local dt3 = self:GetDTInt(3)

	if dt3 == 20 then
		return
	end

	if self.ShouldBolt == true or self.IsReloading == true then
		return
	end

	if dt3 == 2 then
		return
	end

	local time = CurTime()

	if self.SecondaryAtt == 1 and self.Owner:KeyDown(IN_USE) and self:GetDTInt(3) != 8 then

		if SERVER then
			if self.Grenade == false then
				self.Owner:EmitSound("weapons/shotgun/shotgun_empty.wav", 65, math.random(99, 101))
				self.Grenade = true
			else
				self.Owner:EmitSound("weapons/ClipEmpty_Rifle.wav", 65, math.random(99, 101))
				self.Grenade = false
			end
		end

		self:SetNextPrimaryFire( time + 0.25 )
		self:SetNextSecondaryFire( time + 0.25 )
		return
	end

	if (self:Clip1() == 0 or self.Owner:WaterLevel() == 3) and not self.Grenade then
		self:EmitSound("weapons/shotgun/shotgun_empty.wav", 65, math.random(99, 101))
		self:SetNextSecondaryFire( time + 0.05 )
		self:SetNextPrimaryFire( time + 0.25 )
		return
	end

	if CLIENT and not game.SinglePlayer() then
		if self.Owner:KeyDown(IN_USE) then
			if (self.VElements and self.VElements["grenadelauncher"] and self.VElements["grenadelauncher"].color.a == 255) or self:GetDTInt(3) == 8 then
				return
			end
		else
			if self.VElements and self.VElements["grenadelauncher"] and self.VElements["grenadelauncher"].color.a == 255 and self:GetDTInt(3) == 8 then
				return
			end
		end
	end

	if SERVER then
		if self.SecondaryAtt == 1 and self.Grenade and self:GetDTInt(3) == 8 then
			if self.Owner:GetAmmoCount("SMG1_Grenade") == 0 then
				self.Owner:EmitSound("weapons/shotgun/shotgun_empty.wav", 65, math.random(99, 101))
				self:SetNextPrimaryFire( time + 0.25 )
				self:SetNextSecondaryFire( time + 0.05 )
				return
			end

			local prop = ents.Create(self.GrenadeType)
			prop:SetPos(self.Owner:EyePos() + self.Owner:GetAimVector() * 24 + self.Owner:GetRight() * 4 + self.Owner:GetUp() * -6)
			prop:SetOwner(self.Owner)
			prop:SetAngles(self.Owner:EyeAngles())
			prop.BlastRadius = self.BlastRadius
			prop.BlastDamage = self.BlastDamage
			prop:Spawn()
			prop:GetPhysicsObject():SetVelocity(self.Owner:GetAimVector() * 3500)
			prop:SetGravity(1.4)
			prop:SetOwner(self.Owner)

			self.Owner:ViewPunch(Angle(-10, 0, 0))
			self.Owner:EmitSound("weapons/grenade_launcher1.wav", 85, 100)
			self:TakeSecondaryAmmo(1)
			self:SetDTInt(3, 0)
			self.Owner:SetFOV(0, 0.3)

			if self.Owner:GetAmmoCount("SMG1_Grenade") > 0 then
				self:SetNextPrimaryFire(time + 3)
				self:SetNextSecondaryFire(time + 3)
				self.ReloadDelay = time + 3
				self.Owner.AttachDelay = time + 3
			else
				self:SetNextPrimaryFire(time + 0.3)
				self:SetNextSecondaryFire(time + 0.3)
				self.ReloadDelay = time + 0.3
				self.Owner.AttachDelay = time + 0.3
			end

			timer.Simple(0.5, function()
				if (self.Weapon == nil or self:GetClass() != self.Owner:GetActiveWeapon():GetClass()) or self.Owner:GetAmmoCount("SMG1_Grenade") == 0 then
					return
				end

			self:SetDTInt(3, 6)
			end)

			timer.Simple(1, function()
				if (self.Weapon == nil or self:GetClass() != self.Owner:GetActiveWeapon():GetClass()) or self.Owner:GetAmmoCount("SMG1_Grenade") == 0 then
					return
				end

				self.Owner:EmitSound("weapons/smg1/smg1_reload.wav", 50, 100)
				self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_GIVE)
			end)

			timer.Simple(2.75, function()
				if (self.Weapon == nil or self:GetClass() != self.Owner:GetActiveWeapon():GetClass()) or self.Owner:GetAmmoCount("SMG1_Grenade") == 0 then
					return
				end

				self:SetDTInt(3, 0)
			end)

			if self.Owner:GetAmmoCount("SMG1_Grenade") == 0 then
				self.Grenade = false
			end

			return
		end
	end

	self:SetNextSecondaryFire( time + self.Primary.Delay )
	self:SetNextPrimaryFire( time + self.Primary.Delay )

	if ( !self:CanPrimaryAttack() ) then return end

	self:TakePrimaryAmmo( 1 )

	if SERVER then
		if self.IsSilenced == false then
			self.Owner:EmitSound(self.Primary.Sound, self.UnsilencedVolume, math.random(99, 101))
		else
			self.Owner:EmitSound(self.SilencedSound, self.SilencedVolume, math.random(99, 101))
		end

		if self:Clip1() <= 10 then
			self.Owner:EmitSound("weapons/ClipEmpty_Rifle.wav", 60 - (self:Clip1() * 4), 100)
		end

		if not game.SinglePlayer() then
			local ef = EffectData()
			ef:SetOrigin(self.Owner:GetShootPos())
			ef:SetEntity(self.Weapon)
			ef:SetAngles(self.Owner:GetAngles())
			util.Effect("dec_ef_muzzle", ef)
		end
	end

	self.ReloadDelay = time + 0.5
	self.Owner.AttachDelay = time + 0.5
	self.MeleeDelay = time + 0.3

	if self:GetDTInt(3) != 1 then
		self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil * 1.2, self.Primary.NumShots, self:GetDTFloat(0))
		self:Recoil(self.Primary.Recoil * 1.2)
	else
		self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil * 0.75, self.Primary.NumShots, self:GetDTFloat(0))
		self:Recoil(self.Primary.Recoil * 0.75)
	end

	if SERVER and game.SinglePlayer() then
		if self:GetDTInt(3) == 1 then
			SendUserMessage("RECOIL", self.Owner)
		end
	end

	if CLIENT then
		if self:GetDTInt(3) == 1 then
			self.RecoilAmt = 2.5
			self:MuzzleFlosh()
		end
	end

	self.Owner:ViewPunch( Angle(-1 * (self.Primary.Recoil + self.ConeInaccuracy * 4) * (1 - (self.RecoilAff1 + self.RecoilAff2 + self.RecoilAff3)), 0, 0 ) )

	self.ConeInaccuracy = math.Clamp(self.ConeInaccuracy + (0.005 + self.DefRecoil * (0.006 - (self.ConeDecAff1 + self.ConeDecAff2))) * self.InaccAff1, 0, 0.12 * (self.ConeInaccuracyAff1))
	self.ConeInaccDelay = time + self.Primary.Delay * 1.05

	if ( self.Owner:IsNPC() ) then return end
end

local damagemod1, damagemod2

/*---------------------------------------------------------
   Name: SWEP:CSShootBullet( )
---------------------------------------------------------*/
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

	bullet.Damage = math.Round((self.Primary.Damage * (1 - (damagemod1 + damagemod2 ))))

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

	if self:GetDTInt(3) != 1 then
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK) 		// View model animation
		self.AnimPlayed = true
	else
		if not self.AnimPlayed then
			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			self.AnimPlayed = true
		end
	end

	self.Owner:GetViewModel():SetPlaybackRate(self.PlaybackRate or 1) -- some weapons in the pack have slow recoil animation, so I've decided to slightly speed it up

	if self.IsSilenced == false then
		self.Owner:MuzzleFlash()								// Crappy muzzle light
	end

	self.Owner:SetAnimation(PLAYER_ATTACK1)				// 3rd Person Animation

	if ( self.Owner:IsNPC() ) then return end

	// CUSTOM RECOIL !
end

function SWEP:Recoil(recoil)
	if ( (game.SinglePlayer() && SERVER) || ( !game.SinglePlayer() && CLIENT && IsFirstTimePredicted() ) ) then
		local eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - ((recoil * 0.5) * (self.Owner.InexperienceRatio or 1))
		eyeang.yaw = eyeang.yaw - ((recoil * math.random(-1, 1) * 0.25) * (self.Owner.InexperienceRatio or 1))
		self.Owner:SetEyeAngles(eyeang)
	end
end


--[[--------------------------------------------------------
	Checks the objects before any action is taken
	This is to make sure that the entities haven't been removed
---------------------------------------------------------]]
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	if self.DifType then
		surface.SetDrawColor(255, 210, 0, 255)
		surface.SetTexture(self.WepSelectIcon)
		surface.DrawTexturedRect(x + 56, y, 128, 128)
	else
		draw.SimpleText( self.IconLetter, "CSSelectIcons", x + wide/2, y + tall*0.2, Color( 255, 210, 0, 255 ), TEXT_ALIGN_CENTER )
	end
end

local CurMul1 = 0
local CurMul2 = 0
local CurMul3 = 0
local CurMove = -2
local AmntToMove = 0.4
local MoveCycle = 0
local Ironsights_Time = 0.1
local CurShakeA = 0.03
local CurShakeB = 0.03
local randomdir = 0
local randomdir2 = 0
local timetorandom = 0
local BlendPos = Vector(0, 0, 0)
local BlendAng = Vector(0, 0, 0)
local ApproachRate = 0.2

function SWEP:GetViewModelPosition(pos, ang)
	if !self.AimPos then
		return pos, ang
	end

	local FT = FrameTime()
	local DTInt3 = self:GetDTInt(3)

	if DTInt3 == 2 then
		if self.ViewModelFlip then
			TargetPos = Vector(-0.82, -0.165, 0.656)
			TargetAng = Vector(-9.754, -24.673, 0)
		else
			TargetPos = Vector(-0.82, 0.165, 0.656)
			TargetAng = Vector(-9.754, 24.673, 0)
		end

		/*if self:GetClass():find("^cstm_pistol_") then
			TargetPos = self.RunPosPistol
			TargetAng = self.RunAngPistol
		else
			if self.ViewModelFlip == true then
				TargetPos = self.RunPos
				TargetAng = self.RunAng
			else
				TargetPos = self.RunPosNoFlip
				TargetAng = self.RunAngNoFlip
			end
		end*/
	elseif DTInt3 == 1 then
		TargetPos = self.AimPos
		TargetAng = self.AimAng
	elseif DTInt3 == 6  or DTInt3 == 20 then
		TargetPos = Vector(3.934, -9.344, -16.393)
		TargetAng = Vector(0, 0, 0)
	elseif DTInt3 == 15 then
		if self.ViewModelFlip then
			TargetPos = self.MeleePos or Vector(0, 0, 0)
			TargetAng = self.MeleeAng or Vector(0, 0, 0)
		else
			TargetPos = self.MeleePosNoFlip or Vector(0, 0, 0)
			TargetAng = self.MeleeAngNoFlip or Vector(0, 0, 0)
		end
	/*elseif self:GetDTInt(3) == 10 then
		if self.ViewModelFlip then
			TargetPos = Vector(-10, 0, 0)
		else
			TargetPos = Vector(10, 0, 0)
		end
		TargetAng = Vector(0, 0, 0)
	elseif self:GetDTInt(3) == 11 then
		if self.ViewModelFlip then
			TargetPos = Vector(15, 0, 0)
		else
			TargetPos = Vector(-15, 0, 0)
		end
		TargetAng = Vector(0, 0, 0)
	elseif self:GetDTInt(3) == 12 then
		TargetPos = Vector(-0.987, -10.082, 7.313)
		TargetAng = Vector(0, 0, 0)*/
	else
		TargetPos = Vector(0, 0, 0)
		TargetAng = Vector(0, 0, 0)
	end

	if DTInt3 == 1 then
		ApproachRate = FT * 20
	elseif DTInt3 == 6 or DTInt3 == 7 then
		ApproachRate = FT * 4
	elseif DTInt3 == 15 then
		ApproachRate = FT * 40
	else
		ApproachRate = FT * 7
	end

	BlendPos = LerpVector(ApproachRate, BlendPos, TargetPos)
	BlendAng = LerpVector(ApproachRate, BlendAng, TargetAng)

	CurShakeA = math.Approach(CurShakeA, randomdir, 0.01)
	CurShakeB = math.Approach(CurShakeB, randomdir2, 0.01)

	if CurTime() > timetorandom then
		randomdir = math.Rand(-0.1, 0.1)
		randomdir2 = math.Rand(-0.1, 0.1)
		timetorandom = CurTime() + 0.2
	end

	if DTInt3 == 1 then
		self.SwayScale 	= 0
		self.BobScale 	= 0.1
	elseif DTInt3 == 2 or DTInt3 == 4 then
		self.SwayScale 	= 1
		self.BobScale 	= 0.5
	elseif DTInt3 == 0 then
		self.SwayScale 	= 1
		self.BobScale 	= 1
	end

	if CurMove == -2 then
		MoveCycle = 1
	elseif CurMove == 2 then
		MoveCycle = 2
	end

	if MoveCycle == 1 then
		CurMove = math.Approach(CurMove, 2, 0.11 - CurMove * 0.05)
	elseif MoveCycle == 2 then
		CurMove = math.Approach(CurMove, -2, 0.11 - CurMove * 0.05)
	end

	local RS = self.Owner:GetRunSpeed() / 30

	local Off = (DTInt3 == 2 and math.sin(CurTime() * RS)) or 0
	local Off2 = (DTInt3 == 2 and math.cos(CurTime() * RS)) or 0

	if self.ViewModelFlip then
		if self.AimAng then
			ang = ang * 1
			ang:RotateAroundAxis( ang:Right(), 		BlendAng.x + CurShakeB * self.BobScale)
			ang:RotateAroundAxis( ang:Up(), 		(Off - Off2) * 1.5 + BlendAng.y + CurShakeA * self.BobScale)
			ang:RotateAroundAxis( ang:Forward(), 	BlendAng.z + CurShakeA * self.BobScale)
		end

		local Right 	= ang:Right()
		local Up 		= ang:Up()
		local Forward 	= ang:Forward()

		pos = pos + BlendPos.x * Right
		pos = pos + (BlendPos.y - Off - self.RecoilAmt) * Forward
		pos = pos + (BlendPos.z + (Off - Off2) * 0.5) * Up
	else
		if self.AimAng then
			ang = ang * 1
			ang:RotateAroundAxis( ang:Right(), 		BlendAng.x + CurShakeB * self.BobScale)
			ang:RotateAroundAxis( ang:Up(), 		(Off - Off2) * 1.5 + BlendAng.y + CurShakeA * self.BobScale)
			ang:RotateAroundAxis( ang:Forward(), 	BlendAng.z + CurShakeA * self.BobScale)
		end

		local Right 	= ang:Right()
		local Up 		= ang:Up()
		local Forward 	= ang:Forward()

		pos = pos + BlendPos.x * Right
		pos = pos + ((BlendPos.y + Off - self.RecoilAmt) * Forward)
		pos = pos + (BlendPos.z + (Off - Off2) * 0.5) * Up
	end

	self.RecoilAmt = Lerp(FT * 10, self.RecoilAmt, 0)

	return pos, ang
end

SWEP.NextSecondaryAttack = 0

if SERVER then
	local AttSoundDelay = 0

	function SWEP:NWAlpha(alpha)
		umsg.Start("NWAlpha")
			umsg.Entity(self)
			umsg.Short(alpha)
		umsg.End()
	end
end

if CLIENT then
	function SWEP:MuzzleFlosh() -- lololol
		local vm = self.Owner:GetViewModel()
		local muz = vm:GetAttachment("1")
		local muz2 = vm:LookupAttachment("1")

		if not self.Em then
			self.Em = ParticleEmitter(muz.Pos)
		end

		//if GetConVarNumber("cstm_ef_smoke") > 0 then
			ParticleEffect(self.SmokeEffect or "cstm_child_smoke_small", muz.Pos, self.Owner:EyeAngles(), muz)
		//end

		if self.Silenced == true or self.Silenced == 1 then
			return
		end

		if (self.VElements and self.VElements["silencer"] != nil and self.Owner:GetActiveWeapon().VElements["silencer"].color.a != 255) or self.VElements and self.VElements["silencer"] == nil then -- I check if it's not nil and then if it's nil to ensure that weapons that don't have a silencer don't bug

			/*if GetConVarNumber("cstm_ef_heat") > 0 then
				local par = self.Em:Add("sprites/heatwave", muz.Pos)
				par:SetStartSize(4)
				par:SetEndSize(1)
				par:SetDieTime(0.3)
			end*/

			//if GetConVarNumber("cstm_ef_extramuzzle") > 0 then
				ParticleEffectAttach(self.Muzzle or "cstm_muzzle_pistol", PATTACH_POINT_FOLLOW, vm, muz2)
			//end

			//if GetConVarNumber("cstm_ef_sparks") > 0 then
				ParticleEffectAttach(self.SparkEffect or "cstm_child_sparks_small", PATTACH_POINT_FOLLOW, vm, muz2)
			//end

		end
	end

	function SWEP:FireAnimationEvent(pos, ang, ev)
		if ev == 5001 then
			if not self.Owner:ShouldDrawLocalPlayer() then
				self:MuzzleFlosh()

				if self.VElements and self.VElements["silencer"] and self.VElements["silencer"].color.a == 255 then
					return ev == 5001
				end
			end
		end
	end

	local Current = "none"

	local function ReceiveAlpha(um)
		local wep = um:ReadEntity()
		local alpha = um:ReadShort()

		if IsValid(wep) then
			wep.VElements["silencer"].color = Color(255, 255, 255, alpha)
			wep.WElements["silencer"].color = Color(255, 255, 255, alpha)
		end
	end

	usermessage.Hook("NWAlpha", ReceiveAlpha)

	local function ReceiveReloadSpeed(um)
		local wep = um:ReadEntity()

		//if IsValid(wep) then
			wep.ReloadSpeed = 0.8
		//end
	end

	usermessage.Hook("NWSPD", ReceiveReloadSpeed)

	local function ReceiveFireMode(um)
		local Mode = um:ReadString()
		local ply = LocalPlayer()
		local wep = ply:GetActiveWeapon()

		if IsValid(ply) and IsValid(wep) then
			if Mode == "semi" then
				wep.Bullets = 1
				wep.Primary.Automatic = false
			elseif Mode == "burst" then
				wep.Bullets = 3
				wep.Primary.Automatic = true
			elseif Mode == "auto" then
				wep.Bullets = 5
				wep.Primary.Automatic = true
			end
		end
	end

	usermessage.Hook("FRMD", ReceiveFireMode)

	local function CSTM_Recoil()
		local ply = LocalPlayer()
		local wep = ply:GetActiveWeapon()
		local vm = ply:GetViewModel()

		wep.RecoilAmt = 2.5
		wep:MuzzleFlosh()
	end

	usermessage.Hook("RECOIL", CSTM_Recoil)

	local gap = 5
	local gap2 = 0
	local CurAlpha_Weapon = 255
	local ScopeTexture = surface.GetTextureID("gcellmats/scope_rifle2")
	local GLTexture = surface.GetTextureID("sprites/crosshair_gl")
	local UseGoggle = false
	local Bullet = surface.GetTextureID("VGUI/bullet")

	function SWEP:DrawHUD()
		local FT = RealFrameTime()
		local Width = ScrW()
		local Height = ScrH()

		local DTInt3 = self.Weapon:GetDTInt(3)

		if self.Weapon.Bullets then

			local Text

			if self.Weapon.Bullets == 1 then
				Text = "Semi-auto"
			elseif self.Weapon.Bullets == 3 then
				Text = "Burst"
			elseif self.Weapon.Bullets == 5 then
				Text = "Full-auto"
			end

			draw.RoundedBox(6, Width * 0.5 - 60, Height - 100, 120, 30, Color(0, 0, 0, 220))
			draw.SimpleText(Text, "DefaultSmallDropShadow", Width * 0.5, Height - 90, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			surface.SetDrawColor(255, 210, 0, 255)

			if self.Weapon.Bullets == 1 then
				surface.SetTexture(Bullet)
				surface.DrawTexturedRectRotated(Width * 0.5, Height - 80, 16, 16, 180)
			elseif self.Weapon.Bullets == 3 then

				for i = 1, 3 do
					surface.SetDrawColor(255, 210, 0, 255)
					surface.SetTexture(Bullet)
					surface.DrawTexturedRectRotated(Width * 0.5 + 20 * i - 40, Height - 80, 16, 16, 180)
				end

			else

				for i = 1, 5 do
					surface.SetDrawColor(255, 210, 0, 255)
					surface.SetTexture(Bullet)
					surface.DrawTexturedRectRotated(Width * 0.5 + 20 * i - 60, Height - 80, 16, 16, 180)
				end

			end
		end

		if ( self.Owner == LocalPlayer() && self.Owner:ShouldDrawLocalPlayer() ) then

			local tr = util.GetPlayerTrace( self.Owner )
			tr.mask = ( CONTENTS_SOLID||CONTENTS_MOVEABLE||CONTENTS_MONSTER||CONTENTS_WINDOW||CONTENTS_DEBRIS||CONTENTS_GRATE||CONTENTS_AUX )
			local trace = util.TraceLine( tr )

			local coords = trace.HitPos:ToScreen()
			x, y = coords.x, coords.y

		else
			x, y = Width / 2.0, Height / 2.0
		end

		local scale = (10 / (self.Owner:GetFOV() / 90)) * self.Weapon:GetDTFloat(0)

		if DTInt3 == 2 or DTInt3 == 4 or DTInt3 == 20 then
			CurAlpha_Weapon = math.Approach(CurAlpha_Weapon, 0, FT / 0.001)
		elseif (DTInt3 == 1 and self.Weapon.NoProperIronsights != true) or UseGoggle == true or (DTInt3 == 1 and self.Weapon.HasInstalledScope == true) then
			CurAlpha_Weapon = math.Approach(CurAlpha_Weapon, 0, FT / 0.001)
		elseif DTInt3 == 0 or DTInt3 == 3 or DTInt3 == 18 then
			CurAlpha_Weapon = math.Approach(CurAlpha_Weapon, 255, FT / 0.001)
		end

		gap = Lerp(FT * 18, gap, scale * 50)

		surface.SetDrawColor(0, 0, 0, CurAlpha_Weapon)
		surface.DrawRect(x - gap - 11, y - 1, 12, 3)
		surface.SetDrawColor(255, 255, 255, CurAlpha_Weapon)
		surface.DrawRect(x - gap - 10, y, 10, 1)

		surface.SetDrawColor(0, 0, 0, CurAlpha_Weapon)
		surface.DrawRect(x + gap, y - 1, 12, 3)
		surface.SetDrawColor(255, 255, 255, CurAlpha_Weapon)
		surface.DrawRect(x + gap + 1, y, 10, 1)

		surface.SetDrawColor(0, 0, 0, CurAlpha_Weapon)
		surface.DrawRect(x - 1, y + gap - 1, 3, 12)
		surface.SetDrawColor(255, 255, 255, CurAlpha_Weapon)
		surface.DrawRect(x , y + gap, 1, 10)

		surface.SetDrawColor(0, 0, 0, CurAlpha_Weapon)
		surface.DrawRect(x - 1, y - gap - 11, 3, 12)
		surface.SetDrawColor(255, 255, 255, CurAlpha_Weapon)
		surface.DrawRect(x, y - gap - 10, 1, 10)
	end
end

local HideModel = false

function SWEP:SecondaryAttack()
	local dtint3 = self:GetDTInt(3)

	if dtint3 == 20 then
		return
	end

	if dtint3 == 2 or dtint3 == 18 or not self.Owner:OnGround() or self.IsReloading == true or self.Owner:KeyDown(IN_SPEED) or self.ShouldBolt == true then
		return
	end

	local time = CurTime()

	if ( self.NextSecondaryAttack > time ) then return end

	if self.Owner:KeyDown(IN_USE) and dtint3 != 1 then
		if self.CantSilence == true then
			return
		end

		if self.IsSilenced == false then

			if SERVER then
				self:SetDTInt(3, 6)

				timer.Simple(0.5, function()
					if self.Weapon == nil then
						return
					end

					self.Owner:EmitSound("weapons/usp/usp_silencer_on.wav", 50, math.random(99, 101))
					self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_PLACE)
				end)

				timer.Simple(2, function()
					if self.Weapon == nil then
						return
					end

					self:NWAlpha(255)
					self.IsSilenced = true
					self:SetDTInt(3, 7)
				end)
			end

		else
			if SERVER then
				self:SetDTInt(3, 6)

				timer.Simple(0.5, function()
					if self.Weapon == nil then
						return
					end

					self.Owner:EmitSound("weapons/usp/usp_silencer_off.wav", 50, math.random(99, 101))
					self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_PLACE)
				end)

				timer.Simple(1.8, function()
					if self.Weapon == nil then
						return
					end

					self:NWAlpha(1)
					self.IsSilenced = false
					self:SetDTInt(3, 7)
				end)
			end

		end
		self:SetNextPrimaryFire(time + 2.35)
		self:SetNextSecondaryFire(time + 2.35)
		self.ReloadDelay = time + 2.35
		self.Owner.AttachDelay = time + 2.35
		return
	end

	if (dtint3 == 0 or dtint3 == 3 or dtint3 == 7) then

		if not self.CanAimWithRail and self.HasRail and self.ScopeStatus == 0 and self.RequiresRail then
			return
		end

		if SERVER then

			if self.Grenade then
				self:SetDTInt(3, 8)
			else
				self:SetDTInt(3, 1)
			end

			if self.ScopeStatus >= 2 and not self.Grenade then
				if tonumber(self.Owner:GetInfo("cstm_oldacog")) <= 0 then
					local fov
					local ScopeStatus = self.ScopeStatus

					if ScopeStatus == 0 then
						fov = 75
					elseif ScopeStatus == 3 then
						fov = 67
					elseif ScopeStatus == 9 then
						fov = 72
					elseif ScopeStatus == 4 then
						fov = 72
					elseif ScopeStatus == 5 then
						fov = 15

						print("A")

						timer.Simple(0.15, function()
							if self.Weapon != self.Owner:GetActiveWeapon() or self:GetDTInt(3) != 1 then
								return
							end

							self.Owner:DrawViewModel(false)

						end)
					else
						fov = 67
					end

					self.Owner:SetFOV(fov, 0.3)
				else

					self.Owner:SetFOV(40, 0.3)

					if self.ScopeStatus == 2 then
						self.Owner:SetFOV(40, 0.3)

						timer.Simple(0.15, function()
							if self.Weapon != self.Owner:GetActiveWeapon() or self:GetDTInt(3) != 1 then
								return
							end

							self.Owner:DrawViewModel(false)

						end)
					else
						local fov
						local ScopeStatus = self.ScopeStatus

						if ScopeStatus == 0 then
							fov = 75
						elseif ScopeStatus == 3 then
							fov = 67
						elseif ScopeStatus == 9 then
							fov = 72
						elseif ScopeStatus == 4 then
							fov = 72
						elseif ScopeStatus == 5 then
							fov = 15

							timer.Simple(0.15, function()
								if self.Weapon != self.Owner:GetActiveWeapon() or self:GetDTInt(3) != 1 then
									return
								end

								self.Owner:DrawViewModel(false)

							end)
						else
							fov = 67
						end

						self.Owner:SetFOV(fov, 0.3)
					end
				end

			else
				self.Owner:SetFOV(75, 0.3)
			end

		end
	elseif dtint3 == 1 or dtint3 == 8 then
		self:SetDTInt(3, 0)
		if SERVER then
			self.Owner:SetFOV(0, 0.3)
			self.Owner:DrawViewModel(true)
		end
	end

	self:SetNextPrimaryFire(time + 0.2)
	self.NextSecondaryAttack = time + 0.3

end

function SWEP:OnRestore()
	self:SetDTInt(3, 0)
end

if SERVER then
	function SWEP:Melee(ply, wep)

		if CurTime() < wep.MeleeDelay then
			return
		end

		wep:SetDTInt(3, 15)

		wep.MeleeDelay = CurTime() + 0.5
		wep.ReloadDelay = CurTime() + 0.5
		wep.AttachDelay = CurTime() + 0.5
		wep:SetNextPrimaryFire(CurTime() + 0.5)
		wep:SetNextSecondaryFire(CurTime() + 0.5)

		ply:EmitSound("npc/fast_zombie/claw_miss1.wav", 80, 100)
		ply:ViewPunch(Vector(-5, 10, 0))

		timer.Simple(0.1, function()

			if not wep or not ply or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
				return
			end

			local tr = {}
			tr.start = ply:GetShootPos()
			tr.endpos = tr.start + ply:GetAimVector() * 50
			tr.filter = ply
			tr.mins = Vector(-8, -8, -8)
			tr.maxs = Vector(8, 8, 8)

			local trace = util.TraceHull(tr)

			if trace.Hit then

				local physobj = trace.Entity:GetPhysicsObject()

				if physobj:IsValid() then
					physobj:AddVelocity(ply:GetAimVector() * 250)
				end

				if trace.Entity:IsPlayer() or trace.Entity:IsNPC() or trace.Entity:Health() > 0 then
					trace.Entity:TakeDamage(math.random(wep.MeleeDamageMin, wep.MeleeDamageMax), ply, ply)

					if trace.Entity:IsNPC() then
						trace.Entity:SetVelocity(ply:GetForward() * 2000)
					end
				end

				ply:EmitSound("physics/body/body_medium_impact_hard" .. math.random(1, 6) .. ".wav", 80, 100)
			end

		end)

		timer.Simple(0.25, function()
			wep:SetDTInt(3, 0)
		end)
	end

	function SWEP:HolsterWeapon(ply, wep)
		local dt3 = wep:GetDTInt(3)

		if dt3 == 20 then
			wep:SetDTInt(3, 0)

			local CT = CurTime()

			wep:SetNextPrimaryFire(CT + 0.4)
			wep:SetNextSecondaryFire(CT + 0.4)
			wep.ReloadDelay = CT + 0.4
			wep.MeleeDelay = CT + 0.4
		else
			if dt3 != 0 then
				ply:SetFOV(0, 0.3)
			end

			wep:SetDTInt(3, 20)
		end
	end

	concommand.Add("dec_holsterwep", function(ply)
		local wep = ply:GetActiveWeapon()

		if wep.HolsterWeapon then
			if wep.IsCustomWeapon and CurTime() > wep.ReloadDelay then
				wep:HolsterWeapon(ply, wep)
			end
		end
	end)

	concommand.Add("cstm_melee", function(ply)
		local wep = ply:GetActiveWeapon()

		if wep.IsCustomWeapon and wep:GetDTInt(3) == 0 then
			wep:Melee(ply, wep)
		end
	end)
end
