

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoAimpoint = true
	SWEP.NoACOG = true
	SWEP.NoEOTech = true
	
	SWEP.BulletLength = 9
	SWEP.CaseLength = 19
	SWEP.RequiresRail = false
end

if ( CLIENT ) then

	SWEP.PrintName			= "P228"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "a"
	SWEP.Muzzle = "cstm_muzzle_pistol"
	SWEP.SparkEffect = "cstm_child_sparks_small"
	SWEP.SmokeEffect = "cstm_child_smoke_small"
	
	killicon.AddFont( "cstm_pistol_p228", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.p228_Parent", pos = Vector(0.043, 2.888, 3.599), angle = Angle(0, 0, 0), size = Vector(0.043, 0.043, 0.136), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["aimpointdot"] = { type = "Sprite", sprite = "effects/redflare", bone = "v_weapon.p228_Slide", pos = Vector(0.043, 0.949, 0.375), size = { x = 0.3, y = 0.3 }, color = Color(255, 255, 255, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/doctorrds.mdl", bone = "v_weapon.p228_Slide", pos = Vector(-0.207, 0.337, 1.019), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.081, 1.569, 3.2), angle = Angle(0, 180, 180), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(9.762, 0.6, -4), angle = Angle(-90, 0, 0), size = Vector(0.043, 0.043, 0.136), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/doctorrds.mdl", pos = Vector(5.762, 0.949, -4.433), angle = Angle(0, 90, 180), size = Vector(1.299, 1.299, 1.299), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.MeleeOffset = {
		['v_weapon.Right_Arm'] = {vector = Vector(3.8129999637604, 0, -4.5500001907349), angle = Vector(14.512000083923, 0, -129.96899414063)},
		['v_weapon.Right_Index01'] = {vector = Vector(0, -0.25600001215935, 0), angle = Vector(0, -34.263000488281, 0)},
		['v_weapon.Right_Index02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -34.931999206543, 0)},
		['v_weapon.Right_Index03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -34.776000976563, 0)},
		['v_weapon.Right_Middle01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -46.013999938965, 0)},
		['v_weapon.Right_Middle02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -20.507999420166, 0)},
		['v_weapon.Right_Middle03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -24.677000045776, 0)},
		['v_weapon.Right_Ring01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -36.376998901367, 0)},
		['v_weapon.Right_Ring02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -35.764999389648, 0)},
		['v_weapon.Right_Ring03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -12.208999633789, 0)},
		['v_weapon.Right_Pinky01'] = {vector = Vector(0, 0, 0), angle = Vector(-3.194000005722, -26.853000640869, 0)},
		['v_weapon.Right_Pinky02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -25.016000747681, 0)},
		['v_weapon.Right_Pinky03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -23.67799949646, 0)},
		['v_weapon.Right_Thumb01'] = {vector = Vector(0, 0, 0), angle = Vector(-9.2690000534058, 22.17200088501, 0)},
		['v_weapon.Right_Thumb02'] = {vector = Vector(0, 0, 0), angle = Vector(0, 9.0279998779297, 0)} }

end

SWEP.Caliber = "9x19MM"
SWEP.HoldType			= "ar2"
SWEP.Base = "dec_base_pistol"
//SWEP.Category			= "Condition SWEPs"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_pist_p228.mdl"
SWEP.WorldModel = "models/weapons/w_pist_p228.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("weapons/p228/p228-1.wav")
SWEP.Primary.Recoil			= 0.7
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.035
SWEP.Primary.ClipSize		= 13
SWEP.Primary.Delay			= 0.14
SWEP.Primary.DefaultClip	= 13
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
SWEP.IncAmmoPerc = 0.25 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.7
SWEP.CurCone				= 0.035
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
SWEP.IronsightsCone			= 0.026
SWEP.HipCone 				= 0.041
SWEP.ConeInaccuracyAff1 = 0.5

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(4.75, -0.332, 2.819)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ReflexPos = Vector(4.743, -2.951, 2.348)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(-0.48, 0, 0.119)
SWEP.MeleeAng = Vector(0, 0, 0)