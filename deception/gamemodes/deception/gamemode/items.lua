Items = {}
local NI

function GM:RegisterItem(tbl)
	local ItemData = {num = tbl.num, Name = tbl.Name, Category = tbl.Category, Description = tbl.Description, Model = tbl.Model, Stats = tbl.Stats, Price = tbl.Price, Weapon = tbl.Weapon, Unique = tbl.Unique, CanBuy = tbl.CanBuy, BuyFunc = tbl.BuyFunc, TeamText = (tbl.TeamText or {"Civilian", "Agent", "VIP"})}

	table.insert(Items, ItemData)
end

NI = {}
NI.num = 1
NI.Name = "Sig Sauer P228"
NI.Category = "Weapons"
NI.Description = "A pistol chambered in the 9x19MM caliber.\nModerate damage at close range."
NI.Model = "models/weapons/w_pist_p228.mdl"
NI.Stats = {damage = 38, accuracy = 84, rof = 85, range = 55}
NI.Price = 200
NI.Weapon = true
NI.CanBuy = function(ply)
	if not ply:HasWeapon("dec_pistol_p228") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_pistol_p228")
	wep:SetClip1(14)
	ply:GiveAmmoCap(26, "pistol")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 2
NI.Name = "Glock-18"
NI.Category = "Weapons"
NI.Description = "A pistol chambered in the 9x19MM caliber.\nModerate damage at close range."
NI.Model = "models/weapons/w_pist_glock18.mdl"
NI.Stats = {damage = 38, accuracy = 68, rof = 100, range = 55}
NI.Price = 250
NI.Weapon = true
NI.CanBuy = function(ply)
	if not ply:HasWeapon("dec_pistol_glock18") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_pistol_glock18")
	wep:SetClip1(20)

	ply:GiveAmmoCap(38, "pistol")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 3
NI.Name = "FN Five-seveN"
NI.Category = "Weapons"
NI.Description = "A pistol chambered in the 5.7x28MM caliber.\nHigh damage at moderate range."
NI.Model = "models/weapons/w_pist_fiveseven.mdl"
NI.Stats = {damage = 56, accuracy = 100, rof = 70, range = 95}
NI.Price = 300
NI.Weapon = true
NI.CanBuy = function(ply)
	if not ply:HasWeapon("dec_pistol_fiveseven") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_pistol_fiveseven")
	wep:SetClip1(21)

	ply:GiveAmmoCap(40, "pistol")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 4
NI.Name = "Desert Eagle"
NI.Category = "Weapons"
NI.Description = "A pistol chambered in the .50 AE caliber.\nVery high damage at close range."
NI.Model = "models/weapons/w_pist_deagle.mdl"
NI.Stats = {damage = 100, accuracy = 84, rof = 40, range = 100}
NI.Price = 400
NI.Weapon = true
NI.CanBuy = function(ply)
	if not ply:HasWeapon("dec_pistol_deagle") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_pistol_deagle")
	wep:SetClip1(8)

	ply:GiveAmmoCap(14, "pistol")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 5
NI.Name = "Scout"
NI.Category = "Weapons"
NI.Description = "A civilian grade sniper rifle\nUsed for long range defense."
NI.Stats = {damage = 50, accuracy = 100, rof = 48, range = 100}
NI.Model = "models/weapons/w_snip_scout.mdl"
NI.Price = 450
NI.Unique = false
NI.CanBuy = function(ply)
	if not ply:HasWeapon("dec_sniper_scout") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_sniper_scout")
	ply:GiveAmmoCap(10, "AirboatGun")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 6
NI.Name = "MAC-10"
NI.Category = "Weapons"
NI.Description = "A SMG chambered in the .45 ACP caliber.\nHigh damage at close range."
NI.Model = "models/weapons/w_smg_mac10.mdl"
NI.Stats = {damage = 92, accuracy = 56, rof = 100, range = 67}
NI.Price = 500
NI.Weapon = true
NI.CanBuy = function(ply)
	if not ply:HasWeapon("dec_smg_mac10") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_smg_mac10")
	wep:SetClip1(31)

	ply:GiveAmmoCap(30, "smg1")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 7
