WTMenus = {}
CurMenu = 0
MenuOpen = false
MenuTime = 0

WTMenus[1] = {text = "Warn", num = 1}
WTMenus[2] = {text = "Report", num = 2}
WTMenus[3] = {text = "Respond", num = 3}
WTMenus[4] = {text = "Emote", num = 4}

WTChoices = {}

local rand, sound, text, tbl

-- Support

local function DoRadio(ply, a, b)
	tbl = #WTSounds[a][b]
	rand = math.random(1, tbl)
	
	ply:ConCommand("dec_useradio " .. a .. " " .. b .. " " .. rand)
end

WTChoices[1] = {
	[1] = {text = "Help!", num = 1, chatfunc = function(ply)
		DoRadio(ply, 1, 1)
	end},
	
	[2] = {text = "Cover me!", num = 2, chatfunc = function(ply)
		DoRadio(ply, 1, 2)
	end},
	
	[3] = {text = "Follow me.", num = 3, chatfunc = function(ply)
		DoRadio(ply, 1, 3)
	end},
	
	[4] = {text = "Cease fire!", num = 4, chatfunc = function(ply)
		DoRadio(ply, 1, 4)
	end},
	
	[5] = {text = "I see him", num = 5, chatfunc = function(ply)
		DoRadio(ply, 1, 5)
	end},
	
	[6] = {text = "I hear something", num = 6, chatfunc = function(ply)
		DoRadio(ply, 1, 6)
	end},
	
	[7] = {text = "Report in", num = 7, chatfunc = function(ply)
		DoRadio(ply, 1, 7)
	end},
	
	[8] = {text = "Reporting in", num = 8, chatfunc = function(ply)
		DoRadio(ply, 1, 8)
	end}}
	
-- Report

WTChoices[2] = {
	[1] = {text = "Attacking", num = 1, chatfunc = function(ply)
		DoRadio(ply, 2, 1)
	end},
	
	[2] = {text = "Enemy down", num = 2, chatfunc = function(ply)
		DoRadio(ply, 2, 2)
	end},
	
	[3] = {text = "Clear", num = 3, chatfunc = function(ply)
		DoRadio(ply, 2, 3)
	end},
	
	[4] = {text = "I lost him", num = 4, chatfunc = function(ply)
		DoRadio(ply, 2, 4)
	end},
	
	[5] = {text = "In combat", num = 5, chatfunc = function(ply)
		DoRadio(ply, 2, 5)
	end}}
	
-- Respond

WTChoices[3] = {
	[1] = {text = "Affirmative", num = 1, chatfunc = function(ply)
		DoRadio(ply, 3, 1)
	end},
	
	[2] = {text = "Yes", num = 2, chatfunc = function(ply)
		DoRadio(ply, 3, 2)
	end},
	
	[3] = {text = "Negative", num = 3, chatfunc = function(ply)
		DoRadio(ply, 3, 3)
	end},
	
	[4] = {text = "No", num = 4, chatfunc = function(ply)
		DoRadio(ply, 3, 4)
	end},

	[5] = {text = "I'll follow you", num = 5, chatfunc = function(ply)
		DoRadio(ply, 3, 5)
	end},
	
	[6] = {text = "Let's wait here", num = 6, chatfunc = function(ply)
		DoRadio(ply, 3, 6)
	end},
	
	[7] = {text = "I'm coming", num = 7, chatfunc = function(ply)
		DoRadio(ply, 3, 7)
	end}}
	
-- Emote

WTChoices[4] = {
	[1] = {text = "Startled", num = 1, chatfunc = function(ply)
		DoRadio(ply, 4, 1)
	end},
	
	[2] = {text = "Scared", num = 2, chatfunc = function(ply)
		DoRadio(ply, 4, 2)
	end},
	
	[3] = {text = "Jeers", num = 3, chatfunc = function(ply)
		DoRadio(ply, 4, 3)
	end},
	
	[4] = {text = "Cheers", num = 4, chatfunc = function(ply)
		DoRadio(ply, 4, 4)
	end},
	
	[5] = {text = "Good shot", num = 5, chatfunc = function(ply)
		DoRadio(ply, 4, 5)
	end},
	
	[6] = {text = "Compliment", num = 6, chatfunc = function(ply)
		DoRadio(ply, 4, 6)
	end},
	
	[7] = {text = "Taunt", num = 7, chatfunc = function(ply)
		DoRadio(ply, 4, 7)
	end}}

WTSounds = {}

