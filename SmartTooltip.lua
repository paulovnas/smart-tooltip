-- Get localization table
local L = LibStub("AceLocale-3.0"):GetLocale("SmartTooltip")

-- Default settings
local defaults = {
	offsetX = 15,
	offsetY = 15,
	anchorPoint = "BOTTOMLEFT"
}

-- Available anchor points
local anchorPoints = {
	"TOPLEFT",
	"TOP",
	"TOPRIGHT",
	"LEFT",
	"CENTER",
	"RIGHT",
	"BOTTOMLEFT",
	"BOTTOM",
	"BOTTOMRIGHT"
}

-- Initialize saved variables
SmartTooltipDB = SmartTooltipDB or {}

-- Apply defaults if not set
if SmartTooltipDB.offsetX == nil then
	SmartTooltipDB.offsetX = defaults.offsetX
end
if SmartTooltipDB.offsetY == nil then
	SmartTooltipDB.offsetY = defaults.offsetY
end
if SmartTooltipDB.anchorPoint == nil then
	SmartTooltipDB.anchorPoint = defaults.anchorPoint
end

-- Store category ID for later use
local categoryID = nil

-- Slash command for addon info and config
SLASH_SMARTTOOLTIP1 = "/st"
SLASH_SMARTTOOLTIP2 = "/smarttooltip"
SlashCmdList.SMARTTOOLTIP = function(msg)
	if msg == "config" or msg == "options" then
		if categoryID then
			Settings.OpenToCategory(categoryID)
		else
			print("|cffff0000SmartTooltip:|r " .. L["SETTINGS_NOT_LOADED"])
		end
	else
		print("|cff00ff00SmartTooltip|r " .. L["ADDON_INFO"])
		print(L["ADDON_HELP"])
	end
end

-- Tooltip follows cursor
local function PositionTooltipAtCursor(tooltip)
	local x, y = GetCursorPosition()
	local scale = UIParent:GetEffectiveScale()
	tooltip:ClearAllPoints()
	tooltip:SetPoint(SmartTooltipDB.anchorPoint, UIParent, "BOTTOMLEFT",
		(x / scale) + SmartTooltipDB.offsetX,
		(y / scale) + SmartTooltipDB.offsetY)
end

-- Hook the default anchor function to position at cursor immediately
hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
	if tooltip == GameTooltip then
		PositionTooltipAtCursor(tooltip)
	end
end)

-- Keep tooltip following cursor while visible
GameTooltip:HookScript("OnShow", function(self)
	-- Position immediately as backup (in case GameTooltip_SetDefaultAnchor wasn't called)
	PositionTooltipAtCursor(self)

	-- Then keep following cursor every frame
	self:SetScript("OnUpdate", function(tooltip)
		PositionTooltipAtCursor(tooltip)
	end)
end)

GameTooltip:HookScript("OnHide", function(self)
	self:SetScript("OnUpdate", nil)
end)

-- Function to handle unit tooltip modifications
local function ModifyUnitTooltip(tooltip, unit)
	if not unit then return end
	
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit)
		local color = class and (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]
		local unitGuild = GetGuildInfo(unit)
		
		if color then
			local text = GameTooltipTextLeft1:GetText()
			if text then
				GameTooltipTextLeft1:SetFormattedText("|cff%02x%02x%02x%s|r", 
					color.r * 255, color.g * 255, color.b * 255, 
					text:match("|cff......(.+)|r") or text)
			end
		end
		
		if unitGuild then
			GameTooltipTextLeft2:SetText("<"..unitGuild..">")
		end
	else
		local text2 = GameTooltipTextLeft2:GetText()
		if (text2 and string.sub(text2, 1, string.len("Level ")) ~= "Level ") then
			GameTooltipTextLeft2:SetText("<"..text2..">")
		end
	end
end

-- Detect which WoW version we're running
local function ShouldUseNewTooltipAPI()
	-- Check if we have the new API available
	if not (TooltipDataProcessor and TooltipDataProcessor.AddTooltipPostCall) then
		return false
	end
	
	-- Check if UnitTokenFromGUID exists (added in Dragonflight)
	-- This helps distinguish between Cataclysm Classic (which has TooltipDataProcessor 
	-- but incomplete implementation) and Retail (which has full implementation)
	if not UnitTokenFromGUID then
		return false
	end
	
	-- Additional check: Enum.TooltipDataType should exist and be properly populated
	if not (Enum and Enum.TooltipDataType and Enum.TooltipDataType.Unit) then
		return false
	end
	
	return true