NI.Name = "TMP"
NI.Category = "Weapons"
NI.Description = "A SMG chambered in the 9x19MM caliber.\nModerate damage at close range."
NI.Model = "models/weapons/w_smg_tmp.mdl"
NI.Stats = {damage = 72, accuracy = 70, rof = 78, range = 57}
NI.Price = 550
NI.Weapon = true
NI.CanBuy = function(ply)
	if not ply:HasWeapon("dec_smg_tmp") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_smg_tmp")
	wep:SetClip1(31)

	ply:GiveAmmoCap(30, "smg1")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 8
NI.Name = "MP5"
NI.Category = "Weapons"
NI.Description = "A SMG chambered in the 9x19MM caliber.\nModerate damage at close range."
NI.Model = "models/weapons/w_smg_mp5.mdl"
NI.Stats = {damage = 72, accuracy = 85, rof = 69, range = 57}
NI.Price = 600
NI.Weapon = true
NI.CanBuy = function(ply)
	if not ply:HasWeapon("dec_smg_mp5") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_smg_mp5")
	wep:SetClip1(31)

	ply:GiveAmmoCap(30, "smg1")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 9
NI.Name = "UMP"
NI.Category = "Weapons"
NI.Description = "A SMG chambered in the .45 ACP caliber.\nHigh damage at moderate range."
NI.Model = "models/weapons/w_smg_ump45.mdl"
NI.Stats = {damage = 92, accuracy = 73, rof = 52, range = 67}
NI.Price = 700
NI.Weapon = true
NI.CanBuy = function(ply)
	if not ply:HasWeapon("dec_smg_ump") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_smg_ump45")
	wep:SetClip1(26)

	ply:GiveAmmoCap(25, "smg1")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 10
NI.Name = "P90"
NI.Category = "Weapons"
NI.Description = "A SMG chambered in the 5.7x28MM caliber.\nVery high damage at long range."
NI.Model = "models/weapons/w_smg_p90.mdl"
NI.Stats = {damage = 100, accuracy = 100, rof = 78, range = 100}
NI.Price = 800
NI.Weapon = true
NI.CanBuy = function(ply)
	if not ply:HasWeapon("dec_smg_p90") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_smg_p90")
	wep:SetClip1(51)

	ply:GiveAmmoCap(50, "smg1")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 11
NI.Name = "Combat Knife"
NI.Category = "Weapons"
NI.Description = "A very durable, razor-sharp knife.\nCan kill a man in several stabs (or slashes).\nStabbing from behind results in a back-stab.\nBack-stabs kill the target instantly."
NI.Model = "models/weapons/w_knife_t.mdl"
NI.Price = 50
NI.Unique = true
NI.TeamText = {"Agent"}
NI.CanBuy = function(ply)
	if not ply.IsAgent then
		return 3
	end

	if not ply:HasWeapon("dec_melee_knife") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_melee_knife")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 12
NI.Name = "Dart gun"
NI.Category = "Weapons"
NI.Description = "A dart gun that fires out poison darts\nand makes little to no noise.\nThe poison can kill a man in 10 seconds.\nFired darts cannot be retrieved."
NI.Model = "models/weapons/w_pistol.mdl"
NI.Price = 250
NI.Unique = true
NI.TeamText = {"Agent"}
NI.CanBuy = function(ply)
	if not ply.IsAgent then
		return 3
	end

	if not ply:HasWeapon("dec_dart_gun") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_dart_gun")
	ply:GiveAmmoCap(3, "SniperRound")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 13
NI.Name = "AWP"
NI.Category = "Weapons"
NI.Description = "A Sniper Rifle chambered with a .338 caliber.\nVery high damage and long range."
NI.Model = "models/weapons/w_snip_awp.mdl"
NI.Stats = {damage = 80, accuracy = 100, rof = 41, range = 100}
NI.Price = 1000
NI.Unique = true
NI.TeamText = {"VIP"}
NI.CanBuy = function(ply)
	if not ply.IsVIP then
		return 3
	end

	if not ply:HasWeapon("dec_sniper_awp") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_sniper_awp")
	wep:SetClip1(10)

	ply:GiveAmmoCap(10, "smg1")
