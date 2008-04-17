﻿
local MountMe = MountMe
if not MountMe then return end


local GAP = 8
local tekcheck = LibStub("tekKonfig-Checkbox")


local frame = CreateFrame("Frame", nil, UIParent)
frame.name = "MountMe"
frame:Hide()
frame:SetScript("OnShow", function()
	local title, subtitle = LibStub("tekKonfig-Heading").new(frame, "MountMe", "These settings allow you to choose when to swap mount speed equipment.")

	local pvpswap = tekcheck.new(frame, nil, "Swap when PvP flagged", "TOPLEFT", subtitle, "BOTTOMLEFT", -2, -GAP)
	pvpswap.tiptext = "Enable equipment swapping when PvP flagged."
	pvpswap:SetChecked(not MountMe.db.PvPsuspend)

	local bgswap, bgswaplabel = tekcheck.new(frame, nil, "Swap in Battlegrounds", "TOPLEFT", pvpswap, "BOTTOMLEFT", GAP*2, -GAP)
	bgswap.tiptext = "Enable equipment swapping when in a battleground."
	bgswap:SetChecked(not MountMe.db.BGsuspend)
	if MountMe.db.PvPsuspend then
		bgswap:Disable()
		bgswaplabel:SetFontObject(GameFontDisable)
	else
		bgswap:Enable()
		bgswaplabel:SetFontObject(GameFontHighlight)
	end

	local checksound = pvpswap:GetScript("OnClick")
	pvpswap:SetScript("OnClick", function(self)
		checksound(self)
		MountMe.db.PvPsuspend = not MountMe.db.PvPsuspend
		if MountMe.db.PvPsuspend then
			bgswap:Disable()
			bgswaplabel:SetFontObject(GameFontDisable)
		else
			bgswap:Enable()
			bgswaplabel:SetFontObject(GameFontHighlight)
		end
	end)
	bgswap:SetScript("OnClick", function(self) checksound(self); MountMe.db.BGsuspend = not MountMe.db.BGsuspend end)

	frame:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(frame)


LibStub("tekKonfig-AboutPanel").new("MountMe", "MountMe")


