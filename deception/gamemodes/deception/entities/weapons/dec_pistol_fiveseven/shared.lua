

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoAimpoint = true
	SWEP.NoACOG = true
	SWEP.NoEOTech = true
	
	SWEP.BulletLength = 5.7
	SWEP.CaseLength = 28
	SWEP.RequiresRail = false
end

if ( CLIENT ) then

	SWEP.PrintName			= "FiveSeven"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "u"
	SWEP.Muzzle = "cstm_muzzle_pistol"
	SWEP.SparkEffect = "cstm_child_sparks_small"
	SWEP.SmokeEffect = "cstm_child_smoke_small"
	
	killicon.AddFont( "cstm_pistol_fiveseven", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.FIVESEVEN_PARENT", pos = Vector(0, 2.223, 6.913), angle = Angle(0, 0, 0), size = Vector(0.043, 0.043, 0.137), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["aimpointdot"] = { type = "Sprite", sprite = "effects/redflare", bone = "v_weapon.FIVESEVEN_SLIDE", pos = Vector(-0.03, -0.851, 0.944), size = { x = 0.3, y = 0.3 }, color = Color(255, 255, 255, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/doctorrds.mdl", bone = "v_weapon.FIVESEVEN_SLIDE", pos = Vector(-0.281, -0.881, 0.349), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "v_weapon.FIVESEVEN_PARENT", rel = "", pos = Vector(-0.038, 1.256, 5.243), angle = Angle(0, 0, 180), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(10.458, 0.6, -4), angle = Angle(-90, 0, 0), size = Vector(0.043, 0.043, 0.136), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/doctorrds.mdl", pos = Vector(4.413, 0.899, -4.319), angle = Angle(0, 90, 180), size = Vector(1.25, 1.25, 1.25), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.MeleeOffset = {
		['v_weapon.Right_Arm'] = {vector = Vector(1.7560000419617, -2.6380000114441, -6.0440001487732), angle = Vector(10.531000137329, 25.812000274658, -131.3809967041)},
		['v_weapon.Right_Hand'] = {vector = Vector(0, 0, 0), angle = Vector(16.174999237061, 0, 0)},
		['v_weapon.Right_Index01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -43.770000457764, 0)},
		['v_weapon.Right_Index02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -21.118999481201, 0)},
		['v_weapon.Right_Index03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -40.287998199463, 0)},
		['v_weapon.Right_Middle01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -44.506999969482, 0)},
		['v_weapon.Right_Middle02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -21.920000076294, 0)},
		['v_weapon.Right_Middle03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -44.138999938965, 0)},
		['v_weapon.Right_Ring01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -39.919998168945, 0)},
		['v_weapon.Right_Ring02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -24.406999588013, 0)},
		['v_weapon.Right_Ring03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -27.400999069214, 0)},
		['v_weapon.Right_Pinky01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -44.164001464844, 0)},
		['v_weapon.Right_Pinky02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -30.900999069214, 0)},
		['v_weapon.Right_Pinky03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -31.301000595093, 0)},
		['v_weapon.Right_Thumb01'] = {vector = Vector(0, 0, 0), angle = Vector(-16.29400062561, 17.861000061035, 0)},
		['v_weapon.Right_Thumb02'] = {vector = Vector(0, 0, 0), angle = Vector(0, 17.186000823975, 0)} }

end

SWEP.Caliber = "5.7x28MM"
SWEP.HoldType			= "ar2"
SWEP.Base = "dec_base_pistol"
//SWEP.Category			= "Condition SWEPs"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("weapons/fiveseven/fiveseven-1.wav")
SWEP.Primary.Recoil			= 0.5
SWEP.Primary.Damage			= 22
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 20
SWEP.Primary.Delay			= 0.17
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"
SWEP.InitialHoldtype = "pistol"
SWEP.InHoldtype = "pistol"
SWEP.NoAuto = true
SWEP.NoScopes = true
SWEP.NoBoltAnim = true

SWEP.Size = 5

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.3 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.5
SWEP.CurCone				= 0.038
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights
SWEP.ViewPunchCycle 		= 0
SWEP.ViewPunchDelay			= 0
SWEP.WalkPunchCycle			= 0
SWEP.WalkPunchDelay 		= 0
SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 1 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.022
SWEP.HipCone 				= 0.043
SWEP.ConeInaccuracyAff1 = 0.5

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(4.519, -2.688, 3.305)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ReflexPos = Vector(4.489, -3.257, 2.839)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(-1.52, 0, 1.279)
SWEP.MeleeAng = Vector(0, 0, 0)