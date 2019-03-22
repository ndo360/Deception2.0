local smtext = draw.SimpleText

function draw.ShadowedText(text, font, x, y, color, shadowcolor, shadowdist, al, ar, dynamic)
	if dynamic then
		HP = LocalPlayer():Health() / 100
		color = Color(200, 255 * HP, 150 * HP, 255)
	end

	smtext(text, font, x + shadowdist, y + shadowdist, shadowcolor, (al or TEXT_ALIGN_LEFT), (ar or TEXT_ALIGN_CENTER))
	smtext(text, font, x, y, color, (al or TEXT_ALIGN_LEFT), (ar or TEXT_ALIGN_CENTER))
end

include("cl_umsgs.lua")
include("cl_menus.lua")
include("cl_scoreboard.lua")
include("shared.lua")
include("items.lua")
include("cl_mail.lua")
include("tips.lua")
include("waltalmenus.lua")
include("cl_voice.lua")
include("carryables.lua")

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

CreateClientConVar("dec_staminablur", "1", true, true)
CreateClientConVar("dec_staminabeat", "1", true, true)

StatusText = nil
StatusAlphaTime = nil
StatusAlpha = 0
RoundTime = nil
CurChannel = "channel1"
CurPassword = "None"

ColorGreen = Color(0, 255, 70)
ColorNeon = Color(0, 165, 255)
ColorOrange = Color(255, 150, 0)
ColorYellow = Color(255, 200, 0)
ColorRed = Color(255, 30, 0)
ColorWhite = Color(255, 255, 255)
ColorVeryLightBlue = Color(180, 255, 255)
ColorLightGreen = Color(137, 165, 126)

local trect, orect, rect, clr, stext, texture, rbox, rboxex, tid, cfont, sup, bind, round, app, font, minsec, textsize, ceil = surface.DrawTexturedRect, surface.DrawOutlinedRect, surface.DrawRect, surface.SetDrawColor, draw.ShadowedText, surface.SetTexture, draw.RoundedBox, draw.RoundedBoxEx, surface.GetTextureID, surface.CreateFont, string.upper, input.LookupBinding, math.Round, math.Approach, surface.SetFont, string.ToMinutesSeconds, surface.GetTextSize, math.ceil

cfont("Trebuchet24_AA", {size = 24, weight = 500, antialias = true, false, font = "Trebuchet24"})
cfont("Trebuchet64_AA", {size = 64, weight = 500, antialias = true, false, font = "Trebuchet24"})
cfont("Trebuchet56_AA", {size = 56, weight = 500, antialias = true, false, font = "Trebuchet24"})
cfont("DefaultBoldShadow", {size = 12, weight = 400, antialias = true, false, font = "DefaultBold", shadow = true})
cfont("DefaultSmallDropShadow", {font = "Tahoma",size = 11,weight = 0,shadow = true})
cfont("DefaultSmallDropShadow", {font = "Tahoma",size = 11,weight = 0,shadow = true})
cfont("TabLarge", {font = "Tahoma",size = 13,weight = 700,shadow = true})
cfont("UiBold", {font = "Tahoma",size = 12,weight = 1000})


Action_Progress = 0
Action_Time = 0
Action_Alpha = 0
local CurMoney = 10

function GM:AddNotify( str, type, length )
	notification.AddLegacy( str, type, length )
end

local CT, X, Y, FT, HP, Time, clip, td, trace, cl, H, wep2, dt3, ProgressIncrease, aim, haim, dot, x, y, size, size2, x2, has, stam, amt, ply, wep, dtint2, SC, sizer, EP, SP, par, gp, pos, ang, mdl, tbl

par = {["$basetexture"] = "sprites/radio",
["$vertexcolor"] = 1,
["$vertexalpha"] = 1,
["$additive"] = 1,
["$nolod"] = 1}

local Radio = CreateMaterial("RadioMat", "UnlitGeneric", par)

function GM:PostPlayerDraw(pl)
	EP = EyePos()
	CT = CurTime()
	ply = LocalPlayer()
	wep = pl:GetActiveWeapon()

	if pl.RadioAlpha and pl.RadioAlphaTime then
		if pl.RadioAlpha > 0 then
			if CT > pl.RadioAlphaTime then
				pl.RadioAlpha = app(pl.RadioAlpha, 0, 2)
			end

			pos, ang = pl:GetBonePosition(pl:LookupBone("ValveBiped.Bip01_Head1"))

			cam.Start3D(EP, EyeAngles())
				sizer = 8
				sizer = math.Clamp(8 + EP:Distance(pos) / 64, 0, 16) -- make the sprite bigger if we're away

				render.SetMaterial(Radio)
				render.DrawSprite(pos + Vector(0, 0, 16), sizer, sizer, Color(255, 255, 255, pl.RadioAlpha))
			cam.End3D2D()
		end
	end

	if pl:Alive() then
		if pl.BackItems then
			for k, v in pairs(pl.BackItems) do
				if IsValid(v.wep) and (v.wep:GetDTInt(3) == 20 or wep != v.wep) then
					pos, ang = pl:GetBonePosition(pl:LookupBone("ValveBiped.Bip01_Spine2"))
					ang:RotateAroundAxis(ang:Right(), 200)

					v.model:SetRenderOrigin(pos + ang:Forward() * -3 + ang:Right() * 4 + ang:Up() * -4)
					v.model:SetRenderAngles(ang)
					v.model:DrawModel()
				end
			end
		end
	end
end

