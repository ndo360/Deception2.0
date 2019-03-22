
if (SERVER) then

	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false

end

if ( CLIENT ) then

	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.PitchMod = 1
	SWEP.RollMod = 1
	-- This is the font that's used to draw the death icons
	surface.CreateFont( "CSKillIcons", {size=ScreenScale( 30 ), weight=500, antialias=true, additive =true, font="csd"} )
	surface.CreateFont( "CSSelectIcons", {size=ScreenScale( 60 ), weight=500, antialias=true, additive =true, font="csd"} )

end

SWEP.Author			= "LEETNOOB"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= "PRIMARY ATTACK key to fire\nSECONDARY ATTACK key to toggle ironsights\nUSE key + SECONDARY ATTACK key - attach suppressor\nUSE key + RELOAD key - switch between semi-auto/auto firemodes (SMGs/ARs)"

--  Note: This is how it should have worked. The base weapon would set the category
--  then all of the children would have inherited that.
--  But a lot of SWEPS have based themselves on this base (probably not on purpose)
--  So the category name is now defined in all of the child SWEPS.
-- SWEP.Category			= "Counter-Strike"

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
SWEP.Base = "dec_base_pistol"
SWEP.MinFOV = 15
SWEP.MaxFOV = 65
SWEP.CurZoom = 40
SWEP.ZoomDelay = 0
SWEP.CanAdjust = true

function SWEP:Think()
	if SERVER then
		self.ConeDecAff = math.Approach(self.ConeDecAff, 0.1, 0.001)
		self:SetDTFloat(1, math.Approach(self:GetDTFloat(1), 0, 0.05 * self.ConeDecAff))

		if self.Owner:Crouching() then
			self.ConeAff1 = 0.005
		else
			self.ConeAff1 = 0
		end

		if self:GetDTInt(3) == 1 then
			if self.ConeAff2 == 0 then
				self.ConeAff2 = 0.005
			end

			if self.HeadbobMul == 1 then
				self.HeadbobMul = 0.4
			end
		else
			if self.ConeAff2 == 0.005 then
				self.ConeAff2 = 0
			end

			if self.HeadbobMul == 0.4 then
				self.HeadbobMul = 1
			end
		end

		if self:GetDTInt(3) == 1 then
			self.Primary.Cone = math.Clamp(self.DefCone + self.ConeInaccuracy + ((self.Owner:GetVelocity():Length() / 10000) * (self:GetDTInt(3) == 1 and self.VelocitySensivity * 0.3 or self.VelocitySensivity)) - self.ConeAff1 - self.ConeAff3, 0.002, 0.15)
		else
			self.Primary.Cone = 0.055
		end
	end
	//self.FinalCone = self.Primary.Cone
	self:SetDTFloat(0, math.Clamp(self.Primary.Cone, 0.002, 0.15))
	self.ConeInaccuracy = math.Clamp(self.ConeInaccuracy - self.ConeInaccuracyDec, 0, 0.15 * self.ConeInaccuracyAff1)
	self.ConeInaccuracyDec = math.Clamp(self.ConeInaccuracyDec + 0.00002, 0, 0.02)

	local DTInt3 = self:GetDTInt(3)

	if DTInt3 != 20 then
		if self.Owner:KeyDown(IN_SPEED) and self.Owner:OnGround() and DTInt3 != 6 and DTInt3 != 10 and DTInt3 != 15 then
			if self.Owner:GetVelocity():Length() > self.Owner:GetWalkSpeed() then
				if DTInt3 != 2 and DTInt3 != 15 then
					self:SetDTInt(3, 2)
					if SERVER then
						self.Owner:SetFOV(0, 0.3)
						self.Owner:DrawViewModel(true)
						self:SetNextPrimaryFire(CurTime() + 0.3)
						self:SetNextSecondaryFire(CurTime() + 0.3)
					end
				end

			else
				if DTInt3 != 1 or DTInt3 != 8 and DTInt3 != 10 and DTInt3 != 11 and DTInt3 != 12 and DTInt3 != 15 then
					self:SetDTInt(3, 0)
					if SERVER then
						self.Owner:SetFOV(0, 0.3)
						self.Owner:DrawViewModel(true)
					end
				end
			end
		elseif not self.Owner:KeyDown(IN_SPEED) and DTInt3 != 1 and DTInt3 != 0 and DTInt3 != 6 and DTInt3 != 8 and DTInt3 != 10 and DTInt3 != 11 and DTInt3 != 12 and DTInt3 != 15 or not self.Owner:OnGround() and DTInt3 != 6 and DTInt3 != 0 and DTInt3 != 15 then
			self:SetDTInt(3, 0)
			if SERVER then
				self.Owner:SetFOV(0, 0.2)
				self.Owner:DrawViewModel(true)
				self:SetNextPrimaryFire(CurTime() + 0.3)
				self:SetNextSecondaryFire(CurTime() + 0.3)
			end
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

				if activity == "ACT_VM_RELOAD" or activity == "ACT_VM_RELOAD_SILENCED" or activity == "ACT_VM_ATTACH_SILENCER" or activity == "ACT_VM_DETACH_SILENCER" then
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
								wep:SendWeaponAnim(ACT_VM_IDLE)
							//end
						end)

						wep.TimerCreated = true
					end
				else
					wep.TimerCreated = false
					wep.OffsetMeStage = 2
				end
				//end
			end
		end
	end
