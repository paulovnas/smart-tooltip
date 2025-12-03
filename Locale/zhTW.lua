-- Traditional Chinese Localization
local L = LibStub("AceLocale-3.0"):NewLocale("SmartTooltip", "zhTW")
if not L then return end

-- Interface
L["ADDON_NAME"] = "智能提示"
L["SIDEBAR_NAME"] = "智能提示"
L["SUBTITLE"] = "設定提示框相對於鼠標的位置"
L["ANCHOR_POINT"] = "錨點："
L["HORIZONTAL_OFFSET"] = "水平偏移：%d 像素"
L["VERTICAL_OFFSET"] = "垂直偏移：%d 像素"
L["RESET_BUTTON"] = "重置為預設值"
L["RESET_MESSAGE"] = "設定已重置為預設值"
L["TEST_AREA"] = "測試區域："
L["TEST_AREA_HOVER"] = "在此懸停以測試提示框位置"
L["SETTINGS_NOT_LOADED"] = "設定尚未載入。請稍後再試。"
L["ADDON_INFO"] = "v2.0.0 - 進階提示框定位"
L["ADDON_HELP"] = "使用 |cff00ff00/st config|r 開啟設定"

-- Lore tooltips
L["THRALL_NAME"] = "索爾，部落大酋長"
L["THRALL_DESC"] = "曾經是奴隸，如今是部落的英雄，索爾團結了獸人，並帶領他們在卡林多建立了新的家園。"
L["JAINA_NAME"] = "珍娜·普勞德摩爾，大法師"
L["JAINA_DESC"] = "作為一名強大的女巫和祈倫托的領袖，珍娜一直是聯盟對抗燃燒軍團和部落鬥爭中的關鍵人物。"
L["FROSTMOURNE_NAME"] = "霜之哀傷"
L["FROSTMOURNE_DESC"] = "巫妖王的詛咒符文劍，霜之哀傷奪取了無數靈魂，並將阿薩斯王子變成了艾澤拉斯最偉大的反派之一。"
L["FROSTMOURNE_EQUIP"] = "裝備：竊取受害者的靈魂。"
L["FROSTMOURNE_CURSED"] = "|cffff0000詛咒|r"

-- Generic labels
L["LEVEL"] = "等級"
L["FACTION"] = "陣營"
L["HORDE"] = "部落"
L["ALLIANCE"] = "聯盟"
L["ITEM_LEVEL"] = "物品等級"
L["DAMAGE"] = "傷害"