function GM:Think()
	ply = LocalPlayer()

	if IsValid(ply) then
		if not StressMusic1 then
			StressMusic1 = CreateSound(ply, "deception/st_2_2.mp3")
		end
	end

	if not ply.Mail then
		ply.Mail = {}
	end

	if not ply.Items then
		ply.Items = {}
	end

	if RoundTime and RoundTime != -1 then
		if RoundTime - CurTime() <= 60 then
			if not StressMusic1:IsPlaying() then
				StressMusic1:SetSoundLevel(90)
				StressMusic1:Play()

				timer.Create("StressMusic1", 60, 1, function()
					if StressMusic1:IsPlaying() then
						StressMusic1:Stop()
					end
				end)
			end
		end
	else
		if StressMusic1:IsPlaying() then
			StressMusic1:FadeOut(0.5)

			if timer.Exists("StressMusic1") then
				timer.Destroy("StressMusic1")
			end
		end
	end

	if not ply.CMenuKey then
		if not bind("+menu_context") then
			ply.CMenuKey = "NOT BOUND (CONTEXT MENU KEY)"
		else
			ply.CMenuKey = sup(bind("+menu_context"))
		end
	end

	if not ply.UseKey then
		if not bind("+use") then
			ply.UseKey = "NOT BOUND (USE KEY)"
		else
			ply.UseKey = sup(bind("+use"))
		end
	end

	if not ply.QMenuKey then
		if not bind("+menu") then
			ply.QMenuKey = "NOT BOUND (SPAWN MENU KEY)"
		else
			ply.QMenuKey = sup(bind("+menu"))
		end
	end

	if not ply.SpareKey then
		if not bind("gm_showspare1") then
			ply.SpareKey = "NOT BOUND (gm_showspare1)"
		else
			ply.SpareKey = sup(bind("gm_showspare1"))
		end
	end

	if not ply.NoclipKey then
		if not bind("noclip") then
			ply.NoclipKey = "NOT BOUND (NOCLIP KEY)"
		else
			ply.NoclipKey = sup(bind("noclip"))
		end
	end

	if not ply.IDType then
		ply.IDType = 0
	end

	for k, v in pairs(player.GetAll()) do
		if not v.BackItems then
			v.BackItems = {}
		end

		if v:Alive() then
			wep = v:GetActiveWeapon()

			if IsValid(wep) then
				if wep:GetDTInt(3) == 20 then
					wep:SetHoldType("normal")
				else
					wep:SetHoldType(wep.HoldType)
				end
			end

			for k2, v2 in pairs(v:GetWeapons()) do
				if v2.BackModel then
					mdl = v2.BackModel

					if not v.BackItems[mdl] then
						v.BackItems[mdl] = {model = ClientsideModel(mdl, RENDERGROUP_OPAQUE), wep = v2}
						v.BackItems[mdl].model:SetNoDraw(true)
					end
				end
			end
		end

		for k2, v2 in pairs(v.BackItems) do
			if not IsValid(v2.wep) then
				SafeRemoveEntity(v2.model)
				v.BackItems[k2] = nil
				table.Sanitise(v.BackItems)
			end
		end
	end

	if ALTARM_BodyArmor then
		if RedAmountStatus_Body > 0 then
			if RedAmount_Body == 255 and RedAmountStatus_Body == 1 then
				RedAmountStatus_Body = 1
			elseif RedAmount_Body == 20 then
				RedAmountStatus_Body = 2
			elseif RedAmount_Body == 255 and RedAmountStatus_Body == 2 then
				RedAmountStatus_Body = 3
			end
		end

		if RedAmountStatus_Body == 1 then
			RedAmount_Body = app(RedAmount_Body, 20, 12)
		elseif RedAmountStatus_Body == 2 then
			RedAmount_Body = app(RedAmount_Body, 255, 12)
		end

		if ConditionText_Body <= 0 and ALTARM_BodyArmor == true then
			Alpha_Body = app(Alpha_Body, 0, 3)

			if Alpha_Body == 0 and ALTARM_BodyArmor == true then
				ALTARM_BodyArmor = false
				Alpha_Body = 255
			end
		end
	end

	if not ply:Alive() then
		if ALTARM_BodyArmor then
			ALTARM_BodyArmor = false
			ALTARM_BodyArmorTexSetting = 0
			RedAmount_Body = 255
			RedAmountStatus_Body = 0
			Alpha_Body = 0
			ConditionText_Body = 100
		end

		if not ply.SoundPlayed then
			ply:EmitSound("deception/death" .. math.random(1, 2) .. ".mp3", 100, 100)
			ply.SoundPlayed = true
		end

		Poisoned = false
		BlurStrength = 0
	else
		if ply.SoundPlayed then
			ply.SoundPlayed = false
		end

		dtint2 = ply:GetDTInt(2)

		if GetConVarNumber("dec_staminabeat") > 0 then
			if dtint2 <= 50 then
				if not ply.HeartBeatTime or CurTime() > ply.HeartBeatTime then
					ply:EmitSound("deception/hbeat.wav", 80, 125)
					ply.HeartBeatTime = CurTime() + 0.8 - (0.5 - (dtint2 - 50)) / 100
				end
			end
		end

		if dtint2 == 0 and not ply.PlayedExhausted then
			for i = 1, 2 do
				timer.Simple(i - 1 * 0.75, function()
					if IsValid(ply) and ply:Alive() then
						ply:EmitSound("player/suit_sprint.wav", 70 - i * 10, math.random(95, 105))
					end
				end)
			end

			ply.PlayedExhausted = true
		elseif dtint2 > 0 then
			ply.PlayedExhausted = false
		end
	end
end

local txt1, txt2, clr1

function GM:OnPlayerChat(ply, text, tm, dead)
	pl = LocalPlayer()
	txt1 = ""
	txt2 = "Unknown person"

	if dead then
		txt2 = ply:Nick()
		txt1 = "(DEAD) "
		clr1 = Color(255, 0, 0)
	else
		if ply == pl or pl:IsAdmin() or pl:IsSuperAdmin() then
			txt2 = IsValid(ply) and ply:Nick() or "Console"
		else
			if not IsValid(ply) then
				txt2 = "Console"
			elseif ply.Status and ply.Status != 0 then
				txt2 = ply:Nick()
			end
		end

		if tm then
			if ply.Items and ply.Items.Radio and ply.Items.Radio.Has then
				txt1 = "(RADIO) "
				clr1 = ColorNeon
			end
		end
	end

	chat.AddText(clr1, txt1 .. "", Color(100, 200, 100), txt2 .. ":", Color(255, 255, 255), " " .. text)

	return true
