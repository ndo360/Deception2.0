DeriveGamemode("base")
include("shared.lua")
include("items.lua")
include("mapents.lua")
include("mapcycle.lua")
include("filestodownload.lua")
include("sounds.lua")
include("precache.lua")
include("channels.lua")
include("various.lua")
include("carryables.lua")

AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_umsgs.lua")
AddCSLuaFile("cl_menus.lua")
AddCSLuaFile("cl_scoreboard.lua")
AddCSLuaFile("items.lua")
AddCSLuaFile("cl_mail.lua")
AddCSLuaFile("precache.lua")
AddCSLuaFile("tips.lua")
AddCSLuaFile("waltalmenus.lua")
AddCSLuaFile("cl_voice.lua")
AddCSLuaFile("carryables.lua")

PrecacheParticleSystem("cstm_child_sparks_small")
PrecacheParticleSystem("cstm_child_sparks_medium")
PrecacheParticleSystem("cstm_child_sparks_large")
PrecacheParticleSystem("cstm_child_sparks_verylarge")
PrecacheParticleSystem("cstm_child_smoke_small")
PrecacheParticleSystem("cstm_child_smoke_medium")
PrecacheParticleSystem("cstm_child_smoke_large")
PrecacheParticleSystem("cstm_child_smoke_verylarge")
PrecacheParticleSystem("cstm_child_muzzle_small")
PrecacheParticleSystem("cstm_child_muzzle_medium")
PrecacheParticleSystem("cstm_child_muzzle_large")
PrecacheParticleSystem("cstm_child_heat")
PrecacheParticleSystem("cstm_muzzle_pistol")
PrecacheParticleSystem("cstm_muzzle_smg")
PrecacheParticleSystem("cstm_muzzle_ar")
PrecacheParticleSystem("cstm_muzzle_br")
PrecacheParticleSystem("cstm_incendiary_hit")
PrecacheParticleSystem("cstm_frag_fly")
PrecacheParticleSystem("cstm_frag_expl")

umsg.PoolString("AGENT")
umsg.PoolString("VIP")
umsg.PoolString("ROUNDTIME")
umsg.PoolString("NOTENOUGHMONEY")
umsg.PoolString("NOMONEY")
umsg.PoolString("HAVEITEM")
umsg.PoolString("EXAMINE_START")
umsg.PoolString("EXAMINE_END")
umsg.PoolString("EXAMINE_FAIL")
umsg.PoolString("EXAMINE_DEADBODY")
umsg.PoolString("ARMOR")
umsg.PoolString("ARMOR_STATUS")
umsg.PoolString("ARMOR_RESET")
umsg.PoolString("WIN_AGENT")
umsg.PoolString("WIN_VIP")
umsg.PoolString("WIN_DRAW")
umsg.PoolString("VIP_SHOW")
umsg.PoolString("VIP_SHOWN")
umsg.PoolString("VIP_SHOW_FAKE")
umsg.PoolString("VIP_SHOWN_FAKE")
umsg.PoolString("VIP_NOID")
umsg.PoolString("VIP_NOID_FAKE")
umsg.PoolString("PICKPOCKET_VIP")
umsg.PoolString("PICKPOCKET_VIP_FAKE")
umsg.PoolString("PICKPOCKET_NONE")
umsg.PoolString("AGENCY_HELP_1")
umsg.PoolString("AGENCY_HELP_2")
umsg.PoolString("AGENCY_NOPEOPLE")
umsg.PoolString("AGENCY_NOHELP")
umsg.PoolString("AGENCY_VIPDEAD")
umsg.PoolString("REPORT_DEADPLAYER")
umsg.PoolString("KILLPLAYER")
umsg.PoolString("BUYFORGEDID")
umsg.PoolString("NOSPACE")
umsg.PoolString("MAIL_WEAPON_NOSPACE")
umsg.PoolString("MAIL_HAVE")
umsg.PoolString("MAILITEM")
umsg.PoolString("MAILRETRIEVED")
umsg.PoolString("MAILFULL")
umsg.PoolString("SILENTMAIL")
umsg.PoolString("MAPSTOVOTEFOR")
umsg.PoolString("MAPVOTEUPDATE")
umsg.PoolString("ITEMBOUGHT")
umsg.PoolString("FOUNDCARD")
umsg.PoolString("UNLOADWEAPON")
umsg.PoolString("UNLOADWEAPONPARTIALLY")
umsg.PoolString("MAXDOSE")
umsg.PoolString("AMMOFULL")
umsg.PoolString("RADIO")
umsg.PoolString("BUY_WALKIETALKIE")
umsg.PoolString("CHANNEL_EXISTS")
umsg.PoolString("CHANNEL_JOINED")
umsg.PoolString("CHANNEL_JOINDEFAULT")
umsg.PoolString("CHANNEL_CREATED")
umsg.PoolString("CHANNEL_DELETED")
umsg.PoolString("CHANNEL_NONDELETABLE")
umsg.PoolString("CHANNEL_WRONGPASSWORD")
umsg.PoolString("CHANNEL_NONEXISTANT")
umsg.PoolString("CHANNEL_SAME")
umsg.PoolString("CHANNEL_WRONGMASTERPASSWORD")
umsg.PoolString("POISONED")
umsg.PoolString("CUREGET")
umsg.PoolString("POISONCURE")
umsg.PoolString("LASTKILL")
umsg.PoolString("MONEY_GIVEN")
umsg.PoolString("MONEY_RECEIVED")
umsg.PoolString("MONEY_FULL")
umsg.PoolString("MONEY_FULL_ME")
umsg.PoolString("CONFIRM_AGENT")
umsg.PoolString("CONFIRM_VIP")
umsg.PoolString("BA_RECEIVEENTRY")
umsg.PoolString("BA_RECEIVEKILLER")
umsg.PoolString("BA_NOMATCH")
umsg.PoolString("BA_NOFINGER")
umsg.PoolString("MAXUNIQUEWEP")
umsg.PoolString("DISC_AGENT")
umsg.PoolString("DISC_VIP")
umsg.PoolString("ROUNDRESTART")
umsg.PoolString("MEDKITGET")
umsg.PoolString("GETCARRY")

// Net
util.AddNetworkString("MAPSTOVOTEFOR_NET")

