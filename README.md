# SmartTooltip

**SmartTooltip** is a lightweight and highly configurable addon that gives you complete control over your tooltip positioning in World of Warcraft. Say goodbye to tooltips blocking important information - position them exactly where you want!

## Features

### 🎯 Advanced Positioning
- **9 Anchor Points**: Choose from TOPLEFT, TOP, TOPRIGHT, LEFT, CENTER, RIGHT, BOTTOMLEFT, BOTTOM, or BOTTOMRIGHT
- **Precise Offsets**: Fine-tune horizontal and vertical positioning from -100 to +100 pixels
- **Real-time Updates**: See changes instantly as you adjust settings

### ⚙️ Professional Options Panel
- Integrated directly into WoW's Interface → AddOns menu
- Interactive test area with sample tooltips
- Real-time preview on sliders - hover over the sliders to see your settings in action
- One-click reset to defaults

### 🌍 Full Localization Support
- **English (enUS)**: Complete
- **Portuguese Brazilian (ptBR)**: Complete
- Built on AceLocale-3.0 for easy community translations
- Framework ready for additional languages

### 💾 Persistent Settings
- All configurations saved automatically
- Settings persist across sessions and reloads
- Clean SavedVariables implementation

## Installation

1. Download the addon from CurseForge
2. Extract to your `World of Warcraft\_retail_\Interface\AddOns` folder
3. Restart WoW or type `/reload`
4. Configure via `/st config` or ESC → Interface → AddOns → SmartTooltip

## Usage

### Chat Commands
- `/st` - Display addon info and help
- `/st config` - Open configuration panel
- `/smarttooltip` - Alternative command

### Configuration Panel
Access the settings panel through:
- Chat command: `/st config`
- Interface menu: ESC → Interface → AddOns → SmartTooltip

### Settings
1. **Anchor Point**: Select where the tooltip attaches to your cursor
2. **Horizontal Offset**: Adjust left/right positioning (-100 to +100 px)
3. **Vertical Offset**: Adjust up/down positioning (-100 to +100 px)
4. **Test Area**: Hover to preview your settings with a sample tooltip
5. **Reset Button**: Restore default settings instantly

## Examples

### Common Configurations

**Bottom-right corner (Default)**
- Anchor: BOTTOMLEFT
- Offset X: 15
- Offset Y: 15

**Centered on cursor**
- Anchor: CENTER
- Offset X: 0
- Offset Y: 0

**Above cursor**
- Anchor: BOTTOM
- Offset X: 0
- Offset Y: 20

**Left side of cursor**
- Anchor: RIGHT
- Offset X: -20
- Offset Y: 0

## Technical Details

- **Version**: 2.0.0
- **Interface**: 110205 (WoW 11.0.2+)
- **Dependencies**: AceLocale-3.0 (included)
- **SavedVariables**: SmartTooltipDB
- **Memory**: Lightweight (<100 KB)
- **Performance**: Zero impact - only activates on tooltip display

## Compatibility

- ✅ World of Warcraft Retail (11.0.2+)
- ✅ The War Within expansion
- ✅ Compatible with most tooltip addons
- ✅ Works with ElvUI, TipTac, and other UI modifications

## Support & Feedback

Found a bug or have a feature request? Please report issues on:
- CurseForge project page
- GitHub issues (if available)

Want to contribute translations? We use AceLocale-3.0 - check the `Locale` folder for examples.

## Credits

**Author**: GuntherStrike
**Localization**: Community contributors
**Library**: AceLocale-3.0 by Ace3 team

## License

All Rights Reserved. This addon is free to use and distribute through approved addon platforms (CurseForge, Wago.io).

---

### Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and detailed changes.

---

**Enjoying SmartTooltip?** Please leave a review and share with your guild! 💚