end

ALTARM_BodyArmor = false
local PlayerAlpha = 0
tent = nil
local ALTARM_BodyArmorTex1 = tid("altarmor/flak_vest")
local ALTARM_BodyArmorTex2 = tid("altarmor/kevlar_bodyarmor")
local ALTARM_BodyArmorTex3 = tid("altarmor/dyneema_vest")
local Vig_Left = tid("deception/vig_left")
local Vig_Right = tid("deception/vig_right")
local Vig_LowerLeft = tid("deception/vig_lleft")
local Vig_LowerRight = tid("deception/vig_lright")
local Status = "Unknown"
local StatColor = Color(150, 150, 150, 255)
local AddStatus = ""
local ValEnt = false
ALTARM_BodyArmorTexSetting = 0
RedAmount_Body = 255
RedAmountStatus_Body = 0
ConditionText_Body = 100
Alpha_Body = 255
Poisoned = false
BlurStrength = 0

local PLAYER = debug.getregistry().Player

function DEC_RestoreInfo()
	ply = LocalPlayer()
	ply.Mail = {}
	ply.Items = {}
	ply.FingerPrints = {}
	HasWalkieTalkie = false
end

function PLAYER:AddCarryable(num)
	for k, v in pairs(Carryables) do
		if v.num == num then
			table.insert(self.Items, {num = v.num, key = v.key, keytext = v.keytext, icon = surface.GetTextureID(v.icon)})

			if v.addfunc then
				v.addfunc()
			end
		end
	end
end

function PLAYER:RemoveCarryable(num)
	for k, v in pairs(Carryables) do
		if v.num == num then
			table.remove(self.Items, k)
		end
	end
end

function PLAYER:HasWeaponCL(wep)
	has = false

	for k, v in pairs(self:GetWeapons()) do
		if v:GetClass() == wep then
			has = true
			break
		end
	end

	return has
end

function PLAYER:GetWeaponCL(class)
	wep = NULL

	for k, v in pairs(self:GetWeapons()) do
		if v:GetClass() == class then
			wep = v
			break
		end
	end

	return wep
end

local Weapons = {}
Weapons["models/weapons/w_pist_p228.mdl"] = {name = "P228", class = "dec_pistol_p228", unload = true}
Weapons["models/weapons/w_pist_deagle.mdl"] = {name = "Desert Eagle .50AE", class = "dec_pistol_deagle", unload = true}
Weapons["models/weapons/w_pist_fiveseven.mdl"] = {name = "FN Five-seveN", class = "dec_pistol_fiveseven", unload = true}
Weapons["models/weapons/w_pist_glock18.mdl"] = {name = "Glock-18", class = "dec_pistol_glock18", unload = true}
Weapons["models/weapons/w_smg_mac10.mdl"] = {name = "Ingram MAC-10", class = "dec_smg_mac10", unload = true}
Weapons["models/weapons/w_smg_tmp.mdl"] = {name = "TMP", class = "dec_smg_tmp", unload = true}
Weapons["models/weapons/w_smg_mp5.mdl"] = {name = "MP5", class = "dec_smg_mp5", unload = true}
Weapons["models/weapons/w_smg_ump45.mdl"] = {name = "UMP .45", class = "dec_smg_ump45", unload = true}
Weapons["models/weapons/w_smg_p90.mdl"] = {name = "FN P90", class = "dec_smg_p90", unload = true}
Weapons["models/weapons/w_knife_t.mdl"] = {name = "Knife", class = "dec_melee_knife", unload = false}
Weapons["models/weapons/w_rif_ak47.mdl"] = {name = "AK-47", class = "dec_rif_ak47", unload = true}
Weapons["models/weapons/w_rif_famas.mdl"] = {name = "FAMAS", class = "dec_rif_famas", unload = true}
Weapons["models/weapons/w_rif_galil.mdl"] = {name = "IMI Galil AR", class = "dec_rif_galil", unload = true}
Weapons["models/weapons/w_snip_awp.mdl"] = {name = "AWP", class = "dec_sniper_awp", unload = true}
Weapons["models/weapons/w_snip_g3sg1.mdl"] = {name = "G3SG1", class = "dec_sniper_g3sg1", unload = true}
Weapons["models/weapons/w_snip_sg550.mdl"] = {name = "SG550", class = "dec_sniper_g3sg1", unload = true}
Weapons["models/weapons/w_snip_scout.mdl"] = {name = "Scout", class = "dec_sniper_scout", unload = true}
Weapons["models/weapons/w_pistol.mdl"] = {name = "Dart gun", class = "dec_dart_gun", unload = true}
Weapons["models/weapons/w_c4.mdl"] = {name = "Ballistics Analyzer", class = "dec_balanal", unload = false}

local count, addy

function GM:RenderScreenspaceEffects()
	if Poisoned then
		FT = FrameTime()

		BlurStrength = Lerp(FT * 2, BlurStrength, 1)
	else
		FT = FrameTime()

		BlurStrength = Lerp(FT * 2, BlurStrength, 0)
	end

	if BlurStrength >= 0.05 then
		DrawMotionBlur(0.05 * BlurStrength, 0.99 * BlurStrength, 0)
		DrawToyTown(2, ScrH() * BlurStrength)
	end
end

Icons = {}
Icons.Cure = surface.GetTextureID("deception/icons/ic_antidote")
Icons.Radio = surface.GetTextureID("deception/icons/ic_radio")

local Cur

