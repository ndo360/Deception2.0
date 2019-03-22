local ply, CT, Time, time, ent, ent2, status, wep, cond, results, amt, role, rolet, color, slot, itemnum, num, tbl, dosh, progress, fingerprint, cause

local function DEC_ReceiveAgentStatus()
	StatusText = {}
	StatusText.Enum = 1
	StatusText.Type = "You are one of the two agents."
	StatusText.Description = "Eliminate the enemy agent and the VIP."

	StatusAlphaTime = CurTime() + 5

	ply = LocalPlayer()
	ply.TeamText = "Agent"
	ply.InexperienceRatio = 1
	ply.IDType = 0
	DEC_RestoreInfo()

	RunConsoleCommand("dec_received")

	surface.PlaySound("deception/instruc" .. math.random(1, 6) .. ".mp3")
end

usermessage.Hook("AGENT", DEC_ReceiveAgentStatus)

local function DEC_ReceiveVIPStatus()
	StatusText = {}
	StatusText.Enum = 1
	StatusText.Type = "You are the VIP."
	StatusText.Description = "Avoid the enemy agents or eliminate them."
	StatusAlphaTime = CurTime() + 5

	ply = LocalPlayer()
	ply.TeamText = "VIP"
	ply.IDType = 1
	ply.InexperienceRatio = 1.25
	DEC_RestoreInfo()

	RunConsoleCommand("dec_received")
end

usermessage.Hook("VIP", DEC_ReceiveVIPStatus)

local function DEC_WinVip(um)
	R = um:ReadShort()
	MR = um:ReadShort()
	CT = CurTime()
	NewRoundTime = CT + 15
	RoundTime = -1

	StatusText = {}

	if R > MR then
		StatusText.Enum = 1
		StatusText.Description = "Voting for next map started."
		StatusAlphaTime = CT + 29
	else
		StatusText.Enum = 2
		StatusAlphaTime = CT + 14
	end

	StatusText.Type = "The VIP has won the round!"

	ply = LocalPlayer()
	ply.TeamText = "Civilian"
	ply.InexperienceRatio = 1.25
	ply.IDType = 0
	DEC_RestoreInfo()

	for k, v in pairs(player.GetAll()) do
		v.Status = nil
		v.AddStatus = nil
	end

	Poisoned = false
	BlurStrength = 0
end

usermessage.Hook("WIN_VIP", DEC_WinVip)

local function DEC_BuyForgedID()
	LocalPlayer().IDType = 2
end

usermessage.Hook("BUYFORGEDID", DEC_BuyForgedID)

local function DEC_WinAgent(um)
	ply = um:ReadEntity()
	R = um:ReadShort()
	MR = um:ReadShort()
	CT = CurTime()
	NewRoundTime = CT + 15
	RoundTime = -1

	StatusText = {}

	if R > MR then
		StatusText.Enum = 1
		StatusText.Description = "Voting for next map started."
		StatusAlphaTime = CT + 29
	else
		StatusText.Enum = 2
		StatusAlphaTime = CT + 14
	end

	StatusText.Type = ply:Nick() .. " has won the round!"

	ply = LocalPlayer()
	ply.TeamText = "Civilian"
	ply.InexperienceRatio = 1.25
	ply.IDType = 0
	DEC_RestoreInfo()

	for k, v in pairs(player.GetAll()) do
		v.Status = nil
		v.AddStatus = nil
	end

	Poisoned = false
	BlurStrength = 0
end

usermessage.Hook("WIN_AGENT", DEC_WinAgent)

