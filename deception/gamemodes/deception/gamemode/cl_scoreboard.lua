local clr, rect, orect, rbox, stext = surface.SetDrawColor, surface.DrawRect, surface.DrawOutlinedRect, draw.RoundedBox, draw.ShadowedText
local lp, X, Y, X2, Y2, ply, scale1, scale2, state, statecolor, dtint1, ktext, kcolor, FT, slot

function GM:RetrievePlayers() -- I was going to use a kill counter and sort people on the scoreboard by the amount of kills/deaths they had, but then I figured that it would give away people easily
	ply = player.GetAll()
	FT = {}
	
	for k, v in pairs(ply) do
		slot = 1
		
		for k2, v2 in pairs(ply) do
			if v != v2 then
				if v:Frags() < v2:Frags() then
					slot = slot + 1
				elseif v:Frags() == v2:Frags() then
					if v:Deaths() > v2:Deaths() then
						slot = slot + 1
					elseif v:Name() > v2:Name() then
						slot = slot + 1
					end
				end
			end
		end
		
		table.insert(FT, slot, v)
	end
	
	return FT
end

function GM:ScoreboardShow()
	GAMEMODE.ShowScoreboard = true
end

function GM:ScoreboardHide()
	GAMEMODE.ShowScoreboard = false
end

function GM:HUDDrawScoreBoard()
	if not GAMEMODE.ShowScoreboard then
		return
	end
	
	lp = LocalPlayer()	
	X = ScrW()
	Y = ScrH()
	
	X2 = X * 0.5
	Y2 = Y * 0.5
	ply = player.GetAll()
	
	scale1 = #ply * 15
	scale2 = ((#ply * 15) - 15)
	
	clr(137, 165, 126, 255)
	orect(X2 - 300, Y2 - 50 - scale1, 600, 100 + #ply * 30)
	
	clr(40, 80, 40, 100)
	rect(X2 - 299, Y2 - 49 - scale1, 598, 98 + #ply * 30)
	
	rbox(6, X2 - 298, Y2 - 48 - scale1, 596, 30, Color(40, 40, 40, 125))
	stext("'Deception' ver. " .. Ver .. " by Spy and trotskygrad (Ported by polivilas, Geferon, and Ndo360) ", "TabLarge", X2, Y2 - 34 - scale1, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
	clr(137, 165, 126, 255)
	orect(X2 - 275, Y2 - scale1, 550, 32 + #ply * 30)
	
	rbox(6, X2 - 273, Y2 + 1 - scale1, 300, 22, Color(40, 40, 40, 200))
	stext("Player (" .. #ply .. " " .. (#ply > 1 and "players" or "player") .. ")", "TabLarge", X2 - 265, Y2 + 12 - scale1, Color(255, 255, 255, 255), Color(0, 0, 0, 0), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	rbox(6, X2 + 30, Y2 + 1 - scale1, 80, 22, Color(40, 40, 40, 200))
	stext("Status", "TabLarge", X2 + 70, Y2 + 12 - scale1, Color(255, 255, 255, 255), Color(0, 0, 0, 0), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
	rbox(6, X2 + 113, Y2 + 1 - scale1, 60, 22, Color(40, 40, 40, 200))
	stext("Ping", "TabLarge", X2 + 142 , Y2 + 12 - scale1, Color(255, 255, 255, 255), Color(0, 0, 0, 0), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
	rbox(6, X2 + 175, Y2 + 1 - scale1, 98, 22, Color(40, 40, 40, 200))
	stext("Karma", "TabLarge", X2 + 223, Y2 + 12 - scale1, Color(255, 255, 255, 255), Color(0, 0, 0, 0), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	
	for k, v in pairs(ply) do
		rbox(6, X2 - 273, Y2 + 25 + ((k - 1) * 30) - scale2, 300, 20, Color(40, 40, 40, 150))
		stext(v:Nick(), "TabLarge", X2 - 265, Y2 + 35 + ((k - 1) * 30) - scale2, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		
		rbox(6, X2 + 30, Y2 + 25 + ((k - 1) * 30) - scale2, 80, 20, Color(40, 40, 40, 150))
		
		state = "Unknown"
		statecolor = Color(200, 200, 200, 255)
		
		if v == lp then
			state = "---"
			statecolor = Color(0, 150, 255, 255)
		else
			if v.Status == 1 then
				state = "Unarmed"
				statecolor = Color(0, 150, 255, 255)
			elseif v.Status == 2 then
				state = "Suspicious"
				statecolor = Color(255, 150, 0, 255)
			elseif v.Status == 3 then
				state = "Armed"
				statecolor = Color(255, 0, 0, 255)
			end
				
			if v.AddStatus == 1 then
				state = "VIP"
				
				if lp.TeamText != "Agent" then
					statecolor = Color(0, 150, 255, 255)
				else
					statecolor = Color(255, 0, 0, 255)
				end
			elseif v.AddStatus == 2 then
				state = "Not VIP"
				
				if v.Status == 2 then
					statecolor = Color(255, 150, 0, 255)
				elseif v.Status == 3 then
					statecolor = Color(255, 0, 0, 255)
				else
					statecolor = Color(0, 150, 255, 255)
				end
			elseif v.AddStatus == 3 then
				state = "Agent"
				statecolor = Color(255, 0, 0, 255)
			elseif v.AddStatus == 4 then
				state = "Impostor (?)"
				statecolor = Color(255, 150, 0, 255)
			elseif v.AddStatus == 5 then
				state = "Dead"
				statecolor = Color(255, 0, 0, 255)
			end
		end
		
		stext(state, "TabLarge", X2 + 70, Y2 + 35 + ((k - 1) * 30) - scale2, statecolor, Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		
		rbox(6, X2 + 113, Y2 + 25 + ((k - 1) * 30) - scale2, 60, 20, Color(40, 40, 40, 150))
		stext(v:Ping(), "TabLarge", X2 + 142, Y2 + 35 + ((k - 1) * 30) - scale2, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		
		dtint1 = v:GetDTInt(1)
		
		rbox(6, X2 + 175, Y2 + 25 + ((k - 1) * 30) - scale2, 98, 20, Color(40, 40, 40, 150))
		
		if dtint1 < 100 then
			stext(dtint1 .. "%", "TabLarge", X2 + 223, Y2 + 35 + ((k - 1) * 30) - scale2, Color(255, 255 - (100 - dtint1) * 2.5, 255 - (100 - dtint1) * 2.5, 255), Color(0, 0, 0, 0), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			stext(dtint1 .. "%", "TabLarge", X2 + 223, Y2 + 35 + ((k - 1) * 30) - scale2, Color(255 - (dtint1 - 100) * 2.5, 255, 255 - (dtint1 - 100) * 2.5, 255), Color(0, 0, 0, 0), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
end