end

GM:RegisterItem(NI)



NI = {}
NI.num = 14
NI.Name = "SG550"
NI.Category = "Weapons"
NI.Description = "A auto sniper that fires quickly but\nit does less damage than the civilian scout."
NI.Stats = {damage = 40, accuracy = 100, rof = 70, range = 100}
NI.Model = "models/weapons/w_snip_sg550.mdl"
NI.Price = 650
NI.Unique = true
NI.TeamText = {"Agent"}
NI.CanBuy = function(ply)
	if not ply.IsAgent then
		return 3
	end

	if not ply:HasWeapon("dec_sniper_sg550") then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	local wep = ply:Give("dec_sniper_sg550")
	ply:GiveAmmoCap(10, "AirboatGun")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 201
NI.Name = "Pistol ammo"
NI.Category = "Ammo"
NI.Description = "Ammo used for pistols.\nGives you 24 pistol rounds, maximum carryable\namount is 96 rounds."
NI.Model = "models/Items/BoxSRounds.mdl"
NI.Price = 48
NI.CanBuy = function(ply)
	local ac = ply:GetAmmoCount("pistol")

	if ac >= 96 then
		SendUserMessage("AMMOFULL", ply)
		return 3
	end

	return 1
end

NI.BuyFunc = function(ply)
	ply:GiveAmmoCap(24, "pistol")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 202
NI.Name = "SMG ammo"
NI.Category = "Ammo"
NI.Description = "Ammo used for SMGs.\nGives you 30 SMG rounds, maximum carryable\namount is 120 rounds."
NI.Model = "models/Items/BoxMRounds.mdl"
NI.Price = 64
NI.CanBuy = function(ply)
	local ac = ply:GetAmmoCount("smg1")

	if ac >= 120 then
		SendUserMessage("AMMOFULL", ply)
		return 3
	end

	return 1
end

NI.BuyFunc = function(ply)
	ply:GiveAmmoCap(30, "smg1")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 203
NI.Name = "Poison darts"
NI.Category = "Ammo"
NI.Description = "Ammo used for the Dart gun.\nGives you 5 Poison darts, maximum carryable\namount is 10 darts."
NI.Model = "models/Items/CrossbowRounds.mdl"
NI.Price = 50
NI.TeamText = {"Agent"}
NI.CanBuy = function(ply)
	if not ply.IsAgent then
		return 3
	end

	local ac = ply:GetAmmoCount("SniperRound")

	if ac >= 10 then
		SendUserMessage("AMMOFULL", ply)
		return 3
	end

	return 1
end

NI.BuyFunc = function(ply)
	ply:GiveAmmoCap(5, "SniperRound")
end

GM:RegisterItem(NI)

NI = {}
NI.num = 204
NI.Name = "Sniper Ammo"
NI.Category = "Ammo"
NI.Description = "Ammo used for all Snipers.\nGives you 10 shots, maximum carryable\namount is 40 bullets."
NI.Model = "models/Items/357ammobox.mdl"
NI.Price = 75
NI.CanBuy = function(ply)
	local ac = ply:GetAmmoCount("AirboatGun")

	if ac >= 40 then
		SendUserMessage("AMMOFULL", ply)
		return 3
	end

	return 1
end

NI.BuyFunc = function(ply)
	ply:GiveAmmoCap(10, "AirboatGun")
end

GM:RegisterItem(NI)

NI = {}

NI.num = 301
NI.Name = "Flak vest"
NI.Category = "Armor"
NI.Description = "An easily concealable light flak vest.\nDecreases damage from bullets/melee by 15%\nDecreases run speed by 2%\nWill wear down over time."
NI.Model = "models/weapons/w_package.mdl"
NI.Price = 150
NI.CanBuy = function(ply)
	if ply.BodyArmDamageDec != 0.85 then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	ply.BodyArmCondition = 100
	ply.BodyArmDamageDec = 0.85
	ply:SetRunSpeed(GetConVarNumber("dec_runspeed") * 0.98)
	ply.iRunSpeed = ply:GetRunSpeed()
	ply.Weight = ply.Weight + 3

	umsg.Start("ARMOR", ply)
		umsg.Short(100)
		umsg.Short(1)
	umsg.End()