WTSounds[1] = {
	[1] = {
		[1] = {text = "Help!", sound = "bot/help.wav"},
		[2] = {text = "I could use some help!", sound = "bot/i_could_use_some_help.wav"},
		[3] = {text = "I could use some help over here!", sound = "bot/i_could_use_some_help_over_here.wav"},
		[4] = {text = "Need help!", sound = "bot/need_help.wav"},
		[5] = {text = "Need help!", sound = "bot/need_help2.wav"},
		[6] = {text = "I'm in trouble!", sound = "bot/im_in_trouble.wav"},
		[7] = {text = "They got me pinned down here!", sound = "bot/they_got_me_pinned_down_here.wav"}},
	
	[2] = {
		[1] = {text = "Cover me.", sound = "bot/cover_me.wav"},
		[2] = {text = "Cover me.", sound = "bot/cover_me2.wav"}},
		
	[3] = {
		[1] = {text = "Follow me.", sound = "radio/followme.wav"}},
	
	[4] = {
		[1] = {text = "Hold your fire!", sound = "bot/hold_your_fire.wav"},
		[2] = {text = "Ow, it's me!", sound = "bot/ow_its_me.wav"},
		[3] = {text = "Cut it out!", sound = "bot/cut_it_out.wav"},
		[4] = {text = "Ow, I'm on your side!", sound = "bot/im_on_your_side.wav"},
		[5] = {text = "Stop it!", sound = "bot/stop_it.wav"}},
		
	[5] = {
		[1] = {text = "I see our target.", sound = "bot/i_see_our_target.wav"},
		[2] = {text = "Spotted the delivery boy.", sound = "bot/spotted_the_delivery_boy.wav"},
		[3] = {text = "Target acquired.", sound = "bot/target_acquired.wav"},
		[4] = {text = "Target spotted.", sound = "bot/target_spotted.wav"}},
	
	[6] = {
		[1] = {text = "I hear something.", sound = "bot/i_hear_something.wav"},
		[2] = {text = "Hang on, I heard something.", sound = "bot/hang_on_i_heard_something.wav"},
		[3] = {text = "I heard something over there.", sound = "bot/i_heard_something_over_there.wav"}},
		
	[7] = {
		[1] = {text = "Report in, team.", sound = "bot/report_in_team.wav"}},
		
	[8] = {
		[1] = {text = "Reporting in.", sound = "bot/reporting_in.wav"}}
	}
	
WTSounds[2] = {
	[1] = {
		[1] = {text = "Attacking.", sound = "bot/attacking.wav"},
		[2] = {text = "Attacking enemies.", sound = "bot/attacking_enemies.wav"},
		[3] = {text = "Engaging enemies.", sound = "bot/engaging_enemies.wav"}},
		
	[2] = {
		[1] = {text = "Enemy down.", sound = "bot/enemy_down.wav"},
		[2] = {text = "Enemy down.", sound = "bot/enemy_down2.wav"},
		[3] = {text = "Got him.", sound = "bot/got_him.wav"},
		[4] = {text = "He's dead.", sound = "bot/hes_dead.wav"},
		[5] = {text = "He's down.", sound = "bot/hes_down.wav"},
		[6] = {text = "He's done.", sound = "bot/hes_done.wav"},
		[7] = {text = "He's broken.", sound = "bot/hes_broken.wav"},
		[8] = {text = "Ruined his day.", sound = "bot/ruined_his_day.wav"},
		[9] = {text = "Made him cry.", sound = "bot/made_him_cry.wav"},
		[10] = {text = "Dropped him.", sound = "bot/dropped_him.wav"},
		[11] = {text = "Neutralized.", sound = "bot/neutralized.wav"},
		[12] = {text = "Took him down.", sound = "bot/took_him_down.wav"},
		[13] = {text = "Took him out.", sound = "bot/took_him_out.wav"},
		[14] = {text = "Took him out.", sound = "bot/took_him_out2.wav"},
		[15] = {text = "Wasted him.", sound = "bot/wasted_him.wav"},
		[16] = {text = "Killed him.", sound = "bot/killed_him.wav"}},
	
	[3] = {
		[1] = {text = "Clear.", sound = "bot/clear.wav"},
		[2] = {text = "Clear.", sound = "bot/clear2.wav"},
		[3] = {text = "Clear.", sound = "bot/clear3.wav"},
		[4] = {text = "Uhhh, clear.", sound = "bot/clear4.wav"},
		[5] = {text = "All clear here.", sound = "bot/all_clear_here.wav"},
		[6] = {text = "All quiet.", sound = "bot/all_quiet.wav"},
		[7] = {text = "Nothing happening over here.", sound = "bot/nothing_happening_over_here.wav"},
		[8] = {text = "Nothing moving over here.", sound = "bot/nothing_moving_over_here.wav"},
		[9] = {text = "Nothing here.", sound = "bot/nothing_here.wav"},
		[10] = {text = "Area clear.", sound = "bot/area_clear.wav"},
		[11] = {text = "Area secure.", sound = "bot/area_secure.wav"},
		[12] = {text = "There's nobody home.", sound = "bot/theres_nobody_home.wav"}},
		
	[4] = {
		[1] = {text = "He got away.", sound = "bot/he_got_away.wav"},
		[2] = {text = "He got away.", sound = "bot/he_got_away2.wav"},
		[3] = {text = "I lost him!", sound = "bot/i_lost_him.wav"},
		[4] = {text = "I don't know where he went!", sound = "bot/i_dont_know_where_he_went.wav"}},
		
	[5] = {
		[1] = {text = "In combat.", sound = "bot/in_combat.wav"},
		[2] = {text = "In combat.", sound = "bot/in_combat2.wav"},
		[3] = {text = "Returning fire.", sound = "bot/returning_fire.wav"}}
	}
	
