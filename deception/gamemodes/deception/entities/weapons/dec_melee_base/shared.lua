if( SERVER ) then
	SWEP.IsCustomWeapon = true
	SWEP.TakesUpSlot = true
	AddCSLuaFile( "shared.lua" );
end

if( CLIENT ) then
	SWEP.PrintName = "Lead pipe";
	SWEP.Slot = 3;
	SWEP.SlotPos = 3;
	SWEP.DrawAmmo = false;
	SWEP.DrawCrosshair = false;
	SWEP.BounceWeaponIcon = false
end

SWEP.Author			= "-[SB]- Spy"
SWEP.Instructions	= "Primary attack to swing, secondary attack to holster"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Category = "Melee Weapons"

SWEP.HoldType = "melee"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/V_Stunbaton.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {["Dummy14"] = Vector(0.009, 0.009, 0.009)}
SWEP.ActiveHoldType = "melee"
SWEP.InitialHoldType = "melee"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.BlockPos = Vector(-13.443, 0, 8.689)
SWEP.BlockAng = Vector(0, 0, -22.952)

SWEP.Base = "dec_cmodel_cstm_base"

-------------Primary Fire Attributes----------------------------------------
SWEP.Primary.Delay			= 0.9 	--In seconds
SWEP.Primary.Recoil			= 0		--Gun Kick
SWEP.Primary.Damage			= 15	--Damage per Bullet
SWEP.Primary.NumShots		= 1		--Number of shots per one fire
SWEP.Primary.Cone			= 0 	--Bullet Spread
SWEP.Primary.ClipSize		= -1	--Use "-1 if there are no clips"
SWEP.Primary.DefaultClip	= -1	--Number of shots in next clip
SWEP.Primary.Automatic   	= true	--Pistol fire (false) or SMG fire (true)
SWEP.Primary.Ammo         	= "none"	--Ammo Type

-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 0.9
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= true
SWEP.Secondary.Ammo         = "none"

SWEP.HurtTime = 0.1
SWEP.HasReleased = true
SWEP.ReloadDelay = 0

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
	self:SetDTInt(3, 20)

    if CLIENT then

        self:CreateModels(self.VElements) // create viewmodels
        self:CreateModels(self.WElements) // create worldmodels

        // init view model bone build function
        self.BuildViewModelBones = function( s )
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
        end

    end
end

function SWEP:Deploy()
	self.Owner:GetViewModel():SetModel(self.ViewModel)
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + 1)
	self:SetNextSecondaryFire(CurTime() + 1)
	return true
end

function SWEP:Holster()
	return true
end

function SWEP:Reload()
end

function SWEP:Precache()
end

local trace = {}

