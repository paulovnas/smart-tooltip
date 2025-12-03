-- English Localization
local L = LibStub("AceLocale-3.0"):NewLocale("SmartTooltip", "enUS", true)
if not L then return end

-- Interface
L["ADDON_NAME"] = "Smart Tooltip"
L["SIDEBAR_NAME"] = "Smart Tooltip"
L["SUBTITLE"] = "Configure tooltip position relative to cursor"
L["ANCHOR_POINT"] = "Anchor Point:"
L["HORIZONTAL_OFFSET"] = "Horizontal Offset: %d px"
L["VERTICAL_OFFSET"] = "Vertical Offset: %d px"
L["RESET_BUTTON"] = "Reset to Defaults"
L["RESET_MESSAGE"] = "Settings reset to defaults"
L["TEST_AREA"] = "Test Area:"
L["TEST_AREA_HOVER"] = "Hover here to test tooltip position"
L["SETTINGS_NOT_LOADED"] = "Settings not loaded yet. Please try again in a moment."
L["ADDON_INFO"] = "v2.0.0 - Advanced tooltip positioning"
L["ADDON_HELP"] = "Use |cff00ff00/st config|r to open settings"

-- Lore tooltips
L["THRALL_NAME"] = "Thrall, Warchief of the Horde"
L["THRALL_DESC"] = "Once a slave, now a hero of the Horde, Thrall united the orcs and led them to a new homeland in Kalimdor."
L["JAINA_NAME"] = "Jaina Proudmoore, Archmage"
L["JAINA_DESC"] = "A powerful sorceress and leader of the Kirin Tor, Jaina has been a key figure in the Alliance's struggles against the Burning Legion and the Horde."
L["FROSTMOURNE_NAME"] = "Frostmourne"
L["FROSTMOURNE_DESC"] = "The cursed runeblade of the Lich King, Frostmourne has claimed countless souls and transformed Prince Arthas into one of Azeroth's greatest villains."
L["FROSTMOURNE_EQUIP"] = "Equip: Steals the soul of its victims."
L["FROSTMOURNE_CURSED"] = "|cffff0000Cursed|r"

-- Generic labels
L["LEVEL"] = "Level"
L["FACTION"] = "Faction"
L["HORDE"] = "Horde"
L["ALLIANCE"] = "Alliance"
L["ITEM_LEVEL"] = "Item Level"
L["DAMAGE"] = "Damage"
