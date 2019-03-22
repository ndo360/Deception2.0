if CLIENT then
    SWEP.PrintName = "Ballistics Analyzer"
    SWEP.Slot = 3
    SWEP.SlotPos = 3
    SWEP.DrawAmmo = false
    SWEP.DrawCrosshair = false
	SWEP.BounceWeaponIcon = false
end

if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.IsCustomWeapon = true
	SWEP.Unique = true
end

SWEP.Author            = "Spy"
SWEP.Instructions    = "Look at a dead body and press your RELOAD KEY to analyze it.\nUse your PRIMARY and SECONDARY attack keys to go through entries"
SWEP.Contact        = ""
SWEP.Purpose        = ""

SWEP.ViewModelFOV    = 70
SWEP.ViewModelFlip    = false

SWEP.Spawnable            = true
SWEP.AdminSpawnable        = true


SWEP.ViewModel      = "models/weapons/v_c4.mdl"
SWEP.WorldModel   = "models/weapons/w_c4.mdl"
  
-- Primary Fire Attributes --
SWEP.Primary.Recoil            = 0
SWEP.Primary.Damage            = 0
SWEP.Primary.NumShots        = 1
SWEP.Primary.Cone            = 0
SWEP.Primary.ClipSize        = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic       = false    
SWEP.Primary.Ammo             = "none"
 
-- Secondary Fire Attributes --
SWEP.Secondary.Recoil        = 0
SWEP.Secondary.Damage        = 0
SWEP.Secondary.NumShots        = 1
SWEP.Secondary.Cone            = 0
SWEP.Secondary.ClipSize        = -1
SWEP.Secondary.DefaultClip    = -1
SWEP.Secondary.Automatic       = false
SWEP.Secondary.Ammo         = "none"

SWEP.HoldType = "slam"

SWEP.Size = 1
SWEP.CantHolster = true
SWEP.ScreenTurnOn = 0
SWEP.ScreenAlpha = 0
SWEP.CurEntry = 1
SWEP.AnalyzeTime = 0

local CT, pos, ang, vm, att, td, trace

function SWEP:Initialize()
    self:SetWeaponHoldType("slam")
end

function SWEP:Precache()
end

function SWEP:Deploy()
	CT = CurTime()
	self.Owner:GetViewModel():SetModel(self.ViewModel)
	self:SendWeaponAnim(ACT_VM_DEPLOY)
	self.ReloadDelay = CT + 0.8
	self:SetNextPrimaryFire(CT + 0.8)
	
    return true
end

function SWEP:Holster()
    return true
end

local found, prog, fp, er

