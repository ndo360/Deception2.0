Ver = "1.0.7.3"

GM.Name 		= "Deception " .. Ver
GM.Author 		= "Spy"
GM.Email 		= "None"
GM.Website 		= "www.garry.tv"
GM.TeamBased 	= false

function GM:CreateTeams()
	TEAM_PLAYER = 1
	team.SetUp(TEAM_PLAYER, "Player", Color(100, 200, 100))
	team.SetSpawnPoint(TEAM_PLAYER, "info_player_start") -- this doesn't do shit, go look for random position selection in init.lua
	
	team.SetSpawnPoint( TEAM_SPECTATOR, "worldspawn" ) 
end

function GM:PlayerDeathThink()
	return false -- disable respawns
end

MoneyCap = 2000

AmmoLimit = {}
AmmoLimit["pistol"] = 96
AmmoLimit["smg1"] = 120
AmmoLimit["SniperRound"] = 5 -- poison darts
AmmoLimit["AirboatGun"] = 40

for i = 1, 9 do
	util.PrecacheModel("models/player/group01/male_0" .. i .. ".mdl")
end

local rs

function GM:Move(ply, data)
	if SERVER then
		if ply:Alive() then
			if ply:Health() > 20 then
				if not ply:OnGround() and ply:KeyDown(IN_JUMP) then
					if not ply.HasGrabbed then
						ply:AttemptGrab()
					end
				end
			end
			
			if ply:KeyDown(IN_SPEED) then
				rs = ply:GetRunSpeed()
				
				if ply:KeyDown(IN_BACK) then
					data:SetForwardSpeed(rs * -0.7 * ply.DamageSpeedMod)
				elseif ply:KeyDown(IN_FORWARD) then
					data:SetForwardSpeed(rs * ply.DamageSpeedMod)
				end
				
				if ply:KeyDown(IN_MOVERIGHT)  then
					data:SetSideSpeed(rs * 0.8 * ply.DamageSpeedMod)
				elseif ply:KeyDown(IN_MOVELEFT) then
					data:SetSideSpeed(rs * -0.8 * ply.DamageSpeedMod)
				end
			end
		end
	end
end