local function DEC_WinDraw(um)
	R = um:ReadShort()
	MR = um:ReadShort()
	CT = CurTime()
	NewRoundTime = CT + 15
	RoundTime = -1

	StatusText = {}

	if R > MR then
		StatusText.Enum = 1
		StatusText.Description = "Voting for next map started."
		StatusAlphaTime = CT + 29
	else
		StatusText.Enum = 2
		StatusAlphaTime = CT + 14
	end

	StatusText.Type = "Agents are still alive, round draw!"

	ply = LocalPlayer()
	ply.TeamText = "Civilian"
	ply.InexperienceRatio = 1.25
	ply.IDType = 0
	DEC_RestoreInfo()

	for k, v in pairs(player.GetAll()) do
		v.Status = nil
		v.AddStatus = nil
	end

	Poisoned = false
	BlurStrength = 0
end

usermessage.Hook("WIN_DRAW", DEC_WinDraw)

local function DEC_RoundRestart(um)
	R = um:ReadShort()
	MR = um:ReadShort()
	CT = CurTime()
	NewRoundTime = CT + 15
	RoundTime = -1

	StatusText = {}

	if R > MR then
		StatusText.Enum = 1
		StatusText.Description = "Voting for next map started."
		StatusAlphaTime = CT + 29
	else
		StatusText.Enum = 2
		StatusAlphaTime = CT + 14
	end

	StatusText.Type = "Round restarted by server admin."

	ply = LocalPlayer()
	ply.TeamText = "Civilian"
	ply.InexperienceRatio = 1.25
	ply.IDType = 0
	DEC_RestoreInfo()

	for k, v in pairs(player.GetAll()) do
		v.Status = nil
		v.AddStatus = nil
	end

	Poisoned = false
	BlurStrength = 0
end

usermessage.Hook("ROUNDRESTART", DEC_RoundRestart)

local function DEC_ReceiveRoundTime(um)
	Time = um:ReadLong()
	RoundTime = CurTime() + Time

	ply = LocalPlayer()
	ply.InexperienceRatio = 1.25
	DEC_RestoreInfo()

	if IsValid(ply) then
		timer.Simple(0.2, function()
			if ply:Alive() then
				if ply.TeamText != "Agent" and ply.TeamText != "VIP" then
					StatusText = {}
					StatusText.Enum = 1
					StatusText.Type = "You are a Civilian."
					StatusText.Description = "Find out who the VIP is and protect him."
					StatusAlphaTime = CurTime() + 5
				end
			end
		end)
	end
end

usermessage.Hook("ROUNDTIME", DEC_ReceiveRoundTime)

local function DEC_NoMoney()
	GAMEMODE:AddNotify("Cannot buy item - no money.", NOTIFY_ERROR, 7)
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("NOMONEY", DEC_NoMoney)

local function DEC_NotEnoughMoney()
	GAMEMODE:AddNotify("Cannot buy item - not enough money.", NOTIFY_ERROR, 7)
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("NOTENOUGHMONEY", DEC_NotEnoughMoney)

local function DEC_HaveItem()
	GAMEMODE:AddNotify("You already have this item!", NOTIFY_ERROR, 7)
	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("HAVEITEM", DEC_HaveItem)

local function DEC_ExamStart(um)
	ent = um:ReadEntity()
	time = um:ReadShort()

	Action_Progress = 0
	Action_Time = time

	if not ent.Status or ent.Status == 0 then
		chat.AddText(ColorVeryLightBlue, "Examining an unknown person.\nEstimated time - " .. math.Round(time, 2) .. " second(s).")
	else
		chat.AddText(ColorVeryLightBlue, "Examining " .. ent:Nick() .. ".\nEstimated time - " .. math.Round(time, 2) .. " second(s).")
	end

	surface.PlaySound("buttons/button14.wav")
end

usermessage.Hook("EXAMINE_START", DEC_ExamStart)

local function DEC_ExamFail(um)
	chat.AddText(ColorRed, "Examination failed!")
	surface.PlaySound("buttons/button10.wav")

	Action_Time = nil
end

usermessage.Hook("EXAMINE_FAIL", DEC_ExamFail)