end

function SWEP:SecondaryAttack()
	if self:GetDTInt(3) == 2 or not self.Owner:OnGround() or self.IsReloading == true then
		return
	end

	local time = CurTime()

	if self.ShouldBolt == true then
		return
	end

	local int3 = self:GetDTInt(3)

	if self.Owner:KeyDown(IN_USE) and int3 != 1 then
		if self.CantSilence == true then
			return
		end

		if self.IsSilenced == false then

			if SERVER then
				self:SetDTInt(3, 6)

				timer.Simple(0.5, function()
					if self == nil then
						return
					end

					self.Owner:EmitSound("weapons/usp/usp_silencer_on.wav", 50, math.random(99, 101))
					self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_PLACE)
				end)

				timer.Simple(2, function()
					if self == nil then
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
					if self == nil or int3 != 1 then
						return
					end

					self.Owner:EmitSound("weapons/usp/usp_silencer_off.wav", 50, math.random(99, 101))
					self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_PLACE)
				end)

				timer.Simple(1.8, function()
					if self == nil then
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
		return
	end

	if (int3 == 0 or int3 == 3 or int3 == 7) then
		self:SetDTInt(3, 1)
		if SERVER then
			timer.Simple(0.15, function()
				if self == nil or self:GetDTInt(3) != 1 then
					return
				end
				self.Owner:DrawViewModel(false)
			end)

			self.Owner:SetFOV(self.CurZoom, 0.3)
		end
	elseif int3 == 1  then
		self:SetDTInt(3, 0)
		if SERVER then
			self.Owner:SetFOV(0, 0.3)
			self.Owner:DrawViewModel(true)
		end
	end

	self:SetNextPrimaryFire(time + 0.2)
	self:SetNextSecondaryFire(time + 0.3)

end

if CLIENT then
	local ScopeTexture = surface.GetTextureID("gcellmats/scope_rifle2")

	function SWEP:DrawHUD()
		local Width = ScrW()
		local Height = ScrH()
		local x = (Width - 1024) / 2
		local y = (Height - 1024) / 2
		local x2 = Width - x
		local y2 = Height - y

		if self:GetDTInt(3) == 1 then
			if UseGoggle == false then
				TimeToUseGoggle = CurTime() + 0.15
				UseGoggle = true
			end

			if CurTime() > TimeToUseGoggle then
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(ScopeTexture)
				surface.DrawTexturedRectUV(x, y, 1024, 1024, 0,0,1,1)

				surface.SetDrawColor(0, 0, 0, 255)
				surface.DrawRect(0, 0, x, Height)
				surface.DrawRect(x2, 0, x, Height)
				surface.DrawRect(0, 0, Width, y)
				surface.DrawRect(0, y2, Width, y)
			end
		else
			UseGoggle = false
		end
	end
end

function SWEP.ZoomIn(ply)
	if SERVER then
		if CurTime() < ply:GetActiveWeapon().ZoomDelay or ply:GetFOV() == ply:GetActiveWeapon().MinFOV then
			return
		end

		ply:GetActiveWeapon():UpdateFOV(-15)
		ply:GetActiveWeapon().ZoomDelay = CurTime() + 0.2
	end
end

function SWEP.ZoomOut(ply)
	if SERVER then
		if CurTime() < ply:GetActiveWeapon().ZoomDelay or ply:GetFOV() == ply:GetActiveWeapon().MaxFOV then
			return
		end

		ply:GetActiveWeapon():UpdateFOV(15)
		ply:GetActiveWeapon().ZoomDelay = CurTime() + 0.2
	end
end

function SWEP:UpdateFOV(amount)
	if SERVER then
		self.CurZoom = math.Clamp(self.CurZoom + amount, self.MinFOV, self.MaxFOV)
		self.Owner:SetFOV(self.CurZoom, 0.2)
		self.Owner:EmitSound("weapons/zoom.wav", 40, 100)
	end
end

if CLIENT then
	function SWEP.PlayerBindPress(ply, bnd)
		if ply:GetActiveWeapon().CanAdjust != true or CurTime() < ply:GetActiveWeapon().ZoomDelay then
			return
		end

		if not ply:GetActiveWeapon():GetClass():find("^dec_sniper_") or ply:GetActiveWeapon():GetDTInt(3) != 1 then
			return
		end

		if bnd == "invprev" then
			RunConsoleCommand("zoom_in")
			return true
		elseif bnd == "invnext" then
			RunConsoleCommand("zoom_out")
			return true
		end
	end
end

function SWEP:HolsterWeapon(ply)
	local dt3 = self:GetDTInt(3)

	if dt3 == 20 then
		self:SetDTInt(3, 0)

		local CT = CurTime()

		self:SetNextPrimaryFire(CT + 0.4)
		self:SetNextSecondaryFire(CT + 0.4)
		self.ReloadDelay = CT + 0.4
		self.MeleeDelay = CT + 0.4
	else
		if dt3 != 0 then
			ply:SetFOV(0, 0.3)
		end

		self:SetDTInt(3, 20)
	end
end

if SERVER then
	concommand.Add("zoom_in", SWEP.ZoomIn)
	concommand.Add("zoom_out", SWEP.ZoomOut)
else
	hook.Add("PlayerBindPress", "Change zoom level", SWEP.PlayerBindPress)
end