WTSounds[3] = {
	[1] = {
		[1] = {text = "Affirmative.", sound = "bot/affirmative.wav"},
		[2] = {text = "Roger.", sound = "bot/roger.wav"},
		[3] = {text = "Roger that.", sound = "bot/roger_that.wav"}},
		
	[2] = {
		[1] = {text = "Alright.", sound = "bot/alright.wav"},
		[2] = {text = "Alright.", sound = "bot/alright2.wav"},
		[3] = {text = "Yeah, okay.", sound = "bot/yea_ok.wav"},
		[4] = {text = "Okay.", sound = "bot/ok.wav"},
		[5] = {text = "Okay.", sound = "bot/ok2.wav"}},
	
	[3] = {
		[1] = {text = "Uhhh, negative.", sound = "bot/ahh_negative.wav"},
		[2] = {text = "Negative.", sound = "bot/negative.wav"},
		[3] = {text = "Negative.", sound = "bot/negative2.wav"}},
		
	[4] = {
		[1] = {text = "Nah.", sound = "bot/naa.wav"},
		[2] = {text = "No.", sound = "bot/no.wav"},
		[3] = {text = "No.", sound = "bot/no2.wav"},
		[4] = {text = "No thanks.", sound = "bot/no_thanks.wav"}},
		
	[5] = {
		[1] = {text = "I got your back.", sound = "bot/i_got_your_back.wav"},
		[2] = {text = "I got your back.", sound = "bot/i_got_your_back2.wav"},
		[3] = {text = "I'll come with you.", sound = "bot/ill_come_with_you.wav"},
		[4] = {text = "I'll go too.", sound = "bot/ill_go_too.wav"},
		[5] = {text = "I'll go with you.", sound = "bot/ill_go_with_you.wav"},
		[6] = {text = "You heard the man, let's go.", sound = "bot/you_heard_the_man_lets_go.wav"},
		[7] = {text = "Lead on, sir.", sound = "bot/lead_on_sir.wav"},
		[8] = {text = "Lead the way.", sound = "bot/lead_the_way.wav"},
		[9] = {text = "Lead the way, sir.", sound = "bot/lead_the_way_sir.wav"}},
		
	[6] = {
		[1] = {text = "Let's wait here.", sound = "bot/lets_wait_here.wav"},
		[2] = {text = "I'm waiting here.", sound = "bot/im_waiting_here.wav"},
		[3] = {text = "I'm gonna wait here.", sound = "bot/im_going_to_wait_here.wav"}},
		
	[7] = {
		[1] = {text = "Hang on, I'm coming.", sound = "bot/hang_on_im_coming.wav"},
		[2] = {text = "I'm coming.", sound = "bot/im_coming.wav"},
		[3] = {text = "On my way.", sound = "bot/on_my_way.wav"},
		[4] = {text = "On my way.", sound = "bot/on_my_way2.wav"}}
	}