local function DEC_ReceiveExamResults(um)
	ent = um:ReadEntity()
	status = um:ReadShort()

	if ent.Status != 3 then
		ent.Status = status

		if status == 1 then
			chat.AddText(ColorNeon, "This person doesn't seem to be carrying anything.")
		elseif status == 2 then
			chat.AddText(ColorOrange, "This person looks like he has something concealed.")
		elseif status == 3 then
			chat.AddText(ColorRed, "This person is obviously carrying something.")
		end
	else
		if #ent:GetWeapons() == 0 then
			chat.AddText(ColorNeon, "This person does not seem to carry any weapons, unlike some time ago.")
			ent.Status = 1
		else
			chat.AddText(ColorRed, "You have seen this person carry a weapon some time ago.")
		end
	end

	surface.PlaySound("buttons/button17.wav")

	Action_Time = nil
end

usermessage.Hook("EXAMINE_END", DEC_ReceiveExamResults)

local function DEC_PersonWielding(um)
	ent = um:ReadEntity()
	wep = ent:GetActiveWeapon()

	ent.Status = 3

	chat.AddText(ColorRed, "This person is wielding a weapon.\nYou presume it's a(n) ", ColorYellow, wep.PrintName .. ".")
	surface.PlaySound("buttons/button17.wav")

	Action_Time = nil
end

usermessage.Hook("EXAMINE_WIELDING", DEC_PersonWielding)

local function DEC_ReceiveArmorStatus(um)
	cond = um:ReadShort()

	RedAmountStatus_Body = 1
	ConditionText_Body = cond
	RedAmount_Body = 255
	Alpha_Body = 255
end

usermessage.Hook("ARMOR_STATUS", DEC_ReceiveArmorStatus)

local function DEC_Armor(um)
	ConditionText_Body = um:ReadShort()
	ALTARM_BodyArmorTexSetting = um:ReadShort()
	ALTARM_BodyArmor = true
	Alpha_Body = 255
end

usermessage.Hook("ARMOR", DEC_Armor)

local function DEC_ResetArmor(um)
	ConditionText_Body = 100
	ALTARM_BodyArmorTexSetting = 0
	ALTARM_BodyArmor = false
end

usermessage.Hook("ARMOR_RESET", DEC_ResetArmor)

local function DEC_ShowVIP(um)
	ent = um:ReadEntity()

	if not ent.Status then
		ent.Status = 4
	end

	ent.AddStatus = 1

	if LocalPlayer().TeamText != "Agent" then
		results = 0

		for k, v in pairs(player.GetAll()) do
			if v.AddStatus == 1 then
				results = results + 1

				if results > 1 then
					v.AddStatus = 4
				end
			end
		end

		if results > 1 then
			chat.AddText(ColorNeon, "" .. ent:Nick(), ColorWhite, " has shown you his VIP ID!\nHowever, another person showed you his VIP ID card before!\n", ColorYellow, "One (or more) of them is an impostor!")
			ent.AddStatus = 4
		else
			chat.AddText(ColorNeon, "" .. ent:Nick(), ColorWhite, " has shown you his VIP ID!\nAs a civilian, you're sworn to ", ColorNeon, "protect him!")
			ent.AddStatus = 1
		end
	else
		chat.AddText(ColorNeon, "" .. ent:Nick(), ColorWhite, " has shown you his VIP ID!\nAs an Agent, your objective is to ", ColorRed, "eliminate him!")
	end

	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("VIP_SHOW", DEC_ShowVIP)

local function DEC_VIPShown(um)
	ent = um:ReadEntity()

	if ent.Status and ent.Status != 0 then
		chat.AddText(ColorWhite, "You have shown ", ColorNeon, ent:Nick() .. "", ColorWhite, " your VIP ID!")
	else
		chat.AddText(ColorWhite, "You have shown your VIP ID to an unknown person.")
	end

	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("VIP_SHOWN", DEC_VIPShown)