end

GM:RegisterItem(NI)

NI = {}

NI.num = 302
NI.Name = "Dyneema vest"
NI.Category = "Armor"
NI.Description = "An easily concealable dyneema vest.\nDecreases damage from bullets/melee by 25%\nDecreases run speed by 3.5%\nWill wear down over time."
NI.Model = "models/weapons/w_package.mdl"
NI.Price = 200
NI.CanBuy = function(ply)
	if ply.BodyArmDamageDec != 0.75 then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	ply.BodyArmCondition = 100
	ply.BodyArmDamageDec = 0.75
	ply:SetRunSpeed(GetConVarNumber("dec_runspeed") * 0.965)
	ply.iRunSpeed = ply:GetRunSpeed()
	ply.Weight = ply.Weight + 4

	umsg.Start("ARMOR", ply)
		umsg.Short(100)
		umsg.Short(3)
	umsg.End()
end

GM:RegisterItem(NI)

NI = {}

NI.num = 303
NI.Name = "Kevlar vest"
NI.Category = "Armor"
NI.Description = "An easily concealable kevlar vest.\nDecreases damage from bullets/melee by 32%\nDecreases run speed by 5%\nWill wear down over time."
NI.Model = "models/weapons/w_package.mdl"
NI.Price = 250
NI.CanBuy = function(ply)
	if ply.BodyArmDamageDec != 0.68 then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	ply.BodyArmCondition = 100
	ply.BodyArmDamageDec = 0.68
	ply:SetRunSpeed(GetConVarNumber("dec_runspeed") * 0.95)
	ply.iRunSpeed = ply:GetRunSpeed()
	ply.Weight = ply.Weight + 5

	umsg.Start("ARMOR", ply)
		umsg.Short(100)
		umsg.Short(2)
	umsg.End()
end

GM:RegisterItem(NI)

NI = {}

NI.num = 401
NI.Name = "How to conceal your weapons"
NI.Category = "Other"
NI.Description = "Explains how to properly conceal your weapons.\nIncreases maximum items carried to become\nsuspicious upon examination.\nLasts one round."
NI.Model = "models/props_lab/binderblue.mdl"
NI.Price = 75
NI.CanBuy = function(ply)
	if ply.WeightDetection != 5 then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	ply.WeightDetection = 5
end

GM:RegisterItem(NI)

NI = {}

NI.num = 402
NI.Name = "How to detect concealation"
NI.Category = "Other"
NI.Description = "Explains how to detect concealed items\non people. Increases your examination skills.\nLasts one round."
NI.Model = "models/props_lab/binderblue.mdl"
NI.Price = 75
NI.CanBuy = function(ply)
	if ply.DetectionAmount != 5 then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	ply.DetectionAmount = 5
end

GM:RegisterItem(NI)

NI = {}

NI.num = 403
NI.Name = "How to examine quickly"
NI.Category = "Other"
NI.Description = "Explains how to quickly examine people.\nIncreases player examination speed.\nLasts one round."
NI.Model = "models/props_lab/binderblue.mdl"
NI.Price = 50
NI.CanBuy = function(ply)
	if ply.ExamTime != 1 then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	ply.ExamTime = 1
end

GM:RegisterItem(NI)

NI = {}

NI.num = 404
NI.Name = "Forged VIP ID card"
NI.Category = "Other"
NI.Description = "Allows you to show this fake VIP ID card.\nCan be used to fool civilians into believing you\nto kill the VIP and cause confusion.\nThe enemy agent and the VIP can notice that it's fake."
NI.Model = "models/props_lab/binderblue.mdl"
NI.Price = 300
NI.TeamText = {"Agent"}
NI.CanBuy = function(ply)
	if not ply.IsAgent then
		return 3
	end

	if ply.IDType == 0 then
		return 1
	end

	return 2
end

