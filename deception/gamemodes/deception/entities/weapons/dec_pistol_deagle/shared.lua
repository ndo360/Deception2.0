

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoAimpoint = true
	SWEP.NoACOG = true
	SWEP.NoEOTech = true
	
	SWEP.BulletLength = 12.7
	SWEP.CaseLength = 32.6
	SWEP.RequiresRail = false
end

if ( CLIENT ) then

	SWEP.PrintName			= "Desert Eagle .50AE"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "f"
	SWEP.Muzzle = "cstm_muzzle_br"
	SWEP.SparkEffect = "cstm_child_sparks_large"
	SWEP.SmokeEffect = "cstm_child_smoke_large"
	
	killicon.AddFont( "cstm_pistol_deagle", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["aimpointdot"] = { type = "Sprite", sprite = "effects/redflare", bone = "v_weapon.Deagle_Slide", pos = Vector(0.013, 1.156, 0.386), size = { x = 0.3, y = 0.3 }, color = Color(255, 255, 255, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/doctorrds.mdl", bone = "v_weapon.Deagle_Slide", pos = Vector(-0.239, 0.574, 0.924), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "v_weapon.Deagle_Parent", rel = "", pos = Vector(0, 1.962, 4.138), angle = Angle(0, 0, 180), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/doctorrds.mdl", pos = Vector(7.456, 0.955, -4.52), angle = Angle(0, 90, 180), size = Vector(1.299, 1.299, 1.299), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.MeleeOffset = {
		['v_weapon.Right_Arm'] = {vector = Vector(2.0060000419617, 0, -7.0749998092651), angle = Vector(6.4559998512268, 0, -141.625)},
		['v_weapon.Right_Index01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -9.6190004348755, 0)},
		['v_weapon.Right_Index02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -36.450000762939, 0)},
		['v_weapon.Right_Index03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -41.825000762939, 0)},
		['v_weapon.Right_Middle01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -43.055999755859, 0)},
		['v_weapon.Right_Middle02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -35.331001281738, 0)},
		['v_weapon.Right_Ring01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -31.41900062561, 0)},
		['v_weapon.Right_Ring02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -32.513000488281, 0)},
		['v_weapon.Right_Ring03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -29.768999099731, 0)},
		['v_weapon.Right_Pinky01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -22.22500038147, 0)},
		['v_weapon.Right_Pinky02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -22.893999099731, 0)},
		['v_weapon.Right_Pinky03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -19.52499961853, 0)},
		['v_weapon.Right_Thumb01'] = {vector = Vector(0, 0, 0), angle = Vector(-8.1190004348755, 24.843999862671, 0)}}
	
end

SWEP.Caliber = ".50 AE"
SWEP.Base = "dec_base_pistol"
///SWEP.Category			= "Condition SWEPs (TEST)"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("weapons/deagle/deagle-1.wav")
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 39
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 7
SWEP.Primary.Delay			= 0.3
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"
SWEP.InitialHoldtype = "pistol"
SWEP.InHoldtype = "pistol"
SWEP.NoAuto = true
SWEP.ACOGStatus = 0
SWEP.NoScopes = true
SWEP.CantSilence = true
SWEP.NoBoltAnim = true

SWEP.Size = 5

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.28 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 3
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
SWEP.IronsightsCone 		= 0.026
SWEP.HipCone 				= 0.044
SWEP.ScopeCone 				= 0.022
SWEP.ConeInaccuracyAff1 = 0.5

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(5.147, -3.089, 2.66)
SWEP.AimAng = Vector(0.619, -0.062, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ReflexPos = Vector(5.125, -3.089, 2.361)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(0.843, -0.956, 0.537)
SWEP.MeleeAng = Vector(0, 8.1, 0)