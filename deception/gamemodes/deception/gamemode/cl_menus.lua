local clr, rect, orect, trect, stext, create = surface.SetDrawColor, surface.DrawRect, surface.DrawOutlinedRect, surface.DrawTexturedRect, draw.SimpleText, vgui.Create
local CreatedPanels, BuyPanel, FakePanel, Cats, PSheet, MainFrame, MainFrame2, MainFrame3, MainFrame4, MainFrame5, amt, ModelPanel, RepButt, Name, Desc, Stats, ply, Stop, body, cal, time, role, ply, Wide, Tall, W, x, y, w, h, sl, st, sr, sb, pl, pt, pr, pb, dosh, PrevMins, PrevMaxs, KillCaliber, KillTime, KillRole, min, text, rolet, HelpPanel, Help, mblur, stamblur, stambeat, CBox, addy
local DFrame2 = {}

function DFrame2:Init()
end

function DFrame2:Paint()
	Wide = self:GetWide()
	Tall = self:GetTall()

	clr(137, 165, 126, 255)
	orect(0, 0, Wide, Tall)

	clr(40, 80, 40, (self.Alpha or 100))
	rect(1, 1, Wide - 2, Tall - 2)

	draw.RoundedBox(8, 3, 3, Wide - 6, 20, Color(50, 50, 50, 100))
end

vgui.Register("DFrame2", DFrame2, "DFrame")

local DPropertySheet2 = {}

function DPropertySheet2:Init()
end

function DPropertySheet2:Paint()
	Wide = self:GetWide()
	Tall = self:GetTall()

	clr(137, 165, 126, 255)
	orect(0, 22, Wide, Tall - 22)

	clr(0, 0, 0, 230)
	rect(1, 23, Wide - 2, Tall - 24)
end

vgui.Register("DPropertySheet2", DPropertySheet2, "DPropertySheet")

local Stats = {}

function Stats:SetStats(dmg, rof, acc, rng)
	self.Damage = dmg
	self.Rof = rof
	self.Accuracy = acc
	self.Range = rng
end

function Stats:Paint()
	if self.Damage and self.Rof and self.Accuracy and self.Range then
		-- optimization, bitch nigga

		clr(137, 165, 126, 255)
		orect(50, 0, 100, 12)
		orect(50, 14, 100, 12)
		orect(50, 28, 100, 12)
		orect(50, 42, 100, 12)

		clr(40, 40, 40, 255)
		rect(51, 1, 98, 10)
		rect(51, 15, 98, 10)
		rect(51, 29, 98, 10)
		rect(51, 43, 98, 10)

		stext("Damage", "DefaultSmall", 0, 0, Color(255, 255, 255, 255))
		stext("Speed", "DefaultSmall", 0, 14, Color(255, 255, 255, 255))
		stext("Accuracy", "DefaultSmall", 0, 28, Color(255, 255, 255, 255))
		stext("Range", "DefaultSmall", 0, 42, Color(255, 255, 255, 255))

		clr(137, 165, 126, 255)
		rect(52, 2, self.Damage * 0.96, 8)
		rect(52, 16, self.Rof * 0.96, 8)
		rect(52, 30, self.Accuracy * 0.96, 8)
		rect(52, 44, self.Range * 0.96, 8)
	end
end

vgui.Register("Stats", Stats, "DPanel")

local PANEL = {}

function PANEL:Paint(...)
	W = self:GetWide()
	clr(70, 100, 70, 150)
	rect(1, 1, W - 2, self:GetTall() - 2)

    x, y = self:LocalToScreen( 0, 0 )
    w, h = self:GetSize()

    sl, st, sr, sb = x, y, x + w, y + h

    p = self

    while p:GetParent() do
        p = p:GetParent()
        pl, pt = p:LocalToScreen( 0, 0 )
        pr, pb = pl + p:GetWide(), pt + p:GetTall()
        sl = sl < pl and pl or sl
        st = st < pt and pt or st
        sr = sr > pr and pr or sr
        sb = sb > pb and pb or sb
    end

    render.SetScissorRect( sl, st, sr, sb, true )
        self.BaseClass.Paint( self, ... )
    render.SetScissorRect( 0, 0, 0, 0, false )

	clr(137, 165, 126, 255)
	orect(0, 0, W, 64)
end

