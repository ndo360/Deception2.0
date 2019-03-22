if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.TakesUpSlot = false
	SWEP.Unique = true
end

if( CLIENT ) then
	SWEP.PrintName = "Knife";
	SWEP.Slot = 3;
	SWEP.SlotPos = 3;
	SWEP.CLMode = 0
end

SWEP.Base = "dec_melee_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ShowWorldModel = true

SWEP.ViewModel = "models/weapons/v_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"

SWEP.SwingDelay = 0.65

SWEP.DamageToEnts1 = 20
SWEP.DamageToEnts2 = 25

SWEP.ForceToEntsSmall = 300
SWEP.ForceToEntsMedium = 125

SWEP.DamageToPlayers1 = 30
SWEP.DamageToPlayers2 = 40

SWEP.Range = 55
SWEP.TimerDelay = 0.1
SWEP.DefenseRating = 25
SWEP.UseHitWorld2 = true
SWEP.HoldType = "knife"
SWEP.InitialHoldType = "knife"
SWEP.ViewModelBonescales = {}

SWEP.Recoil = 2
SWEP.Size = 2
SWEP.CanBackstab = true
SWEP.HideCaliber = true -- disables ammo count and caliber display in the lower right corner
SWEP.CanUnload = false

SWEP.Caliber = "Steel"

SWEP.Swing = {
	Sound("weapons/knife/knife_slash1.wav"),
	Sound("weapons/knife/knife_slash2.wav") }

SWEP.HitWorld = {
	Sound("weapons/knife/knife_hitwall1.wav") }
	
SWEP.HitWorld2 = {
	Sound("physics/concrete/concrete_impact_bullet1.wav"),
	Sound("physics/concrete/concrete_impact_bullet2.wav"),
	Sound("physics/concrete/concrete_impact_bullet3.wav"),
	Sound("physics/concrete/concrete_impact_bullet4.wav") }
	
SWEP.HitMan = {
	Sound("weapons/knife/knife_hit1.wav"),
	Sound("weapons/knife/knife_hit2.wav"),
	Sound("weapons/knife/knife_hit3.wav"),
	Sound("weapons/knife/knife_hit4.wav") }