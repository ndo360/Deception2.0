

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoAimpoint = true
	SWEP.NoACOG = true
	SWEP.NoEOTech = true
	
	SWEP.BulletLength = 9
	SWEP.CaseLength = 19
	SWEP.RequiresRail = false
	SWEP.NoLaser = true
end

if ( CLIENT ) then

	SWEP.PrintName			= "Glock 18"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "c"
	SWEP.ReloadAngleMod = -1
	SWEP.Muzzle = "cstm_muzzle_pistol"
	SWEP.SparkEffect = "cstm_child_sparks_small"
	SWEP.SmokeEffect = "cstm_child_smoke_small"
	
	killicon.AddFont( "cstm_pistol_glock18", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.Glock_Parent", pos = Vector(-2.845, 3.2, -0.557), angle = Angle(92.43, 14.538, 1.187), size = Vector(0.043, 0.043, 0.136), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["aimpointdot"] = { type = "Sprite", sprite = "effects/redflare", bone = "v_weapon.Glock_Slide", pos = Vector(0.312, 0.763, 0.215), size = { x = 0.3, y = 0.3 }, color = Color(255, 255, 255, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/doctorrds.mdl", bone = "v_weapon.Glock_Slide", pos = Vector(0.887, 0.125, 0.312), angle = Angle(-77.087, -89.825, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(10.2, 0.6, -4), angle = Angle(-90, 0, 0), size = Vector(0.043, 0.043, 0.136), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/doctorrds.mdl", pos = Vector(4.855, 0.726, -4.224), angle = Angle(0, 90, 180), size = Vector(1.299, 1.299, 1.299), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.MeleeOffset = {
		['v_weapon.Right_Arm'] = {vector = Vector(1.8500000238419, 0.59399998188019, -5.1440000534058), angle = Vector(12.60000038147, -2.4630000591278, -149)},
		['v_weapon.Right_Index01'] = {vector = Vector(0, 0, 0), angle = Vector(-7.0749998092651, -41.407001495361, 0)},
		['v_weapon.Right_Index02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -40.25, 0)},
		['v_weapon.Right_Index03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -58.025001525879, 0)},
		['v_weapon.Right_Middle01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -34.911998748779, 0)},
		['v_weapon.Right_Middle02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -19.950000762939, 0)},
		['v_weapon.Right_Middle03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -19.993999481201, 0)},
		['v_weapon.Right_Ring01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -30.768999099731, 0)},
		['v_weapon.Right_Ring02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -35.562999725342, 0)},
		['v_weapon.Right_Ring03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -35.131999969482, 0)},
		['v_weapon.Right_Pinky01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -42.095001220703, 0)},
		['v_weapon.Right_Pinky02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -18.232000350952, 0)},
		['v_weapon.Right_Pinky03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -17.701000213623, 0)},
		['v_weapon.Right_Thumb01'] = {vector = Vector(0, 0, 0), angle = Vector(-21.47500038147, 28.961999893188, 0)},
		['v_weapon.Right_Thumb02'] = {vector = Vector(0, 0, 0), angle = Vector(0, 36.918998718262, 0)},
		['v_weapon.Right_Thumb03'] = {vector = Vector(0, 0, 0), angle = Vector(0, 39.162998199463, 0)} }
		
		
	
end

SWEP.Caliber = "9x19MM"
SWEP.HoldType			= "ar2"
SWEP.Base = "dec_base_pistol"
///SWEP.Category			= "Condition SWEPs (TEST)"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_pist_glock18.mdl"
SWEP.WorldModel = "models/weapons/w_pist_glock18.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("weapons/glock/glock18-1.wav")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 19
SWEP.Primary.Delay			= 0.12
SWEP.Primary.DefaultClip	= 19
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"
SWEP.InitialHoldtype = "pistol"
SWEP.InHoldtype = "pistol"
SWEP.ACOGStatus = -1
SWEP.NoBoltAnim = true
SWEP.NoAuto = true

SWEP.Size = 5

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = "glock_"
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.28 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.5
SWEP.CurCone				= 0.04
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
SWEP.IronsightsCone 		= 0.032
SWEP.HipCone 				= 0.045
SWEP.ConeInaccuracyAff1 = 0.5

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(4.32, -0.745, 2.891)
SWEP.AimAng = Vector(0.555, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ReflexPos = Vector(4.335, -3.056, 2.553)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(-1.88, 0, 0.6)
SWEP.MeleeAng = Vector(0, 0, 0)