function PANEL:PaintOver()
	if self.CanDraw then
		dosh = LocalPlayer():GetDTInt(0)

		if dosh >= self.Price then
			draw.ShadowedText("Purchase", "TabLarge", 32, 32, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.ShadowedText("Need " .. self.Price - dosh .. "$", "TabLarge", 32, 32, Color(255, 0, 0, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end

-- enum 107 is left click
-- enum 108 is right click

function PANEL:OnMousePressed(enum)
	ply = LocalPlayer()

	if not ply:Alive() then
		return
	end

	ply:ConCommand("dec_buyitem " .. self.ItemNum)
end

function PANEL:OnCursorEntered(enum)
	self.CanDraw = true
end

function PANEL:OnCursorExited(enum)
	self.CanDraw = false
end

vgui.Register( "DModelPanel2", PANEL, "DModelPanel" )

function PANEL:CenterView()
	PrevMins, PrevMaxs = self.Entity:GetRenderBounds()
	self:SetCamPos(PrevMins:Distance(PrevMaxs)*Vector(0.75, 0.75, 0.5))
	self:SetLookAt((PrevMaxs + PrevMins) / 2)
end

function PANEL:LayoutEntity()
end

PANEL = {}

function PANEL:Paint()
	return false
end

vgui.Register("DPanelList2", PANEL, "DPanelList")

local DImage2 = {}

function DImage2:Paint()
	if self.Texture and self.X and self.Y then
		if not self.FinalTexture then
			self.FinalTexture = surface.GetTextureID(self.Texture)
		else
			surface.SetTexture(self.FinalTexture)
			clr(255, 255, 255, 255)
			trect(0, 0, self.X, self.Y)
		end
	end
end

vgui.Register("DImage2", DImage2, "DImage")

local CanContinue = false

local function DEC_BuyMenu()
	if not RoundTime or RoundTime == -1 then
		GAMEMODE:AddNotify("Cannot purchase items until round start!", NOTIFY_ERROR, 7)
		surface.PlaySound("buttons/button10.wav")
		return
	end

	ply = LocalPlayer()

	if not ply:Alive() then
		GAMEMODE:AddNotify("Cannot purchase items while dead!", NOTIFY_ERROR, 7)
		surface.PlaySound("buttons/button10.wav")
		return
	end

	MainFrame4 = create("DFrame2")
	MainFrame4:SetSize(400, 500)
	MainFrame4:Center()
	MainFrame4:SetTitle("Buy menu")
	MainFrame4:SetVisible(true)
	MainFrame4:SetDraggable(false)
	MainFrame4:ShowCloseButton(true)
	MainFrame4:MakePopup()

	PSheet = create("DPropertySheet2", MainFrame4)
	PSheet:SetPos(25, 25)
	PSheet:SetSize(MainFrame4:GetWide() - 50, MainFrame4:GetTall() - 40)

	CreatedPanels = {}
	BuyPanel = nil
	FakePanel = nil
	Cats = {}
	CanContinue = false

	for k, v in pairs(Items) do
		for k2, v2 in pairs(v.TeamText) do
			if ply.TeamText == v2 or (not ply.TeamText and v2 == "Civilian") then
				CanContinue = true
				Stop = false
			end

			if CanContinue and not Stop then
				if not CreatedPanels[v.Category] then
					CreatedPanels[v.Category] = {}

					BuyPanel = create("DPanelList", PSheet)
					BuyPanel:SetPos(10, 20)
					BuyPanel:SetSize(200, 600)
					BuyPanel:SetSpacing(8)
					BuyPanel:EnableHorizontal(false)
					BuyPanel:EnableVerticalScrollbar(true)
					BuyPanel.Paint =  function() end

					FakePanel = create("Panel", BuyPanel)

					PSheet:AddSheet(v.Category, BuyPanel, "deception/money", false, false, v.Category)

					Cats[v.Category] = {amt = 0}
				end

				amt = Cats[v.Category].amt

				ModelPanel = create("DModelPanel2", FakePanel)
				ModelPanel:SetModel(v.Model)
				ModelPanel:SetSize(64, 64)
				ModelPanel:SetPos(10, 24 + amt * 120)
				ModelPanel:CenterView()
				ModelPanel.Price = v.Price
				ModelPanel.ItemNum = v.num

				Name = create("DLabel", FakePanel)
				Name:SetPos(12, 8 + amt * 120)
				Name:SetText(v.Name .. (v.Unique and " (U)" or "").. " - " .. v.Price .. "$")
				Name:SetFont("TabLarge")
				Name:SizeToContents()

				if v.Stats then
					Desc = create("DLabel", FakePanel)
					Desc:SetPos(12, 90 + amt * 120)
					Desc:SetText(v.Description)
					Desc:SizeToContents()

					Stats = create("Stats", FakePanel)
					Stats:SetSize(250, 60)
					Stats:SetPos(80, 28 + amt * 120)
					Stats:SetStats(v.Stats.damage, v.Stats.rof, v.Stats.accuracy, v.Stats.range)
				else
					Desc = create("DLabel", FakePanel)
					Desc:SetPos(80, 28 + amt * 120)
					Desc:SetText(v.Description)
					Desc:SetTextColor(Color(175, 255, 175, 255))
					Desc:SizeToContents()
				end

				Cats[v.Category].amt = Cats[v.Category].amt + 1
				FakePanel:SetSize(400, Cats[v.Category].amt * 120)

				if not CreatedPanels[v.Category].Registered then
					BuyPanel:AddItem(FakePanel)
					CreatedPanels[v.Category].Registered = true
				end
			end

			Stop = true -- this prevents from the loop creating multiple same items
		end
	end
end

concommand.Add("dec_buymenu", DEC_BuyMenu)

local Calibers = {
	["9x19MM"] = {cal = "9x19MM firearm", func = function(text)
		return "It looks like this person was killed by\na firearm chambered in the\n" .. text .. " caliber."
	end},

	["5.7x28MM"] = {cal = "5.7x28MM firearm", func = function(text)
		return "It looks like this person was killed by\na firearm chambered in the\n" .. text .. " caliber."
	end},

	[".45 ACP"] = {cal = ".45 ACP firearm", func = function(text)
		return "It looks like this person was killed by\na firearm chambered in the\n" .. text .. " caliber."
	end},

	[".50 AE"] = {cal = ".50 AE firearm", func = function(text)
		return "It looks like this person was killed by\na firearm chambered in the\n" .. text .. " caliber."
	end},

	["7.62x39MM"] = {cal = "7.62x39MM firearm", func = function(text)
		return "It looks like this person was killed by\na firearm chambered in the\n" .. text .. " caliber."
	end},

	["7.62x51MM"] = {cal = "7.62x51MM firearm", func = function(text)
		return "It looks like this person was killed by\na firearm chambered in the\n" .. text .. " caliber."
	end},

	["5.56x45MM"] = {cal = "5.56x45MM firearm", func = function(text)
		return "It looks like this person was killed by\na firearm chambered in the\n" .. text .. " caliber."
	end},
	
	["7.62×51MM"] = {cal = "7.62×51MM firearm", func = function(text)
		return "It looks like this person was killed by\na firearm chambered in the\n" .. text .. " caliber."
	end},

	[".338 Lapua Magnum"] = {cal = ".338 Lapua Magnum firearm", func = function(text)
		return "It looks like this person was killed by\na firearm chambered in the\n" .. text .. " caliber."
	end},

	["Clumsiness"] = {cal = "Clumsiness", func = function(text)
		return "It seems that this person fell to his death.\nThe cause is not known, it could be\nanything."
	end},

	["Steel"] = {cal = "Steel knife", func = function(text)
		return "It looks like this person was killed by\na knife."
	end},

	["Poison dart"] = {cal = "Dart", func = function(text)
		return "It looks like this person was killed by\nsome kind of a dart.\nMost likely a poison dart."
	end}}

local function DEC_ExamineDeadBody(um)
	body = um:ReadEntity()
	cal = um:ReadString()
	time = um:ReadShort()
	role = um:ReadShort()
	ply = LocalPlayer()

	addy = 0

	if ply.TeamText == "Agent" then
		addy = 30
	end

	MainFrame2 = create("DFrame2")
	MainFrame2:SetSize(250, 360 + addy)
	MainFrame2:Center()
	MainFrame2:SetTitle("Examining " .. body:Nick() .. "'s body.")
	MainFrame2:SetVisible(true)
	MainFrame2:SetDraggable(false)
	MainFrame2:ShowCloseButton(true)
	MainFrame2:MakePopup()

	MainFrame2.Alpha = 200

	KillCaliber = create("DLabel", MainFrame2)
	print(cal)
	KillCaliber:SetText("Kill cause - " .. (Calibers[cal] and Calibers[cal].cal or "The world"))
	KillCaliber:SetPos(10, 30)
	KillCaliber:SetFont("TabLarge")
	KillCaliber:SizeToContents()

	KillCaliber = create("DImage", MainFrame2)
	KillCaliber:SetPos(10, 50)
	KillCaliber:SetImage("deception/icon_killcaliber_2")
	KillCaliber:SetSize(48, 48)

	KillCaliber = create("DLabel", MainFrame2)
	KillCaliber:SetText(Calibers[cal] and Calibers[cal].func(cal) or "Unknown")
	KillCaliber:SetPos(10, 100)
	KillCaliber:SetFont("TabLarge")
	KillCaliber:SizeToContents()

	CT = CurTime()
	min = CT - time <= 59 and "minute" or "minutes"

	KillTime = create("DLabel", MainFrame2)
	KillTime:SetText("Kill time - " .. math.ceil((CT - time) / 60) .. " " .. min .. " ago")
	KillTime:SetPos(10, 160)
	KillTime:SetFont("TabLarge")
	KillTime:SizeToContents()

	KillTime = create("DImage", MainFrame2)
	KillTime:SetPos(10, 180)
	KillTime:SetImage("deception/icon_killtime_2")
	KillTime:SetSize(48, 48)

	text = nil

	if math.ceil((CT - time)/ 60) >= 3 then
		text = "The body is cold, the kill was most likely\nperformed quite some time ago."
	else
		text = "The body is fresh, the kill was most likely\nperformed not long ago."
	end

	KillTime = create("DLabel", MainFrame2)
	KillTime:SetText(text)
	KillTime:SetPos(10, 230)
	KillTime:SetFont("TabLarge")
	KillTime:SizeToContents()

	-- role

	rolet = nil

	if role == 1 then
		rolet = "Civilian"
	elseif role == 2 then
		rolet = "Agent"
	elseif role == 3 then
		rolet = "VIP"
	end

	KillTime = create("DLabel", MainFrame2)
	KillTime:SetText("Player role - " .. rolet)
	KillTime:SetPos(10, 280)
	KillTime:SetFont("TabLarge")
	KillTime:SizeToContents()

	KillTime = create("DImage", MainFrame2)
	KillTime:SetPos(10, 300)
	KillTime:SetImage("deception/icon_playerrole")
	KillTime:SetSize(48, 48)

	-- report dead body button for agents

	if ply.TeamText == "Agent" then
		RepButt = create("DButton", MainFrame2) -- almost RAPEBUTT, AMIRITE?! LOLOLO XDXDXDD LE EPIC WIN FOR LE REDDIT!!! no, fuck you
		RepButt:SetPos(10, 360)
		RepButt:SetSize(100, 18)
		RepButt:SetText("Report body")
		RepButt.DoClick = function()
			RunConsoleCommand("dec_reportdeadbody")
		end
	end
end

usermessage.Hook("EXAMINE_DEADBODY", DEC_ExamineDeadBody)

local function DEC_HelpMenu()
	MainFrame3 = create("DFrame2")
	MainFrame3:SetSize(400, 360)
	MainFrame3:Center()
	MainFrame3:SetTitle("Help menu.")
	MainFrame3:SetVisible(true)
	MainFrame3:SetDraggable(false)
	MainFrame3:ShowCloseButton(true)
	MainFrame3:MakePopup()

	MainFrame3.Alpha = 150

	PSheet = create("DPropertySheet2", MainFrame3)
	PSheet:SetPos(10, 25)
	PSheet:SetSize(MainFrame3:GetWide() - 20, MainFrame3:GetTall() - 30)

	HelpPanel = create("DPanelList2", PSheet)
	HelpPanel:SetSize(380, 320)

	Help = create("DLabel", HelpPanel)
	Help:SetText("The basics.")
	Help:SetPos(0, 0)
	Help:SetFont("TabLarge")
	Help:SetTextColor(Color(0, 200, 80, 255))
	Help:SizeToContents()

	Help = create("DLabel", HelpPanel)
	Help:SetText([[Out of all players, 3 are chosen, 2 of which are Agents A and B.
The third person is the VIP, everyone else remains a Civilian.
To win the round, the Agents have to kill each other AND the VIP.
The VIP has to survive the round OR eliminate the Agents to win.
The Civilians are sworn protect the VIP.]])

	Help:SetFont("DefaultBoldShadow")
	Help:SetPos(0, 20)
	Help:SizeToContents()

	Help = create("DLabel", HelpPanel)
	Help:SetText("The gameplay.")
	Help:SetPos(0, 90)
	Help:SetFont("TabLarge")
	Help:SetTextColor(Color(0, 200, 80, 255))
	Help:SizeToContents()

	Help = create("DLabel", HelpPanel)
	Help:SetText([[Each player gains money over time to spend on items.
The player can access the buy menu by pressing F1 (gm_showhelp).
Some weapons are restricted to certain player classes only (Agent/VIP).
The Agents are able to pick-pocket players to find clues.
The VIP is able to show his VIP ID card to players, to prove that he
is the VIP and get protection from Civilians.
Every player is able to examine another player. To do that, the player
has to come up to another player and press his SPAWN MENU KEY (default - Q).
Agents are much more experienced in examining people and may notice
suspicious players much easier than regular Civilians will.
Each player also has a karma rating. Karma affects the amount of money
a player gets at the start of a round.
Having a karma that's too low will result in a 1 HOUR BAN.]])
	Help:SetFont("DefaultBoldShadow")
	Help:SetPos(0, 110)
	Help:SizeToContents()

	PSheet:AddSheet("Basics", HelpPanel, "gui/silkicons/user", false, false, "The basics of the gamemode.")

	HelpPanel = create("DPanelList2", PSheet)
	HelpPanel:SetSize(380, 320)

	Help = create("DLabel", HelpPanel)
	Help:SetText("Climbing.")
	Help:SetPos(0, 0)
	Help:SetFont("TabLarge")
	Help:SetTextColor(Color(0, 200, 80, 255))
	Help:SizeToContents()

	Help = create("DLabel", HelpPanel)
	Help:SetText([[Each player is able to grab onto ledges and pull himself up.
To do that, walk up to a wall, JUMP up, and hold down your JUMP KEY.
If it's possible, you will grab onto the ledge.
To pull yourself up, press your JUMP KEY again.
To let go of the ledge, press your CROUCH KEY.
You cannot grab onto the ledge while crouching.
Falling down too fast also disallows the ledge grab.
Holding onto a ledge or pulling self up drains stamina.]])

	Help:SetFont("DefaultBoldShadow")
	Help:SetPos(0, 20)
	Help:SizeToContents()

	Help = create("DLabel", HelpPanel)
	Help:SetText("Stamina.")
	Help:SetPos(0, 130)
	Help:SetFont("TabLarge")
	Help:SetTextColor(Color(0, 200, 80, 255))
	Help:SizeToContents()

	Help = create("DLabel", HelpPanel)
	Help:SetText([[Each player also has limited stamina.
Actions such as sprinting, jumping and climbing drain stamina.
When stamina is too low, the player will not be able to sprint.
The indication of stamina is purely visual and sound based.
When your stamina is low enough, you will hear a heartbeat sound
and the corners of your vision will become blurry and darkened.
Walking or standing still restores stamina.
Getting injured also drains stamina.
Your stamina will also drain faster if you have lots of equipment
(weapons, armor) on you.]])

	Help:SetFont("DefaultBoldShadow")
	Help:SetPos(0, 150)
	Help:SizeToContents()

	PSheet:AddSheet("Additional", HelpPanel, "deception/adv_help", false, false, "Additional info for those that don't get tired from reading.")

	HelpPanel = create("DPanelList2", PSheet)
	HelpPanel:SetSize(380, 320)

	mblur = GetConVarNumber("mat_motion_blur_enabled")

	CBox = create("DCheckBoxLabel", HelpPanel)
	CBox:SetText("Motion Blur")
	CBox:SetPos(0, 0)
	CBox:SetConVar(mblur)
	CBox:SetValue(mblur)
	CBox:SizeToContents()

	stamblur = GetConVarNumber("dec_staminablur")

	CBox = create("DCheckBoxLabel", HelpPanel)
	CBox:SetText("Stamina Blur (Requires Motion Blur!)")
	CBox:SetPos(0, 20)
	CBox:SetConVar(stamblur)
	CBox:SetValue(stamblur)
	CBox:SizeToContents()

	stambeat = GetConVarNumber("dec_staminabeat")

	CBox = create("DCheckBoxLabel", HelpPanel)
	CBox:SetText("Stamina Heartbeat")
	CBox:SetPos(0, 40)
	CBox:SetConVar(stambeat)
	CBox:SetValue(stambeat)
	CBox:SizeToContents()

	PSheet:AddSheet("Options", HelpPanel, "gui/silkicons/wrench", false, false, "Disable or enable some stuff to your own liking.")
end

concommand.Add("dec_helpmenu", DEC_HelpMenu)