CreateConVar("dec_roundtime", "600", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_runspeed", "310", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_startmoney_civilian", "200", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_startmoney_agent", "350", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_startmoney_vip", "500", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_income_civ_time", "2", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_income_civ_amount", "1", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_income_agent_time", "1", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_income_agent_amount", "1", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_income_vip_time", "1", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_income_vip_amount", "2", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_rounds", "7", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_healthregen_percentage", "0.25", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_healthregen_enabled", "1", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_healthregen_dmgpenalty", "15", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_healthregen_regentime", "2", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_stamina_drain_sprint_time", "0.6", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_stamina_drain_sprint_amount", "1", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_stamina_drain_jump", "5", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_stamina_drain_ledgepull", "10", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_stamina_drain_ledgehang_time", "1", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_stamina_drain_ledgehang_amount", "1", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_stamina_drain_underwater_time", "0.3", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_stamina_drain_underwater_amount", "1", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_stamina_regen_time", "0.2", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_stamina_regen_amount", "1", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_pickup_weight", "30", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_pickup_enabled", "1", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_propdamage", "0", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_chat_distance", "256", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_mic_distance", "256", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_max_armedkills", "4", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_bandur", "60", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_noreturnfirekarmaloss", "0", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_karmalossmaxdamage", "175", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_confirm_agent", "100", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_confirm_vip", "200", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_analysis_increase", "34", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_analysis_initial", "33", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_maxweapons", "2", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))
CreateConVar("dec_maxweapons_unique", "2", (FCVAR_ARCHIVE || FCVAR_REPLICATED || FCVAR_NOTIFY))

FirstRound = FirstRound or true
GameStarted = GameStarted or false
CanBuy = CanBuy or false
GameStartTime = GameStartTime or 0
RoundsPlayed = RoundsPlayed or 0

GM.PlayerSpawnTime = GM.PlayerSpawnTime or {}

local CT, dtint2, wl, SP, RS, HSP, dist, Dot, td, trace, dmgtype, num, wep, ong, isply, isval, ta, la, distance, dmg, FinalDamageDecay, snd, vol, mdl, pos, ang, sound, RT, rand, MR, ent, cl, aim, haim, dot, rag, mailboxes, item, dosh, cb, inserted, amt, cap, t, ct, def, randpos, res, karma, mywep, wepclass, phys, itm, trace1, trace2, timetosend, hpon, hpmax, hptime, sprintdrain, sprinttime, hangdrain, hangtime, regen, regentime, drown, drowntime, rtype, rcat, rsound, chan, joinchan, pass, mpass, gp, time, dmgmod, hm, m

function GM:Initialize()
end

CurMap = string.lower(game.GetMap())
function GM:CreateEnts()
	for k, v in pairs(MapEnts) do
		if v.map == CurMap then
			ent = ents.Create(v.ent)
			ent:SetPos(v.pos)
			ent:SetAngles(v.ang)
			ent:SetColor(v.color)

			if v.model then
				ent:SetModel(v.model)
			end

			if v.drawstatus then
				ent:SetNoDraw(v.drawstatus)
			end

			ent:Spawn()

			phys = ent:GetPhysicsObject()

			if phys:IsValid() then
				phys:EnableMotion(false)
			end
		end
	end
end

function GM:InitPostEntity()
	self:CreateEnts()
end

function GM:PlayerInitialSpawn(ply)
	ply:LoadKarma()
	ply.GhostPowerTime = 0
	ply.SpookySoundTime = 0
	ply:SetDTInt(3, 100)
end

function GM:PlayerSpawn(ply)
	if not CanBuy then
		RS = GetConVarNumber("dec_runspeed")
		ply:SetDTInt(0, GetConVarNumber("dec_startmoney_civilian") * (ply:GetDTInt(1) / 100))
		ply.Income = GetConVarNumber("dec_income_civ_amount")
		ply.IncomeDelay = 0
		ply.IncomeTime = GetConVarNumber("dec_income_civ_time")
		ply:SetRunSpeed(RS)
		ply:SetWalkSpeed(130)
		ply:SetModel(table.Random(PlayerModels))
		ply:RemoveAllAmmo()
		ply:StripWeapons()
		ply:UnSpectate()
		ply:SetSolid(SOLID_BBOX)
		ply:SetMoveType(MOVETYPE_WALK)
		ply:SetTeam(TEAM_PLAYER)
		ply.InexperienceRatio = 1.25
		ply.DetectionAmount = 10
		ply.WeightDetection = 0
		ply.Weight = 0
		ply.ActionTime = 0
		ply.PickpocketDelay = 0
		ply.HealthRegenTime = 0
		ply.PainDelay = 0
		ply.HealthRegenMax = 100
		ply.Mail = {}
		ply.Entries = {}
		ply.FingerPrints = {}
		ply.Items = {}
		ply:SetDTInt(2, 100)
		ply.StaminaDrainTime = 0
		ply.StaminaRegenTime = 0
		ply.StaminaDrownTime = 0
		ply.DrownedHealth = 0
		ply.UnDrownTime = 0
		ply.GrabTime = 0
		ply.DosesTaken = 0
		ply:SetJumpPower(200)
		ply.HasGrabbed = false
		ply.HasWalkieTalkie = false
		ply.RadioDelay = 0
		ply.RoleSendTime = 0
		ply.ReceivedRole = false
		ply.Poisoned = false
		ply.Poisoner = nil
		ply.DeadBody = nil
		ply.PoisonStamina = 0
		ply.PoisonHealth = 0
		ply.ArmedKills = 0
		ply.Attackers = {}
		ply.ExamTime = 2
		ply.DamageSpeedMod = 1
		ply.DamageDone = 0
		ply.HintsBought = 0
		ply.NonVIPPlayers = nil
		ply.FingerPrint = math.random(1, 50000)
		ply:PositionMe()

		SendUserMessage("ARMOR_RESET")

		ply.BodyArmCondition = 0
		ply.BodyArmDamageDec = 1

		if not GameStarted and self:CanStartRound() then
			self:AttemptSelection()
		end
	else
		ply:KillSilent()

		timer.Simple(0, function()
			ply:SetSolid(SOLID_NONE)
			ply:SetMoveType(MOVETYPE_NOCLIP)
			ply:Spectate(OBS_MODE_ROAMING)
		end)

		umsg.Start("ROUNDTIME", ply)
			umsg.Long((GameStartTime - CurTime()) + GetConVarNumber("dec_roundtime"))
		umsg.End()

		umsg.Start("KILLPLAYER")
			umsg.Entity(ply)
		umsg.End()
	end
end

function GM:PlayerDisconnected(ply)
	if CanBuy then
		if ply.IsAgent then
			if ply == AgentA then
				AgentA = nil
			elseif ply == AgentB then
				AgentB = nil
			end

			SendUserMessage("DISC_AGENT")
		end

		if ply.IsVIP then
			VIP = nil

			SendUserMessage("DISC_VIP")
		end

		-- if not AgentA and not AgentB and VIP then
		-- 	self:EndRound(1)
		-- end
		--
		-- if AgentA and not AgentB and not VIP then
		-- 	self:EndRound(2, AgentA)
		-- elseif AgentB and not AgentA and not VIP then
		-- 	self:EndRound(2, AgentB)
		-- end
	end

	if ply.Ragdoll then
		SafeRemoveEntity(ply.Ragdoll)
	end
end

function GM:PlayerCanHearPlayersVoice(listener, talker)
	if not CanBuy then
		return true
	end

	la = listener:Alive()
	ta = talker:Alive()

	if la and ta then
		if talker.HasWalkieTalkie and listener.HasWalkieTalkie and listener.Channel == talker.Channel then
			return true
		else
			if listener:GetShootPos():Distance(talker:GetShootPos()) <= (GetConVarNumber("dec_mic_distance") * (talker:KeyDown(IN_SPEED) and 2 or 1)) then
				return true
			end
		end
	end

	if ta and not la then
		return true
	end

	if not ta and not la then
		return true
	end

	return false
end

function GM:PlayerCanSeePlayersChat(text, tm, listener, talker)
	if not CanBuy then
		return true
	end

	if !IsValid(talker) then
		return true
	end

	la = listener:Alive()
	ta = talker:Alive()

	if la and ta then
		if tm then
			if talker.HasWalkieTalkie then
				if listener.HasWalkieTalkie and listener.Channel == talker.Channel then
					return true
				end
			else
				return false
			end
		else
			if talker:GetShootPos():Distance(listener:GetShootPos()) <= GetConVarNumber("dec_chat_distance") then
				return true
			end
		end
	end

	if ta and not la then
		return true
	end

	if not ta and not la then
		return true
	end

	return false
end

local rs

function GM:Think()
	CT = CurTime()
	hpon = GetConVarNumber("dec_healthregen_enabled")
	hptime = GetConVarNumber("dec_healthregen_regentime")
	sprintdrain, sprinttime, hangdrain, hangtime, regen, regentime, drown, drowntime = GetConVarNumber("dec_stamina_drain_sprint_amount"), GetConVarNumber("dec_stamina_drain_sprint_time"), GetConVarNumber("dec_stamina_drain_ledgehang_amount"), GetConVarNumber("dec_stamina_drain_ledgehang_time"), GetConVarNumber("dec_stamina_regen_amount"), GetConVarNumber("dec_stamina_regen_time"), GetConVarNumber("dec_stamina_drain_underwater_amount"), GetConVarNumber("dec_stamina_drain_underwater_time")

	for k, v in pairs(player.GetAll()) do
		if v:Alive() then
			v.DamageSpeedMod = math.Approach(v.DamageSpeedMod, 1, 0.005)

			dtint2 = v:GetDTInt(2)
			hp = v:Health()
			wep = v:GetActiveWeapon()

			if IsValid(wep) then
				if wep:GetDTInt(3) == 20 then
					wep:SetHoldType("normal")
				else
					wep:SetHoldType(wep.HoldType)
				end
			end

			if v.Poisoned then
				v.SuppressPain = true
				v.HealthRegenTime = CT + 1
				v.StaminaRegenTime = CT + 1

				if CT >= v.PoisonHealth then
					v:TakeDamage(1, v.Poisoner, v.Poisoner)
					v.PoisonHealth = CT + 0.08
				end

				if CT >= v.PoisonStamina then
					v:SetDTInt(2, math.Clamp(dtint2 - 1, 0, 100))
					v.PoisonStamina = CT + 0.2
				end
			end

			if hpon then
				if v.DrownedHealth == 0 then
					if CT > v.HealthRegenTime then
						if hp < v.HealthRegenMax then
							v:SetHealth(math.Clamp(hp + 1, 0, v.HealthRegenMax))
							v.HealthRegenTime = CT + hptime
						end
					end
				end
			end

			if not v.ReceivedRole then
				if CT > v.RoleSendTime then
					if v.IsAgent then
						SendUserMessage("AGENT", v)
					end

					if v.IsVIP then
						SendUserMessage("VIP", v)
					end

					v.RoleSendTime = CT + 1
				end
			end

			rs = v:GetRunSpeed()

			if hp <= 20 then
				if rs != 150 then
					v:SetRunSpeed(150)
				end
			else
				if dtint2 <= 15 then
					if not v.iRunSpeed then
						if dtint2 == 0 then
							v.iRunSpeed = rs
							v:SetRunSpeed(130)
							v:SetJumpPower(0)
						end

						if not v:KeyDown(IN_SPEED) then
							v.iRunSpeed = rs
							v:SetRunSpeed(130)
							v:SetJumpPower(0)
						end
					end
				else
					if rs == 130 or rs == 150 then
						v:SetJumpPower(200)
						v:SetRunSpeed(v.iRunSpeed or GetConVarNumber("dec_runspeed"))
						v.iRunSpeed = nil
					end
				end
			end

			wl = v:WaterLevel()

			if wl == 3 then
				if dtint2 > 0 then
					if CT > v.StaminaDrownTime then
						v:SetDTInt(2, math.Clamp(dtint2 - drown, 0, 100))
						v.StaminaDrownTime = CT + drowntime
					end
				else
					if CT > v.StaminaDrownTime then
						v.DrownedHealth = v.DrownedHealth + 1
						v:TakeDamage(1, v, v)
						v.StaminaDrownTime = CT + 0.1
					end

					if CT > v.PainDelay then
						v:EmitSound("player/pl_drown" .. math.random(1, 3) .. ".wav", 70, 100)
						v.PainDelay = CT + 1
						v.UnDrownTime = CT + 0.5
					end
				end
			elseif wl < 3 then
				if dtint2 >= 15 then
					if v.DrownedHealth > 0 then
						if CT > v.UnDrownTime then
							v:SetHealth(hp + 1)
							v.DrownedHealth = v.DrownedHealth - 1
							v.UnDrownTime = CT + 0.2
						end
					end
				end
			end

			if not v.HasGrabbed then
				if v:KeyDown(IN_SPEED) and v:GetVelocity():Length() > v:GetWalkSpeed() * 1.2 then
					ong = v:OnGround()
					wl = v:WaterLevel()

					if ong or wl >= 2 then
						if CT > v.StaminaDrainTime then
							v:SetDTInt(2, math.Clamp(dtint2 - sprintdrain, 0, 100))
							v.StaminaDrainTime = CT + (sprinttime - v.Weight / 100)
						end
					end
				else
					if CT > v.StaminaRegenTime and CT > v.StaminaDrownTime then
						v:SetDTInt(2, math.Clamp(dtint2 + regen, 0, 100))
						v.StaminaRegenTime = CT + regentime
					end
				end
			else
				if dtint2 == 0 then
					v.HasGrabbed = false
					v:SetMoveType(MOVETYPE_WALK)
					v:EmitSound("player/suit_sprint.wav", 70, math.random(95, 105))
					v.StaminaRegenTime = CT + 1
				else
					if CT > v.StaminaDrainTime then
						v:SetDTInt(2, math.Clamp(dtint2 - hangdrain, 0, 100))
						v.StaminaDrainTime = CT + hangtime
					end
				end
			end

			if IsValid(v.CarryEnt) then
				if v.LastLook then
					if (v:GetAimVector() - v.LastLook):Length() > 0.4 then -- limit turn speed
						v:DropObject(v.CarryEnt)
						v.CarryEnt = nil
						v.LastLook = nil
					end
				end

				v.LastLook = v:GetAimVector()

				if v:EyeAngles().p <= -10 then -- limit view height
					v:DropObject(v.CarryEnt)
					v.CarryEnt = nil
					v.LastLook = nil
				end

				if v:GetVelocity():Length() > v:GetWalkSpeed() * 1.2 then -- limit move speed
					v:DropObject(v.CarryEnt)
					v.CarryEnt = nil
				end
			else
				v.LastLook = nil
			end

			if CanBuy then
				if v.Income > 0 then
					if CT > v.IncomeDelay then
						v:SetDTInt(0, math.Clamp(v:GetDTInt(0) + v.Income, 0, MoneyCap))
						v.IncomeDelay = CT + v.IncomeTime
					end
				end
			end

			if v.ExamTarget then
				SP = v:GetShootPos()
				HSP = v.ExamTarget:GetShootPos() - Vector(0, 0, 32)
				dist = SP:Distance(HSP)

				if dist <= 256 then
					tmp = (HSP - SP)
					tmp:Normalize()
					Dot = v:GetAimVector():Dot(tmp)

					if Dot >= 0.7 then
						td = {}
						td.start = SP
						td.endpos = td.start + tmp * 256
						td.filter = v

						trace = util.TraceLine(td)

						if trace.Hit then
							if CT > v.ExamFinish then
								if trace.Entity == v.ExamTarget then
									num = 1

									if (v.ExamTarget.Weight - v.ExamTarget.WeightDetection) >= v.DetectionAmount then
										num = 2
									end

									if (v.ExamTarget.Weight - v.ExamTarget.WeightDetection) >= v.DetectionAmount + 10 then
										num = 3
									end

									umsg.Start("EXAMINE_END", v)
										umsg.Entity(v.ExamTarget)
										umsg.Short(num)
									umsg.End()

									v.ExamTarget = nil
								end
							end
						else
							SendUserMessage("EXAMINE_FAIL", v)
							v.ExamTarget = nil
						end
					else
						SendUserMessage("EXAMINE_FAIL", v)
						v.ExamTarget = nil
					end
				else
					SendUserMessage("EXAMINE_FAIL", v)
					v.ExamTarget = nil
				end
			end
		else
			gp = v:GetDTInt(3)

			if v:KeyDown(IN_ATTACK) then
				if gp > 0 then
					td = {}
					td.start = v:GetShootPos()
					td.endpos = td.start + v:GetAimVector() * 2048
					td.filter = v

					trace = util.TraceLine(td)

					if trace.Hit and trace.Entity:GetClass():find("prop_physics") then
						phys = trace.Entity:GetPhysicsObject()

						if phys:IsValid() then
							phys:AddVelocity(v:GetAimVector() * phys:GetMass() * 0.3)
							v:SetDTInt(3, math.Clamp(gp - 1, 0, 100))
						end
					end
				end
			else
				if CT > v.GhostPowerTime then // FIXME
					v:SetDTInt(3, math.Clamp(gp + 1, 0, 100))
					v.GhostPowerTime = CT + 0.1
				end
			end
		end
	end


	-- Round check. This will probably fix most of the round end issues.
	if (GameStarted and CanBuy) and not VoteStarted then
		if IsValid(VIP) and VIP:Alive() then
			if (not IsValid(AgentA) or not AgentA:Alive()) and (not IsValid(AgentB) or not AgentB:Alive()) then
				self:EndRound(1)
			end
		else
			local AgentAValid = IsValid(AgentA) and AgentA:Alive()
			local AgentBValid = IsValid(AgentB) and AgentB:Alive()
			if AgentAValid != AgentBValid then
				self:EndRound(2, AgentAValid and AgentA or AgentB)
			end
		end

		local plysAlive = 0
		for k, v in pairs(player.GetAll()) do
			if v:Alive() then
				plysAlive = plysAlive + 1
			end
		end

		if plysAlive == 0 then
			self:EndRound(1)
		end
	end
end

-- Variables for optimization
local DamageScaleByHitgroup = {
	[HITGROUP_LEFTARM] = {0.5},
	[HITGROUP_RIGHTARM] = {0.5},
	[HITGROUP_HEAD] = {3, 2},
	[HITGROUP_LEFTLEG] = {0.75, 1.25},
	[HITGROUP_RIGHTLEG] = {0.75, 1.25}
}
function GM:ScalePlayerDamage(ply, hg, dmginfo)
	dmginfo:ScaleDamage(0.5) -- halven the damage

	dmg = dmginfo:GetDamage()

	if ply.BodyArmCondition > 0 then
		if ply.BodyArmDamageDec > 0 then
			if hg == HITGROUP_CHEST or hg == HITGROUP_STOMACH or hg == HITGROUP_GEAR then -- No protection for arms
				dmgtype = dmginfo:GetDamageType()

				if dmginfo:IsDamageType(DMG_BULLET) or dmginfo:IsDamageType(DMG_SLASH) then
					ply.BodyArmCondition = math.Clamp(ply.BodyArmCondition - (math.ceil(dmg / 5) + math.random(1, 3)), 0, 100)
					dmginfo:ScaleDamage(1 - ply.BodyArmDamageDec)

					umsg.Start("ARMOR_STATUS", ply)
						umsg.Short(ply.BodyArmCondition)
					umsg.End()
				end
			end
		end
	end

	dmgmod = 0.5

	local HitgroupDamageInfo = DamageScaleByHitgroup[hg]
	if (HitgroupDamageInfo) then
		dmginfo:ScaleDamage(HitgroupDamageInfo[1])
		if (HitgroupDamageInfo[2]) then
			dmgmod = HitgroupDamageInfo[2]
		end
	end

	ply:SetDTInt(2, math.Clamp(ply:GetDTInt(2) - dmg * dmgmod, 0, 100))
end

function GM:PlayerCanPickupWeapon(ply, wep)
	if ply:CountWeapons() >= GetConVarNumber("dec_maxweapons") then
		return false
	end

	return true
end

function GM:AllowPlayerPickup(ply, ent)
	if GetConVarNumber("dec_pickup_enabled") < 1 then
		return false
	end

	if ply:Alive() and IsValid(ent) then
		phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			if phys:GetMass() > GetConVarNumber("dec_pickup_weight") then
				return false
			end
		end
	end

	return true
end

function GM:EntityTakeDamage(ent, dmginfo)
	isply = ent:IsPlayer()
	CT = CurTime()
	local attacker = dmginfo:GetAttacker();
	local amount = dmginfo:GetDamage();

	if ent:WaterLevel() == 3 then
		return
	end

	if isply then
		if dmginfo:GetDamageType() == DMG_CRUSH then
			if GetConVarNumber("dec_propdamage") <= 0 then
				dmginfo:ScaleDamage(0)
				return
			end
		end

		ent.DamageSpeedMod = 0.5
	end

	dmg = dmginfo:GetDamage()

	if attacker:IsPlayer() and IsValid(attacker:GetActiveWeapon()) and isply then
		wep = attacker:GetActiveWeapon()

		if wep.EffectiveRange then
			distance = attacker:GetShootPos():Distance(ent:GetShootPos())
			dmginfo:ScaleDamage(1) -- scale the damage with ammo types

			FinalDamageDecay = 0

			if distance >= wep.EffectiveRange then
				FinalDamageDecay = wep.DamageDecay
			else
				FinalDamageDecay = wep.DamageDecay * (distance / wep.EffectiveRange)
			end

			dmginfo:ScaleDamage(1 - FinalDamageDecay)
		end

		if ent.IsAgent then
			ent.Attackers[attacker] = true
		elseif not ent.IsAgent and not ent.IsVIP then
			attacker.DamageDone = attacker.DamageDone + dmginfo:GetDamage()
		end
	end

	if isply then
		ent.StaminaRegenDelay = CT + 1

		ent.HealthRegenMax = ent.HealthRegenMax - dmginfo:GetDamage() * GetConVarNumber("dec_healthregen_percentage")
		ent.HealthRegenMax = math.Round(ent.HealthRegenMax)
		ent.HealthRegenTime = CT + GetConVarNumber("dec_healthregen_dmgpenalty")

		if not ent.SuppressPain then
			if CT > ent.PainDelay then
				if (ent:Health() - dmg) <= 0 then
					return
				end

				mdl = ent:GetModel()

				if dmg <= 15 then
					if table.HasValue(PS.HF, mdl) then
						snd = table.Random(PS.SmallF)
					elseif table.HasValue(PS.Z, mdl) then
						snd = table.Random(PS.SmallZ)
					elseif table.HasValue(PS.MP, mdl) then
						snd = table.Random(PS.SmallMP)
					elseif table.HasValue(PS.C, mdl) then
						snd = table.Random(PS.SmallC)
					else
						snd = table.Random(PS.Small)
					end

					vol = 80
				elseif dmg <= 40 then
					if table.HasValue(PS.HF, mdl) then
						snd = table.Random(PS.MediumF)
					elseif table.HasValue(PS.Z, mdl) then
						snd = table.Random(PS.MediumZ)
					elseif table.HasValue(PS.MP, mdl) then
						snd = table.Random(PS.MediumMP)
					elseif table.HasValue(PS.C, mdl) then
						snd = table.Random(PS.MediumC)
					else
						snd = table.Random(PS.Medium)
					end

					vol = 85
				else
					if table.HasValue(PS.HF, mdl) then
						snd = table.Random(PS.HighF)
					elseif table.HasValue(PS.Z, mdl) then
						snd = table.Random(PS.HighZ)
					elseif table.HasValue(PS.MP, mdl) then
						snd = table.Random(PS.HighMP)
					elseif table.HasValue(PS.C, mdl) then
						snd = table.Random(PS.HighC)
					else
						snd = table.Random(PS.High)
					end

					vol = 90
				end

				ent:EmitSound(snd, vol)
				ent.PainDelay = CT + math.Rand(0.7, 1.1)
			end
		end

		ent.SuppressPain = true
	end
end

local maxk

function GM:DoPlayerDeath(ply, attacker, dmginfo)
	rag = ents.Create("prop_ragdoll")
	rag:SetPos(ply:GetPos() + Vector(0, 0, 10))
	rag:SetAngles(ply:GetAngles())
	rag:SetModel(ply:GetModel())
	rag:SetOwner(ply)
	rag:Spawn()
	rag:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	rag:SetVelocity(ply:GetVelocity())

	isply = attacker:IsPlayer()
	isval = attacker:IsValid()

	for k = 1, rag:GetPhysicsObjectCount() do
		phys = rag:GetPhysicsObjectNum(k)

		if IsValid(phys) then
			pos, ang = ply:GetBonePosition(rag:TranslatePhysBoneToBone(k))
			phys:SetPos(pos)
			phys:SetAngles(ang)

			if isval and isply then
				phys:SetVelocity(phys:GetMass() * 10 * attacker:GetAimVector())
			end
		end
	end

	rag.DeadPlayer = true
	rag.RealPlayer = ply
	rag.KillTime = CurTime()

	if isply then
		rag.FingerPrint = attacker.FingerPrint
	end

	rag.Killer = attacker
	rag.Analyzers = {}

	if ply.IDType == 1 then
		rag.IDType = 1
	end

	if ply.IsVIP then
		rag.Role = 3
	elseif ply.IsAgent then
		rag.Role = 2
	else
		rag.Role = 1
	end

	ply.Ragdoll = rag
	ply:AddDeaths(1)

	rag.KillCaliber = "Clumsiness"

	if isval and isply then
		rag.KillCaliber = attacker:GetActiveWeapon().Caliber

		if (attacker == ply) then
			attacker:AddFrags(-1)
		else
			attacker:AddFrags(1)
		end
	end

	if GameStarted then
		if attacker:IsValid() and attacker:IsPlayer() then
			umsg.Start("KILLPLAYER", attacker)
				umsg.Entity(ply)
			umsg.End()

			if attacker.IsAgent then
				if ply.IsVIP then
					attacker:IncreaseKarma(5)
				elseif ply.IsAgent then
					attacker:IncreaseKarma(5)
				else
					if ply:CountWeapons() == 0 then
						attacker:DecreaseKarma(15)
					else
						if not attacker.Attackers[ply] and GetConVarNumber("dec_noreturnfirekarmaloss") >= 1 then
							attacker:DecreaseKarma(2)
						else
							attacker.ArmedKills = attacker.ArmedKills + 1
							maxk = GetConVarNumber("dec_max_armedkills")

							if attacker.ArmedKills > maxk then
								attacker:DecreaseKarma(10)
							elseif attacker.ArmedKills == maxk then
								SendUserMessage("LASTKILL", attacker)
							end
						end
					end
				end
			elseif attacker.IsVIP then
				if ply.IsAgent then
					attacker:IncreaseKarma(5)
				else
					attacker:DecreaseKarma(10)
				end
			else
				if ply.IsAgent then
					attacker:IncreaseKarma(5)
				else
					if attacker.DamageDone > GetConVarNumber("dec_karmalossmaxdamage") then
						attacker:DecreaseKarma(10)
					end
				end
			end
		end

		if ply.IsVIP then
			VIP = nil
		elseif ply == AgentA then
			AgentA = nil
		elseif ply == AgentB then
			AgentB = nil
		end

		-- if IsValid(VIP) then
		-- 	if not IsValid(AgentA) and not IsValid(AgentB) then
		-- 		self:EndRound(1)
		-- 	end
		-- else
		-- 	if IsValid(AgentA) and not IsValid(AgentB) then
		-- 		self:EndRound(2, AgentA)
		-- 	elseif IsValid(AgentB) and not IsValid(AgentA) then
		-- 		self:EndRound(2, AgentB)
		-- 	end
		-- end
	end

	ply.ExamTarget = nil

	if isval and isply then
		if attacker:GetDTInt(1) < 60 then
			if not attacker:IsAdmin() and not attacker:IsSuperAdmin() then
				attacker:Punish()
			end
		end
	end

	ply:DropEverything()

	if IsValid(ply.CarryEnt) then
		ply:DropObject(ply.CarryEnt)
	end

	if not ply.SuppressPain then
		mdl = ply:GetModel()

		if table.HasValue(PS.HF, mdl) then
			sound = table.Random(PS.HFD)
		elseif table.HasValue(PS.Z, mdl) then
			sound = table.Random(PS.ZD)
		elseif table.HasValue(PS.MP, mdl) then
			sound = table.Random(PS.MPD)
		elseif table.HasValue(PS.C, mdl) then
			sound = table.Random(PS.CD)
		else
			sound = table.Random(PS.HMD)
		end

		ply:EmitSound(sound, 95)
	end

	ply:SetDTInt(3, 100)
end

function GM:PlayerDeath(ply)
	timer.Simple(0, function()
		ply:SetSolid(SOLID_NONE)
		ply:SetMoveType(MOVETYPE_NOCLIP)
		ply:Spectate(OBS_MODE_ROAMING)
	end)
end

function GM:ShowHelp(ply)
	ply:ConCommand("dec_buymenu")
end

function GM:ShowTeam(ply)
	ply:ConCommand("dec_helpmenu")
end

function GM:ShowSpare1(ply)
	ply:ConCommand("dec_nexttip")
end

local found

function GM:KeyPress(ply, key)
	CT = CurTime()

	if not ply:Alive() then
		if key == IN_ATTACK2 then
			if CT > ply.SpookySoundTime then
				ply:EmitSound(table.Random(SpookySounds), 85, 100)
				ply.SpookySoundTime = CT + 5
			end
		end

		return
	end

	if CT < ply.ActionTime then
		return
	end

	if key == IN_USE then
		td = {}

		td.start = ply:GetShootPos()
		td.endpos = td.start + ply:GetAimVector() * 80
		td.filter = ply

		trace = util.TraceLine(td)
		ent = trace.Entity

		if IsValid(ent) and ent:GetClass() == "prop_ragdoll" then
			if ent.DeadPlayer then
				umsg.Start("EXAMINE_DEADBODY", ply)
					umsg.Entity(ent.RealPlayer)
					umsg.String(ent.KillCaliber)
					umsg.Short(ent.KillTime)
					umsg.Short(ent.Role)
				umsg.End()

				if GameStarted then
					if not ent.Reported then
						if not ply.IsAgent then
							umsg.Start("REPORT_DEADPLAYER")
								umsg.Entity(ent.RealPlayer)
								umsg.Short(ent.Role)
							umsg.End()

							ent.Reported = true

							if ply.IsVIP then
								if ent.IDType == 1 then
									ply.IDType = 1
									ent.IDType = 0
									SendUserMessage("FOUNDCARD", ply)
								end
							end
						else -- make sure to update the status for the agent but silently
							if not ent.Confirmed then
								if ent.Role == 3 then
									amt = GetConVarNumber("dec_confirm_vip")

									umsg.Start("CONFIRM_VIP", ply)
										umsg.Short(amt)
									umsg.End()

									ply:SetDTInt(0, ply:GetDTInt(0) + amt, 0, MoneyCap)
								elseif ent.Role == 2 then
									amt = GetConVarNumber("dec_confirm_agent")

									umsg.Start("CONFIRM_AGENT", ply)
										umsg.Short(amt)
									umsg.End()

									ply:SetDTInt(0, ply:GetDTInt(0) + amt, 0, MoneyCap)
								end

								ent.Confirmed = true
							end

							if not ent.Reported then
								found = false

								for k, v in pairs(ents.FindInSphere(ply:GetShootPos(), 256)) do
									if IsValid(v) then
										if v:IsPlayer() then
											if v != ply and v:Alive() then
												found = true
												break
											end
										end
									end
								end

								if found then
									umsg.Start("REPORT_DEADPLAYER")
										umsg.Entity(ent.RealPlayer)
										umsg.Short(ent.Role)
									umsg.End()

									ent.Reported = true
								else
									umsg.Start("KILLPLAYER", attacker)
										umsg.Entity(ent.RealPlayer)
									umsg.End()
								end
							end

							ply.DeadBody = ent
						end
					end
				end

				ply.ActionTime = CT + 1
			end
		end
	end

	if key == IN_JUMP then
		if ply:GetJumpPower() > 0 then
			if ply:OnGround() then
				ply:SetDTInt(2, math.Clamp(ply:GetDTInt(2) - GetConVarNumber("dec_stamina_drain_jump"), 0, 100))
				ply.StaminaRegenTime = CT + 3
			end
		end

		if ply:GetMoveType() == MOVETYPE_NONE then
			ply:SetMoveType(MOVETYPE_WALK)
			ply:SetLocalVelocity(ply.GrabHitNormal * -100 + Vector(0, 0, 250))
			ply.HasGrabbed = false
			ply.GrabTime = CT + 0.5
			ply:EmitSound("player/suit_sprint.wav", 70, math.random(95, 105))
			ply:SetDTInt(2, math.Clamp(ply:GetDTInt(2) - GetConVarNumber("dec_stamina_drain_ledgepull"), 0, 100))
			ply.StaminaRegenTime = CT + 3
		end
	end

	if key == IN_DUCK then
		if CT > ply.GrabTime then
			if ply.HasGrabbed then
				ply.HasGrabbed = false
				ply.GrabTime = CT + 0.25
				ply:SetMoveType(MOVETYPE_WALK)
				ply.StaminaRegenTime = CT + 0.5
			end
		end
	end
end

function GM:GetFallDamage(ply, speed)
	speed = speed - 480
	return speed * (100/(1024-480))
end

function GM:CanStartRound()
	ply = player.GetAll()

	for k, v in pairs(ply) do
		if not v:Alive() then
			ply[k] = nil
		end
	end

	table.Sanitise(ply)

	if #ply < 3 then
		return false
	end

	return true
end

function GM:AttemptSelection()
	GameStarted = true
	time = 15

	if FirstRound then
		time = 30
	end

	timer.Simple(time, function()
		if not self:CanStartRound() then
			GameStarted = false
			return
		end

		ply = player.GetAll()

		for k, v in pairs(ply) do
			if not v:Alive() then
				-- ply[k] = nil
				-- Lets respawn them instead, this is a bit useless
				v:Spawn()

				if IsValid(v.Ragdoll) then
					SafeRemoveEntity(v.Ragdoll)
					v.Ragdoll = nil
				end
			end
		end

		table.Sanitise(ply)

		CanBuy = true

		GameStartTime = CurTime()
		RT = GetConVarNumber("dec_roundtime")

		timetosend = (GameStartTime - CurTime()) + RT
		-- print(timetosend)

		umsg.Start("ROUNDTIME")
			umsg.Long(timetosend)
		umsg.End()

		if #ply >= 6 then
			if LastPeople then
				for k, v in pairs(ply) do
					for k2, v2 in pairs(LastPeople) do
						if v == v2 then
							table.remove(ply, k)
						end
					end
				end
			end
		end

		local plyNoBots = {}
		local plyBots = {}
		for k, v in pairs(ply) do
			if v:IsBot() then
				table.insert(plyBots, v)
			else
				table.insert(plyNoBots, v)
			end
		end

		local ChosenPlys = {}
		for k, v in RandomPairs(plyNoBots) do
			if #ChosenPlys >= 3 then
				break
			end

			table.insert(ChosenPlys, v)
			table.RemoveByValue(ply, v)
			print("Prioritized " .. v:Name())
		end

		if (#ChosenPlys < 3) then
			for k, v in RandomPairs(plyBots) do
				if #ChosenPlys >= 3 then
					break
				end

				table.insert(ChosenPlys, v)
				table.remove(ply, k)
			end
		end

		if (#ChosenPlys < 3) then
			self:EndRound(1)
			print("Error. Not enough humans alive")
			return
		end


		rand = math.random(#ChosenPlys)
		AgentA = ChosenPlys[rand]
		table.remove(ChosenPlys, rand)
		AgentA:SetDTInt(0, GetConVarNumber("dec_startmoney_agent") * (AgentA:GetDTInt(1) / 100))
		AgentA.Income = GetConVarNumber("dec_income_agent_amount")
		AgentA.IncomeTime = GetConVarNumber("dec_income_agent_time")
		AgentA.InexperienceRatio = 1
		AgentA.DetectionAmount = 5
		AgentA.AgencyHelp = 3
		-- Maximum ammount of helps you can get from the agency

		rand = math.random(#ChosenPlys)
		AgentB = ChosenPlys[rand]
		table.remove(ChosenPlys, rand)
		AgentB:SetDTInt(0, GetConVarNumber("dec_startmoney_agent") * (AgentB:GetDTInt(1) / 100))
		AgentB.Income = GetConVarNumber("dec_income_agent_amount")
		AgentB.IncomeTime = GetConVarNumber("dec_income_agent_time")
		AgentB.InexperienceRatio = 1
		AgentB.DetectionAmount = 5
		AgentB.AgencyHelp = 3
		-- Maximum ammount of helps you can get from the agency

		rand = math.random(#ChosenPlys)
		VIP = ChosenPlys[rand]
		table.remove(ChosenPlys, rand)
		VIP:SetDTInt(0, GetConVarNumber("dec_startmoney_vip") * (VIP:GetDTInt(1) / 100))
		VIP.Income = GetConVarNumber("dec_income_vip_amount")
		VIP.IncomeTime = GetConVarNumber("dec_income_vip_time")

		MsgN("agent A " .. AgentA:Nick())
		MsgN("agent B " .. AgentB:Nick())
		MsgN("VIP " .. VIP:Nick())

		AgentA.IsAgent = true
		AgentB.IsAgent = true
		VIP.IsVIP = true
		VIP.IDType = 1

		if #player.GetAll() >= 6 then -- we need another player.GetAll(), because the local "ply" does not contain all players
			LastPeople = {}
			table.insert(LastPeople, AgentA)
			table.insert(LastPeople, AgentB)
			table.insert(LastPeople, VIP)
		end

		SendUserMessage("AGENT", AgentA)
		SendUserMessage("AGENT", AgentB)
		SendUserMessage("VIP", VIP)

		AgentA.RoleSendTime = CT + 1
		AgentB.RoleSendTime = CT + 1
		VIP.RoleSendTime = CT + 1

		timer.Create("VIPWins", RT, 1, function()
			if not VIP then
				if AgentA and AgentB then
					self:EndRound(3)
				end
			else
				self:EndRound(1)
			end
		end)

		FirstRound = false
	end)
end

function GM:CanPlayerSuicide(ply)
	return false
end

function GM:EndRound(num, ent)
	MR = GetConVarNumber("dec_rounds")
	RoundsPlayed = RoundsPlayed + 1
	ply = player.GetAll()

	if num == 1 then
		umsg.Start("WIN_VIP")
			umsg.Short(RoundsPlayed)
			umsg.Short(MR)
		umsg.End()

		for k, v in pairs(ply) do
			if not v.IsAgent and not v.IsVIP and v:Alive() then
				v:IncreaseKarma(5)
			end
		end

	elseif num == 2 then
		umsg.Start("WIN_AGENT")
			umsg.Entity(ent)
			umsg.Short(RoundsPlayed)
			umsg.Short(MR)
		umsg.End()
	elseif num == 3 then
		umsg.Start("WIN_DRAW")
			umsg.Short(RoundsPlayed)
			umsg.Short(MR)
		umsg.End()

	elseif num == 4 then
		umsg.Start("ROUNDRESTART")
			umsg.Short(RoundsPlayed)
			umsg.Short(MR)
		umsg.End()
	end

	GameStarted = false
	CanBuy = false
	spawns = nil

	for k, v in pairs(ply) do
		v:StripWeapons()
		v:SetFOV(0, 0.3)
	end

	if RoundsPlayed <= MR then
		timer.Simple(14, function()
			for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
				SafeRemoveEntity(v)
			end
		end)

		timer.Simple(15, function()
			self:RestartRound()
		end)
	else
		VoteStarted = true
		self:SelectRandomMaps(8)
	end
end

function GM:RestartRound()
	game.CleanUpMap()

	for k, v in pairs(player.GetAll()) do
		v.IsAgent = false
		v.IsVIP = false
		v.IDType = 0
		v.AgencyHelp = 0
		v.NonVIPPlayers = nil
		v.Mail = {}

		if v.Ragdoll then
			SafeRemoveEntity(v.Ragdoll)
		end

		v.Ragdoll = nil
		v:Spawn()
	end

	self:CreateEnts()
end

local function DEC_PerformAction(ply)
	if not CanBuy then
		return
	end

	CT = CurTime()

	if CT < ply.ActionTime then
		return
	end

	if ply:KeyDown(IN_USE) then
		if ply.IsVIP then
			if ply.IDType == 1 then
				td = {}
				td.start = ply:GetShootPos()
				td.endpos = td.start + ply:GetAimVector() * 256
				td.filter = ply

				trace = util.TraceLine(td)

				if trace.Hit then
					if trace.Entity:IsPlayer() then
						umsg.Start("VIP_SHOW", trace.Entity)
							umsg.Entity(ply)
						umsg.End()

						umsg.Start("VIP_SHOWN", ply)
							umsg.Entity(trace.Entity)
						umsg.End()
					end
				end
			else
				SendUserMessage("VIP_NOID", ply)
			end
		elseif ply.IsAgent then
			/*if ply.IDType == 1 then // fuck it, real card is real!
				td = {}
				td.start = ply:GetShootPos()
				td.endpos = td.start + ply:GetAimVector() * 256
				td.filter = ply

				trace = util.TraceLine(td)

				if trace.Hit then
					if trace.Entity:IsPlayer() then
						umsg.Start("VIP_SHOW", trace.Entity)
							umsg.Entity(ply)
						umsg.End()

						umsg.Start("VIP_SHOWN", ply)
							umsg.Entity(trace.Entity)
						umsg.End()
					end
				end
			end*/
			if ply.IDType == 2 or ply.IDType == 1 then
				td = {}
				td.start = ply:GetShootPos()
				td.endpos = td.start + ply:GetAimVector() * 256
				td.filter = ply

				trace = util.TraceLine(td)

				if trace.Hit then
					if trace.Entity:IsPlayer() then
						if not trace.Entity.IsAgent and not trace.Entity.IsVIP then
							umsg.Start("VIP_SHOW", trace.Entity)
								umsg.Entity(ply)
							umsg.End()

							umsg.Start("VIP_SHOWN_FAKE", ply)
								umsg.Entity(trace.Entity)
							umsg.End()
						else
							umsg.Start("VIP_SHOW_FAKE", trace.Entity)
								umsg.Entity(ply)
							umsg.End()

							umsg.Start("VIP_SHOWN_FAKE", ply)
								umsg.Entity(trace.Entity)
							umsg.End()
						end
					end
				end
			end
		end

		ply.ActionTime = CT + 1

		return
	end

	if IsValid(ply.CarryEnt) then
		ply:DropObject(ply.CarryEnt)
		ply.CarryEnt = nil
		return
	end

	td = {}
	td.start = ply:GetShootPos()
	td.endpos = td.start + ply:GetAimVector() * 256
	td.filter = ply

	trace = util.TraceLine(td)

	if trace.Hit then
		cl = trace.Entity:GetClass()

		if trace.Entity:IsPlayer() then
			aim = ply:GetAimVector()
			aim = Vector(aim.x, aim.y)

			haim = trace.Entity:GetAimVector()
			haim = Vector(haim.x, haim.y, 0)

			dot = aim:DotProduct(haim)

			if dot > 0.6 and ply.IsAgent then
				if CT > ply.PickpocketDelay then
					dist = td.start:Distance(trace.Entity:GetShootPos())

					if dist < 60 then -- didn't want to use another trace, so I'll just distance it instead
						if trace.Entity:GetVelocity():Length() == 0 then
							if trace.Entity.IsVIP then
								umsg.Start("PICKPOCKET_VIP", ply)
									umsg.Entity(trace.Entity)
								umsg.End()

								trace.Entity.IDType = 0
								ply.IDType = 1
							elseif trace.Entity.IsAgent then
								if trace.Entity.IDType == 2 then
									umsg.Start("PICKPOCKET_VIP_FAKE", ply)
										umsg.Entity(trace.Entity)
									umsg.End()
								else
									SendUserMessage("PICKPOCKET_NONE", ply)
								end

								trace.Entity.IDType = 0
							else
								SendUserMessage("PICKPOCKET_NONE", ply)
							end

							ply.PickpocketDelay = CT + 10
						end

						ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)
					end
				end
			else
				if IsValid(trace.Entity:GetActiveWeapon()) then
					if trace.Entity:GetActiveWeapon():GetDTInt(3) != 20 then
						umsg.Start("EXAMINE_WIELDING", ply)
							umsg.Entity(trace.Entity)
						umsg.End()

						ply.ActionTime = CT + 1

						return
					end
				end

				if not ply.ExamTarget then
					ply.ExamTarget = trace.Entity
					ply.ExamFinish = CT + ply.ExamTime

					umsg.Start("EXAMINE_START", ply)
						umsg.Entity(ply.ExamTarget)
						umsg.Short(ply.ExamTime)
					umsg.End()

					ply.ActionTime = CT + 1
				end
			end
		elseif cl == "prop_ragdoll" then
			dist = td.start:Distance(trace.Entity:GetPos())

			if dist <= 50 then
				ply:PickupObject(trace.Entity)
				ply.CarryEnt = trace.Entity
			end
		elseif cl == "dec_weapon" then
			dist = td.start:Distance(trace.Entity:GetPos())

			if dist <= 70 then
				trace.Entity:Unload(ply)
			end
		elseif cl == "func_breakable" and trace.MatType == MAT_GLASS then
			trace.Entity:TakeDamage(100, nil, nil)
			ply:EmitSound("ambient/voices/citizen_punches2.wav", 70, math.random(95, 105))
			ply:EmitSound(table.Random(ShatterGlass), 80, math.random(95, 105))
			ply.ActionTime = CT + 0.5
		elseif cl == "func_breakable_surf" then
			dist = td.start:Distance(trace.HitPos)

			if dist <= 55 then
				trace.Entity:Input("Shatter", NULL, NULL, "")
				ply:EmitSound("ambient/voices/citizen_punches2.wav", 70, math.random(95, 105))
				ply:EmitSound(table.Random(ShatterGlass), 80, math.random(95, 105))
				ply.ActionTime = CT + 0.5
			end
		end
	end
end

concommand.Add("dec_action", DEC_PerformAction)

local function DEC_BuyItem(ply, com, args)
	mailboxes = #ents.FindByClass("dec_mailbox")

	if mailboxes > 0 then
		if not ply.Mail then
			ply.Mail = {}
		end

		if #ply.Mail >= 4 then
			SendUserMessage("MAILFULL", ply)
			return
		end
	end

	if not CanBuy then
		return
	end

	item = args[1]

	if not item then
		return
	end

	item = tonumber(item)

	dosh = ply:GetDTInt(0)

	if dosh <= 0 then
		SendUserMessage("NOMONEY", ply)
		return
	end

	for k, v in pairs(Items) do
		if v.num == item then
			cb = v.CanBuy(ply)

			if cb == 1 then
				if dosh - v.Price >= 0 then
					if mailboxes > 0 then
						inserted = table.insert(ply.Mail, k)

						umsg.Start("MAILITEM", ply)
							umsg.Short(inserted)
							umsg.Short(k)
						umsg.End()
					else
						v.BuyFunc(ply)
					end

					ply:SetDTInt(0, dosh - v.Price)
					break
				else
					SendUserMessage("NOTENOUGHMONEY", ply)
					break
				end
			elseif cb == 2 then
				SendUserMessage("HAVEITEM", ply)
				break
			end
		end
	end
end

concommand.Add("dec_buyitem", DEC_BuyItem)

local PLAYER = debug.getregistry().Player

function PLAYER:HasItemNum(num)
	for k, v in pairs(self.Items) do
		if v.num == num then
			return true
		end
	end

	return false
end

function PLAYER:AddCarryable(num)
	for k, v in pairs(Carryables) do
		if v.num == num then
			table.insert(self.Items, {num = v.num, cuf = v.canusefunc, uf = v.usefunc})

			umsg.Start("GETCARRY", self)
				umsg.Short(v.num)
			umsg.End()
		end
	end
end

function PLAYER:CanGiveAmmo(ammo)
	amt = self:GetAmmoCount(ammo)
	cap = AmmoLimit[ammo]

	if amt == cap then
		return false
	end

	return true
end

function PLAYER:GetRemainingAmmo(num, ammo)
	amt = self:GetAmmoCount(ammo)
	cap = AmmoLimit[ammo]

	if amt + num >= cap then
		return cap - amt
	end

	return 0
end

function PLAYER:GiveAmmoCap(num, ammo)
	amt = self:GetAmmoCount(ammo)
	cap = AmmoLimit[ammo]

	if amt == cap then
		return
	end

	if amt + num <= cap then
		self:GiveAmmo(num, ammo)
	else
		self:GiveAmmo(cap - amt, ammo)
	end
end

function PLAYER:PositionMe()
	if not spawns then
		spawns = {}

		t = ents.FindByClass("info_player_terrorist")
		ct = ents.FindByClass("info_player_counterterrorist")
		def = ents.FindByClass("info_player_start")

		for k, v in pairs(t) do
			table.insert(spawns, v)
		end

		for k, v in pairs(ct) do
			table.insert(spawns, v)
		end

		for k, v in pairs(def) do
			table.insert(spawns, v)
		end
	end

	randpos = math.random(1, #spawns)
	self:SetPos(spawns[randpos]:GetPos())
	table.remove(spawns, randpos)
end

function PLAYER:IncreaseKarma(amt)
	res = math.Clamp(self:GetDTInt(1) + amt, 60, 140)
	self:SetDTInt(1, res)
	self:SetPData("DEC_Karma", res)
end

function PLAYER:DecreaseKarma(amt)
	res = math.Clamp(self:GetDTInt(1) - amt, 50, 140)
	self:SetDTInt(1, res)
	self:SetPData("DEC_Karma", res)
end

function PLAYER:SaveKarma()
	karma = self:GetPData("DEC_Karma")

	if not karma then
		self:SetPData("DEC_Karma", 100)
	else
		self:SetPData("DEC_Karma", self:GetDTInt(1))
	end
end

function PLAYER:LoadKarma()
	karma = self:GetPData("DEC_Karma")

	if not karma then
		self:SetPData("DEC_Karma", 100)
		self:SetDTInt(1, 100)
	else
		self:SetDTInt(1, karma)
	end
end

local id, dur

function PLAYER:Punish()
	self:SetPData("DEC_Karma", 100)

	id = self:SteamID()
	dur = tostring(GetConVarNumber("dec_bandur"))

	game.ConsoleCommand(string.format("kickid %s %s\n", id, "Karma too low - " .. dur .. " minute ban."))
	game.ConsoleCommand(string.format("banid %s %s kick\n", dur, id))
	game.ConsoleCommand("writeid\n")
end

function PLAYER:DropWep()
	if not IsValid(self:GetActiveWeapon()) then
		return
	end

	td = {}
	td.start = self:GetShootPos()
	td.endpos = td.start + self:GetAimVector() * 40
	td.filter = self

	trace = util.TraceHull(td)
	mywep = self:GetActiveWeapon()
	wepclass = mywep:GetClass()

	wep = ents.Create("dec_weapon")
	wep:SetPos(trace.HitPos)
	wep:Spawn()
	wep:SetModel(mywep.WorldModel)
	wep:PhysicsInit(SOLID_VPHYSICS)
	wep.UseDelay = CurTime() + 1
	wep.WepClass = wepclass
	wep.Ammo = mywep:Clip1()
	wep.AmmoType = mywep.Primary.Ammo
	wep.CanUnload = mywep.CanUnload
	wep.Unique = mywep.Unique

	phys = wep:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end

	if (!mywep.Size) then
		print("INVALID SIZE! FIX BLYAT")
	end
	self.Weight = self.Weight - (mywep.Size or 5)

	self:StripWeapon(wepclass)
end

concommand.Add("dec_dropweapon", PLAYER.DropWep)

function PLAYER:DropEverything()
	for k, v in pairs(self:GetWeapons()) do
		print(v)

		wep = ents.Create("dec_weapon")
		wep:SetPos(self:GetPos() + Vector(0, 0, 32))
		wep:Spawn()
		wep:SetModel(v.WorldModel)
		wep:PhysicsInit(SOLID_VPHYSICS)
		wep.UseDelay = CurTime() + 1
		wep.WepClass = v:GetClass()
		wep.Ammo = v:Clip1()
		wep.AmmoType = v.Primary.Ammo
		wep.CanUnload = v.CanUnload

		phys = wep:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:Wake()
		end

		wep:SetVelocity(self:GetVelocity())
	end
end

function PLAYER:Poison(ply)
	self.Poisoned = true
	self.Poisoner = ply
	SendUserMessage("POISONED", self)
end

function PLAYER:AttemptGrab()
	if self:Health() <= 20 then
		return
	end

	if self:GetMoveType() != MOVETYPE_WALK then
		return
	end

	if self:GetVelocity():Length() >= 1100 then
		return
	end

	if self:Crouching() then
		return
	end

	if CurTime() < self.GrabTime then
		return
	end

	if self:GetDTInt(2) <= 15 then
		return
	end

	SP = self:GetShootPos()
	aim = self:GetAimVector()
	td = {}

	td.start = SP
	td.endpos = td.start + Vector(aim.x, aim.y, 0) * 32
	td.filter = self

	trace1 = util.TraceLine(td)

	if IsValid(trace1.Entity) then
		cl = trace1.Entity:GetClass()

		if cl == "prop_physics" or cl == "prop_ragdoll" then
			if trace1.Entity:GetPhysicsObject():IsMoveable() then
				return
			end
		end
	end

	if trace1.Hit and not trace1.Entity:IsPlayer() then
		td = {}

		td.start = SP
		td.endpos = td.start + Vector(aim.x, aim.y, 0.5) * 32
		td.filter = self

		trace2 = util.TraceLine(td)

		if IsValid(trace2.Entity) then
			cl = trace2.Entity:GetClass()

			if cl == "prop_physics" or cl == "prop_ragdoll" then
				if trace2.Entity:GetPhysicsObject():IsMoveable() then
					return
				end
			end
		end

		if not trace2.Hit and not trace2.Entity:IsPlayer() then
			self.GrabHitNormal = trace1.HitNormal
			self:SetPos(trace1.HitPos - Vector(0, 0, 62))
			self:SetMoveType(MOVETYPE_NONE)
			self.HasGrabbed = true
			self.GrabTime = CurTime() + 0.25
			self:ViewPunch(Angle(4, 0, 0))
			self:EmitSound("physics/flesh/flesh_impact_hard" .. math.random(3, 5) .. ".wav", 70, 100)
			self:SetLocalVelocity(Vector(0, 0, 0))
		end
	end
end

function PLAYER:CountWeapons()
	amt = 0

	for k, v in pairs(self:GetWeapons()) do
		if v.TakesUpSlot then
			amt = amt + 1
		end
	end

	return amt
end

function PLAYER:CountUniqueWeapons()
	amt = 0

	for k, v in pairs(self:GetWeapons()) do
		if v.Unique then
			amt = amt + 1
		end
	end

	return amt
end

local function DEC_RetrieveMail(ply, com, args)
	Proceed = false

	for k, v in pairs(ents.FindInSphere(ply:GetPos(), 64)) do
		if v:GetClass() == "dec_mailbox" then
			Proceed = true
		end
	end

	if not Proceed then
		return
	end

	if not ply.Mail then
		SendUserMessage("NOMAIL", self)
		return
	end

	item = args[1]

	if not item then
		return
	end

	item = tonumber(item)

	itm = Items[ply.Mail[item]]

	if itm.Weapon then
		if ply:CountWeapons() >= GetConVarNumber("dec_maxweapons") then
			SendUserMessage("NOSPACE", ply)
			return
		end

		cb = itm.CanBuy(ply)

		if cb == 2 then
			SendUserMessage("HAVEITEM", ply)
			return
		end
	end

	if itm.Unique then
		if ply:CountUniqueWeapons() >= GetConVarNumber("dec_maxweapons_unique") then
			SendUserMessage("NOSPACE", ply)
			return
		end

		cb = itm.CanBuy(ply)

		if cb == 2 then
			SendUserMessage("HAVEITEM", ply)
			return
		end
	end

	itm.BuyFunc(ply)
	table.remove(ply.Mail, item)

	umsg.Start("MAILRETRIEVED", ply)
		umsg.Short(item)
	umsg.End()
end

concommand.Add("dec_retrievemail", DEC_RetrieveMail)

local function DEC_UseRadio(ply, com, args)
	CT = CurTime()

	if not ply:Alive() or not ply.HasWalkieTalkie or CT < ply.RadioDelay then
		return
	end

	rtype = args[1]
	rcat = args[2]
	rsound = args[3]

	if not rtype or not rcat or not rsound then
		return
	end

	rtype, rcat, rsound = tonumber(rtype), tonumber(rcat), tonumber(rsound)

	for k, v in pairs(player.GetAll()) do
		if v:Alive() and v.HasWalkieTalkie and v.Channel == ply.Channel then
			umsg.Start("RADIO", v)
				umsg.Short(rtype)
				umsg.Short(rcat)
				umsg.Short(rsound)
				umsg.Entity(ply)
			umsg.End()
		end
	end

	ply.RadioDelay = CT + 2
end

concommand.Add("dec_useradio", DEC_UseRadio)

local function DEC_Channel_Join(ply, com, args)
	if not ply:Alive() or not ply.HasWalkieTalkie then
		return
	end

	chan = args[1]
	pass = args[2]

	if not chan or not pass then
		return
	end

	joinchan = Channels[chan]

	if joinchan then
		if joinchan.password then
			if pass == joinchan.password then
				ply.Channel = chan
				SendUserMessage("CHANNEL_JOINED", ply)
			else
				SendUserMessage("CHANNEL_WRONGPASSWORD", ply)
			end
		else
			ply.Channel = chan
			SendUserMessage("CHANNEL_JOINED", ply)
		end
	else
		SendUserMessage("CHANNEL_NONEXISTANT", ply)
	end
end

concommand.Add("dec_channel_join", DEC_Channel_Join)

local function DEC_Channel_Create(ply, com, args)
	if not ply:Alive() or not ply.HasWalkieTalkie then
		return
	end

	chan = args[1]
	mpass = args[2]
	pass = args[3]

	if not chan or not mpass or not pass then
		return
	end

	joinchan = Channels[chan]

	if not joinchan then
		Channels[chan] = {password = pass, masterpassword = mpass, deletable = true}
		ply.Channel = chan
		SendUserMessage("CHANNEL_CREATED", ply)
	else
		SendUserMessage("CHANNEL_EXISTS", ply)
	end
end

concommand.Add("dec_channel_create", DEC_Channel_Create)

local function DEC_Channel_Delete(ply, com, args)
	if not ply:Alive() or not ply.HasWalkieTalkie then
		return
	end

	chan = args[1]
	mpass = args[2]

	if not chan or not mpass then
		return
	end

	joinchan = Channels[chan]

	if joinchan then
		if mpass then
			if mpass == joinchan.masterpassword then
				if joinchan.deletable then
					if ply.Channel == chan then
						ply.Channel = "channel1"
					end

					Channels[chan] = nil
					table.Sanitise(Channels)
					SendUserMessage("CHANNEL_DELETED", ply)
				end
			else
				SendUserMessage("CHANNEL_WRONGMASTERPASSWORD", ply)
			end
		end
	else
		SendUserMessage("CHANNEL_NONEXISTANT", ply)
	end
end

concommand.Add("dec_channel_delete", DEC_Channel_Delete)

local function DEC_ConfirmRoleReceival(ply)
	if GameStarted and CanBuy then
		ply.ReceivedRole = true
	end
end

concommand.Add("dec_received", DEC_ConfirmRoleReceival)

local function DEC_ReportBody(ply)
	if not GameStarted or not CanBuy then
		return
	end

	if not ply.IsAgent then
		return
	end

	ent = ply.DeadBody

	if ent and IsValid(ent) then
		if not ent.Reported then
			if ent:GetPos():Distance(ply:GetShootPos()) <= 80 then
				umsg.Start("REPORT_DEADPLAYER")
					umsg.Entity(ent.RealPlayer)
					umsg.Short(ent.Role)
				umsg.End()

				ply.DeadBody.Reported = true
			end
		end
	end
end

concommand.Add("dec_reportdeadbody", DEC_ReportBody)

local function DEC_GiveMoney(ply, com, args)
	if not GameStarted or not CanBuy then
		return
	end

	dosh = args[1]

	if not dosh then
		return
	end

	CT = CurTime()

	if CT < ply.ActionTime then
		return
	end

	m = ply:GetDTInt(0)
	dosh = math.Clamp(tonumber(dosh), 0, m)

	if dosh > m then
		dosh = m
	end

	if m < dosh then -- not gonna happen
		return
	end

	if dosh <= 0 then
		return -- not gonna happen either, bro
	end

	td = {}
	td.start = ply:GetShootPos()
	td.endpos = td.start + ply:GetAimVector() * 65
	td.filter = ply

	trace = util.TraceLine(td)

	if trace.Hit and trace.Entity:IsPlayer() and trace.Entity:Alive() then
		hm = trace.Entity:GetDTInt(0)

		if hm == MoneyCap then
			umsg.Start("MONEY_FULL", ply)
				umsg.Entity(trace.Entity)
				umsg.Short(dosh)
			umsg.End()

			umsg.Start("MONEY_FULL_ME", trace.Entity)
				umsg.Entity(ply)
				umsg.Short(dosh)
			umsg.End()

			ply.ActionTime = CT + 0.75

			return
		end

		if hm + dosh > MoneyCap then
			dosh = MoneyCap - hm
		end

		trace.Entity:SetDTInt(0, math.Clamp(hm + dosh, 0, MoneyCap))
		ply:SetDTInt(0, math.Clamp(m - dosh, 0, MoneyCap))

		umsg.Start("MONEY_GIVE", ply)
			umsg.Entity(trace.Entity)
			umsg.Short(dosh)
		umsg.End()

		umsg.Start("MONEY_RECEIVED", trace.Entity)
			umsg.Entity(ply)
			umsg.Short(dosh)
		umsg.End()

		ply.ActionTime = CT + 0.75
	end
end

concommand.Add("dec_givemoney", DEC_GiveMoney)

local function DEC_UseItem(ply, com, args)
	num = args[1]

	if not num then
		return
	end

	num = tonumber(num)

	for k, v in pairs(ply.Items) do
		if v.num == num then
			if v.cuf(ply) then
				v.uf(ply)
				table.remove(ply.Items, k)
			end
		end
	end
end

concommand.Add("dec_useitem", DEC_UseItem)

local function DEC_RestartRound(ply)
	if not IsValid(ply) or (ply:IsAdmin() or ply:IsSuperAdmin()) then
		RoundsPlayed = math.Clamp(RoundsPlayed - 1, 0, GetConVarNumber("dec_rounds"))
		GAMEMODE:EndRound(4)
	end
end

concommand.Add("dec_restartround", DEC_RestartRound)

timer.Create("SaveKarma", 120, 0, function()
	for k, v in pairs(player.GetAll()) do
		v:SaveKarma()
	end
end)
