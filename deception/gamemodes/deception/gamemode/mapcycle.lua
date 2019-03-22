local Map, vote

function GM:SetupMaps()
	Maps = file.Read("cfg/mapcycle.txt", "GAME") -- read that file nigga
	Maps = string.Explode("\n", Maps) -- separate map names

	for k, v in pairs(Maps) do
		if (not v:find("_")) or string.StartWith(v, "//") then -- remove entries that we suppose aren't maps
			Maps[k] = nil;
		end
	end

	table.Sanitise(Maps)
end

function GM:SelectRandomMaps(amt)
	self:SetupMaps()

	-- MapsToSend = nil
	MapsToSend = {}

	-- for i = 1, amt do
	-- 	if #Maps > 0 then
	-- 		if not MapsToSend then -- if we haven't set up the base maps to send string
	-- 			map = math.random(1, #Maps)
	-- 			MapsToSend = Maps[map] -- then just make it a map name
	-- 			table.remove(Maps, map)
	-- 		else -- otherwise
	-- 			map = math.random(1, #Maps)
	-- 			MapsToSend = MapsToSend .. " " .. Maps[map] -- keep the map name, create a space and add another map name to the end of the string
	-- 			table.remove(Maps, map)
	-- 		end
	-- 	end
	-- end

	while (#MapsToSend < amt and #Maps > (#MapsToSend - #Maps)) do
		local map, key = table.Random(Maps)
		table.insert(MapsToSend, map)
		table.remove(Maps, key)
	end

	net.Start("MAPSTOVOTEFOR_NET")
		net.WriteTable(MapsToSend)
	net.Broadcast()

	-- umsg.Start("MAPSTOVOTEFOR")
	-- 	umsg.String(MapsToSend)
	-- umsg.End()

	-- MapsToSend = string.Explode(" ", MapsToSend)

	for k, v in pairs(MapsToSend) do
		MapsToSend[k] = {map = v, votes = 0}
	end

	timer.Simple(30, function()
		self:SelectNextMap()
	end)
end

function GM:SelectNextMap()
	Map = {map = "", votes = 0}

	for k, v in pairs(MapsToSend) do
		if v.votes > Map.votes then
			Map = {map = v.map, votes = v.votes}
		end
	end

	if Map.map == "" then
		Map.map = MapsToSend[1].map
	end

	game.ConsoleCommand("changelevel " .. Map.map .. "\n")
end

function DEC_ReceiveMapVote(ply, com, args)
	if not VoteStarted then
		return
	end

	if ply.Voted then
		return
	end

	vote = args[1]

	if not vote then -- u try to voet NILU? DING DONG RETURNU
		return
	end

	vote = tonumber(vote)

	if not MapsToSend[vote] then -- u try to voet for non-existant mapu? DING DONG RETURNU
		return
	end

	MapsToSend[vote].votes = MapsToSend[vote].votes + 1

	umsg.Start("MAPVOTEUPDATE")
		umsg.Short(vote)
	umsg.End()

	ply.Voted = true
end

concommand.Add("dec_votemap", DEC_ReceiveMapVote)