function SWEP:Think()
	if SERVER then
		if CurTime() < self.HurtTime then -- this way there is no way we miss the entity even though we are in-range but have missed the moment when it was supposed to hit the entity
			local aim = self.Owner:GetAimVector()

			trace.start = self.Owner:GetShootPos()
			trace.endpos = trace.start + aim * self.Range
			trace.filter = self.Owner
			trace.mins = Vector(-4, -4, -8)
			trace.maxs = Vector(12, 12, 8)

			local trace2 = util.TraceHull(trace)

			if trace2.Entity != NULL then
				local isply = trace2.Entity:IsPlayer()

				if isply or trace2.Entity:IsNPC() or trace2.Entity:GetClass() == "prop_ragdoll" then
					if self.IsSlashSound then
						if trace2.MatType == MAT_FLESH or trace2.MatType == MAT_BLOODYFLESH or trace2.MatType == MAT_ANTLION or trace2.MatType == MAT_ALIENFLESH then
							self.Owner:EmitSound(table.Random(self.SlashMan), 80, math.random(99, 101))
						end
					else
						if trace2.MatType == MAT_FLESH or trace2.MatType == MAT_BLOODYFLESH or trace2.MatType == MAT_ANTLION or trace2.MatType == MAT_ALIENFLESH then
							if self.BatSound == 1 then
								self.Owner:EmitSound("weapons/bat_hit.wav", 80, math.random(99, 101))
							elseif self.BatSound == 2 then
								self.Owner:EmitSound("weapons/bat_baseball_hit_flesh.wav", 80, math.random(99, 101))
							else
								self.Owner:EmitSound(table.Random(self.HitMan), 80, math.random(99, 101))
							end
						end
					end

					local dmginfo = DamageInfo()
					local haim

					if isply then
						haim = trace2.Entity:GetAimVector()
						haim = Vector(haim.x, haim.y, 0)
					end

					if isply and self.CanBackstab and aim:DotProduct(haim) >= 0.5 then
						dmginfo:SetDamage(trace2.Entity:Health() * 2)
						dmginfo:SetDamageType(DMG_CLUB)
						dmginfo:SetAttacker(self.Owner)
						dmginfo:SetInflictor(self)
						trace2.Entity:TakeDamageInfo(dmginfo)

						local ED = EffectData()
						ED:SetStart(trace2.Entity:GetPos())
						ED:SetOrigin(trace2.Entity:GetPos())
						ED:SetScale(1)

						util.Effect("bloodspray", ED)
					else
						dmginfo:SetDamage(math.random(self.DamageToPlayers1, self.DamageToPlayers2))
						dmginfo:SetDamageType(DMG_CLUB)
						dmginfo:SetAttacker(self.Owner)
						dmginfo:SetInflictor(self)
						trace2.Entity:TakeDamageInfo(dmginfo)

						local ED = EffectData()
						ED:SetStart(trace2.Entity:GetPos())
						ED:SetOrigin(trace2.Entity:GetPos())
						ED:SetScale(1)
						util.Effect("bloodspray", ED)
					end

				elseif trace2.Entity:GetClass() == "func_breakable_surf" then
					trace2.Entity:Input("Shatter", NULL, NULL, "")
					self.Owner:EmitSound(table.Random(self.HitWorld), 80, math.random(99, 101))
					self.Owner:EmitSound(table.Random(self.ShatterGlass), 80, math.random(99, 101))
				elseif trace2.Entity:Health() > 0 then
					self.Owner:EmitSound(table.Random(self.HitWorld), 80, math.random(99, 101))

					if self.UseHitWorld2 == true then
						self.Owner:EmitSound(table.Random(self.HitWorld2), 80, math.random(99, 101))
					end

					trace2.Entity:TakeDamage(math.random(self.DamageToEnts1, self.DamageToEnts2), self.Owner, self)
				else
					self.Owner:EmitSound(table.Random(self.HitWorld), 80, math.random(99, 101))

					if self.UseHitWorld2 == true then
						self.Owner:EmitSound(table.Random(self.HitWorld2), 80, math.random(99, 101))
					end

					trace2.Entity:TakeDamage(math.random(self.DamageToEnts1, self.DamageToEnts2), self.Owner, self)
				end

				local phys = trace2.Entity:GetPhysicsObject()

				if phys:IsValid() then
					if phys:GetMass() < 10 then
						phys:AddVelocity(self.Owner:GetForward() * self.ForceToEntsSmall)
					elseif phys:GetMass() < 150 then
						phys:AddVelocity(self.Owner:GetForward() * self.ForceToEntsMedium)
					end
				end

				self.HurtTime = CurTime() - 0.1
			end
		end
	end

	if not self.Owner:KeyDown(IN_ATTACK2) then
		if self.HasReleased == false then
			self.HasReleased = true
		end
	end
end

function SWEP:PrimaryAttack()
	if self:GetDTInt(3) == 20 then
		return
	end

	local CT = CurTime()

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_HITCENTER)

	timer.Simple(self.TimerDelay, function()
		if self == nil then
			return
		end

		self.HurtTime = CT + 0.2

		if IsValid(self.Owner) then
			self.Owner:ViewPunch(Angle(self.Recoil * 0.3, math.random(-2, 2), math.random(-2, 2)))
		end

		if SERVER then
			if self.Swing["BaseClass"] then
				self.Swing["BaseClass"] = nil
			end

			if IsValid(self.Owner) then
				self.Owner:EmitSound(table.Random(self.Swing), 80, math.random(99, 101))
			end
		end
	end)

	if SERVER then
		self:SetNextPrimaryFire(CT + self.SwingDelay)
		self:SetNextSecondaryFire(CT + self.SwingDelay * 0.9)
		self.ReloadDelay = CT + self.SwingDelay
	end
end

function SWEP:SecondaryAttack()
	return false
end

if SERVER then
	function SWEP:HolsterWeapon(ply, wep)
		local dt3 = wep:GetDTInt(3)
		local CT = CurTime()

		if CT > self.ReloadDelay then
			if dt3 == 20 then
				wep:SetDTInt(3, 0)

				wep:SetNextPrimaryFire(CT + 0.4)
				wep:SetNextSecondaryFire(CT + 0.4)
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