end

-- Choose the appropriate API based on detection
if ShouldUseNewTooltipAPI() then
	-- Retail (Dragonflight 10.0.2+) - Use new API
	TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, data)
		if tooltip ~= GameTooltip then return end
		
		-- Get unit token from tooltip data
		local unit
		if data and data.guid then
			unit = UnitTokenFromGUID(data.guid)
		end
		
		ModifyUnitTooltip(tooltip, unit)
	end)
else
	-- Classic Era, TBC, WotLK, Cataclysm Classic - Use old API
	GameTooltip:HookScript("OnTooltipSetUnit", function(tooltip)
		local _, unit = tooltip:GetUnit()
		ModifyUnitTooltip(tooltip, unit)
	end)
end

-- /run print((select(4, GetBuildInfo())))

-- Create Settings Panel
local function CreateOptionsPanel()
	-- Create the main settings frame
	local frame = CreateFrame("Frame")
	frame.name = L["SIDEBAR_NAME"]

	-- Title
	local title = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
	title:SetPoint("TOPLEFT", 16, -16)
	title:SetText(L["ADDON_NAME"])

	-- Subtitle
	local subtitle = frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	subtitle:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -8)
	subtitle:SetText(L["SUBTITLE"])

	-- Anchor Point Dropdown
	local anchorLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	anchorLabel:SetPoint("TOPLEFT", subtitle, "BOTTOMLEFT", 8, -24)
	anchorLabel:SetText(L["ANCHOR_POINT"])

	local anchorDropdown = CreateFrame("Frame", "ST_AnchorDropdown", frame, "UIDropDownMenuTemplate")
	anchorDropdown:SetPoint("TOPLEFT", anchorLabel, "BOTTOMLEFT", -16, -4)

	UIDropDownMenu_SetWidth(anchorDropdown, 150)
	UIDropDownMenu_SetText(anchorDropdown, SmartTooltipDB.anchorPoint)

	local function AnchorDropdown_OnClick(self)
		SmartTooltipDB.anchorPoint = self.value
		UIDropDownMenu_SetText(anchorDropdown, self.value)
	end

	local function AnchorDropdown_Initialize(self, level)
		local info = UIDropDownMenu_CreateInfo()
		for _, anchor in ipairs(anchorPoints) do
			info.text = anchor
			info.value = anchor
			info.func = AnchorDropdown_OnClick
			info.checked = (anchor == SmartTooltipDB.anchorPoint)
			UIDropDownMenu_AddButton(info)
		end
	end

	UIDropDownMenu_Initialize(anchorDropdown, AnchorDropdown_Initialize)

	-- Horizontal Offset Slider
	local offsetXSlider = CreateFrame("Slider", "ST_OffsetXSlider", frame, "OptionsSliderTemplate")
	offsetXSlider:SetPoint("TOPLEFT", anchorDropdown, "BOTTOMLEFT", 16, -16)
	offsetXSlider:SetMinMaxValues(-100, 100)
	offsetXSlider:SetValue(SmartTooltipDB.offsetX)
	offsetXSlider:SetValueStep(1)
	offsetXSlider:SetObeyStepOnDrag(true)
	offsetXSlider:SetWidth(200)

	_G[offsetXSlider:GetName().."Low"]:SetText("-100")
	_G[offsetXSlider:GetName().."High"]:SetText("100")
	_G[offsetXSlider:GetName().."Text"]:SetText(string.format(L["HORIZONTAL_OFFSET"], SmartTooltipDB.offsetX))

	offsetXSlider:SetScript("OnValueChanged", function(self, value)
		value = math.floor(value + 0.5)
		SmartTooltipDB.offsetX = value
		_G[self:GetName().."Text"]:SetText(string.format(L["HORIZONTAL_OFFSET"], value))
	end)

	offsetXSlider:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetText(L["THRALL_NAME"], 1, 0.82, 0)
		GameTooltip:AddLine(L["THRALL_DESC"], 1, 1, 1, true)
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(L["LEVEL"], "80", 1, 1, 1, 1, 1, 1)
		GameTooltip:AddDoubleLine(L["FACTION"], L["HORDE"], 1, 1, 1, 1, 0.2, 0.2)
		GameTooltip:Show()
	end)

	offsetXSlider:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	-- Vertical Offset Slider
	local offsetYSlider = CreateFrame("Slider", "ST_OffsetYSlider", frame, "OptionsSliderTemplate")
	offsetYSlider:SetPoint("TOPLEFT", offsetXSlider, "BOTTOMLEFT", 0, -32)
	offsetYSlider:SetMinMaxValues(-100, 100)
	offsetYSlider:SetValue(SmartTooltipDB.offsetY)
	offsetYSlider:SetValueStep(1)
	offsetYSlider:SetObeyStepOnDrag(true)
	offsetYSlider:SetWidth(200)

	_G[offsetYSlider:GetName().."Low"]:SetText("-100")
	_G[offsetYSlider:GetName().."High"]:SetText("100")
	_G[offsetYSlider:GetName().."Text"]:SetText(string.format(L["VERTICAL_OFFSET"], SmartTooltipDB.offsetY))

	offsetYSlider:SetScript("OnValueChanged", function(self, value)
		value = math.floor(value + 0.5)
		SmartTooltipDB.offsetY = value
		_G[self:GetName().."Text"]:SetText(string.format(L["VERTICAL_OFFSET"], value))
	end)

	offsetYSlider:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetText(L["JAINA_NAME"], 0.25, 0.78, 0.92)
		GameTooltip:AddLine(L["JAINA_DESC"], 1, 1, 1, true)
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(L["LEVEL"], "80", 1, 1, 1, 1, 1, 1)
		GameTooltip:AddDoubleLine(L["FACTION"], L["ALLIANCE"], 1, 1, 1, 0.2, 0.5, 1)
		GameTooltip:Show()
	end)

	offsetYSlider:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	-- Reset Button
	local resetButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	resetButton:SetPoint("TOPLEFT", offsetYSlider, "BOTTOMLEFT", -8, -32)
	resetButton:SetSize(150, 25)
	resetButton:SetText(L["RESET_BUTTON"])
	resetButton:SetScript("OnClick", function()
		SmartTooltipDB.offsetX = defaults.offsetX
		SmartTooltipDB.offsetY = defaults.offsetY
		SmartTooltipDB.anchorPoint = defaults.anchorPoint
		offsetXSlider:SetValue(defaults.offsetX)
		offsetYSlider:SetValue(defaults.offsetY)
		UIDropDownMenu_SetText(anchorDropdown, defaults.anchorPoint)
		print("|cff00ff00SmartTooltip:|r " .. L["RESET_MESSAGE"])
	end)

	-- Test Area
	local testAreaLabel = frame:CreateFontString(nil, "ARTWORK", "GameFontNormal")
	testAreaLabel:SetPoint("TOPLEFT", resetButton, "BOTTOMLEFT", 8, -24)
	testAreaLabel:SetText(L["TEST_AREA"])

	local testArea = CreateFrame("Frame", nil, frame, "BackdropTemplate")
	testArea:SetPoint("TOPLEFT", testAreaLabel, "BOTTOMLEFT", 0, -8)
	testArea:SetSize(500, 100)
	testArea:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = { left = 11, right = 12, top = 12, bottom = 11 }
	})

	local testAreaText = testArea:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
	testAreaText:SetPoint("CENTER", 0, 0)
	testAreaText:SetText(L["TEST_AREA_HOVER"])

	testArea:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_NONE")
		GameTooltip:SetText(L["FROSTMOURNE_NAME"], 0.6, 0.8, 1)
		GameTooltip:AddLine(L["FROSTMOURNE_DESC"], 1, 1, 1, true)
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(L["ITEM_LEVEL"], "284", 1, 1, 1, 1, 1, 1)
		GameTooltip:AddDoubleLine(L["DAMAGE"], "694 - 1042", 1, 1, 1, 1, 1, 1)
		GameTooltip:AddLine(L["FROSTMOURNE_EQUIP"], 0, 1, 0)
		GameTooltip:AddLine(L["FROSTMOURNE_CURSED"], 1, 0.2, 0.2)
		GameTooltip:Show()
	end)

	testArea:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)

	-- Register with the new Settings API
	local category, layout = Settings.RegisterCanvasLayoutCategory(frame, L["SIDEBAR_NAME"])
	Settings.RegisterAddOnCategory(category)
	categoryID = category:GetID()
end

-- Initialize settings panel after player login
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("PLAYER_LOGIN")
initFrame:SetScript("OnEvent", function()
	CreateOptionsPanel()
end)