NI.BuyFunc = function(ply)
	ply.IDType = 2
	SendUserMessage("BUYFORGEDID", ply)
end

GM:RegisterItem(NI)

NI = {}

NI.num = 405
NI.Name = "Antidote"
NI.Category = "Other"
NI.Description = "Cures any contracted poisoning or disease.\nCannot purchase if not poisoned."
NI.Model = "models/healthvial.mdl"
NI.Price = 25
NI.CanBuy = function(ply)
	if ply:HasItemNum(1) then
		return 3
	end

	return 1
end

NI.BuyFunc = function(ply)
	ply:AddCarryable(1)
end

GM:RegisterItem(NI)

NI = {}

NI.num = 406
NI.Name = "Medkit"
NI.Category = "Other"
NI.Description = "Restores 25 health points upon retrieval.\nRestores max. health regen by 10 points\nCannot buy if health is full.\nCannot use more than 2 medkits per round."
NI.Model = "models/Items/HealthKit.mdl"
NI.Price = 50
NI.CanBuy = function(ply)
	if ply.DosesTaken == 2 then
		SendUserMessage("MAXDOSE", ply)
		return 3
	end

	if ply:Health() == 100 then
		return 3
	end

	return 1
end

NI.BuyFunc = function(ply)
	ply:EmitSound("items/medshot4.wav", 70, 100)
	ply:SetHealth(math.Clamp(ply:Health() + 25, 0, 100))
	ply.HealthRegenMax = math.Clamp(ply.HealthRegenMax + 10, 0, 100)
	ply.DosesTaken = ply.DosesTaken + 1
end

GM:RegisterItem(NI)

NI = {}

NI.num = 407
NI.Name = "Walkie-talkie"
NI.Category = "Other"
NI.Description = "A radio used for remote communication.\nUpon purchase, allows the use of radio\ncommands by using the weapon slot keys."
NI.Model = "models/weapons/w_eq_eholster.mdl"
NI.Price = 25
NI.CanBuy = function(ply)
	if ply.HasWalkieTalkie then
		return 2
	end

	return 1
end

NI.BuyFunc = function(ply)
	ply.HasWalkieTalkie = true
	SendUserMessage("BUY_WALKIETALKIE", ply)

	if not ply.Channel then
		ply.Channel = "channel1"
	end
end

GM:RegisterItem(NI)

NI = {}

NI.num = 408
NI.Name = "Ballistics Analyzer"
NI.Category = "Other"
NI.Description = "A device used to find out the fingerprint\nof a killer by sampling bullets on dead bodies."
NI.Model = "models/weapons/w_c4.mdl"
NI.Price = 300
NI.Unique = true
NI.TeamText = {"Civilian", "VIP"}
NI.CanBuy = function(ply)
	if ply.IsAgent then
		return 2
	end

	if ply:HasWeapon("dec_balanal") then
		return 2
	end

	return 1
end

NI.BuyFunc = function(ply)
	ply:Give("dec_balanal")
end

GM:RegisterItem(NI)

NI = {}

NI.num = 501
NI.Name = "Agency help - 1 person"
NI.Category = "Hints"
NI.Description = "Purchase help from the agency.\nTells you who is definitely not the VIP\nto shorten the circle of suspects."
NI.Model = "models/props_c17/paper01.mdl"
NI.Price = 50
NI.TeamText = {"Agent"}
NI.CanBuy = function(ply)
	if not IsValid(VIP) then
		SendUserMessage("AGENCY_VIPDEAD", ply)
		return 3
	end

	if not ply.IsAgent then
		return 3
	end

	if ply.AgencyHelp == 0 then
		SendUserMessage("AGENCY_NOHELP", ply)
		return 3
	end

	if not ply.NonVIPPlayers then
		ply.NonVIPPlayers = player.GetAll()

		for k, v in pairs(ply.NonVIPPlayers) do
			if v.IsVIP or not IsValid(v) or not v:Alive() or v == ply then
				table.RemoveByValue(ply.NonVIPPlayers, v)
			end
		end
	end

	if ply.NonVIPPlayers then
		for k, v in pairs(ply.NonVIPPlayers) do
			if not IsValid(v) or not v:Alive() or v == ply then
				table.RemoveByValue(ply.NonVIPPlayers, v)
			end
		end

		if #ply.NonVIPPlayers == 0 then
			SendUserMessage("AGENCY_NOHELP", ply)
			return 3
		end
	end

	if #player.GetAll() < 5 then
		umsg.Start("AGENCY_NOPEOPLE", ply)
			umsg.Short(5)
		umsg.End()

		return 3
	end

	if (ply.HintsBought or 0) >= #ply.NonVIPPlayers then
		SendUserMessage("AGENCY_NOHELP", ply)
		print("Preventing bought from player " .. ply:Name() .. " due to max bought count reached")

		return 3
	end
	ply.HintsBought = (ply.HintsBought or 0) + 1

	return 1
