# SmartTooltip

## [v2.0.0] (2025-12-03)

### New Features
- ✨ **Configurable Anchor Points**: Choose from 9 different anchor positions (TOPLEFT, TOP, TOPRIGHT, LEFT, CENTER, RIGHT, BOTTOMLEFT, BOTTOM, BOTTOMRIGHT)
- ✨ **Adjustable Offsets**: Set horizontal and vertical offsets from -100 to +100 pixels
  - ✨ Full Localization Support: Using AceLocale-3.0 library
    - English (enUS) - Default
    - Portuguese Brazilian (ptBR) - Complete translation
    - German (deDE) - Complete translation
    - French (frFR) - Complete translation
    - Spanish (esES) - Complete translation
    - Traditional Chinese (zhTW) - Complete translation
    - Simplified Chinese (zhCN) - Complete translation
    - Korean (koKR) - Complete translation
    - Russian (ruRU) - Complete translation
    - Italian (itIT) - Complete translation
- ✨ **Options Panel**: Professional settings interface in WoW's AddOns menu
  - Interactive test area with WoW lore tooltips
  - Real-time preview on sliders
  - Reset to defaults button
- ✨ **Chat Commands**: `/smarttooltip` or `/smarttooltip config` to access settings (or `st`)
- ✨ **SavedVariables**: All settings persist between sessions

### Technical Improvements
- Modular code structure with separate localization files
- AceLocale-3.0 integration for easy translation management
- Modern WoW 11.0.2+ Settings API implementation
- Organized file structure (Libs/, Locale/)
- Comprehensive tooltip examples featuring Thrall, Jaina, and Frostmourne

### Interface
- Sidebar name: "SmartTooltip" (localized as "Opções SmartTooltip" in PT-BR)
- Enhanced test area (500px width) for comfortable testing
- Tooltips with WoW lore instead of Lorem Ipsum
- Clean and professional UI design
