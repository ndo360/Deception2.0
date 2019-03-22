

if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoAimpoint = true
	SWEP.NoACOG = true
	SWEP.NoEOTech = true
	SWEP.NoDocter = true
	SWEP.ScopeStatus = 5
	SWEP.MeleeDamageMin = 20
	SWEP.MeleeDamageMax = 25

	SWEP.BulletLength = 8.58
	SWEP.CaseLength = 69.20
	SWEP.NoLaser = true
end

if ( CLIENT ) then

	SWEP.PrintName			= "AWP"
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 4
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "r"
	SWEP.Muzzle = "cstm_muzzle_br"
	SWEP.SparkEffect = "cstm_child_sparks_large"
	SWEP.SmokeEffect = "cstm_child_smoke_large"
	SWEP.BoneApproachSpeed = 0.8
	SWEP.BackModel = "models/weapons/w_snip_awp.mdl"

	killicon.AddFont( "cstm_sniper_awp", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )

	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.awm_parent", pos = Vector(-0.232, 3.381, 20), angle = Angle(1.031, 3.094, 0), size = Vector(0.059, 0.059, 0.25), color = Color(255, 255, 255, 1), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(40, 1.506, -2.863), angle = Angle(-90, 0, 0), size = Vector(0.059, 0.059, 0.25), color = Color(255, 255, 255, 1), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}

	SWEP.MeleeOffset = {
		['v_weapon.Left_Arm'] = {vector = Vector(16.493999481201, -3.0250000953674, 10.031000137329), angle = Vector(131.30000305176, -30.313999176025, 27.055999755859)},
		['v_weapon.Left_Middle01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -44.681999206543, 0)},
		['v_weapon.Left_Middle02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -9.6070003509521, 0)},
		['v_weapon.Left_Middle03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -32.888000488281, 0)},
		['v_weapon.Left_Ring01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -46.881999969482, 0)},
		['v_weapon.Left_Ring02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -37.963001251221, 0)},
		['v_weapon.Left_Pinky01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -36.737998962402, 0)},
		['v_weapon.Left_Pinky02'] = {vector = Vector(0, 0, 0), angle = Vector(-24.663000106812, -36.362998962402, 0)},
		['v_weapon.Left_Pinky03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -71.763000488281, 0)} }

		SWEP.ReloadAct = "reload"

end

SWEP.Caliber = ".338 Lapua Magnum"
SWEP.HoldType			= "ar2"
SWEP.Base				= "dec_base_sniper"
///SWEP.Category			= "Condition SWEPs (TEST)"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_snip_awp.mdl"
SWEP.WorldModel = "models/weapons/w_snip_awp.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.Size 				= 10
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("weapons/awp/awp1.wav")
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage			= 80
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 10
SWEP.Primary.Delay			= 1.5
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SniperRound"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.SilencedSound = Sound("weapons/scout/scout_fire-1.wav")
SWEP.SilencedVolume = 80

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.NoBoltAnim = true
SWEP.AnimPrefix = "awm_"
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.35 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 6
SWEP.DefCone				= 0.005
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights
SWEP.ViewPunchCycle 		= 0
SWEP.ViewPunchDelay			= 0
SWEP.WalkPunchCycle			= 0
SWEP.WalkPunchDelay 		= 0
SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 3 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.AltSilencedSound 		= true
SWEP.NoAuto = true

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(5.4, -3.425, 2.086)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.MeleePos = Vector(-2.161, -17.542, 0.6)
SWEP.MeleeAng = Vector(0, -130, 0)
