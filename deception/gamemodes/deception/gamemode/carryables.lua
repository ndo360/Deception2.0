Carryables = {}

function GM:RegisterCarryable(tbl)
	table.insert(Carryables, {num = tbl.num, icon = tbl.icon, keytext = tbl.keytext, key = tbl.key, canusefunc = tbl.canusefunc, usefunc = tbl.usefunc, addfunc = tbl.addfunc})
end

local NC

-- antidote

NC = {}
NC.num = 1
NC.keytext = "[6]"
NC.key = "slot6"
NC.icon = "deception/icons/ic_antidote"

NC.canusefunc = function(ply)
	if not ply.Poisoned then
		return false
	end
	
	return true
end

NC.usefunc = function(ply)
	ply.Poisoned = false
	SendUserMessage("POISONCURE", ply)
end

GM:RegisterCarryable(NC)

-- radio

NC = {}
NC.num = 2
NC.keytext = "[1]"
NC.key = "penis" -- over-rides, since radio is hard-coded into the client
NC.icon = "deception/icons/ic_radio"

NC.canusefunc = function(ply)
	return true
end

NC.usefunc = function(ply)
	return true
end

NC.addfunc = function()
	HasWalkieTalkie = true
end

GM:RegisterCarryable(NC)