WTSounds[4] = {
	[1] = {
		[1] = {text = "Aah!", sound = "bot/aah.wav"},
		[2] = {text = "Oh!", sound = "bot/oh.wav"},
		[3] = {text = "Whoa!", sound = "bot/whoa.wav"}},
		
	[2] = {
		[1] = {text = "Oh boy!", sound = "bot/oh_boy.wav"},
		[2] = {text = "Oooh boy!", sound = "bot/oh_boy2.wav"},
		[3] = {text = "Oh no!", sound = "bot/oh_no.wav"},
		[4] = {text = "Uh oh!", sound = "bot/uh_oh.wav"},
		[5] = {text = "Yikes!", sound = "bot/yikes.wav"}},
		
	[3] = {
		[1] = {text = "Oh my god!", sound = "bot/oh_my_god.wav"},
		[2] = {text = "Oh no!", sound = "bot/oh_no_sad.wav"},
		[3] = {text = "Oh man.", sound = "bot/oh_man.wav"},
		[4] = {text = "Aw, hell.", sound = "bot/aw_hell.wav"},
		[5] = {text = "Aww, man.", sound = "bot/aww_man.wav"},
		[6] = {text = "That's not good!", sound = "bot/thats_not_good.wav"}},

	[4] = {
		[1] = {text = "Woo!", sound = "bot/whoo.wav"},
		[2] = {text = "Woo!", sound = "bot/whoo2.wav"},
		[3] = {text = "Yeah, baby!", sound = "bot/yea_baby.wav"},
		[4] = {text = "Yess!", sound = "bot/yesss.wav"},
		[5] = {text = "Yess!", sound = "bot/yesss2.wav"},
		[6] = {text = "It's a party!", sound = "bot/its_a_party.wav"},
		[7] = {text = "Oh yeah!!", sound = "bot/oh_yea.wav"},
		[8] = {text = "Oh yeah.", sound = "bot/oh_yea2.wav"}},
		
	[5] = {
		[1] = {text = "Good shot.", sound = "bot/good_shot.wav"},
		[2] = {text = "Good shot.", sound = "bot/good_shot2.wav"}},
		
	[6] = {
		[1] = {text = "Very nice.", sound = "bot/very_nice.wav"},
		[2] = {text = "Well done.", sound = "bot/well_done.wav"},
		[3] = {text = "Nice.", sound = "bot/nice.wav"},
		[4] = {text = "Nice.", sound = "bot/nice2.wav"}},
		
	[7] = {
		[1] = {text = "And that's how it's done!", sound = "bot/and_thats_how_its_done.wav"},
		[2] = {text = "I am dangerous!", sound = "bot/i_am_dangerous.wav"},
		[3] = {text = "I am on fire!", sound = "bot/i_am_on_fire.wav"},
		[4] = {text = "I wasn't worried for a minute.", sound = "bot/i_wasnt_worried_for_a_minute.wav"},
		[5] = {text = "Look out!", sound = "bot/look_out_brag.wav"},
		[6] = {text = "That's right!", sound = "bot/thats_right.wav"},
		[7] = {text = "That's the way this is done!", sound = "bot/thats_the_way_this_is_done.wav"},
		[8] = {text = "They never knew what hit them.", sound = "bot/they_never_knew_what_hit_them.wav"},
		[9] = {text = "This is my house!", sound = "bot/this_is_my_house.wav"},
		[10] = {text = "Who's the man?!", sound = "bot/whos_the_man.wav"},
		[11] = {text = "Do not mess with me!", sound = "bot/do_not_mess_with_me.wav"},
		[12] = {text = "Who wants some more?!", sound = "bot/who_wants_some_more.wav"}}
	}
	
if CLIENT then
	local a, b, c, tbl, ply, nm, lp
	
	local function DEC_ReceiveRadio(um)
		a = um:ReadShort()
		b = um:ReadShort()
		c = um:ReadShort()
		ply = um:ReadEntity()
		lp = LocalPlayer()
		
		ply.RadioAlpha = 255
		ply.RadioAlphaTime = CurTime() + 1
		
		nm = "Unknown person"
		
		if ply == lp or lp:IsAdmin() or lp:IsSuperAdmin() then
			nm = ply:Nick()
		else
			if ply.Status and ply.Status != 0 then
				nm = ply:Nick()
			end
		end
		
		tbl = WTSounds[a][b][c]
		chat.AddText(ColorNeon, "(RADIO) [", ColorLightGreen, a .. "-" .. b .. "-" .. c, ColorNeon, "] ", ColorWhite, nm .. ": " .. tbl.text)
		surface.PlaySound(tbl.sound)
	end
	
	usermessage.Hook("RADIO", DEC_ReceiveRadio)
end
