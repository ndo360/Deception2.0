local SpawnIcon2 = {}
local matHover = Material( "vgui/spawnmenu/hover" )
local ply, itm, MainFrame, icon

function SpawnIcon2:Init()
end

function SpawnIcon2:SetToolTip()
	return false
end

function SpawnIcon2:Paint()
	ply = LocalPlayer()

	if not self.Retrieved then
		if self.ItemText then
			DisableClipping(true)
			draw.SimpleText(self.ItemText, "TabLarge", 50, 20, Color(255, 255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			DisableClipping(false)
		end
	end
end

function SpawnIcon2:PaintOver()
	if not self.Retrieved then
		if self.MouseOver then
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( matHover )
			self:DrawTexturedRect()
		end
	else
		DisableClipping(true)
		draw.RoundedBox(4, 0, 0, 230, 40, Color(0, 0, 0, 150))
		draw.SimpleText("RETRIEVED", "Trebuchet24_AA", 115, 20, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		DisableClipping(false)
	end
end

function SpawnIcon2:OnCursorEntered()
	self.MouseOver = true
end

function SpawnIcon2:OnCursorExited()
	self.MouseOver = false
end

function SpawnIcon2:OnMousePressed(enum)
	if self.Retrieved then	
		return
	end
	
	//self.animPress:Start( 0.2 ) // FIXME
	
	local ply = LocalPlayer()
	
	if enum == 107 then
		ply:ConCommand("dec_retrievemail " .. self.Slot)
	end
end

vgui.Register("SpawnIcon2", SpawnIcon2, "SpawnIcon")

local function DEC_Mail()
	if not RoundTime or RoundTime == -1 then
		return
	end
	
	ply = LocalPlayer()

	MainFrame = vgui.Create("DFrame2")
	MainFrame:SetSize(250, 30 + #ply.Mail * 50)
	MainFrame:Center()
	MainFrame:SetTitle("Mail menu.")
	MainFrame:SetVisible(true)
	MainFrame:SetDraggable(false)
	MainFrame:ShowCloseButton(true)
	MainFrame:MakePopup()
	
	for k, v in pairs(ply.Mail) do
		itm = Items[v.itemnum]
		icon = vgui.Create("SpawnIcon2", MainFrame)
		icon:SetModel(itm.Model)
		icon:SetPos(10, 30 + (k - 1) * 50)
		icon:SetSize(40, 40)
		icon.Slot = k
		icon.ItemNum = itm.num
		icon.ItemText = itm.Name
		
		ply.Mail[k].refer = icon
	end
	
	MailFrame = MainFrame
end

concommand.Add("dec_mail", DEC_Mail)