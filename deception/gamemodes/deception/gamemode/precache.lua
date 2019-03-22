local psound, pmodel = util.PrecacheSound, util.PrecacheModel

-- various sound effects

psound("sound/deception/death1.mp3")
psound("sound/deception/death2.mp3")
psound("sound/deception/hbeat.wav")
psound("sound/deception/st_2_2.mp3")

for i = 1, 6 do
	psound("sound/deception/instruc" .. i .. ".mp3")
end

-- player models

for i = 1, 9 do
	pmodel("models/player/Group01/Male_0" .. i .. ".mdl")
end

pmodel("models/player/Hostage/Hostage_01.mdl")
pmodel("models/player/Hostage/Hostage_02.mdl")
pmodel("models/player/Hostage/hostage_03.mdl")
pmodel("models/player/Hostage/hostage_04.mdl")

-- view models

pmodel("models/weapons/v_pist_deagle.mdl")
pmodel("models/weapons/v_pist_fiveseven.mdl")
pmodel("models/weapons/v_pist_glock18.mdl")
pmodel("models/weapons/v_pist_p228.mdl")
pmodel("models/weapons/v_smg_mac10.mdl")
pmodel("models/weapons/v_smg_mp5.mdl")
pmodel("models/weapons/v_smg_p90.mdl")
pmodel("models/weapons/v_smg_tmp.mdl")
pmodel("models/weapons/v_smg_ump45.mdl")
pmodel("models/weapons/v_knife_t.mdl")

-- world models

pmodel("models/weapons/w_pist_deagle.mdl")
pmodel("models/weapons/w_pist_fiveseven.mdl")
pmodel("models/weapons/w_pist_glock18.mdl")
pmodel("models/weapons/w_pist_p228.mdl")
pmodel("models/weapons/w_smg_mac10.mdl")
pmodel("models/weapons/w_smg_mp5.mdl")
pmodel("models/weapons/w_smg_p90.mdl")
pmodel("models/weapons/w_smg_tmp.mdl")
pmodel("models/weapons/w_smg_ump45.mdl")
pmodel("models/weapons/w_knife_t.mdl")