local function DEC_VIPNoID()
	LocalPlayer().IDType = 0
	chat.AddText(ColorRed, "You didn't find your ID in your pockets!\nLooks like someone pick-pocketed it from you!")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("VIP_NOID", DEC_VIPNoID)

local function DEC_FoundCard()
	LocalPlayer().IDType = 1
	chat.AddText(ColorNeon, "You have retrieved your VIP ID card from the dead body!")
	surface.PlaySound("buttons/button14.wav")
end

usermessage.Hook("FOUNDCARD", DEC_FoundCard)

local function DEC_ShowVIP_Fake(um)
	ent = um:ReadEntity()
	ply = LocalPlayer()

	if ply.TeamText == "Agent" then
		chat.AddText(ColorNeon, "" .. ent:Nick(), ColorWhite, " has shown you his VIP ID!\nThe VIP ID is fake, and only agents are able to receive them!", ColorRed, "\nEliminate the enemy Agent!")
		ent.AddStatus = 3
	elseif ply.TeamText == "VIP" then
		chat.AddText(ColorNeon, "" .. ent:Nick(), ColorWhite, " has shown you his VIP ID!\nThe VIP ID is fake, as the only VIP here is you!", ColorRed, "\nAvoid or eliminate the Agent!")
		ent.AddStatus = 3
	else
		ent.AddStatus = 1

		local results = 0

		for k, v in pairs(player.GetAll()) do
			if v.AddStatus == 1 then
				results = results + 1

				if results > 1 then
					v.AddStatus = 4
				end
			end
		end

		if results > 1 then
			chat.AddText(ColorNeon, "" .. ent:Nick(), ColorWhite, " has shown you his VIP ID!\nHowever, another person showed you his VIP ID card before!\n", ColorYellow, "One (or more) of them is an impostor!")
			ent.AddStatus = 4
		else
			chat.AddText(ColorNeon, "" .. ent:Nick(), ColorWhite, " has shown you his VIP ID!\nAs a civilian, you're sworn to ", ColorNeon, "protect him!")
			ent.AddStatus = 1
		end
	end

	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("VIP_SHOW_FAKE", DEC_ShowVIP_Fake)

local function DEC_VIPShown_Fake(um)
	ent = um:ReadEntity()

	if ent.Status and ent.Status != 0 then
		chat.AddText(ColorWhite, "You have shown ", ColorNeon, ent:Nick() .. "", ColorWhite, " your fake VIP ID!")
	else
		chat.AddText(ColorWhite, "You have shown your fake VIP ID to an unknown person.")
	end

	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("VIP_SHOWN_FAKE", DEC_VIPShown_Fake)

local function DEC_VIPNoID_Fake()
	LocalPlayer().IDType = 0
	chat.AddText(ColorRed, "You didn't find your fake ID in your pockets!\nLooks like someone pick-pocketed it from you!")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("VIP_NOID_FAKE", DEC_VIPNoID_Fake)

local function DEC_PickpocketVIP(um)
	ent = um:ReadEntity()

	ent.AddStatus = 1
	chat.AddText(ColorYellow, "Pick-pocketed ID card; the person is the VIP!")
	LocalPlayer().IDType = 1
	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("PICKPOCKET_VIP", DEC_PickpocketVIP)

local function DEC_PickpocketVIP_Fake(um)
	ent = um:ReadEntity()

	ent.AddStatus = 3
	chat.AddText(ColorYellow, "Pick-pocketed ID card; the ID card is fake, that means the person is an enemy Agent!", ColorNeon, "You can now use the fake ID to cause confusion among civilians!")
	LocalPlayer().IDType = 2
	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("PICKPOCKET_VIP_FAKE", DEC_PickpocketVIP_Fake)

local function DEC_PickpocketNothing(um)
	chat.AddText(ColorWhite, "No clues found on person.", ColorYellow, "\nNext pick-pocket available in 10 seconds.")
	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("PICKPOCKET_NONE", DEC_PickpocketNothing)