function GM:HUDPaint()
	CT = CurTime()
	X = ScrW()
	Y = ScrH()
	ply = LocalPlayer()
	FT = FrameTime()

	if ply:Alive() then
		-- vignetting starts here
		clr(255, 255, 255, 255 * (1 - (ply:GetDTInt(2) / 100)))
		texture(Vig_Left)

		SC = ScreenScale(128)
		trect(0, 0, SC, SC)

		texture(Vig_Right)
		trect(X - SC, 0, SC, SC)

		texture(Vig_LowerLeft)
		trect(0, Y - SC, SC, SC)

		texture(Vig_LowerRight)
		trect(X - SC, Y - SC, SC, SC)
		-- ends here

		HP = ply:Health()

		stext((ply.TeamText or "Civilian"), "Trebuchet24_AA", 50, Y - 125, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		stext(ply:GetDTInt(0) .. "/" .. MoneyCap .. "$", "Trebuchet24_AA", 50, Y - 100, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		stext(HP .. "/100HP", "Trebuchet24_AA", 50, Y - 75, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, true)

		if RoundTime and RoundTime - CT > 0 then
			Time = minsec(RoundTime - CT)

			if RoundTime - CT < 60 then
				stext("Time left: " .. Time, "Trebuchet24_AA", 50, Y - 50, Color(200, 50, 0, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, false)
			else
				stext("Time left: " .. Time, "Trebuchet24_AA", 50, Y - 50, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, false)
			end
		else
			stext("Preparing", "Trebuchet24_AA", 50, Y - 50, Color(255, 150, 0, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, false)
		end

		if ply.Items then
			clr(255, 255, 255, 255)

			for k, v in pairs(ply.Items) do
				surface.SetTexture(v.icon)
				trect(20, 20 + (k - 1) * 64, 48, 48)

				stext(v.keytext, "UiBold", 20, 60 + (k - 1) * 64, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end

		wep = ply:GetActiveWeapon()

		if IsValid(wep) then
			clip = wep:Clip1()

			stext("Current: " .. wep.PrintName, "Trebuchet24_AA", X - 50, Y - 100, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, false)

			if wep.Caliber then
				if not wep.HideCaliber then
					if wep.HideFMJ then
						stext(wep.Caliber, "Trebuchet24_AA", X - 50, Y - 50, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, false)
					else
						if wep.Primary.Ammo != "buckshot" then
							stext(wep.Caliber .. " FMJ", "Trebuchet24_AA", X - 50, Y - 50, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, false)
						elseif wep.Primary.Ammo != "buckshot" then
							stext(wep.Caliber .. "BUCK", "Trebuchet24_AA", X - 50, Y - 50, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, false)
						end
					end

					if clip <= wep.Primary.ClipSize then
						stext(clip .. "/" .. ply:GetAmmoCount(wep.Primary.Ammo), "Trebuchet24_AA", X - 50, Y - 75, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, false)
					else
						stext(wep.Primary.ClipSize .. "+1" .. "/" .. ply:GetAmmoCount(wep.Primary.Ammo), "Trebuchet24_AA", X - 50, Y - 75, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, false)
					end
				end
			end

			if ply.CMenuKey then
				dt3 = wep:GetDTInt(3)

				if not wep.CantHolster then
					if dt3 != 20 then
						stext("Conceal - " .. ply.CMenuKey .. "; Drop - " .. ply.UseKey .. " + " .. ply.CMenuKey, "Trebuchet24_AA", X * 0.5, Y - 50, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
					else
						stext("Draw - " .. ply.CMenuKey .. "; Drop - " .. ply.UseKey .. " + " .. ply.CMenuKey, "Trebuchet24_AA", X * 0.5, Y - 50, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
					end
				else
					stext("Drop - " .. ply.UseKey .. " + " .. ply.CMenuKey, "Trebuchet24_AA", X * 0.5, Y - 50, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
				end
			end
		else
			clr(0, 0, 0, 255)
			rect(X / 2 - 2, Y / 2 - 2, 4, 4)

			clr(255, 255, 255, 255)
			rect(X / 2 - 1, Y / 2 - 1, 2, 2)
		end

		td = {}
		td.start = ply:GetShootPos()
		td.endpos = td.start + ply:GetAimVector() * 256
		td.filter = ply

		trace = util.TraceLine(td)

		if trace.Hit then
			if trace.Entity:IsPlayer() then
				tent = trace.Entity
				PlayerAlpha = Lerp(FT * 15, PlayerAlpha, 255)
				ValEnt = true
			else
				cl = trace.Entity:GetClass()
				if cl == "prop_ragdoll" or cl == "dec_weapon" or cl == "func_breakable" or cl == "func_breakable_surf" then
					PlayerAlpha = Lerp(FT * 15, PlayerAlpha, 255)
					tent = trace.Entity
					ValEnt = false
				else
					PlayerAlpha = Lerp(FT * 15, PlayerAlpha, 0)
					ValEnt = false
				end
			end
		else
			PlayerAlpha = Lerp(FT * 15, PlayerAlpha, 0)
			ValEnt = false
		end

		if Action_Time then
			Action_Alpha = Lerp(FT * 15, Action_Alpha, 255)

			ProgressIncrease = 100 * (FT / Action_Time)

			Action_Progress = math.Clamp(Action_Progress + ProgressIncrease, 0, 100)

			if Action_Progress >= 100 then
				Action_Time = nil
			end
		else
			Action_Alpha = Lerp(FT * 15, Action_Alpha, 0)
		end

		if Action_Alpha > 5 then
			rbox(4, X * 0.5 - 100, Y * 0.7, 200, 12, Color(0, 0, 0, Action_Alpha * 0.75))

			if Action_Progress > 1 then
				rboxex(4, X * 0.5 - 99, Y * 0.7 + 1, Action_Progress * 1.98, 5, Color(0, 150, 255, Action_Alpha), true, true, false, false)
				rboxex(4, X * 0.5 - 99, Y * 0.7 + 6, Action_Progress * 1.98, 5, Color(0, 100, 255, Action_Alpha), false, false, true, true)
			end

			smtext("Progress: " .. round(Action_Progress) .. "%", "DefaultSmallDropShadow", X * 0.5, Y * 0.7 + 6, Color(255, 255, 255, Action_Alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if IsValid(tent) then
			cl = tent:GetClass()

			if tent:IsPlayer() then
				if PlayerAlpha > 5 then
					Status = "Unknown"
					StatColor = Color(150, 150, 150, PlayerAlpha)

					if tent.Status == 1 then
						Status = "Unarmed"
						StatColor = Color(0, 150, 255, PlayerAlpha)
					elseif tent.Status == 2 then
						Status = "Suspicious"
						StatColor = Color(255, 150, 0, PlayerAlpha)
					elseif tent.Status == 3 then
						Status = "Armed"
						StatColor = Color(255, 0, 0, PlayerAlpha)
					end

					if tent.AddStatus == 1 then
						AddStatus = ", VIP"

						if ply.TeamText != "Agent" then
							StatColor = Color(0, 150, 255, PlayerAlpha)
						else
							StatColor = Color(255, 0, 0, PlayerAlpha)
						end
					elseif tent.AddStatus == 2 then
						AddStatus = ", Not VIP"

						if Status == "Suspicious" then
							StatColor = Color(255, 150, 0, PlayerAlpha)
						elseif Status == "Dangerous" then
							StatColor = Color(255, 0, 0, PlayerAlpha)
						else
							StatColor = Color(0, 150, 255, PlayerAlpha)
						end
					elseif tent.AddStatus == 3 then
						AddStatus = ", Agent"
						StatColor = Color(255, 0, 0, PlayerAlpha)
					elseif tent.AddStatus == 4 then
						AddStatus = ", Impostor (?)"
						StatColor = Color(255, 150, 0, PlayerAlpha)
					else
						AddStatus = ""
					end

					HP = "Healthy"
					H = tent:Health()

					if H <= 75 then
						HP = "Slightly hurt"
					end

					if H <= 50 then
						HP = "Hurt"
					end

					if H <= 25 then
						HP = "Almost dead"
					end

					if not tent.Status or tent.Status == 0 then
						stext("Unknown person" .. AddStatus, "Trebuchet24_AA", X * 0.5, Y * 0.5 + 50, StatColor, Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					else
						stext(tent:Nick() .. " - " .. Status .. AddStatus, "Trebuchet24_AA", X * 0.5, Y * 0.5 + 50, StatColor, Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end

					stext(HP, "Trebuchet24_AA", X * 0.5, Y * 0.5 + 80, Color(200, 255 * (H / 100), 150 * (H / 100), PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

					addy = 0

					if not tent.Status or tent.Status != 3 then
						aim = ply:GetAimVector()
						aim = Vector(aim.x, aim.y)

						haim = tent:GetAimVector()
						haim = Vector(haim.x, haim.y, 0)

						dot = aim:DotProduct(haim)

						if dot > 0.1 then
							has = false

							if tent.BackItems then
								for k, v in pairs(tent.BackItems) do
									if IsValid(v.wep) and v.wep:GetDTInt(3) == 20 then
										has = true
										break
									end
								end
							end

							if has then
								tent.Status = 3
								chat.AddText(ColorRed, "You notice a weapon on this person's back.")
								surface.PlaySound("buttons/button17.wav")
							end
						end
					end

					if ply.TeamText == "Agent" then
						aim = ply:GetAimVector()
						aim = Vector(aim.x, aim.y)

						haim = tent:GetAimVector()
						haim = Vector(haim.x, haim.y, 0)

						dot = aim:DotProduct(haim)

						if dot < 0.6 then
							stext("Press " .. ply.QMenuKey .. " to examine player.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 110, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						else
							stext("Press " .. ply.QMenuKey .. " to pick-pocket player.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 110, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
						end
					else
						stext("Press " .. ply.QMenuKey .. " to examine player.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 110, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end

					if ply.IDType == 1 then
						addy = 30
						stext("Press " .. ply.UseKey .. " + " .. ply.QMenuKey .. " to show your VIP ID to this player.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 140, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					elseif ply.IDType == 2 then
						addy = 30
						stext("Press " .. ply.UseKey .. " + " .. ply.QMenuKey .. " to show your forged VIP ID to this player.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 140, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					end

					stext("Press " .. ply.NoclipKey .. " to give " .. CurMoney .. "$", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 140 + addy, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					stext("Use mousewheel to increase/decrease amount.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 170 + addy, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			elseif cl == "prop_ragdoll" then
				stext("Dead body.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 50, Color(255, 150, 0, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
				stext("Press " .. ply.UseKey .. " to examine body.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 80, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
				stext("Press " .. ply.QMenuKey .. " to drag body.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 110, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
			elseif cl == "dec_weapon" then
				wep2 = Weapons[tent:GetModel()]

				stext(wep2.name, "Trebuchet24_AA", X * 0.5, Y * 0.5 + 50, Color(255, 150, 0, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)

				if wep2.unload then
					if not tent.empty then
						stext("Press " .. ply.QMenuKey .. " to unload weapon.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 110, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
					else
						if tent.empty == 1 then
							stext("This weapon is partially unloaded.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 110, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
						else
							stext("This weapon is empty.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 110, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
						end
					end
				else
					if ply:HasWeaponCL("dec_balanal") then
						stext("You already have this weapon.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 110, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
					end
				end

				stext("Press " .. ply.UseKey .. " to take weapon.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 80, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
			elseif (cl == "func_breakable" and trace.MatType == MAT_GLASS) or cl == "func_breakable_surf" then
				stext("Press " .. ply.QMenuKey .. " to break glass.", "Trebuchet24_AA", X * 0.5, Y * 0.5 + 80, Color(255, 255, 255, PlayerAlpha), Color(0, 0, 0, PlayerAlpha), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, false)
			end
		end

		if ALTARM_BodyArmor == true then
			clr(255, RedAmount_Body, RedAmount_Body, Alpha_Body)

			if ALTARM_BodyArmorTexSetting == 1 then
				texture(ALTARM_BodyArmorTex1)
			elseif ALTARM_BodyArmorTexSetting == 2 then
				texture(ALTARM_BodyArmorTex2)
			else
				texture(ALTARM_BodyArmorTex3)
			end

			trect(X - 100, Y * 0.5 - 40, 64, 64)
			rbox(4, X - 95, Y * 0.5 + 40, 54, 15, Color(0, 0, 0, Alpha_Body))
			rbox(4, X - 93, Y * 0.5 + 42, 50, 11, Color(70, 70, 70, Alpha_Body))

			if ConditionText_Body > 2 then
				rbox(2, X - 93, Y * 0.5 + 42, ConditionText_Body / 2, 11, Color(135, 132, 112, Alpha_Body))
			end

			smtext(ConditionText_Body ..  "%", "DefaultSmall", X - 67, Y * 0.5 + 47, Color(255, 255, 255, Alpha_Body), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	else
		clr(0, 0, 0, 255)
		rect(0, 0, X, 50)
		rect(0, Y - 50, X, 50)

		smtext("You are dead. You will respawn when the round ends.", "TargetID", X * 0.5, 15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if RoundTime and RoundTime != -1 then
			smtext("Round ends in: " .. minsec(RoundTime - CT), "TargetID", X * 0.5, 35, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		elseif RoundTime and RoundTime == -1 then
			smtext("Round is over, new round will begin in a few seconds.", "TargetID", X * 0.5, 35, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			smtext("Round is still being prepared, how did you manage to die so soon?", "TargetID", X * 0.5, 35, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		smtext("Press F1 (gm_showhelp) to open the buy menu. (while alive)" , "TargetID", X * 0.5, Y - 35, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		smtext("Press F2 (gm_showteam) to open the help menu." , "TargetID", X * 0.5, Y - 15, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		font("UiBold")
		x, y = textsize(Tips[CurTip]) + 10

		x2 = round(x * 0.5)

		clr(137, 165, 126, 255)
		orect(X * 0.5 - x2, Y - 100, x, 40)

		clr(0, 0, 0, 200)
		rect(X * 0.5 - x2 + 1, Y - 99, x - 2, 38)

		stext(Tips[CurTip], "UiBold", X * 0.5, Y - 90, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if ply.SpareKey then
			stext("Tip " .. CurTip .. "/" .. #Tips .. ". Press " .. ply.SpareKey .. " to get another tip.", "UiBold", X * 0.5, Y - 70, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		clr(137, 165, 126, 255)
		orect(X * 0.5 - 200, 60, 400, 60)

		clr(0, 0, 0, 200)
		rect(X * 0.5 - 199, 61, 398, 58)

		stext("You are in Ghost Mode!", "UiBold", X * 0.5, 70, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		stext("Look at a prop and hold your PRIMARY ATTACK KEY to push the prop!", "UiBold", X * 0.5, 90, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		stext("Press your SECONDARY ATTACK KEY to play a spooky sound!", "UiBold", X * 0.5, 110, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		rbox(4, X * 0.5 - 100, 129, 200, 16, Color(0, 0, 0, 255))
		rbox(2, X * 0.5 - 99, 130, 198, 14, Color(80, 80, 80, 255))

		gp = ply:GetDTInt(3)

		if gp > 1 then
			rbox(2, X * 0.5 - 99, 130, gp * 1.98, 14, Color(150, 200, 150, 255))
		end

		stext("Ghost powers: " .. gp .. "%", "UiBold", X * 0.5, 137, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	if StatusText and StatusText.Type then
		if CT < StatusAlphaTime then
			StatusAlpha = app(StatusAlpha, 255, FT * 400)
		else
			StatusAlpha = app(StatusAlpha, 0, FT * 400)
		end

		if StatusAlpha >= 5 then
			size = 250

			font("UiBold")

			x, y = textsize(StatusText.Type)

			if x > size - 7 then
				size = x + 10
			end

			size2 = round(size * 0.5)

			clr(137, 165, 126, StatusAlpha)
			orect(X * 0.5 - size2, Y * 0.3, size, 40)

			clr(0, 0, 0, StatusAlpha * 0.9)
			rect(X * 0.5 - size2 + 1, Y * 0.3 + 1, size - 2, 38)

			smtext(StatusText.Type, "UiBold", X * 0.5, Y * 0.3 + 10, Color(255, 255, 255, StatusAlpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			if StatusText.Enum == 2 then
				smtext("Starting a new round (" .. R .. "/" .. MR ..  ") in ".. ceil(NewRoundTime - CT) .. " second(s).", "UiBold", X * 0.5, Y * 0.3 + 30, Color(255, 255, 255, StatusAlpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				smtext(StatusText.Description, "UiBold", X * 0.5, Y * 0.3 + 30, Color(255, 255, 255, StatusAlpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	end

	if HasWalkieTalkie then
		if MenuOpen then
			if not WTChoices[CurMenu] then
				count = #WTMenus

				clr(137, 165, 126, 255)
				orect(10, Y * 0.5 - count * 10 - 30, 200, count * 20 + 60)

				clr(0, 40, 0, 125)
				rect(11, Y * 0.5 - count * 10 + 1 - 30, 198, count * 20 + 60 - 2)

				for k, v in pairs(WTMenus) do
					stext(k .. ". " .. v.text, "TabLarge", 20, Y * 0.5 + k * 20 - count * 10 - 30, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end

				stext("9. Manage channels", "TabLarge", 20, Y * 0.5 + count * 10 - 10, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				stext("0. Back", "TabLarge", 20, Y * 0.5 + count * 10 + 10, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			else
				count = #WTChoices[CurMenu]

				clr(137, 165, 126, 255)
				orect(10, Y * 0.5 - count * 10 - 20, 200, count * 20 + 40)

				clr(0, 40, 0, 125)
				rect(11, Y * 0.5 - count * 10 + 1 - 20, 198, count * 20 + 40 - 2)

				for k, v in pairs(WTChoices[CurMenu]) do
					stext(k .. ". " .. v.text, "TabLarge", 20, Y * 0.5 + k * 20 - count * 10 - 20, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end

				stext("0. Back", "TabLarge", 20, Y * 0.5 + count * 10, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		end
	end

	if maps then
		clr(137, 165, 126, 255)
		orect(10, Y * 0.5 - #maps * 10, 250, #maps * 20 + 40)

		clr(0, 40, 0, 200)
		rect(11, Y * 0.5 - #maps * 10 + 1, 248, #maps * 20 + 40 - 2)

		stext("Vote for a map. (Vote ends in " .. ceil(MapEndTime - CT) .. " " .. (MapEndTime - CT < 0 and "second)" or "seconds)"), "TabLarge", 20, Y * 0.5 - #maps * 10 + 15, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		for k, v in pairs(maps) do
			stext(k .. ". " .. v.map .. " (" .. v.votes .. (v.votes == 1 and " vote)" or " votes)"), "TabLarge", 20, Y * 0.5 + k * 20 - #maps * 10 + 20, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
	end
end

function GM:GetMotionBlurValues(x, y, fw, spin)
	if GetConVarNumber("dec_staminablur") < 1 then
		return 0, 0, 0, 0
	end

	ply = LocalPlayer()

	if ply:Alive() then
		stam = ply:GetDTInt(2)

		amt = 0

		if stam <= 40 then
			amt = stam / 0.4
			amt = amt / 100

			return 0, 0, (1 - amt) * 0.01, 0
		end
	end

	return 0, 0, 0, 0
end

local MainFrame, Text, TextBox, Butt, chan, pass, mpass
local create = vgui.Create

local function OpenChannelManagement()
	ply = LocalPlayer()

	MainFrame = create("DFrame2")
	MainFrame:SetSize(200, 295)
	MainFrame:Center()
	MainFrame:SetTitle("Channel menu")
	MainFrame:SetVisible(true)
	MainFrame:SetDraggable(false)
	MainFrame:ShowCloseButton(true)
	MainFrame:MakePopup()

	Text = create("DLabel", MainFrame)
	Text:SetText("Channel name")
	Text:SetFont("TabLarge")
	Text:SizeToContents()
	Text:SetPos(20, 30)

	TextBox = create("DTextEntry", MainFrame)
	TextBox:SetText("")
	TextBox:SetPos(20, 50)
	TextBox:SetSize(160, 20)
	TextBox.OnTextChanged = function(self)
		chan = self:GetValue()
	end

	TextBox.OnEnter = function(self)
		chan = self:GetValue()
		print(chan)
	end

	Text = create("DLabel", MainFrame)
	Text:SetText("Channel password")
	Text:SetFont("TabLarge")
	Text:SizeToContents()
	Text:SetPos(20, 80)

	TextBox = create("DTextEntry", MainFrame)
	TextBox:SetText("")
	TextBox:SetPos(20, 100)
	TextBox:SetSize(160, 20)
	TextBox.OnTextChanged = function(self)
		pass = self:GetValue()
	end

	TextBox.OnEnter = function(self)
		pass = self:GetValue()
	end

	Text = create("DLabel", MainFrame)
	Text:SetText("Channel master password\n(for deletion/creation)")
	Text:SetFont("TabLarge")
	Text:SizeToContents()
	Text:SetPos(20, 130)

	TextBox = create("DTextEntry", MainFrame)
	TextBox:SetText("")
	TextBox:SetPos(20, 170)
	TextBox:SetSize(160, 20)
	TextBox.OnTextChanged = function(self)
		mpass = self:GetValue()
	end

	TextBox.OnEnter = function(self)
		mpass = self:GetValue()
	end

	Butt = create("DButton", MainFrame)
	Butt:SetText("Join")
	Butt:SetPos(20, 200)
	Butt:SetSize(50, 18)
	Butt.DoClick = function()
		ply:ConCommand("dec_channel_join " .. chan .. " " .. pass)
	end

	Butt = create("DButton", MainFrame)
	Butt:SetText("Create")
	Butt:SetPos(75, 200)
	Butt:SetSize(50, 18)
	Butt.DoClick = function()
		ply:ConCommand("dec_channel_create " .. chan .. " " .. mpass .. " " .. pass)
	end

	Butt = create("DButton", MainFrame)
	Butt:SetText("Delete")
	Butt:SetPos(130, 200)
	Butt:SetSize(50, 18)
	Butt.DoClick = function()
		ply:ConCommand("dec_channel_delete " .. chan .. " " .. mpass)
	end

	Butt = create("DButton", MainFrame)
	Butt:SetText("Join default channel")
	Butt:SetPos(40, 225)
	Butt:SetSize(120, 18)
	Butt.DoClick = function()
		ply:ConCommand("dec_channel_join channel1 asd")
	end

	Butt = create("DButton", MainFrame)
	Butt:SetText("Print channel info")
	Butt:SetPos(40, 250)
	Butt:SetSize(120, 18)
	Butt.DoClick = function()
		if CurChannel and CurPassword then
			chat.AddText(ColorNeon, "Channel name:", ColorWhite, " " .. CurChannel, ColorNeon, "\nChannel password:", ColorWhite, " " .. CurPassword)
			surface.PlaySound("buttons/button14.wav")

			if CurMasterPassword then
				chat.AddText(ColorNeon, "Master password:", ColorWhite, " " .. CurMasterPassword)
			end
		else
			chat.AddText(ColorYellow, "Channel info not found.")
			surface.PlaySound("buttons/button10.wav")
		end
	end
end

function GM:PlayerBindPress(ply, bind, press)
	CT = CurTime()

	if HasWalkieTalkie then
		if MenuOpen and press then
			if bind == "slot0" then
				if CurMenu != 0 then
					CurMenu = 0
				else
					MenuOpen = false
					CurMenu = 0
				end

				return true
			end

			if bind == "slot9" and CurMenu == 0 then
				CurMenu = 0
				MenuOpen = false

				OpenChannelManagement()

				return true
			end

			if bind:find("slot") then
				bind = string.Replace(bind, "slot", "")
				bind = tonumber(bind)

				if CurMenu == 0 and WTChoices[bind] then
					if CurMenu != bind then
						CurMenu = bind
					else
						WTChoices[CurMenu][bind].chatfunc(ply)
						CurMenu = 0
						MenuOpen = false
					end
				elseif CurMenu != 0 and WTChoices[CurMenu] then
					if WTChoices[CurMenu][bind] then
						WTChoices[CurMenu][bind].chatfunc(ply)
						CurMenu = 0
						MenuOpen = false
					end
				end

				return true
			end
		end

		if bind == "slot1" and press then
			if not MenuOpen then
				MenuOpen = true
				return true
			end
		end
	end

	if VoteStarted then
		if bind:find("slot") then
			bind = string.Replace(bind, "slot", "")

			ply:ConCommand("dec_votemap " .. bind)
			return true
		end
	end

	if bind == "noclip" and press then
		if tent and tent:IsPlayer() and tent:GetShootPos():Distance(ply:GetShootPos()) <= 65 then
			ply:ConCommand("dec_givemoney " .. CurMoney)
			return true
		end
	end

	if press and bind:find("slot") then
		for k, v in pairs(ply.Items) do
			if v.key == bind then
				RunConsoleCommand("dec_useitem", v.num)
				return true
			end
		end
	end

	if IsValid(tent) and tent:IsPlayer() then
		if ValEnt then
			if bind == "invnext" then
				if press then
					CurMoney = math.Clamp(CurMoney + 5, 5, ply:GetDTInt(0))
					return true
				end
			end

			if bind == "invprev" then
				if press then
					CurMoney = math.Clamp(CurMoney - 5, 5, ply:GetDTInt(0))
					return true
				end
			end
		end
	end
end

local Move = Angle(0, 0, 0)
local view, FT, WS, VEL, CT, RS, func

function GM:CalcView(ply, pos, ang, fov)
	view = {}
	FT = FrameTime()

	if ply:Alive() and ply:OnGround() then
		WS = ply:GetWalkSpeed()
		VEL = ply:GetVelocity():Length()

		if VEL > WS * 0.8 then
			CT = CurTime()
			RS = ply:GetRunSpeed()

			if VEL < RS * 0.8 then
				Move.p = Lerp(FT * 15, Move.p, math.sin(CT * (WS / 15)) * 0.5)
				Move.y = Lerp(FT * 15, Move.y, math.cos(CT * (WS / 20)) * 0.5)
			else
				Move.p = Lerp(FT * 15, Move.p, math.sin(CT * (RS / 20)))
				Move.y = Lerp(FT * 15, Move.y, math.sin(CT * (RS / 30)))
			end
		else
			Move.p = Lerp(FT * 15, Move.p, 0)
			Move.y = Lerp(FT * 15, Move.y, 0)
		end
	else
		Move.p = Lerp(FT * 15, Move.p, 0)
		Move.y = Lerp(FT * 15, Move.y, 0)
	end

	view.origin = pos
	view.angles = ang + Angle(Move.p * 0.2, Move.y * 0.2, 0)
	view.fov = fov

	wep = ply:GetActiveWeapon()

	if IsValid(wep) then

		func = wep.GetViewModelPosition

		if ( func ) then
			view.vm_origin,  view.vm_angles = func( wep, pos * 1, ang * 1 ) // Note: *1 to copy the object so the child function can't edit it.
		end

		func = wep.CalcView

		if ( func ) then
			view.origin, view.angles, view.fov = func( wep, ply, pos * 1, ang * 1, fov ) // Note: *1 to copy the object so the child function can't edit it.
		end

	end

	return view
end

function GM:OnSpawnMenuOpen()
	if LocalPlayer():Alive() then
		RunConsoleCommand("dec_action")
	end
end

function GM:OnContextMenuOpen()
	local ply = LocalPlayer()

	if IsValid(ply:GetActiveWeapon()) then
		if ply:KeyDown(IN_USE) then
			RunConsoleCommand("dec_dropweapon")
		else
			RunConsoleCommand("dec_holsterwep")
		end
	end
end

local function HideHUDStuff(name)
	if name == "CHudHealth" or name == "CHudCrosshair" or name == "CHudBattery" or name == "CHudAmmo" or name == "CHudSecondaryAmmo" then
		return false
	end
end

hook.Add("HUDShouldDraw", "HideHUDStuff", HideHUDStuff)

local function DEC_NextTip(ply)
	if Tips[CurTip + 1] then
		CurTip = CurTip + 1
	else
		CurTip = 1
	end
end

concommand.Add("dec_nexttip", DEC_NextTip)

local function DEC_Channel_Joined()
	chat.AddText(ColorNeon, "Joined radio channel!")
	surface.PlaySound("buttons/button14.wav")

	if chan and pass then
		CurChannel = chan
		CurPassword = pass
		CurMasterPassword = nil
	end
end

usermessage.Hook("CHANNEL_JOINED", DEC_Channel_Joined)

local function DEC_Channel_JoinedDefault()
	chat.AddText(ColorNeon, "Joined default radio channel!")
	surface.PlaySound("buttons/button14.wav")

	if chan and pass then
		CurChannel = "channel1"
		CurPassword = "None"
	end
end

usermessage.Hook("CHANNEL_JOINDEFAULT", DEC_Channel_JoinedDefault)

local function DEC_Channel_Created()
	chat.AddText(ColorNeon, "Created and joined radio channel!")
	surface.PlaySound("buttons/button17.wav")

	CurChannel = chan
	CurPassword = pass
	CurMasterPassword = mpass
end

usermessage.Hook("CHANNEL_CREATED", DEC_Channel_Created)
