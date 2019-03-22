

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.NoEOTech = true
	SWEP.NoGL = true
	SWEP.NoDocter = true
	
	SWEP.BulletLength = 7.62
	SWEP.CaseLength = 39
end

if ( CLIENT ) then

	SWEP.PrintName			= "AK-47"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	SWEP.IconLetter			= "b"
	/*SWEP.Bone = "v_weapon.Right_Arm"
	SWEP.BoneOffset = Vector(0, 3, 0)
	SWEP.CurOffset = Vector(0, 0, 0)
	SWEP.CurAngleOffset = Vector(0, 0, 0)
	SWEP.ActiveOffset = Vector(2, 2, 0)
	SWEP.ActiveAngleOffset = Vector(0, 0, -90)
	SWEP.FineTuneTiming = 1*/
	SWEP.Muzzle = "cstm_muzzle_ar"
	SWEP.SparkEffect = "cstm_child_sparks_medium"
	SWEP.SmokeEffect = "cstm_child_smoke_medium"
	
	killicon.AddFont( "cstm_rif_ak47", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	

	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.AK47_Parent", pos = Vector(0, 2.93, 18.868), angle = Angle(0.2, 0, 0), size = Vector(0.059, 0.059, 0.159), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {}},
		["acogdot"] = { type = "Sprite", sprite = "sprites/acog_tri", bone = "v_weapon.AK47_Parent", pos = Vector(-0.028, 6.296, -0.987), size = { x = 0.3, y = 0.3 }, color = Color(255, 255, 255, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},		
		["acog"] = { type = "Model", model = "models/wystan/attachments/acog.mdl", bone = "v_weapon.AK47_Parent", pos = Vector(0.217, 1.33, -2.556), angle = Angle(180, 0, 90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {}},
		["rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "v_weapon.AK47_Parent", pos = Vector(-0.181, 4.081, 2.842), angle = Angle(0, 0, 90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {}},
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "v_weapon.AK47_Parent", pos = Vector(0.125, 1.401, -2.376), angle = Angle(180, 0, 90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpointdot"] = { type = "Sprite", sprite = "effects/redflare", bone = "v_weapon.AK47_Parent", pos = Vector(-0.044, 6.125, 0.955), size = { x = 0.3, y = 0.3 }, color = Color(255, 255, 255, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.419, 3.325, 13.807), angle = Angle(0, 90, 180), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
		//["grenadelauncher"] = { type = "Model", model = "models/wystan/attachments/gp30.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0.238, 0.887, -9.051), angle = Angle(180, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(31.5, 0.337, -1.699), angle = Angle(-84.794, 0, 0), size = Vector(0.059, 0.059, 0.159), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/acog.mdl", pos = Vector(2.598, 0, 0.13), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", pos = Vector(2.243, 0.162, 0), angle = Angle(180, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", pos = Vector(9.949, 0.625, -3.744), angle = Angle(0, 90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.MeleeOffset = {
		['v_weapon.Left_Arm'] = {vector = Vector(7.3509998321533, 1.9129999876022, 13.173999786377), angle = Vector(93.430999755859, 26.83099937439, 90)},
		['v_weapon.Left_Thumb01'] = {vector = Vector(0, 0, 0), angle = Vector(0, 16.468999862671, 0)},
		['v_weapon.Left_Thumb_02'] = {vector = Vector(0, 0, 0), angle = Vector(0.41299998760223, 31.10000038147, 0)},
		['v_weapon.Left_Pinky02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -9.7130002975464, 0)},
		['v_weapon.Left_Pinky03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -60.118999481201, 0)},
		['v_weapon.Left_Ring02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -37.743000030518, 0)},
		['v_weapon.Left_Ring03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -56.23099899292, 0)},
		['v_weapon.Left_Middle02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -32.111999511719, 0)},
		['v_weapon.Left_Middle03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -71.887001037598, 0)},
		['v_weapon.Left_Index01'] = {vector = Vector(0, 0, 0), angle = Vector(0, 36.526000976563, 0)} }
	
end

SWEP.Caliber = "7.62x39MM"
SWEP.HoldType			= "ar2"
SWEP.Base				= "dec_base_pistol"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("weapons/ak47/ak47-1.wav")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 29
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.1
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.SilencedSound = Sound("weapons/m4a1/m4a1-1.wav")
SWEP.SilencedVolume = 75

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = "ak47_"
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.25 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 1.2
SWEP.CurCone				= 0
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights
SWEP.ViewPunchCycle 		= 0
SWEP.ViewPunchDelay			= 0
SWEP.WalkPunchCycle			= 0
SWEP.WalkPunchDelay 		= 0
SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 2.2 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.019
SWEP.HipCone 				= 0.062
SWEP.ScopeCone = 0.013
SWEP.InaccAff1 = 0.75
SWEP.SkipIdle = true
SWEP.ConeInaccuracyAff1 = 0.7

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.AimAng = Vector(2.5174, -0.0099, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ScopePos = Vector(5.973, -6.456, 2.04)
SWEP.ScopeAng = Vector(-0.551, 0, 0)

SWEP.ACOGPos = Vector(5.985, -4.591, 1.85)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(3.838, -20, 0.984)
SWEP.MeleeAng = Vector(0, -150, 0)