function SWEP:Reload()
	if SERVER then
		CT = CurTime()
		
		if CT < self.AnalyzeTime then
			return
		end
		
		td = {}
		td.start = self.Owner:GetShootPos()
		td.endpos = td.start + self.Owner:GetAimVector() * 75
		td.filter = self.Owner
		
		trace = util.TraceLine(td)
		
		if trace.Hit then
			if trace.Entity:GetClass() == "prop_ragdoll" then
				if trace.Entity.FingerPrint then
					if not trace.Entity.Analyzers[self.Owner] then
						found = false
						
						er = self.Owner.FingerPrints
						
						for k, v in pairs(er) do
							if trace.Entity.FingerPrint == v.fingerprint then
								v.progress = math.Clamp(v.progress + 34, 0, 100)
								prog = v.progress
								fp = trace.Entity.FingerPrint
								found = true
								
								break
							end
						end
						
						if not found then
							er[#er + 1] = {fingerprint = trace.Entity.FingerPrint, progress = 33}
							fp = trace.Entity.FingerPrint
							prog = 33
						end
						
						umsg.Start("BA_RECEIVEENTRY", self.Owner)
							umsg.Short(prog)
							umsg.Short(fp)
						umsg.End()
						
						trace.Entity.Analyzers[self.Owner] = true
					end
				else
					SendUserMessage("BA_NOFINGER", self.Owner)
				end
			elseif trace.Entity:IsPlayer() then
				er = self.Owner.FingerPrints
				
				for k, v in pairs(er) do
					if trace.Entity.FingerPrint == v.fingerprint then
						if v.progress == 100 then
							umsg.Start("BA_RECEIVEKILLER", self.Owner)
								umsg.Short(v.fingerprint)
								umsg.Entity(trace.Entity)
							umsg.End()
							
							break
						else
							SendUserMessage("BA_NOMATCH", self.Owner)
							
							break
						end
					end
				end
			end
		end
		
		self.AnalyzeTime = CT + 0.5
	end
end

if CLIENT then
	local Clr = Color(255, 0, 0, 0)
	local wep, ply, tbl, tbl2
	
	function SWEP:ViewModelDrawn()
		vm = self.Owner:GetViewModel()
		pos, ang = vm:GetBonePosition(vm:LookupBone("v_weapon.c4"))
		ang:RotateAroundAxis(ang:Right(), 180)
		ang:RotateAroundAxis(ang:Forward(), -90)
		tbl = self.Owner.FingerPrints
		
		cam.Start3D2D(pos + ang:Up() * 2.7 + ang:Forward() * 1.9 + ang:Right() * 0.1, ang, 0.004)
			if not tbl or #tbl == 0 then
				draw.SimpleText("No entries found", "Trebuchet64_AA", 330, -300, Color(50, 150, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			else
				tbl2 = tbl[self.CurEntry]
				
				draw.SimpleText("Fingerprint entry: " .. self.CurEntry .. "/" .. #tbl, "Trebuchet64_AA", 330, -300, Color(50, 150, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				
				Clr = Color(255, 0, 0, 255)
				
				tbl2.progressbar = math.Approach(tbl2.progressbar, tbl2.progress, 2)
				
				if tbl2.progressbar != 100 then
					draw.RoundedBox(8, 425, -160, 200, 60, Color(100, 100, 100, 255))
					draw.RoundedBox(8, 428, -157, 194, 54, Color(50, 50, 50, 255))
					
					if tbl2.progressbar > 1 then
						draw.RoundedBox(8, 428, -157, tbl2.progressbar * 1.94, 54, Color(100, 200, 100, 255))
					end
					
					draw.SimpleText("Fingerprint analysis:", "Trebuchet56_AA", 0, -160, Color(255, 0, 0, 255))
					draw.SimpleText(tbl2.progressbar .. "%", "Trebuchet56_AA", 525, -130, Color(255, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText("Killer fingerprint: #" .. tbl2.fingerprint, "Trebuchet56_AA", 0, -160, Clr)
				end
				
				if IsValid(tbl2.killer) then
					Killer = tbl2.killer:Nick()
					
					if Killer and #Killer >= 20 then
						Killer = string.Left(Killer, 20) .. "..."
					end
					
					Clr = Color(50, 255, 100, 255)
				else
					Killer = "Unknown"
				end
					
				draw.SimpleText("Victims: " .. tbl2.victims, "Trebuchet56_AA", 0, -220, Clr)
				draw.SimpleText("Killer: " .. Killer, "Trebuchet56_AA", 0, -100, Clr)
			end
			
			draw.RoundedBox(6, 0, -250, 685, 20, Color(50, 150, 255, 255))
		cam.End3D2D()
	end
	
	function SWEP:DrawHUD()
		draw.ShadowedText("RELOAD KEY - Analyze body/player for fingerprints", "Trebuchet24_AA", ScrW() * 0.5, ScrH() - 80, Color(255, 255, 255, 255), Color(0, 0, 0, 255), 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	
	function SWEP:GetViewModelPosition(pos, ang)
		ang:RotateAroundAxis(ang:Right(), 25.636)
		ang:RotateAroundAxis(ang:Up(), 3.244)
		ang:RotateAroundAxis(ang:Forward(), -3.256)
		
		pos = pos + 0.36 * ang:Right()
		pos = pos + -7.645 * ang:Forward()
		pos = pos + -1.981 * ang:Up()
		
		return pos, ang
	end
end

function SWEP:PrimaryAttack()
	if CLIENT then
		if self.Owner.FingerPrints and #self.Owner.FingerPrints > 1 then
			if self.Owner.FingerPrints[self.CurEntry + 1] then
				self.CurEntry = self.CurEntry + 1
			else
				self.CurEntry = 1
			end
			
			surface.PlaySound("buttons/button16.wav")
		end
	end
end

function SWEP:SecondaryAttack()
	if CLIENT then
		if self.Owner.FingerPrints and #self.Owner.FingerPrints > 1 then
			if self.Owner.FingerPrints[self.CurEntry - 1] then
				self.CurEntry = self.CurEntry - 1
			else
				self.CurEntry = #self.Owner.FingerPrints
			end
			
			surface.PlaySound("buttons/button16.wav")
		end
	end
end