end

NI.BuyFunc = function(ply)
	local rand = math.random(1, #ply.NonVIPPlayers)
	local ent = ply.NonVIPPlayers[rand]
	table.remove(ply.NonVIPPlayers, rand)

	ply.AgencyHelp = ply.AgencyHelp - 1

	if !IsValid(ent) then
		return
	end

	umsg.Start("AGENCY_HELP_1", ply)
		umsg.Entity(ent)
	umsg.End()
end

GM:RegisterItem(NI)

NI = {}

NI.num = 502
NI.Name = "Agency help - 2 persons"
NI.Category = "Hints"
NI.Description = "Purchase help from the agency.\nTells you who is definitely not the VIP\nto shorten the circle of suspects."
NI.Model = "models/props_c17/paper01.mdl"
NI.Price = 75
NI.TeamText = {"Agent"}
NI.CanBuy = function(ply)
	if not IsValid(VIP) then
		SendUserMessage("AGENCY_VIPDEAD", ply)
		return 3
	end

	if not ply.IsAgent then
		return 3
	end

	if ply.AgencyHelp == 0 then
		SendUserMessage("AGENCY_NOHELP", ply)
		return 3
	end

	if not ply.NonVIPPlayers then
		ply.NonVIPPlayers = player.GetAll()

		for k, v in pairs(ply.NonVIPPlayers) do
			if v.IsVIP or not IsValid(v) or not v:Alive() or v == ply then
				table.RemoveByValue(ply.NonVIPPlayers, v)
			end
		end
	end

	if ply.NonVIPPlayers then
		for k, v in pairs(ply.NonVIPPlayers) do
			if not IsValid(v) or not v:Alive() or v == ply then
				table.RemoveByValue(ply.NonVIPPlayers, v)
			end
		end

		if #ply.NonVIPPlayers < 2 then
			SendUserMessage("AGENCY_NOHELP", ply)
			return 3
		end
	end

	if #player.GetAll() < 9 then
		umsg.Start("AGENCY_NOPEOPLE", ply)
			umsg.Short(9)
		umsg.End()

		return 3
	end

	if (ply.HintsBought or 0) >= #ply.NonVIPPlayers then
		SendUserMessage("AGENCY_NOHELP", ply)
		print("Preventing bought from player " .. ply:Name() .. " due to max bought count reached")

		return 3
	end
	ply.HintsBought = (ply.HintsBought or 0) + 2

	return 1
end

NI.BuyFunc = function(ply)
	local rand = math.random(1, #ply.NonVIPPlayers)
	local ent = ply.NonVIPPlayers[rand]
	table.remove(ply.NonVIPPlayers, rand)

	local rand2 = math.random(1, #ply.NonVIPPlayers)
	local ent2 = ply.NonVIPPlayers[rand2]
	table.remove(ply.NonVIPPlayers, rand2)

	ply.AgencyHelp = ply.AgencyHelp - 1

	if !IsValid(ent) then
		return
	end

	if !IsValid(ent2) then
		umsg.Start("AGENCY_HELP_1", ply)
			umsg.Entity(ent)
		umsg.End()
		return
	end

	umsg.Start("AGENCY_HELP_2", ply)
		umsg.Entity(ent)
		umsg.Entity(ent2)
	umsg.End()
end

GM:RegisterItem(NI)