local function DEC_AgencyHelp_NoPeople(um)
	amt = um:ReadShort()

	chat.AddText(ColorYellow, "Need at least " .. amt .. " players to buy this hint.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("AGENCY_NOPEOPLE", DEC_AgencyHelp_NoPeople)

local function DEC_AgencyHelp_NoHelp(um)
	chat.AddText(ColorYellow, "Cannot buy hint - agency has no intel left.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("AGENCY_NOHELP", DEC_AgencyHelp_NoHelp)

local function DEC_AgencyHelp_VIP_1(um)
	ent = um:ReadEntity()

	ent.AddStatus = 2
	chat.AddText(ColorNeon, ent:Nick() .. "", ColorWhite, " is definitely NOT the VIP.")
	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("AGENCY_HELP_1", DEC_AgencyHelp_VIP_1)

local function DEC_AgencyHelp_VIP_2(um)
	ent = um:ReadEntity()
	ent2 = um:ReadEntity()

	ent.AddStatus = 2
	ent2.AddStatus = 2

	chat.AddText(ColorNeon, ent:Nick() .. "", ColorWhite, " and ", ColorNeon, ent2:Nick() .. "", ColorWhite, " are definitely NOT the VIPs")
	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("AGENCY_HELP_2", DEC_AgencyHelp_VIP_2)

local function DEC_AgencyHelp_NoPeople(um)
	amt = um:ReadShort()

	chat.AddText(ColorYellow, "Need at least " .. amt .. " players to buy this hint.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("AGENCY_NOPEOPLE", DEC_AgencyHelp_NoPeople)

local function DEC_AgencyHelp_VIPDead()
	chat.AddText(ColorYellow, "Cannot buy help - VIP has already been eliminated.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("AGENCY_VIPDEAD", DEC_AgencyHelp_VIPDead)

local function DEC_KillPlayerSilent(um)
	ent = um:ReadEntity()
	ent.Status = 0
	ent.AddStatus = 5
end

usermessage.Hook("KILLPLAYER", DEC_KillPlayerSilent)

local function DEC_DeadBodyFound(um)
	ent = um:ReadEntity()
	role = um:ReadShort()
	ent.Status = 0
	ent.AddStatus = 5

	rolet = "a Civilian!"
	color = ColorWhite

	if role == 2 then
		rolet = "an Agent!"
		color = ColorRed
	elseif role == 3 then
		rolet = "the VIP!"
		color = ColorNeon
	end

	chat.AddText(ColorYellow, ent:Nick() .. "'s body has been found!\nHe was ", color, "" .. rolet)
	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("REPORT_DEADPLAYER", DEC_DeadBodyFound)

local function DEC_NoSpaceLeft()
	chat.AddText(ColorYellow, "Cannot take item - no space left.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("NOSPACE", DEC_NoSpaceLeft)

local function DEC_ItemBought(um)
	chat.AddText(ColorNeon, "Item bought!")
	surface.PlaySound("buttons/button14.wav")
end

usermessage.Hook("ITEMBOUGHT", DEC_ItemBought)

local function DEC_NoSpaceLeft_Mail_Weapon()
	chat.AddText(ColorYellow, "Cannot retrieve item from mail - no space left.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("MAIL_WEAPON_NOSPACE", DEC_NoSpaceLeft_Mail_Weapon)

local function DEC_NoSpaceLeft_Mail_Have()
	chat.AddText(ColorYellow, "Cannot retrieve item from mail - you already have this item.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("MAIL_HAVE", DEC_NoSpaceLeft_Mail_Have)

local function DEC_ReceiveMailItem(um)
	slot = um:ReadShort()
	itemnum = um:ReadShort()
	ply = LocalPlayer()

	if not ply.Mail then
		ply.Mail = {}
	end

	ply.Mail[slot] = {itemnum = itemnum}

	chat.AddText(ColorNeon, "Item bought and delivered to mailbox!")
	surface.PlaySound("buttons/button14.wav")
end

usermessage.Hook("MAILITEM", DEC_ReceiveMailItem)

local function DEC_ReceiveMailItemSilent(um)
	slot = um:ReadShort()
	itemnum = um:ReadShort()
	ply = LocalPlayer()

	if not ply.Mail then
		ply.Mail = {}
	end

	ply.Mail[slot] = {itemnum = itemnum}
end

usermessage.Hook("SILENTMAIL", DEC_ReceiveMailItemSilent)

local function DEC_MailFull(um)
	chat.AddText(ColorOrange, "Cannot purchase item - mail box full.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("MAILFULL", DEC_MailFull)

local function DEC_RetrieveMail(um)
	slot = um:ReadShort()
	ply = LocalPlayer()

	if IsValid(ply.Mail[slot].refer) then
		ply.Mail[slot].refer.Retrieved = true
	end

	table.remove(ply.Mail, slot)

	for k, v in pairs(ply.Mail) do
		if v.refer.Slot != k then
			v.refer.Slot = k
		end
	end
end

usermessage.Hook("MAILRETRIEVED", DEC_RetrieveMail)


// Mapvote
-- local function DEC_MapsToVoteFor(um)
-- 	maps = um:ReadString()
-- 	maps = string.Explode(" ", maps)
--
-- 	for k, v in pairs(maps) do
-- 		maps[k] = {map = v, votes = 0}
-- 	end
--
-- 	MapEndTime = CurTime() + 30
--
-- 	VoteStarted = true
-- 	Voted = false
-- end
--
-- usermessage.Hook("MAPSTOVOTEFOR", DEC_MapsToVoteFor)

local function DEC_MapsToVoteForNet(len, ply)
	maps = net.ReadTable()

	for k, v in pairs(maps) do
		maps[k] = {map = v, votes = 0}
	end

	MapEndTime = CurTime() + 30

	VoteStarted = true
	Voted = false
end

net.Receive("MAPSTOVOTEFOR_NET", DEC_MapsToVoteForNet)

local function DEC_VotemapUpdate(um)
	num = um:ReadShort()
	tbl = maps[num]

	tbl.votes = tbl.votes + 1

	chat.AddText(ColorVeryLightBlue, tbl.map .. " has received a vote.")
	surface.PlaySound("buttons/button14.wav")
end

usermessage.Hook("MAPVOTEUPDATE", DEC_VotemapUpdate)


// Other things
local function DEC_UnloadWeapon(um)
	if IsValid(tent) and tent:GetClass() == "dec_weapon" then
		tent.empty = 2
	end

	chat.AddText(ColorNeon, "Unloaded weapon!")
	surface.PlaySound("weapons/elite/elite_clipout.wav")
end

usermessage.Hook("UNLOADWEAPON", DEC_UnloadWeapon)

local function DEC_UnloadWeaponPartially(um)
	if IsValid(tent) and tent:GetClass() == "dec_weapon" then
		tent.empty = 1
	end

	chat.AddText(ColorNeon, "Partially unloaded weapon!")
	surface.PlaySound("weapons/elite/elite_clipout.wav")
end

usermessage.Hook("UNLOADWEAPONPARTIALLY", DEC_UnloadWeaponPartially)

local function DEC_WeaponEmpty(um)
	if IsValid(tent) and tent:GetClass() == "dec_weapon" then
		tent.empty = true
	end

	chat.AddText(ColorNeon, "That weapon is empty.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("WEAPONEMPTY", DEC_WeaponEmpty)

local function DEC_AmmoFull(um)
	chat.AddText(ColorYellow, "Cannot carry any more of that ammo type.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("AMMOFULL", DEC_AmmoFull)

local function DEC_MaximumDose(um)
	chat.AddText(ColorNeon, "Cannot buy medkit - maximum dosage reached.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("MAXDOSE", DEC_MaximumDose)

local function DEC_BuyRadio(um)
	chat.AddText(ColorNeon, "Bought walkie talkie.\nPress ", ColorWhite, "1", ColorNeon, " to open the radio menu, navigate using ", ColorWhite, "weapon slot keys.")
	surface.PlaySound("items/itempickup.wav")

	ply = LocalPlayer()
	ply:AddCarryable(2)
end

usermessage.Hook("BUY_WALKIETALKIE", DEC_BuyRadio)

local function DEC_Channel_WrongPassword()
	chat.AddText(ColorYellow, "Couldn't join channel - wrong password")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("CHANNEL_WRONGPASSWORD", DEC_Channel_WrongPassword)

local function DEC_Channel_Exists()
	chat.AddText(ColorYellow, "This channel already exists.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("CHANNEL_EXISTS", DEC_Channel_Exists)

local function DEC_Channel_Deleted()
	chat.AddText(ColorYellow, "Channel deleted.")
	surface.PlaySound("buttons/button17.wav")
	CurChannel = nil
	CurPassword = nil
end

usermessage.Hook("CHANNEL_DELETED", DEC_Channel_Deleted)

local function DEC_Channel_NotDeletable()
	chat.AddText(ColorRed, "This channel cannot be deleted.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("CHANNEL_NONDELETABLE", DEC_Channel_NotDeletable)

local function DEC_Channel_Same()
	chat.AddText(ColorYellow, "You already are on this channel!")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("CHANNEL_SAME", DEC_Channel_Same)

local function DEC_Channel_WrongMasterPassword()
	chat.AddText(ColorRed, "Couldn't perform action - wrong master password.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("CHANNEL_WRONGMASTERPASSWORD", DEC_Channel_WrongMasterPassword)

local function DEC_Poisoned()
	Poisoned = true
end

usermessage.Hook("POISONED", DEC_Poisoned)

local function DEC_PoisonCure()
	Poisoned = false
	ply = LocalPlayer()

	ply:RemoveCarryable(1)
	ply:EmitSound("items/smallmedkit1.wav", 70, 100)
end

usermessage.Hook("POISONCURE", DEC_PoisonCure)

local function DEC_ReceiveNewCarryable(um)
	num = um:ReadShort()

	LocalPlayer():AddCarryable(num)
end

usermessage.Hook("GETCARRY", DEC_ReceiveNewCarryable)

local function DEC_LastKill()
	chat.AddText(ColorYellow, "This was the last armed Civilian you were allowed to kill.\nAny other armed Civilian you kill who does not return fire, ", ColorRed, "will cost you karma.")
	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("LASTKILL", DEC_LastKill)

local nt

local function DEC_Money_Give(um)
	ent = um:ReadEntity()
	dosh = um:ReadShort()

	nt = "an unknown person"

	if ent.Status and ent.Status != 0 then
		nt = ent:Nick()
	end

	chat.AddText(ColorWhite, "Gave ", ColorNeon, nt .. " ", ColorWhite, dosh .. "$")
	surface.PlaySound("buttons/button14.wav")
end

usermessage.Hook("MONEY_GIVE", DEC_Money_Give)

local function DEC_Money_Received(um)
	ent = um:ReadEntity()
	dosh = um:ReadShort()

	nt = "An unknown person"

	if ent.Status and ent.Status != 0 then
		nt = ent:Nick()
	end

	chat.AddText(ColorNeon, nt .. " ", ColorWhite, "gave you ", ColorNeon, dosh .. "$")
	surface.PlaySound("buttons/button14.wav")
end

usermessage.Hook("MONEY_RECEIVED", DEC_Money_Received)

local function DEC_Money_Full(um)
	ent = um:ReadEntity()
	dosh = um:ReadShort()

	nt = "an unknown person"

	if ent.Status and ent.Status != 0 then
		nt = ent:Nick()
	end

	chat.AddText(ColorWhite, "Tried to give ", ColorNeon, nt .. " ", ColorWhite, dosh .. "$ but he cannot carry any more money.")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("MONEY_FULL", DEC_Money_Full)

local function DEC_Money_Full_Me(um)
	ent = um:ReadEntity()
	dosh = um:ReadShort()

	nt = "An unknown person"

	if ent.Status and ent.Status != 0 then
		nt = ent:Nick()
	end

	chat.AddText(ColorNeon, nt .. " ", ColorWhite, "tried to give you ", ColorNeon, dosh .. "$", ColorWhite, " but you cannot carry any more money")
	surface.PlaySound("buttons/button10.wav")
end

usermessage.Hook("MONEY_FULL_ME", DEC_Money_Full_Me)

local function DEC_Confirm_Agent(um)
	dosh = um:ReadShort()

	chat.AddText(ColorWhite, "Agent confirmed! Received ", ColorNeon, dosh .. "$")
	surface.PlaySound("buttons/button14.wav")
end

usermessage.Hook("CONFIRM_AGENT", DEC_Confirm_Agent)

local function DEC_Confirm_VIP(um)
	dosh = um:ReadShort()

	chat.AddText(ColorWhite, "VIP confirmed! Received ", ColorNeon, dosh .. "$")
	surface.PlaySound("buttons/button14.wav")
end

usermessage.Hook("CONFIRM_VIP", DEC_Confirm_VIP)

local found

local function DEC_ReceiveBallisticsAnalysis(um)
	progress = um:ReadShort()
	fingerprint = um:ReadShort()
	ply = LocalPlayer()

	if progress == 100 then
		chat.AddText(ColorNeon, "Fingerprint analysis complete!\nFingerprint ID is: ", ColorWhite, "#" .. fingerprint)
	else
		chat.AddText(ColorYellow, "Fingerprint analysis at", ColorWhite, " " .. progress .. "%", ColorYellow, ". Analyze more bodies to complete the analysis.")
	end

	found = false

	for k, v in pairs(ply.FingerPrints) do
		if v.fingerprint == fingerprint then
			v.fingerprint = fingerprint
			v.progress = progress

			if not v.progressbar then
				v.progressbar = 0
			end

			v.victims = v.victims + 1
			ply:GetActiveWeapon().CurEntry = k
			found = true

			break
		end
	end

	if not found then
		ply.FingerPrints[#ply.FingerPrints + 1] = {fingerprint = fingerprint, progress = progress, progressbar = 0, victims = 1}
	end

	surface.PlaySound("buttons/combine_button1.wav")
end

usermessage.Hook("BA_RECEIVEENTRY", DEC_ReceiveBallisticsAnalysis)

local function DEC_ReceiveKiller(um)
	fingerprint = um:ReadShort()
	ent = um:ReadEntity()

	for k, v in pairs(ply.FingerPrints) do
		if v.fingerprint == fingerprint then
			v.killer = ent

			chat.AddText(ColorYellow, "Person's fingerprint ID matches with database entry ", ColorWhite, "#" .. k, ColorYellow, "!")
			surface.PlaySound("buttons/combine_button5.wav")

			break
		end
	end
end

usermessage.Hook("BA_RECEIVEKILLER", DEC_ReceiveKiller)

local function DEC_NoMatch()
	chat.AddText(ColorYellow, "No fingerprint match found in database.")
	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("BA_NOMATCH", DEC_NoMatch)

local function DEC_NoFingerPrints()
	chat.AddText(ColorYellow, "No fingerprints found on body.")
	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("BA_NOFINGER", DEC_NoFingerPrints)

local function DEC_AgentDisconnected()
	chat.AddText(ColorYellow, "An Agent has left the server.")
	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("DISC_AGENT", DEC_AgentDisconnected)

local function DEC_VipDisconnected()
	chat.AddText(ColorYellow, "The VIP has left the server.")
	surface.PlaySound("buttons/button17.wav")
end

usermessage.Hook("DISC_VIP", DEC_VipDisconnected)
