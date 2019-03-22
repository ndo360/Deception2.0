

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoAimpoint = true
	SWEP.NoACOG = true
	SWEP.NoEOTech = true
	SWEP.NoDocter = true
	
	SWEP.BulletLength = 5.7
	SWEP.CaseLength = 28
	SWEP.RequiresRail = false
end

if ( CLIENT ) then

	SWEP.PrintName			= "FN P90"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 2
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "m"
	SWEP.Muzzle = "cstm_muzzle_smg"
	SWEP.SparkEffect = "cstm_child_sparks_medium"
	SWEP.SmokeEffect = "cstm_child_smoke_medium"
	SWEP.BackModel = "models/weapons/w_smg_p90.mdl"
	
	killicon.AddFont( "cstm_smg_p90", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.p90_Parent", pos = Vector(0.043, 2.944, 6.593), angle = Angle(0, 0, 0), size = Vector(0.043, 0.043, 0.15), color = Color(255, 255, 255, 1), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(13.718, 1.18, -2.901), angle = Angle(-90, 0, 0), size = Vector(0.043, 0.043, 0.15), color = Color(255, 255, 255, 1), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}
	
	SWEP.NoProperIronsights = true
	
	SWEP.BoneApproachSpeed = 0.45
	
	SWEP.MeleeOffset = {
		['v_weapon.Right_Arm'] = {vector = Vector(6.451000213623, 8.1809997558594, 4.3559999465942), angle = Vector(45.555999755859, -43.875, -64.630996704102)},
		['v_weapon.Right_Thumb01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -17.819000244141, 0)},
		['v_weapon.Right_Thumb02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -9.2749996185303, 0)},
		['v_weapon.Right_Thumb03'] = {vector = Vector(0, 0, 0), angle = Vector(-13.755999565125, 0, 0)},
		['v_weapon.Right_Index01'] = {vector = Vector(0.11900000274181, 0, 0), angle = Vector(0, 7.5749998092651, 0)},
		['v_weapon.Right_Index02'] = {vector = Vector(0, 0, 0), angle = Vector(0, 16.412000656128, 0)},
		['v_weapon.Right_Index03'] = {vector = Vector(0, 0, 0), angle = Vector(0, 21.481000900269, 0)},
		['v_weapon.Right_Middle01'] = {vector = Vector(0, 0, 0), angle = Vector(0, 17.162000656128, 0)},
		['v_weapon.Right_Middle02'] = {vector = Vector(0, 0, 0), angle = Vector(0, 4.438000202179, 0)},
		['v_weapon.Right_Ring01'] = {vector = Vector(0, 0, 0), angle = Vector(0, 19.75, 0)},
		['v_weapon.Right_Ring02'] = {vector = Vector(0, 0, 0), angle = Vector(0, 6.8499999046326, 0)},
		['v_weapon.Right_Pinky01'] = {vector = Vector(0, 0, 0), angle = Vector(0, 43.174999237061, 0)},
		['v_weapon.Right_Pinky02'] = {vector = Vector(0, 0, 0), angle = Vector(0, 27.66900062561, 0)},
		['v_weapon.Right_Pinky03'] = {vector = Vector(0, 0, 0), angle = Vector(0, 26.069000244141, 0)},
		['v_weapon.Left_Arm'] = {vector = Vector(4.438000202179, -1.9249999523163, 12.069999694824), angle = Vector(60.937999725342, 47.944000244141, 107.60600280762)},
		['v_weapon.Left_Hand'] = {vector = Vector(0, 0, 0), angle = Vector(4.4809999465942, 0, 0)},
		['v_weapon.Left_Index01'] = {vector = Vector(0, 0, 0), angle = Vector(0, 26.281000137329, 0)},
		['v_weapon.Left_Index02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -7.5809998512268, 0)},
		['v_weapon.Left_Index03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -38.937999725342, 0)},
		['v_weapon.Left_Thumb01'] = {vector = Vector(0, 0, 0), angle = Vector(0, 11.52499961853, 0)},
		['v_weapon.Left_Thumb_02'] = {vector = Vector(0, 0, 0), angle = Vector(0, 34.668998718262, 0)},
		['v_weapon.Left_Thumb03'] = {vector = Vector(0, 0, 0), angle = Vector(0, 70.52499961853, 0)},
		['v_weapon.Left_Middle01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -8.6499996185303, 0)},
		['v_weapon.Left_Middle02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -17.613000869751, 0)},
		['v_weapon.Left_Middle03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -71.837997436523, 0)},
		['v_weapon.Left_Ring01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -20.424999237061, 0)},
		['v_weapon.Left_Ring02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -24.22500038147, 0)},
		['v_weapon.Left_Ring03'] = {vector = Vector(0, 0, 0), angle = Vector(0, -46.743999481201, 0)},
		['v_weapon.Left_Pinky01'] = {vector = Vector(0, 0, 0), angle = Vector(0, -43.631000518799, 0)},
		['v_weapon.Left_Pinky02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -42.650001525879, 0)},
		['v_weapon.Left_Pinky02'] = {vector = Vector(0, 0, 0), angle = Vector(0, -42.650001525879, 0)} }
	
end

SWEP.Caliber = "5.7x28MM"
SWEP.HoldType			= "ar2"
SWEP.Base = "dec_base_pistol"
///SWEP.Category			= "Condition SWEPs (TEST)"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_smg_p90.mdl"
SWEP.WorldModel = "models/weapons/w_smg_p90.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("weapons/p90/p90-1.wav")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 25
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 50
SWEP.Primary.Delay			= 0.0666
SWEP.Primary.DefaultClip	= 50
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"

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
SWEP.VelocitySensivity		= 1.2 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.017
SWEP.HipCone 				= 0.045
SWEP.InaccAff1 = 0.45
SWEP.ConeInaccuracyAff1 = 0.55

SWEP.Size = 7

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(2, -4.427, 2.44)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.MeleePos = Vector(-3.526, -14.414, 0.025)
SWEP.MeleeAng = Vector(0, -130, 0)
